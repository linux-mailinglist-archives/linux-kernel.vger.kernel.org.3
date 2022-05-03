Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5C518CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiECTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiECTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:04:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD5D2B259;
        Tue,  3 May 2022 12:01:05 -0700 (PDT)
Date:   Tue, 03 May 2022 19:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651604463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7M0Azw91fCVodeFHNIFS0MZtP2Po+9EbNqB3ca7cok=;
        b=ttZaMZAxHPGP5pHfmn+9ZR9J7ntPtRh+SnYrCIFixpjuyJCQ8T3ttDwIxKVo2ebTAH90X9
        JeSJvyaW+lNI8LZy+ltHZPp01QbdsMSdMwhUsmdcngUW1XOHSsn9QKKCBtT/cnMudsbGbl
        pJYSB4c1ap6BhuvugVGiR2BzUHGiXNChVSkP47AJxJHaapc+Hf2lJjrJauJap1T9i6zjm9
        v2zL9AEtd03eCYFVQQrfjrsyZsaU5k4wo5h3dH6aE8Z4NxYNMMiWUZiLcMiQe0cLgk6tq3
        +0caq3OcAB5YNbGOPK0QLSbdL2MJw9fCo0gfXZlH4wGt9KGyY2akHOvPOZ3Xcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651604463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7M0Azw91fCVodeFHNIFS0MZtP2Po+9EbNqB3ca7cok=;
        b=HmCdXJwsgscM3chuq+s/XJRQdeD4VLTmn/cOqXNuQ5g3fEvFThgQKVQcOCFujGggCBAy4c
        0STOeYYJqCyBmxAQ==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Convert SWAPGS to swapgs and remove the
 definition of SWAPGS
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220503032107.680190-7-jiangshanlai@gmail.com>
References: <20220503032107.680190-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165160446219.4207.15978997115867513161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c89191ce67efa4e5353db6a67f7287c28e673740
Gitweb:        https://git.kernel.org/tip/c89191ce67efa4e5353db6a67f7287c28e673740
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Tue, 03 May 2022 11:21:07 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 03 May 2022 12:26:08 +02:00

x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS

XENPV doesn't use swapgs_restore_regs_and_return_to_usermode(),
error_entry() and the code between entry_SYSENTER_compat() and
entry_SYSENTER_compat_after_hwframe.

Change the PV-compatible SWAPGS to the ASM instruction swapgs in these
places.

Also remove the definition of SWAPGS since no more users.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220503032107.680190-7-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S        | 6 +++---
 arch/x86/entry/entry_64_compat.S | 2 +-
 arch/x86/include/asm/irqflags.h  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 062aa9d..3121866 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1019,7 +1019,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1051,7 +1051,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1072,7 +1072,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007..c5aeb08 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -50,7 +50,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 111104d..7793e52 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -137,14 +137,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#else
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#else
-#define SWAPGS	swapgs
-#endif
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
