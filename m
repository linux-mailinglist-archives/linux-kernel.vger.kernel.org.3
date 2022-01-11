Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A798348B42F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiAKRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:43:08 -0500
Received: from mail.efficios.com ([167.114.26.124]:49186 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbiAKRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:43:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF0849E0B2;
        Tue, 11 Jan 2022 12:43:06 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xUJmegCQTBfR; Tue, 11 Jan 2022 12:43:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 129E19E028;
        Tue, 11 Jan 2022 12:43:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 129E19E028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641922986;
        bh=xBh+V9iay3cToS0t36FKQFANnpaQbWaUYYK4vn8gyhc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jkvNSj2pR4No50UgXn+NKaXeDld/g/F3K8ELsXWojlP5PrCT0BPMugHlS47TZrTbm
         MIcsHF0qlD2BnYjvFcdQY31meuOFl/S4rI0oUODCGzL4uZf+aWjAivTV77HAREk2pl
         NZoiN5X7gQkQN8hPg+Raqi83s2Hdyk8YIfX3mi3KwazT6rc0iUxoAu5xZfM2X5EGTs
         uIyGPqqwIQFH229z9iBTTzwbXBgbx+9Tj3JjnqGGmMZcZGrRzA1cuWUazyUWkNd0MZ
         4bBpYUW+AduMrER1Hl76Ssddpz2OfjIdSNvT73X6ARW0GcWxX/c1Gv80j8mE5y2hjk
         uIrwt4ctSsZZA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CsoC32ApfVrI; Tue, 11 Jan 2022 12:43:06 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DCDDE9E23B;
        Tue, 11 Jan 2022 12:43:05 -0500 (EST)
Date:   Tue, 11 Jan 2022 12:43:05 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>
Message-ID: <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220111110556.inteixgtl5vpmka7@wittgenstein>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com> <20220111110556.inteixgtl5vpmka7@wittgenstein>
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq: x86: implement abort-at-ip extension
Thread-Index: gVz1eiEL8mZgJB0IBKSKfeVQDSFc0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 11, 2022, at 6:05 AM, Christian Brauner brauner@kernel.org wrote:

> On Mon, Jan 10, 2022 at 12:16:10PM -0500, Mathieu Desnoyers wrote:
>> Allow rseq critical section abort handlers to optionally figure out at
>> which instruction pointer the rseq critical section was aborted.
>> 
>> This allows implementing rseq critical sections with loops containing
>> the commit instruction, for which having the commit as last instruction
>> of the sequence is not possible.  This is useful to implement adaptative
>> mutexes aware of preemption in user-space. (see [1])
>> 
>> This also allows implementing rseq critical sections with multiple
>> commit steps, and use the abort-at-ip information to figure out what
>> needs to be undone in the abort handler.
>> 
>> Introduce the RSEQ_FLAG_QUERY_ABORT_AT_IP rseq system call flag.  This
>> lets userspace query whether the kernel and architecture supports the
>> abort-at-ip rseq extension.
>> 
>> Only provide this information for rseq critical sections for which the
>> rseq_cs descriptor has the RSEQ_CS_FLAG_ABORT_AT_IP flag set.  Abort
>> handlers for critical sections with this flag set need to readjust the
>> stack pointer.  The abort-at-ip pointer is populated by the kernel on
>> the top of stack on abort.  For x86-32, the abort handler of an
>> abort-at-ip critical section needs to add 4 bytes to the stack pointer.
>> For x86-64, the abort hanler needs to add 136 bytes to the stack
>> pointer: 8 bytes to skip the abort-at-ip value, and 128 bytes to skip
>> the x86-64 redzone for leaf functions.
>> 
>> [1]
>> https://github.com/compudj/rseq-test/blob/adapt-lock-abort-at-ip/test-rseq-adaptative-lock.c#L80
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>> Changes since v1:
>> - Use top of stack to place abort-at-ip value rather than ecx/rcx
>>   register,
>> - Skip redzone on x86-64.
>> ---
>>  arch/x86/include/asm/ptrace.h |  5 +++++
>>  arch/x86/kernel/ptrace.c      | 12 ++++++++++++
>>  include/uapi/linux/rseq.h     |  4 ++++
>>  kernel/rseq.c                 | 28 ++++++++++++++++++++++++++++
>>  4 files changed, 49 insertions(+)
>> 
>> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
>> index 703663175a5a..c96eb2448110 100644
>> --- a/arch/x86/include/asm/ptrace.h
>> +++ b/arch/x86/include/asm/ptrace.h
>> @@ -387,5 +387,10 @@ extern int do_set_thread_area(struct task_struct *p, int
>> idx,
>>  # define do_set_thread_area_64(p, s, t)	(0)
>>  #endif
>>  
>> +#ifdef CONFIG_RSEQ
>> +# define RSEQ_ARCH_HAS_ABORT_AT_IP
>> +int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip);
>> +#endif
>> +
>>  #endif /* !__ASSEMBLY__ */
>>  #endif /* _ASM_X86_PTRACE_H */
>> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
>> index 6d2244c94799..561ed98d12ba 100644
>> --- a/arch/x86/kernel/ptrace.c
>> +++ b/arch/x86/kernel/ptrace.c
>> @@ -1368,3 +1368,15 @@ void user_single_step_report(struct pt_regs *regs)
>>  {
>>  	send_sigtrap(regs, 0, TRAP_BRKPT);
>>  }
>> +
>> +int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip)
>> +{
>> +	if (user_64bit_mode(regs)) {
>> +		/* Need to skip redzone for leaf functions. */
>> +		regs->sp -= sizeof(u64) + 128;
>> +		return put_user(ip, (u64 __user *)regs->sp);
>> +	} else {
>> +		regs->sp -= sizeof(u32);
>> +		return put_user(ip, (u32 __user *)regs->sp);
>> +	}
> 
> I think it would be really helpful if you added the full explanation for
> sizeof(u64) + 128 or -sizeof(u32) into this codepath or provide
> constants. For folks not familiar with stuff like this it'll look like
> magic numbers. :)

Good point, here is the planned update:

int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip)
{
        if (user_64bit_mode(regs)) {
                /*
                 * rseq abort-at-ip x86-64 ABI: stack pointer is decremented to
                 * skip the redzone (128 bytes on x86-64), and decremented of
                 * the pointer size (8 bytes).  The aborted address (abort-at-ip)
                 * is stored at this updated stack pointer location (top of stack).
                 *
                 * Skipping the redzone is needed to make sure not to corrupt
                 * stack data when the rseq critical section is within a leaf
                 * function.
                 */
                regs->sp -= sizeof(u64) + 128;
                return put_user(ip, (u64 __user *)regs->sp);
        } else {
                /*
                 * rseq abort-at-ip x86-32 ABI: stack pointer is decremented of
                 * the pointer size (4 bytes).  The aborted address (abort-at-ip)
                 * is stored at this updated stack pointer location (top of stack).
                 */
                regs->sp -= sizeof(u32);
                return put_user(ip, (u32 __user *)regs->sp);
        }
}



> 
>> +}
>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>> index 9a402fdb60e9..3130232e6d0c 100644
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -20,12 +20,14 @@ enum rseq_cpu_id_state {
>>  
>>  enum rseq_flags {
>>  	RSEQ_FLAG_UNREGISTER = (1 << 0),
>> +	RSEQ_FLAG_QUERY_ABORT_AT_IP = (1 << 1),
>>  };
>>  
>>  enum rseq_cs_flags_bit {
>>  	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>>  	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
>> +	RSEQ_CS_FLAG_ABORT_AT_IP_BIT		= 3,
>>  };
>>  
>>  enum rseq_cs_flags {
>> @@ -35,6 +37,8 @@ enum rseq_cs_flags {
>>  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
>>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
>>  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>> +	RSEQ_CS_FLAG_ABORT_AT_IP		=
>> +		(1U << RSEQ_CS_FLAG_ABORT_AT_IP_BIT),
>>  };
>>  
>>  /*
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 6d45ac3dae7f..fb52f2d11b56 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -21,6 +21,13 @@
>>  #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
>>  				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
>>  
>> +#ifdef RSEQ_ARCH_HAS_ABORT_AT_IP
>> +static bool rseq_has_abort_at_ip(void) { return true; }
>> +#else
>> +static bool rseq_has_abort_at_ip(void) { return false; }
>> +static int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip) { return 0;
>> }
>> +#endif
>> +
>>  /*
>>   *
>>   * Restartable sequences are a lightweight interface that allows
>> @@ -79,6 +86,16 @@
>>   *
>>   *       [abort_ip]
>>   *   F1. <failure>
>> + *
>> + * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
>> + * have the following behavior on abort: when the stack grows down: the
>> + * stack pointer is decremented to skip the redzone, and decremented of
>> + * the pointer size.  The aborted address (abort-at-ip) is stored at
>> + * this stack pointer location.  The user-space abort handler needs to
>> + * pop the abort-at-ip address from the stack, and add the redzone size
>> + * to the stack pointer.
>> + *
>> + * TODO: describe stack grows up.
> 
> Is this intentional or did you forget? :)

Since I did not implement abort-at-ip on stack-grows-up architectures, I felt
it would be too early to describe the algorithm. I can simply remove the TODO
altogether and we'll take care of it when we get there ? If I had to try to
wordsmith it, it would look like e.g.:

 *                                    [...] When the stack grows up: the
 * stack pointer is incremented to skip the redzone, and incremented of
 * the pointer size.  The aborted address (abort-at-ip) is stored immediately
 * under this stack pointer location.  The user-space abort handler needs to
 * pop the abort-at-ip address from the stack, and subtract the redzone size
 * from the stack pointer.

[ Please let me know if I got somehow confused in my understanding of stack grows
up architectures. ]

I'm also unsure whether any of the stack grows up architecture have redzones ?
From a quick grep for redzone in Linux arch/, only openrisc, powerpc64 and
x86-64 appear to have redzones.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
