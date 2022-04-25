Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6050E4EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiDYP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiDYP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:59:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE32114FAE;
        Mon, 25 Apr 2022 08:56:22 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:56:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650902181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2yTwPxv8H/dUOhfrqLiZHWdWH8T8aQb7iNOdHS/XIE4=;
        b=QM/oyovEFP74DbhBQUiQArTi16JTpDv1T8KT1a9///cLClfSdaiiiIvGhWKnWf2N66Esms
        EGvAqwqzRn4SWQP96r9Ell8BptCwln4X+BfyZwlfaOgieGam9P8rCHpAMCm1BCKSxZOjJ4
        kFeeiHHuPFjEVCCaRX+ywmKmMV8ye+wbG3L8eRGgn6lxz5EWu2qaobWxFzyLD4RySFB4gq
        IgKXLc+wFWktRgGJsrHStz7/Ijb9AYVaBNNdVmZuw+RAxZn8onAsxBpedWL24Ebvhl9Pq7
        o7qNUZP6z/CWeYKAaOwd9N15Nx9jtgMU3OrmEH9KvyqP+bSzPl5idpeLMHzk5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650902181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2yTwPxv8H/dUOhfrqLiZHWdWH8T8aQb7iNOdHS/XIE4=;
        b=zeD6UgsbVv9QIvZ0MOBD7VZMyGdm+HWz3GKTC5pwEujnyULwCo7IqO16+hqHfY2KoeGKcZ
        FLiWQB9IuGoYknDQ==
From:   "tip-bot2 for Carlos Bilbao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Simplify AMD severity grading logic
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405183212.354606-2-carlos.bilbao@amd.com>
References: <20220405183212.354606-2-carlos.bilbao@amd.com>
MIME-Version: 1.0
Message-ID: <165090218047.4207.9735013762678136837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     70c459d915e838b7f536b8e26e0b3a6141bd2645
Gitweb:        https://git.kernel.org/tip/70c459d915e838b7f536b8e26e0b3a6141bd2645
Author:        Carlos Bilbao <carlos.bilbao@amd.com>
AuthorDate:    Tue, 05 Apr 2022 13:32:13 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Apr 2022 12:32:03 +02:00

x86/mce: Simplify AMD severity grading logic

The MCE handler needs to understand the severity of the machine errors to
act accordingly. Simplify the AMD grading logic following a logic that
closely resembles the descriptions of the public PPR documents. This will
help include more fine-grained grading of errors in the future.

  [ bp: Touchups. ]

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220405183212.354606-2-carlos.bilbao@amd.com
---
 arch/x86/kernel/cpu/mce/severity.c | 101 +++++++++-------------------
 1 file changed, 36 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1add869..d842148 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -301,85 +301,56 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	}
 }
 
-static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
+/* See AMD PPR(s) section Machine Check Error Handling. */
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
-	u64 mcx_cfg;
+	int ret;
 
 	/*
-	 * We need to look at the following bits:
-	 * - "succor" bit (data poisoning support), and
-	 * - TCC bit (Task Context Corrupt)
-	 * in MCi_STATUS to determine error severity.
+	 * Default return value: Action required, the error must be handled
+	 * immediately.
 	 */
-	if (!mce_flags.succor)
-		return MCE_PANIC_SEVERITY;
-
-	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
-
-	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
-	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
-	    (m->status & MCI_STATUS_TCC) &&
-	    (err_ctx == IN_KERNEL))
-		return MCE_PANIC_SEVERITY;
-
-	 /* ...otherwise invoke hwpoison handler. */
-	return MCE_AR_SEVERITY;
-}
-
-/*
- * See AMD Error Scope Hierarchy table in a newer BKDG. For example
- * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
- */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-{
-	enum context ctx = error_context(m, regs);
+	ret = MCE_AR_SEVERITY;
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
-		return MCE_PANIC_SEVERITY;
-
-	if (m->status & MCI_STATUS_UC) {
-
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
+	if (m->status & MCI_STATUS_PCC) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out;
+	}
 
-		/*
-		 * On older systems where overflow_recov flag is not present, we
-		 * should simply panic if an error overflow occurs. If
-		 * overflow_recov flag is present and set, then software can try
-		 * to at least kill process to prolong system operation.
-		 */
-		if (mce_flags.overflow_recov) {
-			if (mce_flags.smca)
-				return mce_severity_amd_smca(m, ctx);
-
-			/* kill current process */
-			return MCE_AR_SEVERITY;
-		} else {
-			/* at least one error was not logged */
-			if (m->status & MCI_STATUS_OVER)
-				return MCE_PANIC_SEVERITY;
-		}
-
-		/*
-		 * For any other case, return MCE_UC_SEVERITY so that we log the
-		 * error and exit #MC handler.
-		 */
-		return MCE_UC_SEVERITY;
+	if (m->status & MCI_STATUS_DEFERRED) {
+		ret = MCE_DEFERRED_SEVERITY;
+		goto out;
 	}
 
 	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
+	 * If the UC bit is not set, the system either corrected or deferred
+	 * the error. No action will be required after logging the error.
 	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
+	if (!(m->status & MCI_STATUS_UC)) {
+		ret = MCE_KEEP_SEVERITY;
+		goto out;
+	}
 
 	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
+	 * On MCA overflow, without the MCA overflow recovery feature the
+	 * system will not be able to recover, panic.
 	 */
-	return MCE_KEEP_SEVERITY;
+	if ((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out;
+	}
+
+	if (!mce_flags.succor) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out;
+	}
+
+	if (error_context(m, regs) == IN_KERNEL)
+		ret = MCE_PANIC_SEVERITY;
+
+out:
+	return ret;
 }
 
 static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
