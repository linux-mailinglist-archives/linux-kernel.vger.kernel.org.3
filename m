Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0384AB404
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiBGFvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351765AbiBGEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:36:45 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C9C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:36:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q4-20020a170902f78400b0014d57696618so902003pln.20
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 20:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RpgZKv2pVrDwgi45sVAGsLhZHRNIToNQoQwH+0Lvsto=;
        b=XQU5iYcr6a16R873ijABcrJIJQvoY6+ZidyrmpaLJI8ap0nOPS0uAadVqL44nJqbLC
         jVKw3xgZFolPPieidVjP9oGlEZvjKCkEy0OdknkbZXXDEAuhnovmBOT9eV1IGehPbjhr
         Zm0tFnedLEsJWGDqUAk1ejxoUfWkJXD/Y5824olCFtCi53Uo3hmyoMCgTIE5jAq+B1Mr
         k/12Lp8/ihI9TPTsjb+pekgA2S212xjuZQg3g4Fee3RiUi0lhw692l8ikgzMFUI52KU4
         jZC3oIulGrPtlhPzBO8p68/6r1VH9FG4YY/pZJdX1rQRlYLl1AVA//AB/DzD2QZ/LgY2
         EZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RpgZKv2pVrDwgi45sVAGsLhZHRNIToNQoQwH+0Lvsto=;
        b=7cotABx42dZ3QWOTqqeclEbQlJO1AXRML/eciJvxjtoojE+wsLKsMdQRReqcDoxu2m
         AOSZcmW4JXjiSse5Nwf/rejCPbhIYaoUuSS+8OQp8jobBfO2CvYN18k145KHy7DLcPo/
         oxbQmXBsppo0Cl430j0O5wkvFrxS79gmSPYiQONtDyXYlxSv1OMPONA/2witZb2oD7kF
         tq+CI3RC5G3dHkrqbe3ZDG1A/VcayLe8EhcW/poH8d4SdT9LQUKuxfpaj5lFVsI11Bz1
         838ohOEG3HHlkLwZsmNCqzLtuRF8nGMzjYzg7xgoBtJ7OHZATFfWyvxrCVU8R8i+cNBS
         kW0Q==
X-Gm-Message-State: AOAM532JyPiTjWWNvG8qn9w2LZymGg/+imJg+NVIB5PKmUEe33dCHQ6b
        AFad3+7o3Pxd7khDr//luVEjdqDh
X-Google-Smtp-Source: ABdhPJw7haqNCja730dbklrD2inGu4ZzhrXi20XTGrD1LNTCyQm4RisEuw91mmTo3UC8p/QzN9zJOSgw
X-Received: from juew-desktop.sea.corp.google.com ([2620:15c:100:202:786b:6fb0:c021:39be])
 (user=juew job=sendgmr) by 2002:a17:90a:5503:: with SMTP id
 b3mr16550573pji.187.1644208603586; Sun, 06 Feb 2022 20:36:43 -0800 (PST)
Date:   Sun,  6 Feb 2022 20:36:40 -0800
Message-Id: <20220207043640.2829295-1-juew@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
From:   Jue Wang <juew@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast string copy instructions ("rep movs*") could consume an
uncorrectable memory error in the cache line _right after_ the
desired region to copy and raise an MCE.

Bit 0 of MSR_IA32_MISC_ENABLE can be cleared to disable fast string copy
and will avoid such spurious machine checks. However, that is less
preferable due to the permanent performance impact. Considering memory
poison is rare, it's desirable to keep fast string enabled until an MCE
is seen.

Intel has confirmed the following:
1. The CPU erratum of fast string copy only applies to
SKX/CLX/CPL generations.
2. Directly return from MCE handler will result in complete execution
of the fast string copy (rep movs*) with no data loss or corruption.
3. Directly return from MCE handler will not result in another MCE
firing on the next poisoned cache line due to rep movs*.
4. Directly return from MCE handler will resume execution from a
correct point in code.
5. Directly return from MCE handler due to any other SRAR MCEs will
result in the same instruction that triggered the MCE firing a second
MCE immediately.
6. It's not safe to directly return without disabling the fast string
copy, as the next fast string copy of the same buffer on the same CPU
would result in a PANIC MCE.

The mitigation in this patch should mitigate the erratum completely with
the only caveat that the fast string copy is disabled on the affected
hyper thread thus performance degradation.

This is still better than the OS crashes on MCEs raised on an
irrelevant process due to 'rep movs*' accesses in a kernel context,
e.g., copy_page.

Since a host drain / fail-over usually starts right after the first
MCE is signaled, which results in VM migration or termination, the
performance degradation is a transient effect.

Tested:

Injected errors on 1st cache line of 8 anonymous pages of process
'proc1' and observed MCE consumption from 'proc2' with no panic
(directly returned).

Without the fix, the host panicked within a few minutes on a
random 'proc2' process due to kernel access from copy_page.

Signed-off-by: Jue Wang <juew@google.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 61 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 ++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..06001e3b2ff2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -834,6 +834,57 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 	m->cs = regs->cs;
 }
 
+static bool is_intel_srar(u64 mci_status)
+{
+	return (mci_status &
+		(MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
+		 MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
+		 MCI_STATUS_AR|MCI_STATUS_S)) ==
+		(MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
+		 MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S);
+}
+
+/*
+ * Disable fast string copy and return from the MCE handler upon the first SRAR
+ * MCE on bank 1 due to a CPU erratum on Intel SKX/CLX/CPL CPUs.
+ * The fast string copy instructions ("rep movs*") could consume an
+ * uncorrectable memory error in the cache line _right after_ the
+ * desired region to copy and raise an MCE with RIP pointing to the
+ * instruction _after_ the "rep movs*".
+ * This mitigation addresses the issue completely with the caveat of
+ * performance degradation on the CPU affected. This is still better
+ * than the OS crashes on MCEs raised on an irrelevant process due to
+ * 'rep movs*' accesses in a kernel context (e.g., copy_page).
+ * Since a host drain / fail-over usually starts right after the first
+ * MCE is signaled, which results in VM migration or termination, the
+ * performance degradation is a transient effect.
+ *
+ * Returns true when fast string copy on cpu should be disabled.
+ */
+static bool quirk_skylake_repmov(void)
+{
+	/*
+	 * State that represents if an SRAR MCE has already signaled on the DCU bank.
+	 */
+	static DEFINE_PER_CPU(bool, srar_dcu_signaled);
+
+	if (unlikely(!__this_cpu_read(srar_dcu_signaled))) {
+		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+
+		if (is_intel_srar(mc1_status)) {
+			__this_cpu_write(srar_dcu_signaled, true);
+			msr_clear_bit(MSR_IA32_MISC_ENABLE,
+				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);
+			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
+			pr_err("First SRAR MCE on DCU, CPU: %d, disable fast string copy.\n",
+			       smp_processor_id());
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
@@ -1403,6 +1454,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
+		return;
+
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
@@ -1858,6 +1912,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
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
index 52c633950b38..cec227c25138 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -170,7 +170,10 @@ struct mce_vendor_flags {
 	/* SandyBridge IFU quirk */
 	snb_ifu_quirk		: 1,
 
-	__reserved_0		: 57;
+	/* Skylake, Cascade Lake, Cooper Lake rep movs quirk */
+	skx_repmov_quirk		: 1,
+
+	__reserved_0		: 56;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.35.0.263.gb82422642f-goog

