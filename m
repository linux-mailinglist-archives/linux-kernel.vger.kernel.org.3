Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354DF4D9CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbiCOOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348896AbiCOOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:01:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBA354183
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:00:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KHw4R3Bw9zfYq8;
        Tue, 15 Mar 2022 21:59:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 22:00:30 +0800
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
 <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
 <20220315054935.GA3454497@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1770029b-fd59-4eb1-c891-5a2ba4beef9c@huawei.com>
Date:   Tue, 15 Mar 2022 22:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220315054935.GA3454497@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/15 13:49, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Mar 14, 2022 at 03:10:25PM +0800, Miaohe Lin wrote:
>> On 2022/3/14 10:13, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> There is a race condition between memory_failure_hugetlb() and hugetlb
>>> free/demotion, which causes setting PageHWPoison flag on the wrong page
>>> (which was a hugetlb when memory_failure() was called, but was removed
>>> or demoted when memory_failure_hugetlb() is called).  This results in
>>> killing wrong processes.  So set PageHWPoison flag with holding page lock,
>>
>> It seems hold page lock could not help solve this race condition as hugetlb
>> page demotion is not required to hold the page lock. Could you please explain
>> this a bit more?
> 
> Sorry, the last line in the paragraph need change. What prevents the current
> race is hugetlb_lock, not page lock.  The page lock is here to prevent the
> race with hugepage allocation (not directly related to the current issue,
> but it's still necessary).

Many thanks for clarifying this.

> 
>>
>> BTW:Is there some words missing or here should be 'page lock.' instead of 'page lock,' ?
> 
> I should use a period here, I'll fix it.
> 
> [...]
> 
>>> @@ -1503,24 +1502,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>  	int res;
>>>  	unsigned long page_flags;
>>>  
>>> -	if (TestSetPageHWPoison(head)) {
>>> -		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>>> -		       pfn);
>>> -		res = -EHWPOISON;
>>> -		if (flags & MF_ACTION_REQUIRED)
>>> -			res = kill_accessing_process(current, page_to_pfn(head), flags);
>>> -		return res;
>>> -	}
>>> -
>>> -	num_poisoned_pages_inc();
>>> -
>>>  	if (!(flags & MF_COUNT_INCREASED)) {
>>>  		res = get_hwpoison_page(p, flags);
>>>  		if (!res) {
>>
>> In this (res == 0) case, hugetlb page could be dissolved via __page_handle_poison.
>> But since PageHWPoison is not set yet, we can't set the PageHWPoison to the correct
>> page. Think about the below code in dissolve_free_huge_page:
>> 	/*
>> 	 * Move PageHWPoison flag from head page to the raw
>> 	 * error page, which makes any subpages rather than
>> 	 * the error page reusable.
>> 	 */
>> 	if (PageHWPoison(head) && page != head) {
>> 		SetPageHWPoison(page);
>> 		ClearPageHWPoison(head);
>> 	}
>>
>> SetPageHWPoison won't be called for the error page. Or am I miss something?
> 
> No, you're right.  We need call page_handle_poison() instead of
> __page_handle_poison().
> 
> @@ -1512,7 +1512,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  			}
>  			unlock_page(head);
>  			res = MF_FAILED;
> -			if (__page_handle_poison(p)) {
> +			if (page_handle_poison(p, true, false)) {
>  				page_ref_inc(p);
>  				res = MF_RECOVERED;
>  			}
> 

This one looks good to me.

> 
> 
>>
>>>  			lock_page(head);
>>>  			if (hwpoison_filter(p)) {
>>> -				if (TestClearPageHWPoison(head))
>>> -					num_poisoned_pages_dec();
>>>  				unlock_page(head);
>>>  				return -EOPNOTSUPP;
>>>  			}
>>> @@ -1553,13 +1539,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>  	page_flags = head->flags;
>>>  
>>>  	if (hwpoison_filter(p)) {
>>> -		if (TestClearPageHWPoison(head))
>>> -			num_poisoned_pages_dec();
>>>  		put_page(p);
>>>  		res = -EOPNOTSUPP;
>>>  		goto out;
>>>  	}
>>>  
>>> +	if (TestSetPageHWPoison(head))
>>> +		goto already_hwpoisoned;
>>> +
>>> +	num_poisoned_pages_inc();
>>> +
>>>  	/*
>>>  	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>>>  	 * simply disable it. In order to make it work properly, we need
>>> @@ -1585,6 +1574,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>  out:
>>>  	unlock_page(head);
>>>  	return res;
>>> +already_hwpoisoned:
>>> +	put_page(p);
>>> +	unlock_page(head);
>>
>> Generally speaking, we should do unlock_page before put_page or page might be disappeared
>> before we unlock the page. This should be ok when memory_failure succeeds to handle the
>> page previously as it holds one extra page refcnt. But it might be problematic when
>> memory_failure failed to handle the page last time. We might be the last user here.
> 
> OK, so another code path in "if (hwpoison_filter)@ block seems to need
> the same change in the order.

You're right.

> 
> Thanks,
> Naoya Horiguchi
> 

Many thanks for your patch.
