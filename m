Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3551B63C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiEEDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiEEDBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:01:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738BD49270
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:57:45 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KtyzH1BWTzhYpF;
        Thu,  5 May 2022 10:57:15 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:57:36 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:57:36 +0800
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
To:     Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <zengshun.wu@outlook.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids> <20220421100639.03c0d123@gandalf.local.home>
 <YmF0xYpTMoWOIl00@lakrids> <20220421114201.21228eeb@gandalf.local.home>
 <YmGF/OpIhAF8YeVq@lakrids>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <8f36ebd2-2c56-d896-3a91-c97a5760b344@huawei.com>
Date:   Thu, 5 May 2022 10:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <YmGF/OpIhAF8YeVq@lakrids>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


�� 2022/4/22 0:27, Mark Rutland д��:
> On Thu, Apr 21, 2022 at 11:42:01AM -0400, Steven Rostedt wrote:
>> On Thu, 21 Apr 2022 16:14:13 +0100
>> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>>>> Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
>>>> be quite common). But each of these ftrace_ops traces a function (or
>>>> functions) that are not being traced by the other ftrace_ops. That is, each
>>>> ftrace_ops has its own unique function(s) that they are tracing. One could
>>>> be tracing schedule, the other could be tracing ksoftirqd_should_run
>>>> (whatever).
>>> Ok, so that's when messing around with bpf or kprobes, and not generally
>>> when using plain old ftrace functionality under /sys/kernel/tracing/
>>> (unless that's concurrent with one of the former, as per your other
>>> reply) ?
>> It's any user of the ftrace infrastructure, which includes kprobes, bpf,
>> perf, function tracing, function graph tracing, and also affects instances.
>>
>>>> Without this change, because the arch does not support dynamically
>>>> allocated trampolines, it means that all these ftrace_ops will be
>>>> registered to the same trampoline. That means, for every function that is
>>>> traced, it will loop through all 10 of theses ftrace_ops and check their
>>>> hashes to see if their callback should be called or not.
>>> Sure; I can see how that can be quite expensive.
>>>
>>> What I'm trying to figure out is who this matters to and when, since the
>>> implementation is going to come with a bunch of subtle/fractal
>>> complexities, and likely a substantial overhead too when enabling or
>>> disabling tracing of a patch-site. I'd like to understand the trade-offs
>>> better.
>>>
>>>> With dynamically allocated trampolines, each ftrace_ops will have their own
>>>> trampoline, and that trampoline will be called directly if the function
>>>> is only being traced by the one ftrace_ops. This is much more efficient.
>>>>
>>>> If a function is traced by more than one ftrace_ops, then it falls back to
>>>> the loop.
>>> I see -- so the dynamic trampoline is just to get the ops? Or is that
>>> doing additional things?
>> It's to get both the ftrace_ops (as that's one of the parameters) as well
>> as to call the callback directly. Not sure if arm is affected by spectre,
>> but the "loop" function is filled with indirect function calls, where as
>> the dynamic trampolines call the callback directly.
>>
>> Instead of:
>>
>>    bl ftrace_caller
>>
>> ftrace_caller:
>>    [..]
>>    bl ftrace_ops_list_func
>>    [..]
>>
>>
>> void ftrace_ops_list_func(...)
>> {
>> 	__do_for_each_ftrace_ops(op, ftrace_ops_list) {
>> 		if (ftrace_ops_test(op, ip)) // test the hash to see if it
>> 					     //	should trace this
>> 					     //	function.
>> 			op->func(...);
>> 	}
>> }
>>
>> It does:
>>
>>    bl dyanmic_tramp
>>
>> dynamic_tramp:
>>    [..]
>>    bl func  // call the op->func directly!
>>
>>
>> Much more efficient!
>>
>>
>>> There might be a middle-ground here where we patch the ftrace_ops
>>> pointer into a literal pool at the patch-site, which would allow us to
>>> handle this atomically, and would avoid the issues with out-of-range
>>> trampolines.
>> Have an example of what you are suggesting?
> We can make the compiler to place 2 NOPs before the function entry point, and 2
> NOPs after it using `-fpatchable-function-entry=4,2` (the arguments are
> <total>,<before>). On arm64 all instructions are 4 bytes, and we'll use the
> first two NOPs as an 8-byte literal pool.
>
> Ignoring BTI for now, the compiler generates (with some magic labels added here
> for demonstration):
>
> 	__before_func:
> 			NOP
> 			NOP
> 	func:
> 			NOP
> 			NOP
> 	__remainder_of_func:
> 			...
>
> At ftrace_init_nop() time we patch that to:
>
> 	__before_func:
> 			// treat the 2 NOPs as an 8-byte literal-pool
> 			.quad	<default ops pointer> // see below
> 	func:
> 			MOV	X9, X30
> 			NOP
> 	__remainder_of_func:
> 			...
>
> When enabling tracing we do
>
> 	__before_func:
> 			// patch this with the relevant ops pointer
> 			.quad	<ops pointer>
> 	func:
> 			MOV	X9, X30
> 			BL	<trampoline>	// common trampoline

I have a question that does this common trampoline allocated by 
module_alloc()? if yes,

how to handle the long jump from traced func to common trampoline if 
only adding

two NOPs in front of func.

-- Wang ShaoBo

> 	__remainder_of_func:
> 		 	..
>
> The `BL <trampoline>` clobbers X30 with __remainder_of_func, so within
> the trampoline we can find the ops pointer at an offset from X30. On
> arm64 we can load that directly with something like:
>
> 	LDR	<tmp>, [X30, # -(__remainder_of_func - __before_func)]
>
> ... then load the ops->func from that and invoke it (or pass it to a
> helper which does):
>
> 	// Ignoring the function arguments for this demonstration
> 	LDR	<tmp2>, [<tmp>, #OPS_FUNC_OFFSET]
> 	BLR	<tmp2>
>
> That avoids iterating over the list *without* requiring separate
> trampolines, and allows us to patch the sequence without requiring
> stop-the-world logic (since arm64 has strong requirements for patching
> most instructions other than branches and nops).
>
> We can initialize the ops pointer to a default ops that does the whole
> __do_for_each_ftrace_ops() dance.
>
> To handle BTI we can have two trampolines, or we can always reserve 3 NOPs
> before the function so that we can have a consistent offset regardless.
>
> Thanks,
> Mark.
> .
