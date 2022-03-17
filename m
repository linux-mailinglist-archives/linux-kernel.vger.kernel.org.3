Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4C4DC2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiCQJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiCQJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:29:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F815147ADC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:28:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK1td0MzNz9smV;
        Thu, 17 Mar 2022 17:24:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 17:28:14 +0800
Subject: Re: [PATCH v4] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220316120701.394061-1-naoya.horiguchi@linux.dev>
 <7362f9ee-81fa-702a-7a03-1a91ecf0b58e@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3fe5a7e9-785d-db79-543a-c7723fc6f505@huawei.com>
Date:   Thu, 17 Mar 2022 17:28:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7362f9ee-81fa-702a-7a03-1a91ecf0b58e@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/17 6:51, Mike Kravetz wrote:
> On 3/16/22 05:07, Naoya Horiguchi wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> There is a race condition between memory_failure_hugetlb() and hugetlb
>> free/demotion, which causes setting PageHWPoison flag on the wrong page.
>> The one simple result is that wrong processes can be killed, but another
>> (more serious) one is that the actual error is left unhandled, so no one
>> prevents later access to it, and that might lead to more serious results
>> like consuming corrupted data.
>>
>> Think about the below race window:
>>
>>   CPU 1                                   CPU 2
>>   memory_failure_hugetlb
>>   struct page *head = compound_head(p);
>>                                           hugetlb page might be freed to
>>                                           buddy, or even changed to another
>>                                           compound page.
>>
>>   get_hwpoison_page -- page is not what we want now...
>>
>> The compound_head is called outside hugetlb_lock, so the head is not
>> reliable.
>>
>> So set PageHWPoison flag after passing prechecks. And to detect
>> potential violation, this patch also introduces a new action type
>> MF_MSG_DIFFERENT_PAGE_SIZE.
> 
> Thanks for squashing these patches.
> 
> In my testing, there is a change in behavior that may not be intended.
> 
> My test strategy is:
> - allocate two hugetlb pages
> - create a mapping which reserves those two pages, but does not fault them in
>   - as a result, the pages are on the free list but can not be freed
> - inject error on a subpage of one of the huge pages
>   - echo 0xYYY > /sys/kernel/debug/hwpoison/corrupt-pfn
> - memory error code will call dissolve_free_huge_page
>   - dissolve_free_huge_page returns -EBUSY because
>     h->free_huge_pages - h->resv_huge_pages == 0
> - We never end up setting Poison on the page with error or head page
> - Huge page sitting on free list with error in subpage and not marked
> - huge page with error could be given to an application or returned to buddy
> 
> Prior to this change, Poison would be set on the head page
> 

Many thanks for pointing this out. IIUC, this change in behavior should be a bit
unintended. We're trying to avoid setting PageHWPoison flag on the wrong page so
we have to set the PageHWPoison flag after passing prechecks as commit log said.
But there is room for improvement, e.g. when page changed to single page or another
compound-size page after we grab the page refcnt, we could also set PageHWPoison
before bailing out ? There might be something more we can do?

> I do not think this was an intended change in behavior.  But, perhaps it is
> all we can do in this case?  Sorry for not being able to look more closely
> at the code right now.   
> 

Thanks.
