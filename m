Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7054F4672F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351149AbhLCH4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhLCH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:56:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B65C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:53:26 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id k4so2255865pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 23:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcaJfRFD0ChsREdtxzGfY7F7qf9moiLnQpnz0JQsiWg=;
        b=jJ1b2UU3ErITTCyVDtIAQ/4XQ/hUMadfmvn00MUNa9eeCnVzPSajbqRQDv/2lhaZGr
         NFQwOMlooNLduRYJt1MTQnQwHxbjJmJ4tsxiLoIzDqHtJIRGOh3Aw96V2hx95DO9VPvx
         967V8BuO+Y5gzmkI8HuG94iF5J8l3LNdnWqd87O18OtHr16ZRUt1bjwAC9RsbMIFcVr0
         smUTN+TpSWs0lXQ3hHFN22Sqr27JGt9JbFRdK6nG9A7RiB7RrlHIZ9XPJOOZbwu3jBGH
         vZOSaUQjtTjJ3r9CuOd6DK7Juba8klrzaO5A+lcIBoDE/Zhd4lvR1lXtUFcuNy/8HKxG
         L3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcaJfRFD0ChsREdtxzGfY7F7qf9moiLnQpnz0JQsiWg=;
        b=ASgJC8Jl/9vSx27Eq9nC8lVWNbGp5iO0oC6PrBQwFypMqQdjkCPPs6Wz/DtFjTMS4h
         cTHilTTT0UhAj0cASkkmoAl7YRRycMhh+WaCeXoMlUsKLIpqVFRJ3nSxZNkRO/7b7pFd
         sh6/3CKhprNKkWT7c/zl1ucPaoCasMnFKhAcwkb3rsNIWaBRmy6ZJPFeZ+PJMGzWg4z1
         VpZQ9wqYIdioNdnlWa5obAF0rkSFnNu0ayufHX3UQ1rWBRgTzD9AmcjkRwU0SVSpSJpj
         073fS4ZuC3/DUb2JdnElWR7EwZUY8r1zAr9O+JfsXVFXWAcloDNkPiUNW3LAs1GfrNdA
         q4GA==
X-Gm-Message-State: AOAM532XmT+fp4HV3e64jk/18Cy1ISC/Acc6cSs2WFk9HlzVFyBSt2aS
        JUVZ2Rxx+6+OqfxYXV+uMtM+BhusIBM=
X-Google-Smtp-Source: ABdhPJxDIj1a7FKeC2HqmS5tsjay9mnXVL+G2qAZAWA4v6iH0pPwDZhd3YWfrITJSbi2Uh7ioOeSGw==
X-Received: by 2002:a63:864a:: with SMTP id x71mr3452681pgd.60.1638518005903;
        Thu, 02 Dec 2021 23:53:25 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id d10sm2136727pfl.139.2021.12.02.23.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:53:25 -0800 (PST)
Date:   Fri, 3 Dec 2021 16:53:23 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Down <chris@chrisdown.name>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: remove wrappers for clone and fork
Message-ID: <YanM831BiT+tzmd7@antec>
References: <20211128022803.3828408-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128022803.3828408-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:28:01AM +0900, Stafford Horne wrote:
> The comment here explains that the extra saved registers are clobbered
> by _switch.  However, looking at switch they are definitely saved, so I
> am not sure why these wrappers are needed.  This was noticed when
> auditing the clone3 syscall path which works fine and does not have the
> extra wrapper code.
> 
> The patch removes the wrapper code as a cleanup.

Nak.

This breaks stuff.  More extensive testing resulted in instability.

There may be another way, but as for now this code that restores these
registers during return is basically clobbering them again.

        l.lwz   r12,PT_GPR12(r1)
        l.lwz   r14,PT_GPR14(r1)
        l.lwz   r16,PT_GPR16(r1)
        l.lwz   r18,PT_GPR18(r1)
        l.lwz   r20,PT_GPR20(r1)
        l.lwz   r22,PT_GPR22(r1)
        l.lwz   r24,PT_GPR24(r1)
        l.lwz   r26,PT_GPR26(r1)
        l.lwz   r28,PT_GPR28(r1)

        l.j     _syscall_return
         l.nop

-Stafford

> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/include/asm/syscalls.h |  7 ------
>  arch/openrisc/kernel/entry.S         | 36 ++--------------------------
>  2 files changed, 2 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/syscalls.h b/arch/openrisc/include/asm/syscalls.h
> index 3a7eeae6f56a..c8c8a5072ad9 100644
> --- a/arch/openrisc/include/asm/syscalls.h
> +++ b/arch/openrisc/include/asm/syscalls.h
> @@ -20,11 +20,4 @@ asmlinkage long sys_or1k_atomic(unsigned long type, unsigned long *v1,
>  
>  #include <asm-generic/syscalls.h>
>  
> -asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
> -			void __user *parent_tid, void __user *child_tid, int tls);
> -asmlinkage long __sys_fork(void);
> -
> -#define sys_clone __sys_clone
> -#define sys_fork __sys_fork
> -
>  #endif /* __ASM_OPENRISC_SYSCALLS_H */
> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index 59c6d3aa7081..062967e09fbb 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
> @@ -1139,43 +1139,11 @@ ENTRY(_switch)
>  
>  /* ==================================================================== */
>  
> -/* These all use the delay slot for setting the argument register, so the
> +/*
> + * This uses the delay slot for setting the argument register, so the
>   * jump is always happening after the l.addi instruction.
> - *
> - * These are all just wrappers that don't touch the link-register r9, so the
> - * return from the "real" syscall function will return back to the syscall
> - * code that did the l.jal that brought us here.
> - */
> -
> -/* fork requires that we save all the callee-saved registers because they
> - * are all effectively clobbered by the call to _switch.  Here we store
> - * all the registers that aren't touched by the syscall fast path and thus
> - * weren't saved there.
>   */
>  
> -_fork_save_extra_regs_and_call:
> -	l.sw    PT_GPR14(r1),r14
> -	l.sw    PT_GPR16(r1),r16
> -	l.sw    PT_GPR18(r1),r18
> -	l.sw    PT_GPR20(r1),r20
> -	l.sw    PT_GPR22(r1),r22
> -	l.sw    PT_GPR24(r1),r24
> -	l.sw    PT_GPR26(r1),r26
> -	l.jr	r29
> -	 l.sw    PT_GPR28(r1),r28
> -
> -ENTRY(__sys_clone)
> -	l.movhi	r29,hi(sys_clone)
> -	l.ori	r29,r29,lo(sys_clone)
> -	l.j	_fork_save_extra_regs_and_call
> -	 l.nop
> -
> -ENTRY(__sys_fork)
> -	l.movhi	r29,hi(sys_fork)
> -	l.ori	r29,r29,lo(sys_fork)
> -	l.j	_fork_save_extra_regs_and_call
> -	 l.nop
> -
>  ENTRY(sys_rt_sigreturn)
>  	l.jal	_sys_rt_sigreturn
>  	 l.addi	r3,r1,0
> -- 
> 2.31.1
> 
