Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800B6491373
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiARBgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:36:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35849 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiARBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:36:35 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JdBDh6bKwzccS2;
        Tue, 18 Jan 2022 09:35:48 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 09:36:32 +0800
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Steven Rostedt <rostedt@goodmis.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <gustavoars@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
 <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
 <20220111101425.7c59de5b@rorschach.local.home>
 <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
 <202201141935.A3F2ED1CF@keescook>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <81169efd-66bc-8cb3-c61a-f3ac30f089da@huawei.com>
Date:   Tue, 18 Jan 2022 09:36:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <202201141935.A3F2ED1CF@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/1/15 11:50, Kees Cook Ð´µÀ:
> On Thu, Jan 13, 2022 at 10:18:57AM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 11, 2022 at 10:14:25AM -0500, Steven Rostedt wrote:
>>> On Tue, 11 Jan 2022 12:30:42 +0100
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>>>>>   	if (unlikely(!deref_curr_numa_group(p))) {
>>>>>>> -		unsigned int size = sizeof(struct numa_group) +
>>>>>>> -				    NR_NUMA_HINT_FAULT_STATS *
>>>>>>> -				    nr_node_ids * sizeof(unsigned long);
>>>>>>> +		unsigned int size = struct_size(grp, faults,
>>>>>>> +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);
>>>>>> Again, why?! The old code was perfectly readable, this, not so much.
>>>>> Because it is unsafe,
>>>> Unsafe how? Changelog doesn't mention anything, nor do you. In fact,
>>>> Changelog says there is no functional change, which makes me hate the
>>>> thing for obscuring something that was simple.
>>> If for some reason faults changes in size, the original code must be
>>> updated whereas the new code is robust enough to not need changing.
> I think this alone is reason enough. :)
>
>> Then I would still much prefer something like:
>>
>> 	unsigned int size = sizeof(*grp) +
>> 			    NR_NUMA_HINT_FAULT_STATS * numa_node_ids * sizeof(gfp->faults);
>>
>> Which is still far more readable than some obscure macro. But again, the
> I'm not sure it's _obscure_, but it is relatively new. It's even
> documented. ;)
> https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> That said, the original patch is incomplete: it should be using size_t
> for "size".
thanks, I will send a v3 patch with this change and more detailed commit 
message.
>> It is a fairly useful and common pattern to have a small structure and
>> an array in the same memory allocation.
>>
>> Think hash-tables, the structure contains the size of the table and some
>> other things, like for example a seed for the hash function or a lock,
>> and then the table itself as an array.
> Right, the use of flexible arrays is very common in the kernel. So much
> so that we've spent years fixing all the ancient "fake flexible arrays"
> scattered around the kernel messing up all kinds of compile-time and
> run-time flaw mitigations. Flexible array manipulations are notoriously
> prone to mistakes (overflows in allocation, mismatched bounds storage
> sizes, array index overflows, etc). These helpers (with more to come)
> help remove some of the foot-guns that C would normally impart to them.
>
>> I can't, nor do I want to, remember all these stupid little macros. Esp.
>> not for trivial things like this.
> Well, the good news is that other folks will (and are) fixing them for
> you. :) Even if you never make mistakes with flexible arrays, other
> people do, and so we need to take on some improvements to the robustness
> of the kernel source tree-wide.
>
> -Kees
>
