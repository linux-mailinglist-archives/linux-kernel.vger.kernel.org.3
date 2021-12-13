Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EAE473310
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhLMRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbhLMRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196FDC061748;
        Mon, 13 Dec 2021 09:35:05 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:35:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5z4GDOZaI8lCMET8/sLZ3r5CINCeu5QaNtgjz6NbLlg=;
        b=rz6uvaS6vDhYfxDTBfRUYHadm5eEhp2TAQym/sIvmfXtiniLJ34I5BH1aUImvojjiPvinQ
        P1pRF+lfwyHZvJFmual0Ms7qauqQ0BsdT76z1w+/hA2+bIzyI7Bj7gXybPpUnklHzA9Xni
        H/XZ5qLKvE3UsHGOWJGTbNzfyD99dcTTCZkBtKEHf5dQ3FAonS0lO9yP8HlNQh9CulEA84
        qOmh0YBJIjyJ907OlZ5p/HD7PS4l8yiYr3JDQ7aXWIarRVOHmNhbT91gVlVzcROpp+RubK
        EYB7xwNpYLUaOp9ftY1KTlw3XxBhz9h0pLrOxMXUlH6LAXDqUxisxm0aUXlVMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5z4GDOZaI8lCMET8/sLZ3r5CINCeu5QaNtgjz6NbLlg=;
        b=Eu3FldhbHlt90Z47ut3fV3aGOC4CJ1ifYzarfd7XMQTtiKhDGUeIfCKlQQd08enRHfA+ie
        CNUFLeToDMMJUfCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Move the tainting outside of the noinstr region
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-11-bp@alien8.de>
References: <20211208111343.8130-11-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690278.23020.18304748017394593222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     75581a203e63210aabb1336c8c9cb65a7858b596
Gitweb:        https://git.kernel.org/tip/75581a203e63210aabb1336c8c9cb65a7858b596
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 02 Nov 2021 08:14:44 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:13:35 +01:00

x86/mce: Move the tainting outside of the noinstr region

add_taint() is yet another external facility which the #MC handler
calls. Move that tainting call into the instrumentation-allowed part of
the handler.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x617: call to add_taint() leaves .noinstr.text section

While at it, allow instrumentation around the mce_log() call.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x690: call to mce_log() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-11-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 41 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 53b4cfc..044c94b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1180,13 +1180,14 @@ static noinstr bool mce_check_crashing_cpu(void)
 	return false;
 }
 
-static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
-			    unsigned long *toclear, unsigned long *valid_banks,
-			    int no_way_out, int *worst)
+static __always_inline int
+__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
+		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
+		int *worst)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
-	int severity, i;
+	int severity, i, taint = 0;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		__clear_bit(i, toclear);
@@ -1213,7 +1214,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 			continue;
 
 		/* Set taint even when machine check was not enabled. */
-		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+		taint++;
 
 		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
 
@@ -1236,7 +1237,13 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
 
+		/*
+		 * Enable instrumentation around the mce_log() call which is
+		 * done in #MC context, where instrumentation is disabled.
+		 */
+		instrumentation_begin();
 		mce_log(m);
+		instrumentation_end();
 
 		if (severity > *worst) {
 			*final = *m;
@@ -1246,6 +1253,8 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 	/* mce_clear_state will clear *final, save locally for use later */
 	*m = *final;
+
+	return taint;
 }
 
 static void kill_me_now(struct callback_head *ch)
@@ -1362,7 +1371,7 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
-	int worst = 0, order, no_way_out, kill_current_task, lmce;
+	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
@@ -1441,7 +1450,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		order = mce_start(&no_way_out);
 	}
 
-	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+	taint = __mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1473,17 +1482,19 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	if (worst != MCE_AR_SEVERITY && !kill_current_task)
-		goto out;
-
 	/*
-	 * Enable instrumentation around the external facilities like
-	 * task_work_add() (via queue_task_work()), fixup_exception() etc.
-	 * For now, that is. Fixing this properly would need a lot more involved
-	 * reorganization.
+	 * Enable instrumentation around the external facilities like task_work_add()
+	 * (via queue_task_work()), fixup_exception() etc. For now, that is. Fixing this
+	 * properly would need a lot more involved reorganization.
 	 */
 	instrumentation_begin();
 
+	if (taint)
+		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
+	if (worst != MCE_AR_SEVERITY && !kill_current_task)
+		goto out;
+
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
@@ -1513,9 +1524,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			queue_task_work(&m, msg, kill_me_never);
 	}
 
+out:
 	instrumentation_end();
 
-out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
