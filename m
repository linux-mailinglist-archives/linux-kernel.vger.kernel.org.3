Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C065439FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiFHRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiFHRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:10:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289C3FBBCE;
        Wed,  8 Jun 2022 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654707412; x=1686243412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=F4L0RjTrL9ocDlqPulFosaCzsuwH2sWkXHYM3jpPmOo=;
  b=lNsUY7D7F5So1YpLz2U6+df9bddJRo3ZYnp2D+u8SGKDhfwApqfGG+LP
   qIRzBbf/hMmj0zO+EhUDwLtBZXiYd0DAKbtF0CorJYn2Ge/jacOHYlBS6
   j5j5UicSD65zk1tnEDGaaeHGZzB+AuSb1/Av2BUoRB3N9O6F+9C0giY+v
   9ncZvKXbjCreZccwPKQeDBP/aJkn3ym82DLoW2xE8m4DZ4FEbENMysgLi
   CIL+UljYFN54ZRwX/7+WaBdXrI04+fxZu6GAjbJGNrLSCGkuDYuGTqf+L
   uPJZ/0DJZmiTs/lxx69UPKiS8nscA275NRJLLcPVHlpnIPvr3HNUaXiDf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265768316"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="265768316"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 09:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="585001329"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 09:56:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org, riel@fb.com,
        bigeasy@linutronix.de, hch@lst.de, fenghua.yu@intel.com,
        rui.zhang@intel.com, artem.bityutskiy@linux.intel.com,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 1/2] x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
Date:   Wed,  8 Jun 2022 09:47:47 -0700
Message-Id: <20220608164748.11864-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220608164748.11864-1-chang.seok.bae@intel.com>
References: <20220608164748.11864-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU enters an idle state, a non-initialized AMX register state may
be the cause of preventing a deeper low-power state. Other extended
register states whether initialized or not do not impact the CPU idle
state.

The new helper can ensure the AMX state is initialized before the CPU is
idle, and it will be used by the intel idle driver.

Check the AMX_TILE feature bit before using XGETBV1 as a chain of
dependencies was established via cpuid_deps[]: AMX->XFD->XGETBV1.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@fb.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
Changes from v4:
* Switch to check the AMX_TILE flag instead XGETBV1 (Dave Hansen).
* Massage the changelog.

Changes from v3:
* Call out AMX state in changelog (Thomas Glexiner).

Changes from v2:
* Check the feature flag instead of fpu_state_size_dynamic() (Dave Hansen).

Changes from v1:
* Check the dynamic state flag first, to avoid #UD with XGETBV(1).
---
 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 6b0f31fb53f7..503a577814b2 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -164,4 +164,6 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 /* prctl */
 extern long fpu_xstate_prctl(int option, unsigned long arg2);
 
+extern void fpu_idle_fpregs(void);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 45b18eb94fa1..35f709f619fb 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -295,6 +295,15 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	return 0;
 }
 
+static inline void tile_release(void)
+{
+	/*
+	 * Instruction opcode for TILERELEASE; supported in binutils
+	 * version >= 2.36.
+	 */
+	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0531d6a06df5..3b28c5b25e12 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -851,3 +851,17 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 	 */
 	return 0;
 }
+
+/*
+ * Initialize register state that may prevent from entering low-power idle.
+ * This function will be invoked from the cpuidle driver only when needed.
+ */
+void fpu_idle_fpregs(void)
+{
+	/* Note: AMX_TILE being enabled implies XGETBV1 support */
+	if (cpu_feature_enabled(X86_FEATURE_AMX_TILE) &&
+	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
+		tile_release();
+		fpregs_deactivate(&current->thread.fpu);
+	}
+}
-- 
2.17.1

