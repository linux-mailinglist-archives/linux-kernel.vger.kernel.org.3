Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4756A65D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGGO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiGGO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:57:15 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFA6050E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:55:49 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Ldzx42v9hz9t90;
        Thu,  7 Jul 2022 16:55:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lGeRlFMvrpmv; Thu,  7 Jul 2022 16:55:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Ldzx20t7cz9tGl;
        Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0934B8B79F;
        Thu,  7 Jul 2022 16:55:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OQtiZNxWGIkV; Thu,  7 Jul 2022 16:55:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B38748B768;
        Thu,  7 Jul 2022 16:55:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 267EtOoq541785
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 16:55:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 267EtOrU541784;
        Thu, 7 Jul 2022 16:55:24 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/ppc-opcode: Define and use PPC_RAW_SETB()
Date:   Thu,  7 Jul 2022 16:55:16 +0200
Message-Id: <b08a4f26919a8f8cdcf7544ab552d9c1c63418b5.1657205708.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
References: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657205714; l=2466; s=20211009; h=from:subject:message-id; bh=MA6xOj9VVExuUsXYFao1TGXDnAJxvOazN6adHfrGfKw=; b=GDomlNnPfB4QFvP1BsU9IFZH6sUc/nVNlR02hQbgUJh4+JhIHvaYw2Q3C5vXKSHrkHkh1cCfjiOx DAcibdPEA22OTmCxPVt7uzy8L60KNDDD0CZWXyzEpzz54t5+GO+M
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

We have PPC_INST_SETB then build the 'setb' instruction in the
user.

Instead, define PPC_RAW_SETB() and use it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 2 +-
 arch/powerpc/lib/test_emulate_step.c  | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 5527a955fb4a..7b81b37a191e 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -290,7 +290,6 @@
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
 #define PPC_INST_STRING_GEN_MASK	0xfc00067e
-#define PPC_INST_SETB			0x7c000100
 #define PPC_INST_STSWI			0x7c0005aa
 #define PPC_INST_STSWX			0x7c00052a
 #define PPC_INST_TRECHKPT		0x7c0007dd
@@ -583,6 +582,7 @@
 #define PPC_RAW_BL(offset)		(0x48000001 | PPC_LI(offset))
 #define PPC_RAW_TW(t0, a, b)		(0x7f000008 | ___PPC_RS(t0) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_TRAP()			PPC_RAW_TW(31, 0, 0)
+#define PPC_RAW_SETB(t, bfa)		(0x7c000100 | ___PPC_RT(t) | ___PPC_RA((bfa) << 2))
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_BCCTR_FLUSH		stringify_in_c(.long PPC_INST_BCCTR_FLUSH)
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index f2e47be05e8c..23c7805fb7b3 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -53,9 +53,6 @@
 	ppc_inst_prefix(PPC_PREFIX_MLS | __PPC_PRFX_R(pr) | IMM_H(i), \
 			PPC_RAW_ADDI(t, a, i))
 
-#define TEST_SETB(t, bfa)       ppc_inst(PPC_INST_SETB | ___PPC_RT(t) | ___PPC_RA((bfa & 0x7) << 2))
-
-
 static void __init init_pt_regs(struct pt_regs *regs)
 {
 	static unsigned long msr;
@@ -935,21 +932,21 @@ static struct compute_test compute_tests[] = {
 		.subtests = {
 			{
 				.descr = "BFA = 1, CR = GT",
-				.instr = TEST_SETB(20, 1),
+				.instr = ppc_inst(PPC_RAW_SETB(20, 1)),
 				.regs = {
 					.ccr = 0x4000000,
 				}
 			},
 			{
 				.descr = "BFA = 4, CR = LT",
-				.instr = TEST_SETB(20, 4),
+				.instr = ppc_inst(PPC_RAW_SETB(20, 4)),
 				.regs = {
 					.ccr = 0x8000,
 				}
 			},
 			{
 				.descr = "BFA = 5, CR = EQ",
-				.instr = TEST_SETB(20, 5),
+				.instr = ppc_inst(PPC_RAW_SETB(20, 5)),
 				.regs = {
 					.ccr = 0x200,
 				}
-- 
2.36.1

