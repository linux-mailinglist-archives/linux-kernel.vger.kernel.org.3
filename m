Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CB474D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhLNVvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:51:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42890 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231130AbhLNVvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:51:31 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC6231EC01DF;
        Tue, 14 Dec 2021 22:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639518686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dtrIY+28yL2pqjL89pCI2cj0FcduCyJaiFUSJFsTa54=;
        b=b7VA6pUh0dLNL7eTgbezmrGMTc6ofa2QXAA4vKmjiohBjg6mWcpHCUtNQiE+5mEFF819ES
        IoMynwTVDClRkn5vTO+akUU0X+h8jaBvXHeYn4aR0/NVJ8fvI+9Zn0aY/zrJSIV6NBYUq2
        BC9plLaT+lN1YnHcI7ak9pI5Bq1nw54=
Date:   Tue, 14 Dec 2021 22:51:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is
 also in syscall gap
Message-ID: <YbkR36Vpb1h5SlMZ@zn.tnic>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213042215.3096-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tom and leaving the whole mail un-trimmed for him.

On Mon, Dec 13, 2021 at 12:22:15PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When returning to user space, the %rsp is user controlled value.

And?

I'd expect to see here some text analyzing the couple of instructions
between those new labels you've added and whether a #VC can happen
there.

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S        | 2 ++
>  arch/x86/entry/entry_64_compat.S | 2 ++
>  arch/x86/include/asm/proto.h     | 4 ++++
>  arch/x86/include/asm/ptrace.h    | 4 ++++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e23319ad3f42..44dadea935f7 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -213,8 +213,10 @@ syscall_return_via_sysret:
>  
>  	popq	%rdi
>  	popq	%rsp
> +SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
>  	swapgs
>  	sysretq
> +SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
>  SYM_CODE_END(entry_SYSCALL_64)
>  
>  /*
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 0051cf5c792d..98afdf92f360 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -293,6 +293,7 @@ sysret32_from_system_call:
>  	 * code.  We zero R8-R10 to avoid info leaks.
>           */
>  	movq	RSP-ORIG_RAX(%rsp), %rsp
> +SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
>  
>  	/*
>  	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
> @@ -310,6 +311,7 @@ sysret32_from_system_call:
>  	xorl	%r10d, %r10d
>  	swapgs
>  	sysretl
> +SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
>  SYM_CODE_END(entry_SYSCALL_compat)
>  
>  /*
> diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
> index feed36d44d04..f042cfc9938f 100644
> --- a/arch/x86/include/asm/proto.h
> +++ b/arch/x86/include/asm/proto.h
> @@ -13,6 +13,8 @@ void syscall_init(void);
>  #ifdef CONFIG_X86_64
>  void entry_SYSCALL_64(void);
>  void entry_SYSCALL_64_safe_stack(void);
> +void entry_SYSRETQ_unsafe_stack(void);
> +void entry_SYSRETQ_end(void);
>  long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
>  #endif
>  
> @@ -28,6 +30,8 @@ void entry_SYSENTER_compat(void);
>  void __end_entry_SYSENTER_compat(void);
>  void entry_SYSCALL_compat(void);
>  void entry_SYSCALL_compat_safe_stack(void);
> +void entry_SYSRETL_compat_unsafe_stack(void);
> +void entry_SYSRETL_compat_end(void);
>  void entry_INT80_compat(void);
>  #ifdef CONFIG_XEN_PV
>  void xen_entry_INT80_compat(void);
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 703663175a5a..b3d2ba13cee2 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -186,9 +186,13 @@ static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
>  	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
>  		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
>  
> +	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack &&
> +		      regs->ip <  (unsigned long)entry_SYSRETQ_end);
>  #ifdef CONFIG_IA32_EMULATION
>  	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_compat &&
>  		      regs->ip <  (unsigned long)entry_SYSCALL_compat_safe_stack);
> +	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETL_compat_unsafe_stack &&
> +		      regs->ip <  (unsigned long)entry_SYSRETL_compat_end);
>  #endif
>  
>  	return ret;
> -- 
> 2.19.1.6.gb485710b
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
