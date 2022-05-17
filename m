Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D652AE32
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiEQWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiEQWdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:33:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC73EABD;
        Tue, 17 May 2022 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652826800; x=1684362800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TNJIWjD4DGVIcQKb8FhoKhbYIvjf/XjvmxN3K/+SH90=;
  b=TOHoh5XefKnjIiT/0OeDVNGEO0lmNfDlcp526zNkE/Hj2F1z4p5Vq6q4
   IZK6uLS0CL9CPUSAh4FdpYkJU6Hcwlr3jmq5qGCoSLZ+84qIAvENLnw+e
   o3UkSEcJLSBNRjGxGxlWGpLicZh/SkA2xa/T6whC3gs7nU8c/O6R5kF4Y
   83Mvb1/JmxE//PAmljYRQIUJzfi501AxzJAHIjlSqRlsOF5OA47Tcp+3p
   ZHVklU3DQLuUkOck5QaUvvzXCnTbKtnl6jCaa1ExpiWa9CRyLGmcseyna
   hMseIYDeZaCJubOh+HSwy2y04GG6FcJnYxZ1CSnH9YGoDSLhPxwEGQBou
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268945492"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268945492"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="555993799"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 15:33:19 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v4 1/2] x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
Date:   Tue, 17 May 2022 15:24:29 -0700
Message-Id: <20220517222430.24524-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517222430.24524-1-chang.seok.bae@intel.com>
References: <20220517222430.24524-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU enters an idle state, non-initialized AMX register state may be
the cause of preventing a deeper low-power state. Other extended register
states whether initialized or not does not impact on the CPU idle state.

The new helper can ensure AMX state initialized before CPU idle, and it
will be used by the intel idle driver.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Call out AMX state in changelog (Thomas Glexiner).

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
index e28ab0ecc537..21ca325bd4db 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -836,3 +836,16 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
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

