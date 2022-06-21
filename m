Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54887552C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbiFUHhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiFUHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:37:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D5E1C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:37:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRywS1bWyz1KC5C;
        Tue, 21 Jun 2022 15:35:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:37:25 +0800
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-2-linmiaohe@huawei.com>
 <87r13jrdst.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a384f290-dff3-6dad-f1d3-8ec245b9bebd@huawei.com>
 <87letqpzm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <463fe0cd-504a-f887-0201-691bacd9e69d@huawei.com>
Date:   Tue, 21 Jun 2022 15:37:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87letqpzm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/6/21 9:35, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/6/20 15:31, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> security_vm_enough_memory_mm() checks whether a process has enough memory
>>>> to allocate a new virtual mapping. And total_swap_pages is considered as
>>>> available memory while swapoff tries to make sure there's enough memory
>>>> that can hold the swapped out memory. But total_swap_pages contains the
>>>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>>>> success even if there's no memory to hold the swapped out memory because
>>>> total_swap_pages always greater than or equal to p->pages.
>>>
>>> Per my understanding, swapoff will not allocate virtual mapping by
>>> itself.  But after swapoff, the overcommit limit could be exceeded.
>>> security_vm_enough_memory_mm() is used to check that.  For example, in a
>>> system with 4GB memory and 8GB swap, and 10GB is in use,
>>>
>>> CommitLimit:    4+8 = 12GB
>>> Committed_AS:   10GB
>>>
>>> security_vm_enough_memory_mm() in swapoff() will fail because
>>> 10+8 = 18 > 12.  This is expected because after swapoff, the overcommit
>>> limit will be exceeded.
>>>
>>> If 3GB is in use,
>>>
>>> CommitLimit:    4+8 = 12GB
>>> Committed_AS:   3GB
>>>
>>> security_vm_enough_memory_mm() in swapoff() will succeed because
>>> 3+8 = 11 < 12.  This is expected because after swapoff, the overcommit
>>> limit will not be exceeded.
>>
>> In OVERCOMMIT_NEVER scene, I think you're right.
>>
>>>
>>> So, what's the real problem of the original implementation?  Can you
>>> show it with an example as above?
>>
>> In OVERCOMMIT_GUESS scene, in a system with 4GB memory and 8GB swap, and 10GB is in use,
>> pages below is 8GB, totalram_pages() + total_swap_pages is 12GB, so swapoff() will succeed
>> instead of expected failure because 8 < 12. The overcommit limit is always *ignored* in the
>> below case.
>>
>> 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
>> 		if (pages > totalram_pages() + total_swap_pages)
>> 			goto error;
>> 		return 0;
>> 	}
>>
>> Or am I miss something?
> 
> Per my understanding, with OVERCOMMIT_GUESS, the number of in-use pages
> isn't checked at all.  The only restriction is that the size of the
> virtual mapping created should be less than total RAM + total swap

Do you mean the only restriction is that the size of the virtual mapping
*created every time* should be less than total RAM + total swap pages but
*total virtual mapping* is not limited in OVERCOMMIT_GUESS scene? If so,
the current behavior should be sane and I will drop this patch.

Thanks!

> pages.  Because swapoff() will not create virtual mapping, so it's
> expected that security_vm_enough_memory_mm() in swapoff() always
> succeeds.
> 
> Best Regards,
> Huang, Ying
> 
>>
>> Thanks!
>>
>>>
>>>> In order to fix it, p->pages should be retracted from total_swap_pages
>>>> first and then check whether there's enough memory for inuse swap pages.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> [snip]
>>>
>>> .
>>>
> 
> .
> 

