Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984744E653B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351127AbiCXOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbiCXOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:17 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854FA27DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:45 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSMG1QSwz9sTv;
        Thu, 24 Mar 2022 15:31:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IGDEJ7dX8uNF; Thu, 24 Mar 2022 15:31:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLz0NDXz9sTy;
        Thu, 24 Mar 2022 15:30:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED49B8B78C;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lFfgi1jTid_n; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 087988B7A7;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUhEb1811738
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:43 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUhrT1811737;
        Thu, 24 Mar 2022 15:30:43 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 15/22] powerpc/ftrace: Simplify expected_nop_sequence()
Date:   Thu, 24 Mar 2022 15:30:05 +0100
Message-Id: <b617f679cb71a4d6ed1866d11aaa2d6b5c3d63fe.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132151; l=1538; s=20211009; h=from:subject:message-id; bh=1DO4SNrhdDjZCmpTrZccuhk4GnTHpfT7IFl/43Z7Mzk=; b=t1sodoXfuNbA+ivfoI3lfiedDazUkAAiCrLsklOB7EZxEyTbmrotABfxcs8nUfrA0tBOezSZi/8l TTIzt2utCiaguP+bDLpODCey2X7U/QBRCYT6rkRJ8xzLliYQLVVw
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid ifdefs around expected_nop_sequence().

While at it make it a bool.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 15e0746806f8..ffedf8c82ea8 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -390,24 +390,14 @@ int ftrace_make_nop(struct module *mod,
  * They should effectively be a NOP, and follow formal constraints,
  * depending on the ABI. Return false if they don't.
  */
-#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-static int
-expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
-{
-	if (!ppc_inst_equal(op0, ppc_inst(PPC_RAW_BRANCH(8))) ||
-	    !ppc_inst_equal(op1, ppc_inst(PPC_INST_LD_TOC)))
-		return 0;
-	return 1;
-}
-#else
-static int
-expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
+static bool expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
 {
-	if (!ppc_inst_equal(op0, ppc_inst(PPC_RAW_NOP())))
-		return 0;
-	return 1;
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return ppc_inst_equal(op0, ppc_inst(PPC_RAW_NOP()));
+	else
+		return ppc_inst_equal(op0, ppc_inst(PPC_RAW_BRANCH(8))) &&
+		       ppc_inst_equal(op1, ppc_inst(PPC_INST_LD_TOC));
 }
-#endif
 
 static int
 __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
-- 
2.35.1

