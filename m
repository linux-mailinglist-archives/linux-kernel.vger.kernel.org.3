Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC60E484004
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiADKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:41:01 -0500
Received: from foss.arm.com ([217.140.110.172]:57996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbiADKlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:41:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 043871FB;
        Tue,  4 Jan 2022 02:41:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FF33F5A1;
        Tue,  4 Jan 2022 02:40:57 -0800 (PST)
Date:   Tue, 4 Jan 2022 10:40:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, samitolvanen@google.com,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC] aarch64: scs: reload shadow call stack in user
 exception entry
Message-ID: <YdQkM8IlonhEhU/R@FVFF77S0Q05N>
References: <20211228010604.109572-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228010604.109572-1-ashimida@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 27, 2021 at 05:06:04PM -0800, Dan Li wrote:
> When el0 exception occurs, kernel_entry/exit will load/save tsk->scs_sp
> to ensure scs working properly. AFAIK, the SCS offset should always be
> 0 at this time.
> 
> Is it reasonable to reload x18 to scs_base directly in kernel_entry
> here, or am I missing something?
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

AFAICT the saving here is just that we avoid storing the SCS SP upon return to
EL0, and I suspect that in practice that's not measureable.

So without numbers to show otherwise, I'd prefer to leave this as-is, though I
agree that this patch should work.  If we do want to change this, I think we
need a comment in the `kernel_exit` path to pair with the `scs_load` in
`kernel_entry`.

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/scs.h | 7 +++++++
>  arch/arm64/kernel/entry.S    | 3 +--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> index 8297bccf0784..2bc0d0575e75 100644
> --- a/arch/arm64/include/asm/scs.h
> +++ b/arch/arm64/include/asm/scs.h
> @@ -9,6 +9,10 @@
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	scs_sp	.req	x18
>  
> +	.macro scs_reload tsk
> +	ldr	scs_sp, [\tsk, #TSK_TI_SCS_BASE]
> +	.endm
> +
>  	.macro scs_load tsk
>  	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>  	.endm
> @@ -17,6 +21,9 @@
>  	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>  	.endm
>  #else
> +	.macro scs_reload tsk
> +	.endm
> +
>  	.macro scs_load tsk
>  	.endm
>  
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index bc6d5a970a13..57547a3e4f7c 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -265,7 +265,7 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
>  alternative_else_nop_endif
>  1:
>  
> -	scs_load tsk
> +	scs_reload tsk
>  	.else
>  	add	x21, sp, #PT_REGS_SIZE
>  	get_current_task tsk
> @@ -365,7 +365,6 @@ alternative_if ARM64_WORKAROUND_845719
>  alternative_else_nop_endif
>  #endif
>  3:
> -	scs_save tsk
>  
>  	/* Ignore asynchronous tag check faults in the uaccess routines */
>  	ldr	x0, [tsk, THREAD_SCTLR_USER]
> -- 
> 2.17.1
> 
