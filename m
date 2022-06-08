Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3ED543CED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiFHTcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFHTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:32:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE331E7379;
        Wed,  8 Jun 2022 12:32:40 -0700 (PDT)
Date:   Wed, 08 Jun 2022 19:32:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654716759;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoQk4tzuqtbHjz3NYYUPrCnf5P1rjXtgvCraA40akys=;
        b=pHJFVE5Ku0NvcfuG5XXT+Fm71tcBr995erlLoEK6XQuPpMCKFBZrUSyqZI0hX7frng8o1n
        1fviESLYn2UwseraPaiiVS07yUB7975oXt2sa2hyxO7ZcSW8hF+JepVetuWZYZBAsL9ZIn
        CZWmdU4/dLLy1Wwcuy79N/mYTBpZdaG5Zny8qITwfu1mYCpKAcAamRNMuD32R5C435qsvs
        NtXdeR/YWRYBaqDg2ON2ncQF9pUGltIJ8SdzrvVezlKaiT4WHMDBpA3GuDeWWCqZz/FBQs
        YWSWI+LsgTGCM1sgSJDRP2qThMAvtO4E9TDvE3D5R6VCsgjatZnvLWbFVv+lKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654716759;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoQk4tzuqtbHjz3NYYUPrCnf5P1rjXtgvCraA40akys=;
        b=tP3LExaSxq/z6iJ84R7x9dWeeT7x6hqoJjQHRLyB5hVEpTQ1XcBiMVeThEYJ01StHEu9mh
        aQnSW0xL4aXYaGBA==
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
Message-ID: <165471675832.4207.11246479220985649107.tip-bot2@tip-bot2>
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

Commit-ID:     407f1fd0780e39d60778a66c6a157d8c8c832729
Gitweb:        https://git.kernel.org/tip/407f1fd0780e39d60778a66c6a157d8c8c832729
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 08 Jun 2022 09:47:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Jun 2022 12:03:56 -07:00

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
index c83b302..df48912 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -165,4 +165,6 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 struct task_struct;
 extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
 
+extern void fpu_idle_fpregs(void);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a..d434fba 100644
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
index c049561..209cfac 100644
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
