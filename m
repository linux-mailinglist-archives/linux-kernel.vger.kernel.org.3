Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2195614E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiF3IXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiF3IW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:22:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32677B6D;
        Thu, 30 Jun 2022 01:22:53 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYWVT4nzZzhYx7;
        Thu, 30 Jun 2022 16:20:33 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 16:22:51 +0800
Subject: Re: [PATCH -next, v2] powerpc: add support for syscall stack
 randomization
To:     Michael Ellerman <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20220516073225.112875-1-xiujianfeng@huawei.com>
 <87zghw2efr.fsf@mpe.ellerman.id.au>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <347aee64-fd5b-c8c6-55c8-76fd49e089e7@huawei.com>
Date:   Thu, 30 Jun 2022 16:22:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87zghw2efr.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/6/29 14:04, Michael Ellerman Ð´µÀ:
> Xiu Jianfeng <xiujianfeng@huawei.com> writes:
>> Add support for adding a random offset to the stack while handling
>> syscalls. This patch uses mftb() instead of get_random_int() for better
>> performance.
>>
>> In order to avoid unconditional stack canaries on syscall entry (due to
>> the use of alloca()), also disable stack protector to avoid triggering
>> needless checks and slowing down the entry path. As there is no general
>> way to control stack protector coverage with a function attribute, this
>> must be disabled at the compilation unit level.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> ---
>> Changes in v2:
>>    -move choose choose_random_kstack_offset() to the end of system_call_exception
>>    -allow full 6 (10) bits of entropy
>>    -disable stack-protector for interrupt.c
>> ---
>>   arch/powerpc/Kconfig            |  1 +
>>   arch/powerpc/kernel/Makefile    |  7 +++++++
>>   arch/powerpc/kernel/interrupt.c | 19 ++++++++++++++++++-
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 98309eeae09c..2f0019a0054e 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -192,6 +192,7 @@ config PPC
>>   	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
>>   	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
>>   	select HAVE_ARCH_KFENCE			if PPC_BOOK3S_32 || PPC_8xx || 40x
>> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>>   	select HAVE_ARCH_KGDB
>>   	select HAVE_ARCH_MMAP_RND_BITS
>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index 4ddd161aef32..5c5e85b8229b 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -40,6 +40,13 @@ CFLAGS_cputable.o += -DDISABLE_BRANCH_PROFILING
>>   CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
>>   endif
>>   
>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>> +# Remove stack protector to avoid triggering unneeded stack canary
>> +# checks due to randomize_kstack_offset.
>> +CFLAGS_REMOVE_interrupt.o = -fstack-protector -fstack-protector-strong
>> +CFLAGS_interrupt.o += -fno-stack-protector
>> +#endif
> I'm a bit reluctant to remove stack protection from all of interrupt.c
> just for this feature.
>
> It's true that none of the functions in interrupt.c currently trigger
> stack protection, but that could change in future.
>
> What about splitting system_call_exception() into a separate file as a
> lead-up patch, example below. Then we can just exclude stack protection
> from that one function.
>
> cheers
Thanks, it's a good idea, I will do in v3.
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index f91f0f29a566..ecfd333b95d1 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -61,7 +61,7 @@ obj-y				:= cputable.o syscalls.o \
>   				   udbg.o misc.o io.o misc_$(BITS).o \
>   				   of_platform.o prom_parse.o firmware.o \
>   				   hw_breakpoint_constraints.o interrupt.o \
> -				   kdebugfs.o stacktrace.o
> +				   kdebugfs.o stacktrace.o syscall.o
>   obj-y				+= ptrace/
>   obj-$(CONFIG_PPC64)		+= setup_64.o \
>   				   paca.o nvram_64.o note.o
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 784ea3289c84..0e75cb03244a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -24,8 +24,6 @@
>   unsigned long global_dbcr0[NR_CPUS];
>   #endif
>   
> -typedef long (*syscall_fn)(long, long, long, long, long, long);
> -
>   #ifdef CONFIG_PPC_BOOK3S_64
>   DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
>   static inline bool exit_must_hard_disable(void)
> @@ -73,165 +71,6 @@ static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
>   	return true;
>   }
>   
> -/* Has to run notrace because it is entered not completely "reconciled" */
> -notrace long system_call_exception(long r3, long r4, long r5,
> -				   long r6, long r7, long r8,
> -				   unsigned long r0, struct pt_regs *regs)
> -{
> -	syscall_fn f;
> -
> -	kuap_lock();
> -
> -	regs->orig_gpr3 = r3;
> -
> -	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> -		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
> -
> -	trace_hardirqs_off(); /* finish reconciling */
> -
> -	CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
> -	user_exit_irqoff();
> -
> -	BUG_ON(regs_is_unrecoverable(regs));
> -	BUG_ON(!(regs->msr & MSR_PR));
> -	BUG_ON(arch_irq_disabled_regs(regs));
> -
> -#ifdef CONFIG_PPC_PKEY
> -	if (mmu_has_feature(MMU_FTR_PKEY)) {
> -		unsigned long amr, iamr;
> -		bool flush_needed = false;
> -		/*
> -		 * When entering from userspace we mostly have the AMR/IAMR
> -		 * different from kernel default values. Hence don't compare.
> -		 */
> -		amr = mfspr(SPRN_AMR);
> -		iamr = mfspr(SPRN_IAMR);
> -		regs->amr  = amr;
> -		regs->iamr = iamr;
> -		if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
> -			mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
> -			flush_needed = true;
> -		}
> -		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
> -			mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
> -			flush_needed = true;
> -		}
> -		if (flush_needed)
> -			isync();
> -	} else
> -#endif
> -		kuap_assert_locked();
> -
> -	booke_restore_dbcr0();
> -
> -	account_cpu_user_entry();
> -
> -	account_stolen_time();
> -
> -	/*
> -	 * This is not required for the syscall exit path, but makes the
> -	 * stack frame look nicer. If this was initialised in the first stack
> -	 * frame, or if the unwinder was taught the first stack frame always
> -	 * returns to user with IRQS_ENABLED, this store could be avoided!
> -	 */
> -	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
> -
> -	/*
> -	 * If system call is called with TM active, set _TIF_RESTOREALL to
> -	 * prevent RFSCV being used to return to userspace, because POWER9
> -	 * TM implementation has problems with this instruction returning to
> -	 * transactional state. Final register values are not relevant because
> -	 * the transaction will be aborted upon return anyway. Or in the case
> -	 * of unsupported_scv SIGILL fault, the return state does not much
> -	 * matter because it's an edge case.
> -	 */
> -	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> -			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
> -		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
> -
> -	/*
> -	 * If the system call was made with a transaction active, doom it and
> -	 * return without performing the system call. Unless it was an
> -	 * unsupported scv vector, in which case it's treated like an illegal
> -	 * instruction.
> -	 */
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
> -	    !trap_is_unsupported_scv(regs)) {
> -		/* Enable TM in the kernel, and disable EE (for scv) */
> -		hard_irq_disable();
> -		mtmsr(mfmsr() | MSR_TM);
> -
> -		/* tabort, this dooms the transaction, nothing else */
> -		asm volatile(".long 0x7c00071d | ((%0) << 16)"
> -				:: "r"(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT));
> -
> -		/*
> -		 * Userspace will never see the return value. Execution will
> -		 * resume after the tbegin. of the aborted transaction with the
> -		 * checkpointed register state. A context switch could occur
> -		 * or signal delivered to the process before resuming the
> -		 * doomed transaction context, but that should all be handled
> -		 * as expected.
> -		 */
> -		return -ENOSYS;
> -	}
> -#endif // CONFIG_PPC_TRANSACTIONAL_MEM
> -
> -	local_irq_enable();
> -
> -	if (unlikely(read_thread_flags() & _TIF_SYSCALL_DOTRACE)) {
> -		if (unlikely(trap_is_unsupported_scv(regs))) {
> -			/* Unsupported scv vector */
> -			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> -			return regs->gpr[3];
> -		}
> -		/*
> -		 * We use the return value of do_syscall_trace_enter() as the
> -		 * syscall number. If the syscall was rejected for any reason
> -		 * do_syscall_trace_enter() returns an invalid syscall number
> -		 * and the test against NR_syscalls will fail and the return
> -		 * value to be used is in regs->gpr[3].
> -		 */
> -		r0 = do_syscall_trace_enter(regs);
> -		if (unlikely(r0 >= NR_syscalls))
> -			return regs->gpr[3];
> -		r3 = regs->gpr[3];
> -		r4 = regs->gpr[4];
> -		r5 = regs->gpr[5];
> -		r6 = regs->gpr[6];
> -		r7 = regs->gpr[7];
> -		r8 = regs->gpr[8];
> -
> -	} else if (unlikely(r0 >= NR_syscalls)) {
> -		if (unlikely(trap_is_unsupported_scv(regs))) {
> -			/* Unsupported scv vector */
> -			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> -			return regs->gpr[3];
> -		}
> -		return -ENOSYS;
> -	}
> -
> -	/* May be faster to do array_index_nospec? */
> -	barrier_nospec();
> -
> -	if (unlikely(is_compat_task())) {
> -		f = (void *)compat_sys_call_table[r0];
> -
> -		r3 &= 0x00000000ffffffffULL;
> -		r4 &= 0x00000000ffffffffULL;
> -		r5 &= 0x00000000ffffffffULL;
> -		r6 &= 0x00000000ffffffffULL;
> -		r7 &= 0x00000000ffffffffULL;
> -		r8 &= 0x00000000ffffffffULL;
> -
> -	} else {
> -		f = (void *)sys_call_table[r0];
> -	}
> -
> -	return f(r3, r4, r5, r6, r7, r8);
> -}
> -
>   static notrace void booke_load_dbcr0(void)
>   {
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> new file mode 100644
> index 000000000000..4d5689eeaf25
> --- /dev/null
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/compat.h>
> +#include <linux/context_tracking.h>
> +
> +#include <asm/interrupt.h>
> +#include <asm/kup.h>
> +#include <asm/syscall.h>
> +#include <asm/time.h>
> +#include <asm/tm.h>
> +#include <asm/unistd.h>
> +
> +
> +typedef long (*syscall_fn)(long, long, long, long, long, long);
> +
> +/* Has to run notrace because it is entered not completely "reconciled" */
> +notrace long system_call_exception(long r3, long r4, long r5,
> +				   long r6, long r7, long r8,
> +				   unsigned long r0, struct pt_regs *regs)
> +{
> +	syscall_fn f;
> +
> +	kuap_lock();
> +
> +	regs->orig_gpr3 = r3;
> +
> +	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> +		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
> +
> +	trace_hardirqs_off(); /* finish reconciling */
> +
> +	CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
> +	user_exit_irqoff();
> +
> +	BUG_ON(regs_is_unrecoverable(regs));
> +	BUG_ON(!(regs->msr & MSR_PR));
> +	BUG_ON(arch_irq_disabled_regs(regs));
> +
> +#ifdef CONFIG_PPC_PKEY
> +	if (mmu_has_feature(MMU_FTR_PKEY)) {
> +		unsigned long amr, iamr;
> +		bool flush_needed = false;
> +		/*
> +		 * When entering from userspace we mostly have the AMR/IAMR
> +		 * different from kernel default values. Hence don't compare.
> +		 */
> +		amr = mfspr(SPRN_AMR);
> +		iamr = mfspr(SPRN_IAMR);
> +		regs->amr  = amr;
> +		regs->iamr = iamr;
> +		if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
> +			mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
> +			flush_needed = true;
> +		}
> +		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
> +			mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
> +			flush_needed = true;
> +		}
> +		if (flush_needed)
> +			isync();
> +	} else
> +#endif
> +		kuap_assert_locked();
> +
> +	booke_restore_dbcr0();
> +
> +	account_cpu_user_entry();
> +
> +	account_stolen_time();
> +
> +	/*
> +	 * This is not required for the syscall exit path, but makes the
> +	 * stack frame look nicer. If this was initialised in the first stack
> +	 * frame, or if the unwinder was taught the first stack frame always
> +	 * returns to user with IRQS_ENABLED, this store could be avoided!
> +	 */
> +	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
> +
> +	/*
> +	 * If system call is called with TM active, set _TIF_RESTOREALL to
> +	 * prevent RFSCV being used to return to userspace, because POWER9
> +	 * TM implementation has problems with this instruction returning to
> +	 * transactional state. Final register values are not relevant because
> +	 * the transaction will be aborted upon return anyway. Or in the case
> +	 * of unsupported_scv SIGILL fault, the return state does not much
> +	 * matter because it's an edge case.
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> +			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
> +		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
> +
> +	/*
> +	 * If the system call was made with a transaction active, doom it and
> +	 * return without performing the system call. Unless it was an
> +	 * unsupported scv vector, in which case it's treated like an illegal
> +	 * instruction.
> +	 */
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
> +	    !trap_is_unsupported_scv(regs)) {
> +		/* Enable TM in the kernel, and disable EE (for scv) */
> +		hard_irq_disable();
> +		mtmsr(mfmsr() | MSR_TM);
> +
> +		/* tabort, this dooms the transaction, nothing else */
> +		asm volatile(".long 0x7c00071d | ((%0) << 16)"
> +				:: "r"(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT));
> +
> +		/*
> +		 * Userspace will never see the return value. Execution will
> +		 * resume after the tbegin. of the aborted transaction with the
> +		 * checkpointed register state. A context switch could occur
> +		 * or signal delivered to the process before resuming the
> +		 * doomed transaction context, but that should all be handled
> +		 * as expected.
> +		 */
> +		return -ENOSYS;
> +	}
> +#endif // CONFIG_PPC_TRANSACTIONAL_MEM
> +
> +	local_irq_enable();
> +
> +	if (unlikely(read_thread_flags() & _TIF_SYSCALL_DOTRACE)) {
> +		if (unlikely(trap_is_unsupported_scv(regs))) {
> +			/* Unsupported scv vector */
> +			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> +			return regs->gpr[3];
> +		}
> +		/*
> +		 * We use the return value of do_syscall_trace_enter() as the
> +		 * syscall number. If the syscall was rejected for any reason
> +		 * do_syscall_trace_enter() returns an invalid syscall number
> +		 * and the test against NR_syscalls will fail and the return
> +		 * value to be used is in regs->gpr[3].
> +		 */
> +		r0 = do_syscall_trace_enter(regs);
> +		if (unlikely(r0 >= NR_syscalls))
> +			return regs->gpr[3];
> +		r3 = regs->gpr[3];
> +		r4 = regs->gpr[4];
> +		r5 = regs->gpr[5];
> +		r6 = regs->gpr[6];
> +		r7 = regs->gpr[7];
> +		r8 = regs->gpr[8];
> +
> +	} else if (unlikely(r0 >= NR_syscalls)) {
> +		if (unlikely(trap_is_unsupported_scv(regs))) {
> +			/* Unsupported scv vector */
> +			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> +			return regs->gpr[3];
> +		}
> +		return -ENOSYS;
> +	}
> +
> +	/* May be faster to do array_index_nospec? */
> +	barrier_nospec();
> +
> +	if (unlikely(is_compat_task())) {
> +		f = (void *)compat_sys_call_table[r0];
> +
> +		r3 &= 0x00000000ffffffffULL;
> +		r4 &= 0x00000000ffffffffULL;
> +		r5 &= 0x00000000ffffffffULL;
> +		r6 &= 0x00000000ffffffffULL;
> +		r7 &= 0x00000000ffffffffULL;
> +		r8 &= 0x00000000ffffffffULL;
> +
> +	} else {
> +		f = (void *)sys_call_table[r0];
> +	}
> +
> +	return f(r3, r4, r5, r6, r7, r8);
> +}
