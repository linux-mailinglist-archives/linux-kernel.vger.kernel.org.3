Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90C4C0163
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiBVSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBVSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:33:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 082137D03A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95D1139F;
        Tue, 22 Feb 2022 10:32:37 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61EB33F66F;
        Tue, 22 Feb 2022 10:32:35 -0800 (PST)
Date:   Tue, 22 Feb 2022 18:32:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 5/9] arm64: asm: Introduce test_sp_overflow macro
Message-ID: <YhUsQZUqgb94EjmD@lakrids>
References: <20220222165212.2005066-1-kaleshsingh@google.com>
 <20220222165212.2005066-6-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165212.2005066-6-kaleshsingh@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:51:06AM -0800, Kalesh Singh wrote:
> From: Quentin Perret <qperret@google.com>
> 
> The asm entry code in the kernel uses a trick to check if VMAP'd stacks
> have overflowed by aligning them at THREAD_SHIFT * 2 granularity and
> checking the SP's THREAD_SHIFT bit.
> 
> Protected KVM will soon make use of a similar trick to detect stack
> overflows, so factor out the asm code in a re-usable macro.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> [Kalesh - Resolve minor conflicts]
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 11 +++++++++++
>  arch/arm64/kernel/entry.S          |  7 +------
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index e8bd0af0141c..ad40eb0eee83 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -850,4 +850,15 @@ alternative_endif
>  
>  #endif /* GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT */
>  
> +/*
> + * Test whether the SP has overflowed, without corrupting a GPR.
> + */
> +.macro test_sp_overflow shift, label
> +	add	sp, sp, x0			// sp' = sp + x0
> +	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
> +	tbnz	x0, #\shift, \label
> +	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
> +	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
> +.endm

I'm a little unhappy about factoring this out, since it's not really
self-contained and leaves sp and x0 partially-swapped when it branches
to the label. You can't really make that clear with comments on the
macro, and you need comments at each use-sire, so I'd ratehr we just
open-coded a copy of this.

> +
>  #endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 772ec2ecf488..ce99ee30c77e 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -53,15 +53,10 @@ alternative_else_nop_endif
>  	sub	sp, sp, #PT_REGS_SIZE
>  #ifdef CONFIG_VMAP_STACK
>  	/*
> -	 * Test whether the SP has overflowed, without corrupting a GPR.
>  	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
>  	 * should always be zero.
>  	 */
> -	add	sp, sp, x0			// sp' = sp + x0
> -	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
> -	tbnz	x0, #THREAD_SHIFT, 0f
> -	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
> -	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
> +	test_sp_overflow THREAD_SHIFT, 0f
>  	b	el\el\ht\()_\regsize\()_\label
>  
>  0:

Further to my comment above, immediately after this we have:

	/* Stash the original SP (minus PT_REGS_SIZE) in tpidr_el0. */
	msr     tpidr_el0, x0

	/* Recover the original x0 value and stash it in tpidrro_el0 */
	sub     x0, sp, x0
	msr     tpidrro_el0, x0

... which is really surprising with the `test_sp_overflow` macro because
it's not clear that modifies x0 and sp in this way.

Thanks,
Mark.
... 

> -- 
> 2.35.1.473.g83b2b277ed-goog
> 
