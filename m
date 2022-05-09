Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D831F51F433
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiEIFrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiEIFqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:46:50 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E815E75A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:42:57 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKg02ygz9sWB;
        Mon,  9 May 2022 07:36:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zE4kndyPflGx; Mon,  9 May 2022 07:36:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKF6VjKz9sWC;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFEAD8B770;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4WhdA-dXHa5n; Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CC058B77D;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aStl1591219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aSbV1591218;
        Mon, 9 May 2022 07:36:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 03/25] powerpc/code-patching: Inline is_offset_in_{cond}_branch_range()
Date:   Mon,  9 May 2022 07:36:01 +0200
Message-Id: <a05be0ccb7373e6a9789a1988fcd0c810f5f9269.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074581; l=3156; s=20211009; h=from:subject:message-id; bh=gLaYW1av0GijX4+cqYkHFoJkNFVZ0gQqCQkmFifsN0M=; b=dLAEd9s8YLV02PIcm3kAxAn6Kt0HmYzrrV229Yma06yk5t9Ksmh51HQdmnH+QG6iLpgYnaTc/Mq3 W/2d9x/RBI8JS+PPSnvYbfP2xrKvpa1wy5+nenAyDUx0lWI0sik2
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

Test in is_offset_in_branch_range() and is_offset_in_cond_branch_range()
are simple tests that are worth inlining.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 29 ++++++++++++++++++++++--
 arch/powerpc/lib/code-patching.c         | 27 ----------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 409483b2d0ce..e7c5df50cb4e 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,8 +22,33 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
-bool is_offset_in_branch_range(long offset);
-bool is_offset_in_cond_branch_range(long offset);
+/*
+ * Powerpc branch instruction is :
+ *
+ *  0         6                 30   31
+ *  +---------+----------------+---+---+
+ *  | opcode  |     LI         |AA |LK |
+ *  +---------+----------------+---+---+
+ *  Where AA = 0 and LK = 0
+ *
+ * LI is a signed 24 bits integer. The real branch offset is computed
+ * by: imm32 = SignExtend(LI:'0b00', 32);
+ *
+ * So the maximum forward branch should be:
+ *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
+ * The maximum backward branch should be:
+ *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
+ */
+static inline bool is_offset_in_branch_range(long offset)
+{
+	return (offset >= -0x2000000 && offset <= 0x1fffffc && !(offset & 0x3));
+}
+
+static inline bool is_offset_in_cond_branch_range(long offset)
+{
+	return offset >= -0x8000 && offset <= 0x7fff && !(offset & 0x3);
+}
+
 int create_branch(ppc_inst_t *instr, const u32 *addr,
 		  unsigned long target, int flags);
 int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 00c68e7fb11e..58262c7e447c 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -208,33 +208,6 @@ int patch_branch(u32 *addr, unsigned long target, int flags)
 	return patch_instruction(addr, instr);
 }
 
-bool is_offset_in_branch_range(long offset)
-{
-	/*
-	 * Powerpc branch instruction is :
-	 *
-	 *  0         6                 30   31
-	 *  +---------+----------------+---+---+
-	 *  | opcode  |     LI         |AA |LK |
-	 *  +---------+----------------+---+---+
-	 *  Where AA = 0 and LK = 0
-	 *
-	 * LI is a signed 24 bits integer. The real branch offset is computed
-	 * by: imm32 = SignExtend(LI:'0b00', 32);
-	 *
-	 * So the maximum forward branch should be:
-	 *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
-	 * The maximum backward branch should be:
-	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
-	 */
-	return (offset >= -0x2000000 && offset <= 0x1fffffc && !(offset & 0x3));
-}
-
-bool is_offset_in_cond_branch_range(long offset)
-{
-	return offset >= -0x8000 && offset <= 0x7fff && !(offset & 0x3);
-}
-
 /*
  * Helper to check if a given instruction is a conditional branch
  * Derived from the conditional checks in analyse_instr()
-- 
2.35.1

