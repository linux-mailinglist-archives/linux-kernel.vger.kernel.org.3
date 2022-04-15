Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC4502039
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348518AbiDOB5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiDOB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:57:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09E165A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:55:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KffXF1F8Gz1HByR;
        Fri, 15 Apr 2022 09:54:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 09:55:14 +0800
Subject: Re: [PATCH v8 1/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
 <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
Date:   Fri, 15 Apr 2022 09:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 1:56, Mike Kravetz wrote:
> On 4/8/22 06:53, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
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
>> The current code first does prechecks roughly and then reconfirms
>> after taking refcount, but it's found that it makes code overly
>> complicated, so move the prechecks in a single hugetlb_lock range.
>>
>> A newly introduced function, try_memory_failure_hugetlb(), always
>> takes hugetlb_lock (even for non-hugetlb pages).  That can be
>> improved, but memory_failure() is rare in principle, so should
>> not be a big problem.
...
> 
> The above code works as designed, but may be a bit confusing.  If HPageFreed()
> we KNOW ref count is zero, so no need to even call get_page_unless_zero() as
> it will always return false in this case.  It might be more clear if written
> as separate else if statements such as:
> 
> 	} else if (HPageFreed(head)) {
> 		ret = 0;
> 	} else if (HPageMigratable(head)) {
> 		ret = get_page_unless_zero(head);
> 		if (ret)
> 			count_increased = true;
> 

This code here is consistent with the logic in get_hwpoison_huge_page. If change is required,
they might need to be changed together.

BTW: They look a bit confusing for me at first but I get used to it later. ;)

Thanks!

> Not insisting this be changed.  Just easier to understand IMO.
> 
> Again, thanks for your work on this!
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

