Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99609587986
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiHBJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiHBJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:03:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B9DEF7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:03:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LxptT2SMjz9sT4;
        Tue,  2 Aug 2022 11:03:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kntTq0FFTLRH; Tue,  2 Aug 2022 11:03:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LxptS588Bz9sj3;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FB018B775;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q0XfY_shXN7T; Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55D008B76D;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27292rRR2260937
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 2 Aug 2022 11:02:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27292rhX2260936;
        Tue, 2 Aug 2022 11:02:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/3] powerpc: Don't hide eh field of lwarx behind a macro
Date:   Tue,  2 Aug 2022 11:02:37 +0200
Message-Id: <8b9c8a1a14f9143552a85fcbf96698224a8c2469.1659430931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
References: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1659430956; l=2628; s=20211009; h=from:subject:message-id; bh=Wgzs/vRVGeTjl/10gdoyxl+3ztjhRdzy37m3kMOttMk=; b=az6eKCSHBoJ+n4XJ3c+VnZoE8Mypy2i+e4re3Tl9q8bjbn0hdCFYrQ/J2D6d/zj1yrMx8p/I/dmf kQUJpl0RCZsYjsBMHHqeo0v+nAVEDoO5Z45lR2BTPLqSeK6KReK5
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eh field must remain 0 for PPC32 and is only used
by PPC64.

Don't hide that behind a macro, just leave the responsibility
to the user.

At the time being, the only users of PPC_RAW_L{WDQ}ARX are
setting the eh field to 0, so the special handling of __PPC_EH
is useless. Just take the value given by the caller.

Same for DEFINE_TESTOP(), don't do special handling in that
macro, ensure the caller hands over the proper eh value.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/bitops.h     |  4 ++--
 arch/powerpc/include/asm/ppc-opcode.h | 11 +----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 344fba3b16eb..c2b8c53e0dcb 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -163,7 +163,7 @@ static inline unsigned long fn(			\
 	"bne- 1b\n"					\
 	postfix						\
 	: "=&r" (old), "=&r" (t)			\
-	: "rK" (mask), "r" (p), "i" (IS_ENABLED(CONFIG_PPC64) ? eh : 0)	\
+	: "rK" (mask), "r" (p), "i" (eh)		\
 	: "cc", "memory");				\
 	return (old & mask);				\
 }
@@ -171,7 +171,7 @@ static inline unsigned long fn(			\
 DEFINE_TESTOP(test_and_set_bits, or, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 DEFINE_TESTOP(test_and_set_bits_lock, or, "",
-	      PPC_ACQUIRE_BARRIER, 1)
+	      PPC_ACQUIRE_BARRIER, IS_ENABLED(CONFIG_PPC64))
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 7b81b37a191e..d9703c5fd713 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -343,6 +343,7 @@
 #define __PPC_SPR(r)	((((r) & 0x1f) << 16) | ((((r) >> 5) & 0x1f) << 11))
 #define __PPC_RC21	(0x1 << 10)
 #define __PPC_PRFX_R(r)	(((r) & 0x1) << 20)
+#define __PPC_EH(eh)	(((eh) & 0x1) << 0)
 
 /*
  * Both low and high 16 bits are added as SIGNED additions, so if low 16 bits
@@ -359,16 +360,6 @@
 #define PPC_LI_MASK	0x03fffffc
 #define PPC_LI(v)	((v) & PPC_LI_MASK)
 
-/*
- * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
- * larx with EH set as an illegal instruction.
- */
-#ifdef CONFIG_PPC64
-#define __PPC_EH(eh)	(((eh) & 0x1) << 0)
-#else
-#define __PPC_EH(eh)	0
-#endif
-
 /* Base instruction encoding */
 #define PPC_RAW_CP_ABORT		(0x7c00068c)
 #define PPC_RAW_COPY(a, b)		(PPC_INST_COPY | ___PPC_RA(a) | ___PPC_RB(b))
-- 
2.36.1

