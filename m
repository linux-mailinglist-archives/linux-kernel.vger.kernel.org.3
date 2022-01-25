Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F949B16C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiAYKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbiAYKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:12:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE0C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:12:56 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B5A41EC0441;
        Tue, 25 Jan 2022 11:12:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643105570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/SkR8C69fbyLSk4Zc2npPvzA0CISECMcPfrCJCLg77I=;
        b=go2+7PBa4BEBYblHiCBya3fMm2EpAxgvbEsMVQiwDH44iBTDm5+MIRxcSnnMNetOavwdw0
        nptLlGIB0c9DCEehwbZqSsU9IKnb1IGaAe9pEv88ApA0SV7RK8t5d1VenwWWaElAg40gHJ
        23iJWnTLYBtk1B6aCHmxVICABRaBszw=
Date:   Tue, 25 Jan 2022 11:12:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?THXDrXM=?= Ferreira <contact@lsferreira.net>,
        x86-ml <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: remove memset call for xmm registers on
 xfpregs_set
Message-ID: <Ye/NHQM3dj8ycUsL@zn.tnic>
References: <20220125022015.874422-1-contact@lsferreira.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125022015.874422-1-contact@lsferreira.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:20:15AM +0000, Luís Ferreira wrote:
> This patch fixes https://bugzilla.kernel.org/show_bug.cgi?id=215524 by removing
> the memset introduced by 6164331d15f7d912fb9369245368e9564ea49813, which
> created a regression on ptrace PTRACE_SETREGSET request with NT_FPREGSET.

Is NT_FPREGSET the same as NT_PRFPREG core_note_type?

I can see former is mentioned in elf(5) as an ELF note type:

/usr/include/elf.h:
#define NT_FPREGSET     2               /* Contains copy of fpregset struct */

while latter is defined in the kernel tree like this:

/*
 * Notes used in ET_CORE. Architectures export some of the arch register sets
 * using the corresponding note types via the PTRACE_GETREGSET and
 * PTRACE_SETREGSET requests.
 * The note name for all these is "LINUX".
 */
#define NT_PRSTATUS     1
#define NT_PRFPREG      2
...

I guess those are one and the same thing - just named differently.

> Particularly, it zeros some XMM registers on the wrong offsets. Fixing the offsets
> only solves the problem for i686, which doesn't include xmm8-15 registers, so
> the right way is to probably completely remove this call.

It's a good thing you mention i686. I believe the reason for the zeroing
was the X86_FEATURE_FXSR check which means the CPU has FXSAVE/FXRSTOR,
CR4.OSFXSR support.

Now, FXSAVE doc says:

"The architecture supports two 512-bit memory formats for FXSAVE, a
64-bit format that saves XMM0-XMM15, and a 32-bit legacy format that
saves only XMM0-XMM7. If FXSAVE is executed in 64-bit mode, the 64-bit
format is used, otherwise the 32-bit format is used."

Then, just to check I went and built a kernel before:

  6164331d15f7 ("x86/fpu: Rewrite xfpregs_set()")

and tried the reproducer with %xmm7 and %xmm9:

$ gdb /bin/bash -batch -x gdbcmds
warning: Could not load shared library symbols for linux-vdso.so.1.
Do you need "set solib-search-path" or "set sysroot"?

Program received signal SIGILL, Illegal instruction.
0x00007ffff79d8a97 in kill () from /lib/x86_64-linux-gnu/libc.so.6
$1 = 0x20202020202020202020202020202020
Setting xmm7 to 35322350018591
$2 = 35322350018591

$  gdb /bin/bash -batch -x gdbcmds
warning: Could not load shared library symbols for linux-vdso.so.1.
Do you need "set solib-search-path" or "set sysroot"?

Program received signal SIGILL, Illegal instruction.
0x00007ffff79d8a97 in kill () from /lib/x86_64-linux-gnu/libc.so.6
$1 = 0xffffffffffffffffffffffffffffffff
Setting xmm9 to 35322350018591
$2 = 35322350018591

So whatever that clearing was supposed to do, it needs to go because it
used to work before that so this looks like a regression. Unless I'm
missing an aspect...

> Signed-off-by: Luís Ferreira <contact@lsferreira.net>
> ---
>  arch/x86/kernel/fpu/regset.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> index 437d7c930c0b..aec6c49029b1 100644
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -116,9 +116,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
>  	/* Copy the state  */
>  	memcpy(&fpu->fpstate->regs.fxsave, &newstate, sizeof(newstate));
>  
> -	/* Clear xmm8..15 */
>  	BUILD_BUG_ON(sizeof(fpu->__fpstate.regs.fxsave.xmm_space) != 16 * 16);
> -	memset(&fpu->fpstate->regs.fxsave.xmm_space[8], 0, 8 * 16);
>  
>  	/* Mark FP and SSE as in use when XSAVE is enabled */
>  	if (use_xsave())
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
