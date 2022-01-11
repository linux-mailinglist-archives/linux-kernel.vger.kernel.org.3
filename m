Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D841A48AC22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiAKLGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiAKLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:06:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259AC061748;
        Tue, 11 Jan 2022 03:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD656159D;
        Tue, 11 Jan 2022 11:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20D0C36AE3;
        Tue, 11 Jan 2022 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641899163;
        bh=+YAl/IpQceTXHbVhHLrxVhuEnb4RZPj0hvqh14o8ENk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPYFURlaQX+0nFoLMLbKUcIo13KhGNdBCGUigh/53sX144YmxCL3lwkv7PPyEz+yX
         qDxzKESWq8BSXcDXNoRPrQj2qhMyKgm0pg3RlHJuFtF57ks9KgWqU8EnxCfcL/I1wx
         /DNY2MzsXQnc0JMOw0m8BunCm5Xw0h0d18r0+9FwFVITRlXSi4ilKybtIZnxce/jzc
         stByQ1R0CMWPlCQDCZMR3H/ZZP4LXzpxiUEAWtsE/08d5vf+i60bBz/Rx17zuxZVT4
         k4vH8reLqxyqlfX88U91PUwnSxpFgHMJZJZEzxO4XjBU5t8dD+9YM7iCZjh2YlIwvv
         XQLHqyD3r3PUQ==
Date:   Tue, 11 Jan 2022 12:05:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com
Subject: Re: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Message-ID: <20220111110556.inteixgtl5vpmka7@wittgenstein>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:16:10PM -0500, Mathieu Desnoyers wrote:
> Allow rseq critical section abort handlers to optionally figure out at
> which instruction pointer the rseq critical section was aborted.
> 
> This allows implementing rseq critical sections with loops containing
> the commit instruction, for which having the commit as last instruction
> of the sequence is not possible.  This is useful to implement adaptative
> mutexes aware of preemption in user-space. (see [1])
> 
> This also allows implementing rseq critical sections with multiple
> commit steps, and use the abort-at-ip information to figure out what
> needs to be undone in the abort handler.
> 
> Introduce the RSEQ_FLAG_QUERY_ABORT_AT_IP rseq system call flag.  This
> lets userspace query whether the kernel and architecture supports the
> abort-at-ip rseq extension.
> 
> Only provide this information for rseq critical sections for which the
> rseq_cs descriptor has the RSEQ_CS_FLAG_ABORT_AT_IP flag set.  Abort
> handlers for critical sections with this flag set need to readjust the
> stack pointer.  The abort-at-ip pointer is populated by the kernel on
> the top of stack on abort.  For x86-32, the abort handler of an
> abort-at-ip critical section needs to add 4 bytes to the stack pointer.
> For x86-64, the abort hanler needs to add 136 bytes to the stack
> pointer: 8 bytes to skip the abort-at-ip value, and 128 bytes to skip
> the x86-64 redzone for leaf functions.
> 
> [1] https://github.com/compudj/rseq-test/blob/adapt-lock-abort-at-ip/test-rseq-adaptative-lock.c#L80
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> Changes since v1:
> - Use top of stack to place abort-at-ip value rather than ecx/rcx
>   register,
> - Skip redzone on x86-64.
> ---
>  arch/x86/include/asm/ptrace.h |  5 +++++
>  arch/x86/kernel/ptrace.c      | 12 ++++++++++++
>  include/uapi/linux/rseq.h     |  4 ++++
>  kernel/rseq.c                 | 28 ++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 703663175a5a..c96eb2448110 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -387,5 +387,10 @@ extern int do_set_thread_area(struct task_struct *p, int idx,
>  # define do_set_thread_area_64(p, s, t)	(0)
>  #endif
>  
> +#ifdef CONFIG_RSEQ
> +# define RSEQ_ARCH_HAS_ABORT_AT_IP
> +int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip);
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_PTRACE_H */
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 6d2244c94799..561ed98d12ba 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -1368,3 +1368,15 @@ void user_single_step_report(struct pt_regs *regs)
>  {
>  	send_sigtrap(regs, 0, TRAP_BRKPT);
>  }
> +
> +int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip)
> +{
> +	if (user_64bit_mode(regs)) {
> +		/* Need to skip redzone for leaf functions. */
> +		regs->sp -= sizeof(u64) + 128;
> +		return put_user(ip, (u64 __user *)regs->sp);
> +	} else {
> +		regs->sp -= sizeof(u32);
> +		return put_user(ip, (u32 __user *)regs->sp);
> +	}

I think it would be really helpful if you added the full explanation for
sizeof(u64) + 128 or -sizeof(u32) into this codepath or provide
constants. For folks not familiar with stuff like this it'll look like
magic numbers. :)

> +}
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index 9a402fdb60e9..3130232e6d0c 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -20,12 +20,14 @@ enum rseq_cpu_id_state {
>  
>  enum rseq_flags {
>  	RSEQ_FLAG_UNREGISTER = (1 << 0),
> +	RSEQ_FLAG_QUERY_ABORT_AT_IP = (1 << 1),
>  };
>  
>  enum rseq_cs_flags_bit {
>  	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
> +	RSEQ_CS_FLAG_ABORT_AT_IP_BIT		= 3,
>  };
>  
>  enum rseq_cs_flags {
> @@ -35,6 +37,8 @@ enum rseq_cs_flags {
>  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
>  	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
>  		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> +	RSEQ_CS_FLAG_ABORT_AT_IP		=
> +		(1U << RSEQ_CS_FLAG_ABORT_AT_IP_BIT),
>  };
>  
>  /*
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 6d45ac3dae7f..fb52f2d11b56 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -21,6 +21,13 @@
>  #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
>  				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
>  
> +#ifdef RSEQ_ARCH_HAS_ABORT_AT_IP
> +static bool rseq_has_abort_at_ip(void) { return true; }
> +#else
> +static bool rseq_has_abort_at_ip(void) { return false; }
> +static int rseq_abort_at_ip(struct pt_regs *regs, unsigned long ip) { return 0; }
> +#endif
> +
>  /*
>   *
>   * Restartable sequences are a lightweight interface that allows
> @@ -79,6 +86,16 @@
>   *
>   *       [abort_ip]
>   *   F1. <failure>
> + *
> + * rseq critical sections defined with the RSEQ_CS_FLAG_ABORT_AT_IP flag
> + * have the following behavior on abort: when the stack grows down: the
> + * stack pointer is decremented to skip the redzone, and decremented of
> + * the pointer size.  The aborted address (abort-at-ip) is stored at
> + * this stack pointer location.  The user-space abort handler needs to
> + * pop the abort-at-ip address from the stack, and add the redzone size
> + * to the stack pointer.
> + *
> + * TODO: describe stack grows up.

Is this intentional or did you forget? :)
