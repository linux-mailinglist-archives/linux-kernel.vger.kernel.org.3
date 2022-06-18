Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE2550216
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383906AbiFRCnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:43:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5C193CF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:43:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LQ0Xr3xMlzjXcS;
        Sat, 18 Jun 2022 10:41:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 10:43:06 +0800
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-2-linmiaohe@huawei.com>
 <76e468b4-c6ac-426c-7ec9-99c620e08cda@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a4b6b2bd-f56c-4f28-6fcc-7ce2f741dd4a@huawei.com>
Date:   Sat, 18 Jun 2022 10:43:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <76e468b4-c6ac-426c-7ec9-99c620e08cda@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/17 15:33, David Hildenbrand wrote:
> On 08.06.22 16:40, Miaohe Lin wrote:
>> security_vm_enough_memory_mm() checks whether a process has enough memory
>> to allocate a new virtual mapping. And total_swap_pages is considered as
>> available memory while swapoff tries to make sure there's enough memory
>> that can hold the swapped out memory. But total_swap_pages contains the
>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>> success even if there's no memory to hold the swapped out memory because
> 
> s/success/succeed/

OK. Thanks.

> 
>> total_swap_pages always greater than or equal to p->pages.
>>
>> In order to fix it, p->pages should be retracted from total_swap_pages
> 
> s/retracted/subtracted/

OK. Thanks.

> 
>> first and then check whether there's enough memory for inuse swap pages.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swapfile.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index ec4c1b276691..d2bead7b8b70 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2398,6 +2398,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>  	struct filename *pathname;
>>  	int err, found = 0;
>>  	unsigned int old_block_size;
>> +	unsigned int inuse_pages;
>>  
>>  	if (!capable(CAP_SYS_ADMIN))
>>  		return -EPERM;
>> @@ -2428,9 +2429,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>  		spin_unlock(&swap_lock);
>>  		goto out_dput;
>>  	}
>> -	if (!security_vm_enough_memory_mm(current->mm, p->pages))
>> -		vm_unacct_memory(p->pages);
>> +
>> +	total_swap_pages -= p->pages;
>> +	inuse_pages = READ_ONCE(p->inuse_pages);
>> +	if (!security_vm_enough_memory_mm(current->mm, inuse_pages))
>> +		vm_unacct_memory(inuse_pages);
>>  	else {
>> +		total_swap_pages += p->pages;
> 
> That implies that whenever we fail in security_vm_enough_memory_mm(),
> that other concurrent users might see a wrong total_swap_pages.
> 
> Assume 4 GiB memory and 8 GiB swap. Let's assume 10 GiB are in use.
> 
> Temporarily, we'd have
> 
> CommitLimit    4 GiB
> Committed_AS  10 GiB

IIUC, even if without this change, the other concurrent users if come after vm_acct_memory()
is done in __vm_enough_memory(), they might see

CommitLimit   12 GiB (4 GiB memory + 8GiB total swap)
Committed_AS  18 GiB (10 GiB in use + 8GiB swap space to swapoff)

Or am I miss something?

> 
> Not sure if relevant, but I wonder if it could be avoided somehow?

It seems this race exists already and is benign. The worst case is concurrent users might
fail to allocate the memory. But that window should be really small and swapoff is a rare
ops. Or should I try to fix this race?

> 
> 
> Apart from that, LGTM.

Many thanks for comment! :)

> 
