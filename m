Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589457A55E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiGSRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiGSRbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:31:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DB52FCB;
        Tue, 19 Jul 2022 10:31:14 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658251872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEy3GJY59I7CxrglpCX3bhG+3jD+S6czPtWIZFCl7Po=;
        b=dS7UOqi7NJupKB4toSMtoWlat7AmOvP1/hXrDUtWOGSGLvAgLnhFNaZnkC2KSHEj0xBhnq
        A1wA4m8WEp+qMwqDBvNxSnBanIUSGLvPc49RiHreDjAErP85kjEM5QipMVrigf6z4eKbc7
        +G28TMFnZmcO3oR9Zh0abGWHhfjGhT88vGolbGdPwFuA8wzqd3hl2Lu8wri6Xm1dNhGiYe
        yIgfO6VXQTV+K+plevYsLJ8EVdJpOX+VqzIt0HkMarRz1zc5nTir2dOamopUWslX7L8KN/
        YC/SMDQKsubMjlQXCxxnOm06CH6ULVGwbf3ursWrkXNRAj6j8uGJDo8NZy50rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658251872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEy3GJY59I7CxrglpCX3bhG+3jD+S6czPtWIZFCl7Po=;
        b=lc6GCQMesJGkjsHc0bv0JQf3v9hbPe8SsI6/AiUO1KPhPe2uk2GJAo6qbbo62ZB1NAes7M
        jWeco2ws+XKH8eBA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220608164748.11864-2-chang.seok.bae@intel.com>
References: <20220608164748.11864-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <165825187133.15455.7594593311230934911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f17b168734c0fe47343a7502d012266a051f9942
Gitweb:        https://git.kernel.org/tip/f17b168734c0fe47343a7502d012266a051f9942
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 08 Jun 2022 09:47:47 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Jul 2022 18:46:15 +02:00

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
Signed-off-by: Borislav Petkov <bp@suse.de>
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
