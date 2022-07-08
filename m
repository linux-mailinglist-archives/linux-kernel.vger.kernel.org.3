Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635D56C030
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiGHRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiGHRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:32:31 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6713F3F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:32:30 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LfgML0sJ5z9tMJ;
        Fri,  8 Jul 2022 19:32:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BQUelTkaowVs; Fri,  8 Jul 2022 19:32:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LfgMF3MNVz9tK2;
        Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A5668B7AB;
        Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JnOCFygWxo9G; Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.202])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFE3B8B7A7;
        Fri,  8 Jul 2022 19:32:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 268HW4UZ1000740
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Jul 2022 19:32:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 268HW44Z1000739;
        Fri, 8 Jul 2022 19:32:04 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        agust@denx.de, jpoimboe@kernel.org, peterz@infradead.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v2 4/7] objtool/powerpc: Add necessary support for inline static calls
Date:   Fri,  8 Jul 2022 19:31:23 +0200
Message-Id: <f96323de33c686ce9ae78e05e8f68c2acc0f0738.1657301423.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657301423.git.christophe.leroy@csgroup.eu>
References: <cover.1657301423.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657301483; l=1844; s=20211009; h=from:subject:message-id; bh=h/w5Vcb6J381cRqeAUanzND0Sl2M7NVgZjy5I1PaDkI=; b=aukkAQFCky7vDF/j+13U0Bq6dHU1lA5UHlqhTNh5pzv+mcnsoKZeet3BdCWegMC02m2hPLLQx49K oe78MV5ECbwIbsr9c7ta/y6VES1aA0XRQo70KXygCoXfRMM7dDBj
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

In order to support inline static calls for powerpc, objtool needs
the following additions:
- R_REL32 macro
- Support for JUMP instruction used for tail calls

Add the support of decoding branch instruction 'b' which is the jump
instruction used for tail calls. This is because a static call can be
a tail call.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/arch/powerpc/decode.c           | 16 ++++++++++------
 tools/objtool/arch/powerpc/include/arch/elf.h |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 06fc0206bf8e..ba84869cd134 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -59,13 +59,17 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	opcode = insn >> 26;
 
 	switch (opcode) {
-	case 18: /* bl */
-		if ((insn & 3) == 1) {
+	case 18: /* bl/b */
+		if ((insn & 3) == 1)
 			*type = INSN_CALL;
-			*immediate = insn & 0x3fffffc;
-			if (*immediate & 0x2000000)
-				*immediate -= 0x4000000;
-		}
+		else if ((insn & 3) == 0)
+			*type = INSN_JUMP_UNCONDITIONAL;
+		else
+			break;
+
+		*immediate = insn & 0x3fffffc;
+		if (*immediate & 0x2000000)
+			*immediate -= 0x4000000;
 		break;
 	}
 
diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
index 73f9ae172fe5..befc2e30d38b 100644
--- a/tools/objtool/arch/powerpc/include/arch/elf.h
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -6,5 +6,6 @@
 #define R_NONE R_PPC_NONE
 #define R_ABS64 R_PPC64_ADDR64
 #define R_ABS32 R_PPC_ADDR32
+#define R_REL32 R_PPC_REL32 /* R_PPC64_REL32 is identical */
 
 #endif /* _OBJTOOL_ARCH_ELF */
-- 
2.36.1

