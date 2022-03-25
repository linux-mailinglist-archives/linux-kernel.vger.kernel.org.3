Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE74E6C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357772AbiCYCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357738AbiCYCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:32:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7AB7160;
        Thu, 24 Mar 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648175437; x=1679711437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iedGPOCULJcEPMdGPip/uvztNGO9WqgsgV67R6Hlq9k=;
  b=cntP+OX+5XBtCoGPslSDe84cWHNEPMVJTnZJBfGdCBvQmHVTPAXfdX0+
   qYvzH+z75OYo9c5hzr32nNySZQ7c6q+VlPpCNvwlUut84b6NxfURtYnV+
   il5XXSMrGRos868I62R3CB7xShQ3rKNCOrZhQxv7CPPoz9NUs77TqlLK7
   i76YZ7ybnlsmujAFPIttNjGYrzOU3en0eqx+Yln1VKxdrLbxklyrx40Rj
   Zq79shHvpSeXJXYQoFqnX1AVtOENeSTI09Z4GNXNB1A3zpUC9eK8F2dsD
   mn7NuUo79w25nEBW8/F3fVT8OP/+jn/WWihrTeKqyOwtBNt7oW37Cqhv2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321733683"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321733683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="693531282"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2022 19:30:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v3 2/3] x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
Date:   Thu, 24 Mar 2022 19:22:18 -0700
Message-Id: <20220325022219.829-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325022219.829-1-chang.seok.bae@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU enters an idle state, non-initialized states left in large
registers may be the cause of preventing deeper low-power states.

The new helper ensures the AMX state is initialized to make the CPU
ready for low-power states. It will be used by the intel idle driver.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Check the feature flag instead of fpu_state_size_dynamic() (Dave Hansen).

Changes from v1:
* Check the dynamic state flag first, to avoid #UD with XGETBV(1).
---
 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c83b3020350a..df48912fd1c8 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -165,4 +165,6 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 struct task_struct;
 extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
 
+extern void fpu_idle_fpregs(void);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..d434fbaeb3ff 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -294,6 +294,15 @@ static inline int enqcmds(void __iomem *dst, const void *src)
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
index 8dea01ffc5c1..3507609e22d7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -847,3 +847,16 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
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
+	if (cpu_feature_enabled(X86_FEATURE_XGETBV1) &&
+	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
+		tile_release();
+		fpregs_deactivate(&current->thread.fpu);
+	}
+}
-- 
2.17.1

