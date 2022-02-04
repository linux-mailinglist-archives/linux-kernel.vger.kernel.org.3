Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819874A97A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358265AbiBDKWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:22:12 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:49329 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiBDKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:22:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jqs694YQFz4xQp;
        Fri,  4 Feb 2022 21:22:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1643970129;
        bh=n/dsnLParIeDzoAdhcs84UwV8S6Ado29Z5vp88a2f1M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mQ1a6NqBdqBur/r8BdALGox6Oa06q/dI4R4QhuVnaAl3Qn/gCrNeJuU6j2XuJNqHZ
         HvRSMohROzxiUoVw5J7UKn1SBtNAjX6f4jORoXb/Piracprop+ZPVDHZsqrKoiihTz
         KrD4fNq9BPA2LV9gAcrdW+D9ikYssFXho+X72YMNqxAgnmDntcNVxUn71saIltkJA9
         QFbmT2/4T7vlmkL5NU3GhPbhbicay131bIB6ZEwjD5FD+aOqugExMwtK9N/ivsivkK
         B6jdpgG5GUfQb53XKPZItRohfe7rXdhdFBk+3Yy6K/JTd7NMY3ySR8nncLfufJTmqQ
         31khwlYPRDfjQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/signal: Fix handling of SA_RESTORER
 sigaction flag
In-Reply-To: <afe50d1db63a10fde9547ea08fe1fa68b0638aba.1624618157.git.christophe.leroy@csgroup.eu>
References: <afe50d1db63a10fde9547ea08fe1fa68b0638aba.1624618157.git.christophe.leroy@csgroup.eu>
Date:   Fri, 04 Feb 2022 21:22:04 +1100
Message-ID: <87a6f7lynn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> powerpc advertises support of SA_RESTORER sigaction flag.
>
> Make it the truth.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/signal_32.c | 8 ++++++--
>  arch/powerpc/kernel/signal_64.c | 4 +++-
>  2 files changed, 9 insertions(+), 3 deletions(-)

Hi Christophe,

I dug into the history a bit on this.

The 32-bit port originally did not define SA_RESTORER in
include/asm-ppc/signal.h, but it was added in 2.1.79.

  https://github.com/mpe/linux-fullhistory/commit/4e7e9c0d54ff5725a73d2210a950f8bc0f225073

That commit added SA_RESTORER to the header, added code to get/set it in
sys_sigaction(), but didn't add any code to use it for signal delivery.


The 64-bit port was merged with SA_RESTORER already defined in
include/asm-ppc64/signal.h:

  https://github.com/mpe/linux-fullhistory/commit/c3aa9878533e724f639852c3d951e6a169e04081
  
Similarly there was code to set/get it in sys_sigaction(), but no code
to use it for signal delivery.


Later the two ports were merged, and the headers were moved and
disintegrated into uapi, so we end up today with SA_RESTORER defined in
arch/powerpc/include/uapi/asm/signal.h, but no code to use it.

So essentially we've had SA_RESTORER defined since ancient kernels, but
never actually supported using it for anything.


One problem with enabling it now is there's no way for userspace to
determine if it's on a fixed kernel or not. That makes it unusable for
userspace, unless it does version checks, or is happy to break on all
old kernels (not likely). We could solve that by defining
SA_RESTORER_FIXED or something, but that's slightly gross.

It's also described in the man page as "Not intended for application
use", ie. it's intended for use by libc. I'm not sure there's any value
in adding support for it to the kernel unless we know there's interest
from glibc/musl in using it.

So my inclination is that we should *not* add support for it, rather we
should leave it unimplemented and remove SA_RESTORER from the header.
There's precedent in riscv for not supporting it at all.

cheers



> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 0608581967f0..cf3da1386595 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -769,7 +769,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
>  	}
>  
>  	/* Save user registers on the stack */
> -	if (tsk->mm->context.vdso) {
> +	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
> +		tramp = (unsigned long)ksig->ka.sa.sa_restorer;
> +	} else if (tsk->mm->context.vdso) {
>  		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
>  	} else {
>  		tramp = (unsigned long)mctx->mc_pad;
> @@ -865,7 +867,9 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
>  	else
>  		unsafe_save_user_regs(regs, mctx, tm_mctx, 1, failed);
>  
> -	if (tsk->mm->context.vdso) {
> +	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
> +		tramp = (unsigned long)ksig->ka.sa.sa_restorer;
> +	} else if (tsk->mm->context.vdso) {
>  		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
>  	} else {
>  		tramp = (unsigned long)mctx->mc_pad;
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 1831bba0582e..fb31a334aca6 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -910,7 +910,9 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  	tsk->thread.fp_state.fpscr = 0;
>  
>  	/* Set up to return from userspace. */
> -	if (tsk->mm->context.vdso) {
> +	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
> +		regs_set_return_ip(regs, (unsigned long)ksig->ka.sa.sa_restorer);
> +	} else if (tsk->mm->context.vdso) {
>  		regs_set_return_ip(regs, VDSO64_SYMBOL(tsk->mm->context.vdso, sigtramp_rt64));
>  	} else {
>  		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
> -- 
> 2.25.0
