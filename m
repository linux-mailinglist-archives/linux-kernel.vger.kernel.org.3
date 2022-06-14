Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7796354BDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355275AbiFNWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbiFNWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4252B02;
        Tue, 14 Jun 2022 15:54:03 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655247241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFIif++WYe6R40cPTD/3X0hAdNJcAH56e2ZH3rTEZAw=;
        b=CPRlOYTMauKq/4y6HQRlN+8eS8PtACSBGAO6ap3M61PwBDb14e0vqdgS1st5zVMtuXf08e
        5j+n7Ts7Gtl2w9H9iQtxDuZZCNzs2q6gBzgoN8RYC1D46+rc3jMmfG6r6ycnCbvSgW2kyq
        I52eBYWbPtv5HMoewJBB1en+46Kh8JI3MZT/UUwRxDzxUikVeYnXrmeaOFzDHl6PPntKa+
        UCkKOqYtwKpoeLRP4uz9foEz+J16FHiMS00Erh8YC+sd3QMVcHivw9rt7HU02ZVSbfxMxS
        rQVteq7Q89tgTI9V9f6iGTBBOodBBT7LGOVXyrc7OTRP7dKrFVzOl8SMQXSpDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655247241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFIif++WYe6R40cPTD/3X0hAdNJcAH56e2ZH3rTEZAw=;
        b=YWyrBgmSIx++8xQR65NrjuDOzChP4MJoTEr6dI+E5MB9j2odEwaEul2asstrIJOtzZEyWE
        HDfMZzvapMobi5AQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220608164748.11864-2-chang.seok.bae@intel.com>
References: <20220608164748.11864-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <165524723963.4207.9260777437314481526.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     418bf5f906c33e83e76239748982dc3d2330cf30
Gitweb:        https://git.kernel.org/tip/418bf5f906c33e83e76239748982dc3d2330cf30
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 08 Jun 2022 09:47:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 14 Jun 2022 15:48:44 -07:00

x86/fpu: Add a helper to prepare AMX state for low-power CPU idle

When a CPU enters an idle state, a non-initialized AMX register state may
be the cause of preventing a deeper low-power state. Other extended
register states whether initialized or not do not impact the CPU idle
state.

The new helper can ensure the AMX state is initialized before the CPU is
idle, and it will be used by the intel idle driver.

Check the AMX_TILE feature bit before using XGETBV1 as a chain of
dependencies was established via cpuid_deps[]: AMX->XFD->XGETBV1.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220608164748.11864-2-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 6b0f31f..503a577 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -164,4 +164,6 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 /* prctl */
 extern long fpu_xstate_prctl(int option, unsigned long arg2);
 
+extern void fpu_idle_fpregs(void);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 45b18eb..35f709f 100644
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
index 0531d6a..3b28c5b 100644
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
