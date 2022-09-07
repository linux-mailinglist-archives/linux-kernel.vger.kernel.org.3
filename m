Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2B5AF8FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIGAgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGAgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:36:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D2857FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:36:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so9671524ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=FGh1VhDcmGlg8+aYUWq0Y5ZRzQes3IbJ2Bvcwl332Vc=;
        b=dYgkW/uq16TcmzVZj9BYnRBL55Cld40RkxDSBE6YP2Ngo2zFDq2ki8L0OSjy46LLzk
         9dH+qF1qHF9muM/47QROimGvq4QAUYyZFG/yyqB+tvMsHjo84UuaBPNpOKNjELyPVbL7
         y2Qi1KMfAWtwwzQWEreE/rP6OXQ+dZm+q4uxlCRSFvszF6zbOxHOer9H++EXfe81SkOS
         60poMCkbjjHR70Z9KWEkk/QrdOY2MrOS3bppTpGFMlFBfPaBjFmmo1a2g3LzbLkd05F0
         NzVGDVgru6WNkTWKnfeu7XRNApaAvWJ3Eiej7KHAgMCKfktPDolfVMtLtxklbmv/e2mv
         gclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FGh1VhDcmGlg8+aYUWq0Y5ZRzQes3IbJ2Bvcwl332Vc=;
        b=TzHnZwmPbDeIzmimwN+/RMMtW2JQmUDS413d4ZgNAXEM4tZ2fZgalyIXJw3tYkRpTu
         wEe978XlxXQMdijtvHTNxzNNnYZxq4oScEPSiQ6xtbRtKNHLCP7qrN5HUCiPti9AoVGb
         TOeUasPWkvWPvreihrJFZf1kTeqIvaNCf91cQdVRpjCr4XLahhfHLqg+U30Q7Srz+HFY
         5vruXqK4mdCx4egT12dOaxuj8N7XMNU9ocYaa2QlRq8hKrWNdKjudplvrN54sSFCbOBB
         RzuPiwKKRYS6TeVGKAdjhwwGU1VuUpAsibNoA3UvEGg/rp6bl6dBm/PoUscyLdRjidlb
         4RSw==
X-Gm-Message-State: ACgBeo2RzheAIxJ7byAbKxuXeEltCqCMeEWvd8sRL8StT8ZJn8rw2ibb
        g5JF/up+MUAxTBGygcaFqIB8yFsrbp5G
X-Google-Smtp-Source: AA6agR657OQhcz8Sr8V2M1tB+dKCHET8C3VHblIbArzxwfHBowbgWsnL/QAJrNcWuptDFnCq3RAOTs492AtR
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:e475:deee:e746:40d9])
 (user=eugenis job=sendgmr) by 2002:a25:d607:0:b0:6a8:d9d8:7735 with SMTP id
 n7-20020a25d607000000b006a8d9d87735mr983824ybg.348.1662510995337; Tue, 06 Sep
 2022 17:36:35 -0700 (PDT)
Date:   Tue,  6 Sep 2022 17:36:30 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907003630.1115439-1-eugenis@google.com>
Subject: [PATCH v4] arm64: mte: move register initialization to C
From:   Evgenii Stepanov <eugenis@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        kernel test robot <lkp@intel.com>
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

If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
in fact implement FEAT_MTE2, setting the system register like this may
lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
in the C function cpu_enable_mte which is called based on the sanitized
version of the system register.

There is no need for the rest of the MTE-related system register
initialization to happen from assembly, with the exception of TCR_EL1,
which must be set to include at least TBI1 because the secondary CPUs
access KASan-allocated data structures early. Therefore, make the TCR_EL1
initialization unconditional and move the rest of the initialization to
cpu_enable_mte so that we no longer have a dependency on the unsanitized
ID register value.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Evgenii Stepanov <eugenis@google.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changelong since v3:
- Removed extra isb barrier.
- Fixed build without CONFIG_ARM64_MTE.

Changelog since v2:
- Fixed register initialization on cpu_resume code path.

Changelog since v1:
- Keep TBI1 off unless CONFIG_ARM64_MTE
- Fixed mask application in the RGSR_EL1 computation (bug found by Kenny
  Root).
- Changed code formatting

 arch/arm64/include/asm/mte.h   |  5 ++++
 arch/arm64/kernel/cpufeature.c |  3 +-
 arch/arm64/kernel/mte.c        | 51 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c    |  2 ++
 arch/arm64/mm/proc.S           | 46 ++++--------------------------
 5 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index aa523591a44e5..760c62f8e22f8 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -42,7 +42,9 @@ void mte_sync_tags(pte_t old_pte, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
+void mte_cpu_setup(void);
 void mte_suspend_enter(void);
+void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
@@ -72,6 +74,9 @@ static inline void mte_thread_switch(struct task_struct *next)
 static inline void mte_suspend_enter(void)
 {
 }
+static inline void mte_suspend_exit(void)
+{
+}
 static inline long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
 	return 0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af4de817d7123..d7a077b5ccd1c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2034,7 +2034,8 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
-	isb();
+
+	mte_cpu_setup();
 
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index b2b730233274b..aca88470fb69d 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -285,6 +285,49 @@ void mte_thread_switch(struct task_struct *next)
 	mte_check_tfsr_el1();
 }
 
+void mte_cpu_setup(void)
+{
+	u64 rgsr;
+
+	/*
+	 * CnP must be enabled only after the MAIR_EL1 register has been set
+	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
+	 * lead to the wrong memory type being used for a brief window during
+	 * CPU power-up.
+	 *
+	 * CnP is not a boot feature so MTE gets enabled before CnP, but let's
+	 * make sure that is the case.
+	 */
+	BUG_ON(read_sysreg(ttbr0_el1) & TTBR_CNP_BIT);
+	BUG_ON(read_sysreg(ttbr1_el1) & TTBR_CNP_BIT);
+
+	/* Normal Tagged memory type at the corresponding MAIR index */
+	sysreg_clear_set(mair_el1,
+			 MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED),
+			 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED,
+				      MT_NORMAL_TAGGED));
+
+	write_sysreg_s(KERNEL_GCR_EL1, SYS_GCR_EL1);
+
+	/*
+	 * If GCR_EL1.RRND=1 is implemented the same way as RRND=0, then
+	 * RGSR_EL1.SEED must be non-zero for IRG to produce
+	 * pseudorandom numbers. As RGSR_EL1 is UNKNOWN out of reset, we
+	 * must initialize it.
+	 */
+	rgsr = (read_sysreg(CNTVCT_EL0) & SYS_RGSR_EL1_SEED_MASK) <<
+	       SYS_RGSR_EL1_SEED_SHIFT;
+	if (rgsr == 0)
+		rgsr = 1 << SYS_RGSR_EL1_SEED_SHIFT;
+	write_sysreg_s(rgsr, SYS_RGSR_EL1);
+
+	/* clear any pending tag check faults in TFSR*_EL1 */
+	write_sysreg_s(0, SYS_TFSR_EL1);
+	write_sysreg_s(0, SYS_TFSRE0_EL1);
+
+	local_flush_tlb_all();
+}
+
 void mte_suspend_enter(void)
 {
 	if (!system_supports_mte())
@@ -301,6 +344,14 @@ void mte_suspend_enter(void)
 	mte_check_tfsr_el1();
 }
 
+void mte_suspend_exit(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	mte_cpu_setup();
+}
+
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
 	u64 mte_ctrl = (~((arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT) &
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 9135fe0f3df53..8b02d310838f9 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -43,6 +43,8 @@ void notrace __cpu_suspend_exit(void)
 {
 	unsigned int cpu = smp_processor_id();
 
+	mte_suspend_exit();
+
 	/*
 	 * We are resuming from reset with the idmap active in TTBR0_EL1.
 	 * We must uninstall the idmap and restore the expected MMU
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7837a69524c53..f38bccdd374a5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -48,17 +48,19 @@
 
 #ifdef CONFIG_KASAN_HW_TAGS
 #define TCR_MTE_FLAGS TCR_TCMA1 | TCR_TBI1 | TCR_TBID1
-#else
+#elif defined(CONFIG_ARM64_MTE)
 /*
  * The mte_zero_clear_page_tags() implementation uses DC GZVA, which relies on
  * TBI being enabled at EL1.
  */
 #define TCR_MTE_FLAGS TCR_TBI1 | TCR_TBID1
+#else
+#define TCR_MTE_FLAGS 0
 #endif
 
 /*
  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
- * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ * changed during mte_cpu_setup to Normal Tagged if the system supports MTE.
  */
 #define MAIR_EL1_SET							\
 	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
@@ -426,46 +428,8 @@ SYM_FUNC_START(__cpu_setup)
 	mov_q	mair, MAIR_EL1_SET
 	mov_q	tcr, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
-
-#ifdef CONFIG_ARM64_MTE
-	/*
-	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
-	 * (ID_AA64PFR1_EL1[11:8] > 1).
-	 */
-	mrs	x10, ID_AA64PFR1_EL1
-	ubfx	x10, x10, #ID_AA64PFR1_MTE_SHIFT, #4
-	cmp	x10, #ID_AA64PFR1_MTE
-	b.lt	1f
-
-	/* Normal Tagged memory type at the corresponding MAIR index */
-	mov	x10, #MAIR_ATTR_NORMAL_TAGGED
-	bfi	mair, x10, #(8 *  MT_NORMAL_TAGGED), #8
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
 
-	mov	x10, #KERNEL_GCR_EL1
-	msr_s	SYS_GCR_EL1, x10
-
-	/*
-	 * If GCR_EL1.RRND=1 is implemented the same way as RRND=0, then
-	 * RGSR_EL1.SEED must be non-zero for IRG to produce
-	 * pseudorandom numbers. As RGSR_EL1 is UNKNOWN out of reset, we
-	 * must initialize it.
-	 */
-	mrs	x10, CNTVCT_EL0
-	ands	x10, x10, #SYS_RGSR_EL1_SEED_MASK
-	csinc	x10, x10, xzr, ne
-	lsl	x10, x10, #SYS_RGSR_EL1_SEED_SHIFT
-	msr_s	SYS_RGSR_EL1, x10
-
-	/* clear any pending tag check faults in TFSR*_EL1 */
-	msr_s	SYS_TFSR_EL1, xzr
-	msr_s	SYS_TFSRE0_EL1, xzr
-
-	/* set the TCR_EL1 bits */
-	mov_q	x10, TCR_MTE_FLAGS
-	orr	tcr, tcr, x10
-1:
-#endif
 	tcr_clear_errata_bits tcr, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-- 
2.37.2.789.g6183377224-goog

