Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120856986F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiGGC7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGGC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:59:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15B29822
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:59:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ldh001dXtz1L8y9;
        Thu,  7 Jul 2022 10:57:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 10:59:29 +0800
Subject: Re: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <alex@ghiti.fr>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
 <865207df-b272-c7c9-e90c-5748262d3d87@huawei.com>
 <20220705063918.GA2508809@hori.linux.bs1.fc.nec.co.jp>
 <185c2a5e-8987-c679-b522-418b5072f1bd@huawei.com> <YsT/8jl2JfDbw0Ku@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cfcb3edd-47f3-8e66-d761-73d3be71ee0d@huawei.com>
Date:   Thu, 7 Jul 2022 10:59:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YsT/8jl2JfDbw0Ku@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/7/6 11:22, Mike Kravetz wrote:
> On 07/06/22 11:04, Miaohe Lin wrote:
>> On 2022/7/5 14:39, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Tue, Jul 05, 2022 at 10:16:39AM +0800, Miaohe Lin wrote:
>>>> On 2022/7/4 9:33, Naoya Horiguchi wrote:
>>>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>>
>>>>> I found a weird state of 1GB hugepage pool, caused by the following
>>>>> procedure:
>>>>>
>>>>>   - run a process reserving all free 1GB hugepages,
>>>>>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
>>>>>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
>>>>>   - kill the reserving process.
>>>>>
>>>>> , then all the hugepages are free *and* surplus at the same time.
>>>>>
>>>>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>>>>   3
>>>>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
>>>>>   3
>>>>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
>>>>>   0
>>>>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
>>>>>   3
>>>>>
>>>>> This state is resolved by reserving and allocating the pages then
>>>>> freeing them again, so this seems not to result in serious problem.
>>>>> But it's a little surprising (shrinking pool suddenly fails).
>>>>>
>>>>> This behavior is caused by hstate_is_gigantic() check in
>>>>> return_unused_surplus_pages(). This was introduced so long ago in 2008
>>>>> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
>>>>> at that time the gigantic pages were not supposed to be allocated/freed
>>>>> at run-time.  Now kernel can support runtime allocation/free, so let's
>>>>> check gigantic_page_runtime_supported() together.
>>>>>
>>>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>
>>>> This patch looks good to me with a few question below.
>>>
>>> Thank you for reviewing.
>>>
>>>>
>>>>> ---
>>>>> v2 -> v3:
>>>>> - Fixed typo in patch description,
>>>>> - add !gigantic_page_runtime_supported() check instead of removing
>>>>>   hstate_is_gigantic() check (suggested by Miaohe and Muchun)
>>>>> - add a few more !gigantic_page_runtime_supported() check in
>>>>>   set_max_huge_pages() (by Mike).
>>>>> ---
>>>>>  mm/hugetlb.c | 19 ++++++++++++++++---
>>>>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 2a554f006255..bdc4499f324b 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -2432,8 +2432,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>>>>>  	/* Uncommit the reservation */
>>>>>  	h->resv_huge_pages -= unused_resv_pages;
>>>>>  
>>>>> -	/* Cannot return gigantic pages currently */
>>>>> -	if (hstate_is_gigantic(h))
>>>>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>>>>  		goto out;
>>>>>  
>>>>>  	/*
>>>>> @@ -3315,7 +3314,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>>>>>  	 * the user tries to allocate gigantic pages but let the user free the
>>>>>  	 * boottime allocated gigantic pages.
>>>>>  	 */
>>>>> -	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>>>>> +	if (hstate_is_gigantic(h) && (!IS_ENABLED(CONFIG_CONTIG_ALLOC) ||
>>>>> +				      !gigantic_page_runtime_supported())) {
>>>>>  		if (count > persistent_huge_pages(h)) {
>>>>>  			spin_unlock_irq(&hugetlb_lock);
>>>>>  			mutex_unlock(&h->resize_lock);
>>>>> @@ -3363,6 +3363,19 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>>>>>  			goto out;
>>>>>  	}
>>>>>  
>>>>> +	/*
>>>>> +	 * We can not decrease gigantic pool size if runtime modification
>>>>> +	 * is not supported.
>>>>> +	 */
>>>>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
>>>>> +		if (count < persistent_huge_pages(h)) {
>>>>> +			spin_unlock_irq(&hugetlb_lock);
>>>>> +			mutex_unlock(&h->resize_lock);
>>>>> +			NODEMASK_FREE(node_alloc_noretry);
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>> +	}
>>>>
>>>> With above change, we're not allowed to decrease the pool size now. But it was allowed previously
>>>> even if !gigantic_page_runtime_supported. Does this will break user?
>>>
>>> Yes, it does. I might get the wrong idea about the definition of
>>> gigantic_page_runtime_supported(), which shows that runtime pool *extension*
>>> is supported or not (implying that pool shrinking is always possible).
>>> If this is right, this new if-block is not necessary.
>>
>> I tend to remove above new if-block to keep pool shrinking available.
>>
> 
> Not sure I am following the questions.
> 
> Take a look at __update_and_free_page which will refuse to 'free' a
> gigantic page if !gigantic_page_runtime_supported.  I 'think' attempting
> to shrink the pool when !gigantic_page_runtime_supported will result in
> leaking gigantic pages.  i.e.  Memory will remain allocated for the

It seems the commit 4eb0716e868e ("hugetlb: allow to free gigantic pages regardless of the configuration")
adds the ability to free gigantic pages even if !gigantic_page_supported(). If the gigantic pages can't be
freed due to gigantic_page_runtime_supported check if __update_and_free_page, there might be something need
to do -- disallow trying to free gigantic pages when !gigantic_page_supported or succeeds to free gigantic
pages regardless of gigantic_page_supported. Maybe I am missing something important. Add Alexandre to help
confirm.

Thanks!

> gigantic page, but it can not be used.
> 
> I can take a closer look during my tomorrow.
> 
> IIRC, the only way gigantic_page_runtime_supported is not set to day is
> in the case of powerpc using 16GB pages allocated/managed by firmware.
> 

