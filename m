Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47542473319
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbhLMRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbhLMRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:08 -0500
Date:   Mon, 13 Dec 2021 17:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riVH2d40NoRoTr0VXFTtJ5Evb/N4yYP+Wi7TnbNlygo=;
        b=1qQdUDwYFZWNXYW6jYH47CMWWpWKfxd4+qvjGoaIN8v0o2+aW2YVBiSRXeJst5LpJ2toQ0
        dlPOa2su86oPNJIIUQNj5eHtBfaD5pvErVqhb0DxLrY1UW9rNJ0TrFw3YlCD7ZJDHotD9L
        8xiXu7tZizQZii/6gIQYjRwQGfJ9RH+H0B6r3AlP8/gVhTcuygIASlpf7vBqFBR9Eo6pIu
        HCwuKXposAlRBJJ85X7I4TYm4psQ+7nCxlwNYQuEt8ZnmH8ibublSDM4R46buyyG6s4lrK
        YTKKmSa3UacUlxd2Ubwx1BKPyIr/PmXeReA9dCt52YD7JcPe9FRoOgFzW+PEuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riVH2d40NoRoTr0VXFTtJ5Evb/N4yYP+Wi7TnbNlygo=;
        b=1pSRzgraFvlF29fGszcbbH3zbEEiBu3w5X2LHXRFxpTUwRbWtTBRBB2tpEZm7IQATFxihf
        BvCcU00+VJnYEiCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Prevent severity computation from being instrumented
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-7-bp@alien8.de>
References: <20211208111343.8130-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690578.23020.3207660208777242690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     0a5b288e85bbef5227bb6397e31fcf1d7ba9142a
Gitweb:        https://git.kernel.org/tip/0a5b288e85bbef5227bb6397e31fcf1d7ba9142a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 13 Oct 2021 09:47:50 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:12:48 +01:00

x86/mce: Prevent severity computation from being instrumented

Mark all the MCE severity computation logic noinstr and allow
instrumentation when it "calls out".

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0xc5d: call to mce_severity() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-7-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/severity.c | 30 ++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 00e97eb..a326467 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -263,24 +263,36 @@ static bool is_copy_from_user(struct pt_regs *regs)
  * distinguish an exception taken in user from from one
  * taken in the kernel.
  */
-static int error_context(struct mce *m, struct pt_regs *regs)
+static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 {
+	int fixup_type;
+	bool copy_user;
+
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
 
-	switch (ex_get_fixup_type(m->ip)) {
+	/* Allow instrumentation around external facilities usage. */
+	instrumentation_begin();
+	fixup_type = ex_get_fixup_type(m->ip);
+	copy_user  = is_copy_from_user(regs);
+	instrumentation_end();
+
+	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
-		if (!regs || !is_copy_from_user(regs))
+		if (!regs || !copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
+
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+
 	default:
 		return IN_KERNEL;
 	}
@@ -315,8 +327,8 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
-			    char **msg, bool is_excp)
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
+				    char **msg, bool is_excp)
 {
 	enum context ctx = error_context(m, regs);
 
@@ -368,8 +380,8 @@ static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
 	return MCE_KEEP_SEVERITY;
 }
 
-static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
-			      int tolerant, char **msg, bool is_excp)
+static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
+				      int tolerant, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
 	enum context ctx = error_context(m, regs);
@@ -405,8 +417,8 @@ static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 	}
 }
 
-int mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
-		 bool is_excp)
+int noinstr mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
+			 bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
