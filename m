Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD347331B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhLMRfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbhLMRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:09 -0500
Date:   Mon, 13 Dec 2021 17:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOIQl/KOhcDtL/RtkanzFkA4fDfQ5FJBN4ydTPAnD1M=;
        b=mD8cfcs2Horr6j2PFEe8I/EPxRubmPLE5+iHm1r8iR8cdU+iVa7qt/1s6yLQ0MU6hghArA
        1cZbNxV97cbxek7V/KmidQUk4e4HsIdsA2moX7cJ8EBMsGlY685hSwS9gw6twqtS0hEER0
        bFjmO1YLzsYqMknZERDLSc3fSKocaIqtjHRy5Z7IP5TlDgdKLm5aLstAEf97ZQmWTQw5Gj
        uniWF47ryKWNR3Zhs8ouSwU6JhF795BMKIFRE4VQj1OoljkVYsDETATqHqitJIvWvJ6jQ0
        1zOr8V8FiBUFNhBd0WOaSlScJTF4pusLjTURfWXRBbsM1w7YIyN73nZm3td9YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOIQl/KOhcDtL/RtkanzFkA4fDfQ5FJBN4ydTPAnD1M=;
        b=gvVUnldJlR1W1sD+OhQdqGFCd4TqqI52liMqVA5msoEMg7Q9G3Ea260CioDCNjBNh6V+Sy
        Fufm+fGBBWQ7MXBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove noinstr annotation from mce_setup()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-5-bp@alien8.de>
References: <20211208111343.8130-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690724.23020.4701478977786510505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     487d654db3edacc31dee86b10258cc740640fad8
Gitweb:        https://git.kernel.org/tip/487d654db3edacc31dee86b10258cc740640fad8
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 05 Oct 2021 19:54:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:12:21 +01:00

x86/mce: Remove noinstr annotation from mce_setup()

Instead, sandwitch around the call which is done in noinstr context and
mark the caller - mce_gather_info() - as noinstr.

Also, document what the whole instrumentation strategy with #MC is going
to be in the future and where it all is supposed to be going to.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-5-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 87a277f..c11fc8d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -127,7 +127,7 @@ static struct irq_work mce_irq_work;
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-noinstr void mce_setup(struct mce *m)
+void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -430,9 +430,15 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
  * check into our "mce" struct so that we can use it later to assess
  * the severity of the problem as we read per-bank specific details.
  */
-static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
+static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
+	/*
+	 * Enable instrumentation around mce_setup() which calls external
+	 * facilities.
+	 */
+	instrumentation_begin();
 	mce_setup(m);
+	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
 	if (regs) {
@@ -1312,11 +1318,11 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
 }
 
 /*
- * The actual machine check handler. This only handles real
- * exceptions when something got corrupted coming in through int 18.
+ * The actual machine check handler. This only handles real exceptions when
+ * something got corrupted coming in through int 18.
  *
- * This is executed in NMI context not subject to normal locking rules. This
- * implies that most kernel services cannot be safely used. Don't even
+ * This is executed in #MC context not subject to normal locking rules.
+ * This implies that most kernel services cannot be safely used. Don't even
  * think about putting a printk in there!
  *
  * On Intel systems this is entered on all CPUs in parallel through
@@ -1328,6 +1334,14 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
  * issues: if the machine check was due to a failure of the memory
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
+ *
+ * Currently, the #MC handler calls out to a number of external facilities
+ * and, therefore, allows instrumentation around them. The optimal thing to
+ * have would be to do the absolutely minimal work required in #MC context
+ * and have instrumentation disabled only around that. Further processing can
+ * then happen in process context where instrumentation is allowed. Achieving
+ * that requires careful auditing and modifications. Until then, the code
+ * allows instrumentation temporarily, where required. *
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
