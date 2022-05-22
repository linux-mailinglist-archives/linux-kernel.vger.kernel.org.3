Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839A5303E6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348364AbiEVPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348200AbiEVPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD3336B4B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 08:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98FA661003
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F418DC34113;
        Sun, 22 May 2022 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653234270;
        bh=lCSXZUmp2XpJTlxqmcLhDoFxLAVPQOfR1UxKkPK1zio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOlqu/xxnnOsLiSZ0Z2RlhhRSow89I7Q/7Rj9UuV3DJ5yC9hwu5OxfZck5IMVqYZh
         7LVeCtb1iMGpkmSAUm9WRbUp5/wZCI6+bDPk5XCMUHoD5i+wE2VbWfZKcJEbzvl8u0
         ctUrihTcckQDZLHkgZogdVFlBRKRBkpsJQVGTAcsBdfs0+ZjxB4pg97bASmweRrRqk
         0O1somznEwwm0jU7a52++5Yh4RQpjLhu91a8MN/luOlfnJSbvPOAFpno+gelA+1yyY
         czDss6+ZiYWfZiP3QVjlbPYLPPxteeWcqlvklTBVVxzYd2hyjTCm6Q8/F+7LyqXZRn
         I9928bfxSZWTw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: switch has_fpu() to the unified static key mechanism
Date:   Sun, 22 May 2022 23:35:43 +0800
Message-Id: <20220522153543.2656-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220522153543.2656-1-jszhang@kernel.org>
References: <20220522153543.2656-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to use the unified static key mechanism instead of putting
static key related here and there.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/switch_to.h | 4 ++--
 arch/riscv/kernel/cpufeature.c     | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0a3f4f95c555..11463489fec6 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <asm/hwcap.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
@@ -56,10 +57,9 @@ static inline void __switch_to_aux(struct task_struct *prev,
 	fstate_restore(next, task_pt_regs(next));
 }
 
-extern struct static_key_false cpu_hwcap_fpu;
 static __always_inline bool has_fpu(void)
 {
-	return static_branch_likely(&cpu_hwcap_fpu);
+	return static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_FPU]);
 }
 #else
 static __always_inline bool has_fpu(void) { return false; }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89f886b35357..0235391be84b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -21,9 +21,6 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
-#ifdef CONFIG_FPU
-__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
-#endif
 __ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
 EXPORT_SYMBOL(riscv_isa_ext_keys);
 
@@ -239,8 +236,4 @@ void __init riscv_fill_hwcap(void)
 		if (j >= 0)
 			static_branch_enable(&riscv_isa_ext_keys[j]);
 	}
-#ifdef CONFIG_FPU
-	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
-		static_branch_enable(&cpu_hwcap_fpu);
-#endif
 }
-- 
2.34.1

