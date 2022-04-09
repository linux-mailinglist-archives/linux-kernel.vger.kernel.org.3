Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE884FA114
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiDIBbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiDIBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C531162B8;
        Fri,  8 Apr 2022 18:27:41 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+B9Fq4we//gqUIqWi36AVjj+0ZUKgZVA5pVmEVrK/xI=;
        b=aCZGpnXbBfwa9KY2fQ6vWjpWOsfvSTRtOXvF5vScHkigfXKr8xtiPMrFqaUSpCq/AwFCvO
        37VPC6FgZMwJSOjbs+ZOkC3L65kRVUpz8orvem4K9EnOktN35M+Tv+FUoMA1ruhUr2KOHy
        udCLcA2tkNAlJ/xBxAjADgv3Jm0Md4SBQ5oH95lGX1iR0RNVI49oI4T5PnToLp9RDhpBcu
        MTvZnX9d2986zCHNUhraZmb6eqOdIAL4zNJHlHwCqzr5HvwokkjnAW/AdbmAxQKDWUv/QF
        0uK6himqC7Zu9UkEYjHol8bstvY/GsoWcufj66GPEVm1I9zQ/oIWHEbmLp65vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+B9Fq4we//gqUIqWi36AVjj+0ZUKgZVA5pVmEVrK/xI=;
        b=5h5zHVRW2ay2MZtLDFgd3oIjoEeqKOIFAPzLgdJRhzkNq3FlVBbCz9TSIg/LDPjHFmbg+u
        uuwkKMIyov7o90Dw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/traps: Refactor exc_general_protection()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-7-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946765914.4207.3107444551080835442.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     775acc82a88fd36f5e89a08d39874fdeeaa04247
Gitweb:        https://git.kernel.org/tip/775acc82a88fd36f5e89a08d39874fdeeaa04247
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:15 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:51 -07:00

x86/traps: Refactor exc_general_protection()

TDX brings a new exception -- Virtualization Exception (#VE). Handling
of #VE structurally very similar to handling #GP.

Extract two helpers from exc_general_protection() that can be reused for
handling #VE.

No functional changes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220405232939.73860-7-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/traps.c | 57 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb9..db8d22a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -686,13 +686,40 @@ static bool try_fixup_enqcmd_gp(void)
 #endif
 }
 
+static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
+				    unsigned long error_code, const char *str)
+{
+	if (fixup_exception(regs, trapnr, error_code, 0))
+		return true;
+
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() && kprobe_running() &&
+	    kprobe_fault_handler(regs, trapnr))
+		return true;
+
+	return notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV) == NOTIFY_STOP;
+}
+
+static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
+				   unsigned long error_code, const char *str)
+{
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+	show_signal(current, SIGSEGV, "", str, regs, error_code);
+	force_sig(SIGSEGV);
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
-	struct task_struct *tsk;
 	unsigned long gp_addr;
-	int ret;
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
 		return;
@@ -711,40 +738,18 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		return;
 	}
 
-	tsk = current;
-
 	if (user_mode(regs)) {
 		if (fixup_iopl_exception(regs))
 			goto exit;
 
-		tsk->thread.error_code = error_code;
-		tsk->thread.trap_nr = X86_TRAP_GP;
-
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
-		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
-		force_sig(SIGSEGV);
+		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
 
-	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		goto exit;
-
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = X86_TRAP_GP;
-
-	/*
-	 * To be potentially processing a kprobe fault and to trust the result
-	 * from kprobe_running(), we have to be non-preemptible.
-	 */
-	if (!preemptible() &&
-	    kprobe_running() &&
-	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		goto exit;
-
-	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
-	if (ret == NOTIFY_STOP)
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
 		goto exit;
 
 	if (error_code)
