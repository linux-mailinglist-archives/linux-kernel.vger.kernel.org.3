Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101552DAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiESRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiESRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:11:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC5205E2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43731CE26EB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DEBC385AA;
        Thu, 19 May 2022 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652980291;
        bh=zfXW98jVyxZ6zoL6xNX2NZNkEnIW/L5pHktyNLtrNGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOrGLBaZbWRP8x43zWCVXO5PL8CQuf+7D3hYJpKE+C9z6jzbP6BvE6FdaON3CnxWY
         Bgxjyl7eyd5PvGkGXjqDfsdE/j+hKImVzZ4XR6bPEwfOW5KP8IbHgVfvlgjYoUxQnp
         mwmbFgIJEBcvRe4D/AxTpgo47XGed4dnuw4GHasj2ECdgdUvCY6t6V1AtTja3n7M37
         KIStclA/x5L3r5+oZQ7XPzStt1h2gU4MjVer79QFVDp8EaNtuNVOpP8l3k1co+IaZz
         npBPFCilgTjoKRGFfgmGCjuDC8I2ghCX2U1A7uPSnTo00QWjweh8Kaz84W82HokrmX
         IjLpTRA1x8cWA==
Date:   Thu, 19 May 2022 10:11:29 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220519171129.enw32izjhxsqc2xm@treble>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net>
 <20220519170009.GL2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519170009.GL2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 07:00:09PM +0200, Peter Zijlstra wrote:
> On Thu, May 19, 2022 at 09:24:11AM -0700, Guenter Roeck wrote:
> > On Fri, May 06, 2022 at 02:14:34PM +0200, Peter Zijlstra wrote:
> > > Since the upper regs don't exist for ia32 code, preserving them
> > > doesn't hurt and it simplifies the code.
> > > 
> > > This doesn't add any attack surface that would not already be
> > > available through INT80.
> > > 
> > > Notably:
> > > 
> > >  - 32bit SYSENTER: didn't clear si, dx, cx.
> > > 
> > >  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
> > >    take a second argument.
> > > 
> > >  - 64bit: didn't clear si since the C functions take a second
> > >    argument; except the error_entry path might have only one argument,
> > >    so clearing si was missing here.
> > > 
> > > 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> > > and selftests pass.
> > > 
> > > Unconditionally clear rsi since it simplifies code.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Borislav Petkov <bp@suse.de>
> > 
> > linux-next (next-20220519) crashes due to this patch when booting
> > q35:EPYC-Rome in qemu.
> 
> Could you try backing out each of the hunks one at a time? They're all
> more or less independent.
> 
> My bet with this being a #PF on an AMD machine, it's either the SI clear
> or the SYSCALL change.

I think this should fix it:

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a97cc78ecb92..29b36e9e4e74 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -73,7 +73,7 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
+	pushq   \rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	pushq   %r9		/* pt_regs->r9 */
@@ -115,8 +115,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
+	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret
 	CLEAR_REGS
 .endm
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ed2be3615b50..2d40dd132442 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
-	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS rcx=%rbx
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
