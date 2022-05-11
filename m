Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1619F522E85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiEKIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiEKIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:36:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1779D55360;
        Wed, 11 May 2022 01:36:50 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KypBw1B6dz1JC74;
        Wed, 11 May 2022 16:35:36 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 16:36:48 +0800
Subject: Re: [PATCH -next] powerpc: add support for syscall stack
 randomization
To:     Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <benh@kernel.crashing.org>, <christophe.leroy@csgroup.eu>,
        <mark.rutland@arm.com>, <mpe@ellerman.id.au>, <paulus@samba.org>,
        <tglx@linutronix.de>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <20220505111932.228814-1-xiujianfeng@huawei.com>
 <1652173338.7bltwybi0c.astroid@bobo.none> <202205100917.5480D91@keescook>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <34b960b1-c0e3-19da-ae49-c709b837f2de@huawei.com>
Date:   Wed, 11 May 2022 16:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <202205100917.5480D91@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/11 0:19, Kees Cook 写道:
> On Tue, May 10, 2022 at 07:23:46PM +1000, Nicholas Piggin wrote:
>> Excerpts from Xiu Jianfeng's message of May 5, 2022 9:19 pm:
>>> Add support for adding a random offset to the stack while handling
>>> syscalls. This patch uses mftb() instead of get_random_int() for better
>>> performance.
>> Hey, very nice.
> Agreed! :)
>
>>> [...]
>>> @@ -82,6 +83,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
>>>   
>>>   	kuap_lock();
>>>   
>>> +	add_random_kstack_offset();
>>>   	regs->orig_gpr3 = r3;
>>>   
>>>   	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>> This looks like the right place. I wonder why other interrupts don't
>> get the same treatment. Userspace can induce the kernel to take a
>> synchronous interrupt, or wait for async ones. Smaller surface area
>> maybe but certain instruction emulation for example could result in
>> significant logic that depends on user state. Anyway that's for
>> hardening gurus to ponder.
> I welcome it being used for any userspace controllable entry to the
> kernel! :)
>
> Also, related, have you validated the result using the LKDTM test?
> See tools/testing/selftests/lkdtm/stack-entropy.sh

not yet, I tested it by printing the address of local variable 
directly,  will do before I send v2,

thanks.

>>> @@ -405,6 +407,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>>>   
>>>   	/* Restore user access locks last */
>>>   	kuap_user_restore(regs);
>>> +	choose_random_kstack_offset(mftb() & 0xFF);
>>>   
>>>   	return ret;
>>>   }
>> So this seems to be what x86 and s390 do, but why are we choosing a
>> new offset for every interrupt when it's only used on a syscall?
>> I would rather you do what arm64 does and just choose the offset
>> at the end of system_call_exception.
>>
>> I wonder why the choose is separated from the add? I guess it's to
>> avoid a data dependency for stack access on an expensive random
>> function, so that makes sense (a comment would be nice in the
>> generic code).
> How does this read? I can send a "real" patch if it looks good:
>
>
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index 1468caf001c0..ad3e80275c74 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -40,8 +40,11 @@ DECLARE_PER_CPU(u32, kstack_offset);
>    */
>   #define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
>   
> -/*
> - * These macros must be used during syscall entry when interrupts and
> +/**
> + * add_random_kstack_offset - Increase stack utilization by previously
> + *			      chosen random offset
> + *
> + * This should be used in the syscall entry path when interrupts and
>    * preempt are disabled, and after user registers have been stored to
>    * the stack.
>    */
> @@ -55,6 +58,24 @@ DECLARE_PER_CPU(u32, kstack_offset);
>   	}								\
>   } while (0)
>   
> +/**
> + * choose_random_kstack_offset - Choose the random offsset for the next
> + *				 add_random_kstack_offset()
> + *
> + * This should only be used during syscall exit when interrupts and
> + * preempt are disabled, and before user registers have been restored
> + * from the stack. This is done to frustrate attack attempts from
> + * userspace to learn the offset:
> + * - Maximize the timing uncertainty visible from userspace: if the
> + *   the offset is chosen at syscall entry, userspace has much more
> + *   control over the timing between chosen offsets. "How long will we
> + *   be in kernel mode?" tends to be more difficult to know than "how
> + *   long will be be in user mode?"
> + * - Reduce the lifetime of the new offset sitting in memory during
> + *   kernel mode execution. Exposures of "thread-local" (e.g. current,
> + *   percpu, etc) memory contents tends to be easier than arbitrary
> + *   location memory exposures.
> + */
>   #define choose_random_kstack_offset(rand) do {				\
>   	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>   				&randomize_kstack_offset)) {		\
>
>
