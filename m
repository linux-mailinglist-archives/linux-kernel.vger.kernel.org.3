Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A634D3D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiCIWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCIWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:43:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFC511C38;
        Wed,  9 Mar 2022 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865761; x=1678401761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ruPtGiXXQdOvROYpaC01TgDVkmf4NhGWvn3Yv1zkvtA=;
  b=OpbbHWCLJ2/kOG1K5Hkrcrf8ObXjd6DDzMZO8olHqmyM3buekI5hmLMe
   vn9MnLWEIU5N3zpjiyHYd2ow48SOvJew3UCYgfg0yigtzsFAzZHB+VLYA
   SQ/fdZqWyB3Ca0ZA1Ic62VZ9LcNZYPtu0S9bvgf+aLoTB49Dx7FwspRyY
   QuMgEDIC7w/dHKrMEe6MJ1URAviRqZj7OBZxtn+JJlXsXxmAsbkkwgtiQ
   fKIcK7Tf6jlVFLOn9NpPFerY1zWeFMpRTfXXmxnaBD290NEpq5USU/yGg
   7XmfdYTZxOC+fADCQUTJoXaKWhszqyTUAe4Txrtksh3BIpAAvFU/WtBCs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="253938954"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="253938954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="554329567"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2022 14:42:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
Date:   Wed,  9 Mar 2022 14:34:30 -0800
Message-Id: <20220309223431.26560-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309223431.26560-1-chang.seok.bae@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Changes from v1:
* Check the dynamic state flag first, to avoid #UD with XGETBV(1).

Dependency on the opcode map update:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/misc&id=9dd94df75b30eca03ed2151dd5bbc152a6f19abf
---
 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 15 +++++++++++++++
 3 files changed, 26 insertions(+)

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
index 8dea01ffc5c1..572dfa962b7b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -847,3 +847,18 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
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
+	if (!fpu_state_size_dynamic())
+		return;
+
+	if (xfeatures_in_use() & XFEATURE_MASK_XTILE) {
+		tile_release();
+		fpregs_deactivate(&current->thread.fpu);
+	}
+}
-- 
2.17.1

