Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789834DD852
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiCRKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180B2DB59B;
        Fri, 18 Mar 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aqJEVPpvJalLsUnfUzsch2vN51qYTT0hYCqrFLIZhZM=;
  b=qsnpR3wxPbvlG3Zh2lXjQbCyCZk4+SMVRdOGFJ7GA7NTdGxJ+7aIhLm8
   6j7GZSDm1dtE6UhHff3Lw+59ZBgLC3oKr4LOCPmmmjYbOko7k4FYL7hzN
   DbHLfK6QfzLcSwCNAreXk8NUbgGvd4Hz7UZREbXPiST3d3nmscwHWvRCZ
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935656"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:15 +0100
Message-Id: <20220318103729.157574-20-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arc/kernel/disasm.c    |    2 +-
 arch/arc/kernel/signal.c    |    2 +-
 arch/arc/kernel/smp.c       |    2 +-
 arch/arc/kernel/unaligned.c |    2 +-
 arch/arc/mm/cache.c         |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/disasm.c b/arch/arc/kernel/disasm.c
index 03f8b1be0c3a..897d5d70b39a 100644
--- a/arch/arc/kernel/disasm.c
+++ b/arch/arc/kernel/disasm.c
@@ -366,7 +366,7 @@ void __kprobes disasm_instr(unsigned long addr, struct disasm_state *state,
 	case op_SP:	/* LD_S|LDB_S b,[sp,u7], ST_S|STB_S b,[sp,u7] */
 		/* note: we are ignoring possibility of:
 		 * ADD_S, SUB_S, PUSH_S, POP_S as these should not
-		 * cause unaliged exception anyway */
+		 * cause unaligned exception anyway */
 		state->write = BITS(state->words[0], 6, 6);
 		state->zz = BITS(state->words[0], 5, 5);
 		if (state->zz)
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index cb2f88502baf..78583e80d124 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -319,7 +319,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	regs->ret = (unsigned long)ksig->ka.sa.sa_handler;
 
 	/*
-	 * handler returns using sigreturn stub provided already by userpsace
+	 * handler returns using sigreturn stub provided already by userspace
 	 * If not, nuke the process right away
 	 */
 	if(!(ksig->ka.sa.sa_flags & SA_RESTORER))
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 78e6d069b1c1..383fefee2ae5 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(smp_atomic_ops_lock);
 
 struct plat_smp_ops  __weak plat_smp_ops;
 
-/* XXX: per cpu ? Only needed once in early seconday boot */
+/* XXX: per cpu ? Only needed once in early secondary boot */
 struct task_struct *secondary_idle_tsk;
 
 /* Called from start_kernel */
diff --git a/arch/arc/kernel/unaligned.c b/arch/arc/kernel/unaligned.c
index d63ebd81f1c6..99a9b92ed98d 100644
--- a/arch/arc/kernel/unaligned.c
+++ b/arch/arc/kernel/unaligned.c
@@ -237,7 +237,7 @@ int misaligned_fixup(unsigned long address, struct pt_regs *regs,
 	if (state.fault)
 		goto fault;
 
-	/* clear any remanants of delay slot */
+	/* clear any remnants of delay slot */
 	if (delay_mode(regs)) {
 		regs->ret = regs->bta & ~1U;
 		regs->status32 &= ~STATUS_DE_MASK;
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 8aa1231865d1..5446967ea98d 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -401,7 +401,7 @@ static inline void __before_dc_op(const int op)
 {
 	if (op == OP_FLUSH_N_INV) {
 		/* Dcache provides 2 cmd: FLUSH or INV
-		 * INV inturn has sub-modes: DISCARD or FLUSH-BEFORE
+		 * INV in turn has sub-modes: DISCARD or FLUSH-BEFORE
 		 * flush-n-inv is achieved by INV cmd but with IM=1
 		 * So toggle INV sub-mode depending on op request and default
 		 */

