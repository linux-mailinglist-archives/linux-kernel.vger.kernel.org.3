Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111EF4BC9B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiBSSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:09:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiBSSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:09:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2312AA6;
        Sat, 19 Feb 2022 10:09:18 -0800 (PST)
Date:   Sat, 19 Feb 2022 18:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645294155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KT2fuDd/2PirIuy3AtxiVnUjnCo2bXQnL7fxmMZK7E0=;
        b=4wZDboyuA4Ndb5TrYKYo1T38Fh+GANBotzIzyfjsSK49uu3Dj+1G0x16m1brwNZ1dwftNB
        1Km6doczk1EFhhOiMqOvDizxBcszr9BgCT9yQCSmN0dZ4aK4ZIMXKL8EV8DCxck0KOv4qA
        ntRYdXS4U9q3RTp6kaP8+HOtaX+0xBBMVrBa1lq1RbS8mVvF+7bU7N/hUHa/rEWmNdDz2e
        Rbylriz2Yi3xsYsS2784VBP59yW9mzpcU6yeGqYRe8hmeod08ilui2SvaYbiD3J+hHifDb
        7G9NLub4kaRmWeMnW538Aa2hUiaP2p1qsZa8bIGeosCnc3O8m1Rk3YewMRmrzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645294155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KT2fuDd/2PirIuy3AtxiVnUjnCo2bXQnL7fxmMZK7E0=;
        b=h4+WaCIuALhrMLcIaQ2CONyORPxdJ5HOEsmrb4N9TihJ9t9sIGjfVnNyXZ/6ydQcCu02H0
        TOAs29WW5+yPzRCQ==
From:   "tip-bot2 for Jue Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Work around an erratum on fast string copy
 instructions
Cc:     Jue Wang <juew@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220218013209.2436006-1-juew@google.com>
References: <20220218013209.2436006-1-juew@google.com>
MIME-Version: 1.0
Message-ID: <164529415398.16921.8042682039148828519.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     8ca97812c3c830573f965a07bbd84223e8c5f5bd
Gitweb:        https://git.kernel.org/tip/8ca97812c3c830573f965a07bbd84223e8c5f5bd
Author:        Jue Wang <juew@google.com>
AuthorDate:    Thu, 17 Feb 2022 17:32:09 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Feb 2022 14:26:42 +01:00

x86/mce: Work around an erratum on fast string copy instructions

A rare kernel panic scenario can happen when the following conditions
are met due to an erratum on fast string copy instructions:

1) An uncorrected error.
2) That error must be in first cache line of a page.
3) Kernel must execute page_copy from the page immediately before that
page.

The fast string copy instructions ("REP; MOVS*") could consume an
uncorrectable memory error in the cache line _right after_ the desired
region to copy and raise an MCE.

Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string
copy and will avoid such spurious machine checks. However, that is less
preferable due to the permanent performance impact. Considering memory
poison is rare, it's desirable to keep fast string copy enabled until an
MCE is seen.

Intel has confirmed the following:
1. The CPU erratum of fast string copy only applies to Skylake,
Cascade Lake and Cooper Lake generations.

Directly return from the MCE handler:
2. Will result in complete execution of the "REP; MOVS*" with no data
loss or corruption.
3. Will not result in another MCE firing on the next poisoned cache line
due to "REP; MOVS*".
4. Will resume execution from a correct point in code.
5. Will result in the same instruction that triggered the MCE firing a
second MCE immediately for any other software recoverable data fetch
errors.
6. Is not safe without disabling the fast string copy, as the next fast
string copy of the same buffer on the same CPU would result in a PANIC
MCE.

This should mitigate the erratum completely with the only caveat that
the fast string copy is disabled on the affected hyper thread thus
performance degradation.

This is still better than the OS crashing on MCEs raised on an
irrelevant process due to "REP; MOVS*' accesses in a kernel context,
e.g., copy_page.

Tested:

Injected errors on 1st cache line of 8 anonymous pages of process
'proc1' and observed MCE consumption from 'proc2' with no panic
(directly returned).

Without the fix, the host panicked within a few minutes on a
random 'proc2' process due to kernel access from copy_page.

  [ bp: Fix comment style + touch ups, zap an unlikely(), improve the
    quirk function's readability. ]

Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20220218013209.2436006-1-juew@google.com
---
 arch/x86/kernel/cpu/mce/core.c     | 64 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  5 +-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0e71474..3d766e6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -815,6 +815,59 @@ quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 }
 
 /*
+ * Disable fast string copy and return from the MCE handler upon the first SRAR
+ * MCE on bank 1 due to a CPU erratum on Intel Skylake/Cascade Lake/Cooper Lake
+ * CPUs.
+ * The fast string copy instructions ("REP; MOVS*") could consume an
+ * uncorrectable memory error in the cache line _right after_ the desired region
+ * to copy and raise an MCE with RIP pointing to the instruction _after_ the
+ * "REP; MOVS*".
+ * This mitigation addresses the issue completely with the caveat of performance
+ * degradation on the CPU affected. This is still better than the OS crashing on
+ * MCEs raised on an irrelevant process due to "REP; MOVS*" accesses from a
+ * kernel context (e.g., copy_page).
+ *
+ * Returns true when fast string copy on CPU has been disabled.
+ */
+static noinstr bool quirk_skylake_repmov(void)
+{
+	u64 mcgstatus   = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+	u64 misc_enable = mce_rdmsrl(MSR_IA32_MISC_ENABLE);
+	u64 mc1_status;
+
+	/*
+	 * Apply the quirk only to local machine checks, i.e., no broadcast
+	 * sync is needed.
+	 */
+	if (!(mcgstatus & MCG_STATUS_LMCES) ||
+	    !(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING))
+		return false;
+
+	mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+
+	/* Check for a software-recoverable data fetch error. */
+	if ((mc1_status &
+	     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
+	      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
+	      MCI_STATUS_AR | MCI_STATUS_S)) ==
+	     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
+	      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
+	      MCI_STATUS_AR | MCI_STATUS_S)) {
+		misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
+		mce_wrmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+		mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
+
+		instrumentation_begin();
+		pr_err_once("Erratum detected, disable fast string copy instructions.\n");
+		instrumentation_end();
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
@@ -1383,6 +1436,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
+		goto clear;
+
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
@@ -1525,6 +1581,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 out:
 	instrumentation_end();
 
+clear:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
@@ -1838,6 +1895,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
 		if (c->x86 == 6 && c->x86_model == 45)
 			mce_flags.snb_ifu_quirk = 1;
+
+		/*
+		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
+		 * rep movs.
+		 */
+		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+			mce_flags.skx_repmov_quirk = 1;
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a04b61e..3efb503 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -170,7 +170,10 @@ struct mce_vendor_flags {
 	/* SandyBridge IFU quirk */
 	snb_ifu_quirk		: 1,
 
-	__reserved_0		: 57;
+	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
+	skx_repmov_quirk	: 1,
+
+	__reserved_0		: 56;
 };
 
 extern struct mce_vendor_flags mce_flags;
