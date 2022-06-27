Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AEC55C26C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiF0MBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiF0LxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:53:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57815BDF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:48:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LWmD3026LzkWdZ;
        Mon, 27 Jun 2022 19:46:58 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 19:48:47 +0800
Subject: Re: [PATCH v2 5/9] mm, hwpoison: make unpoison aware of raw error
 info in hwpoisoned hugepage
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-6-naoya.horiguchi@linux.dev>
 <ea1d17d8-89df-04b7-29e8-0da53dbd3312@huawei.com>
Message-ID: <2b6a6b19-c930-6d27-5929-363802e42596@huawei.com>
Date:   Mon, 27 Jun 2022 19:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ea1d17d8-89df-04b7-29e8-0da53dbd3312@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/27 16:32, Miaohe Lin wrote:
> On 2022/6/24 7:51, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> Raw error info list needs to be removed when hwpoisoned hugetlb is
>> unpoisioned.  And unpoison handler needs to know how many errors there
>> are in the target hugepage. So add them.
>>
>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> snip
> 
>> @@ -2255,7 +2275,7 @@ int unpoison_memory(unsigned long pfn)
>>  unlock_mutex:
>>  	mutex_unlock(&mf_mutex);
>>  	if (!ret || freeit) {
>> -		num_poisoned_pages_dec();
>> +		num_poisoned_pages_sub(count);
> 
> IIUC, num_poisoned_pages will only be incremented once for hugetlb page. If many
> subpages are hwpoisoned, they will reach the "else if (res == -EHWPOISON)" path
> in try_memory_failure_hugetlb and thus num_poisoned_pages_inc is ignored. Maybe
> that should be changed so subpages can contribute to the num_poisoned_pages
> or should we just do num_poisoned_pages_dec here? Or am I miss something?

Sorry. I re-read patch 4/9 and I found hugetlb_set_page_hwpoison will increment the
num_poisoned_pages for each subpages. Please ignore this question.

> 
> Thanks!
> 
>>  		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
>>  				 page_to_pfn(p), &unpoison_rs);
>>  	}
>>
> 

