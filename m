Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BE46D1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhLHLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhLHLRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:25 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EA781EC054F;
        Wed,  8 Dec 2021 12:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cbMqyOzwuYRHnJiqnKSE9on4FrRX/bU6CAwAujfUPI=;
        b=ZV/6gUJdBU78036qZFn2BVlXLLf27ddL17N0XbaFL6Y0yQANpAQfsXcUOHJcibF8ec7OXW
        MAcFi9nwZ9IrWQspvB2zbkFKKeYGn1ihi9VytnLI3UN9JuOzFlmOuMWMzctN7dpHvUqJVg
        I12dWc5GUA97WwWrvvVH7ZlVn05gSWg=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/12] x86/mce: Move the tainting outside of the noinstr region
Date:   Wed,  8 Dec 2021 12:13:41 +0100
Message-Id: <20211208111343.8130-11-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

add_taint() is yet another external facility which the #MC handler
calls. Move that tainting call into the instrumentation-allowed part of
the handler.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x617: call to add_taint() leaves .noinstr.text section

While at it, allow instrumentation around the mce_log() call.

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x690: call to mce_log() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 41 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index eafa7f350fa2..782724b1204f 100644
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
@@ -1354,7 +1363,7 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
-	int worst = 0, order, no_way_out, kill_current_task, lmce;
+	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
@@ -1433,7 +1442,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		order = mce_start(&no_way_out);
 	}
 
-	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+	taint = __mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1465,17 +1474,19 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
@@ -1505,9 +1516,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			queue_task_work(&m, msg, kill_me_never);
 	}
 
+out:
 	instrumentation_end();
 
-out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
-- 
2.29.2

