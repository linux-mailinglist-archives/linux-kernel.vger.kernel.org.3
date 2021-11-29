Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180A461D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbhK2SBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:01:25 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:37095 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348496AbhK2R7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:59:25 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2tCr6grPz9sSh;
        Mon, 29 Nov 2021 18:50:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P5kD9sYVYiDU; Mon, 29 Nov 2021 18:50:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2tCp0Qfrz9sSP;
        Mon, 29 Nov 2021 18:49:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3CA88B7AB;
        Mon, 29 Nov 2021 18:49:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IjKYV44Ykzyj; Mon, 29 Nov 2021 18:49:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.92])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CCEE8B7AE;
        Mon, 29 Nov 2021 18:49:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ATHnojI015566
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 18:49:50 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ATHnox0015565;
        Mon, 29 Nov 2021 18:49:50 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 4/5] powerpc/inst: Move ppc_inst_t definition in asm/reg.h
Date:   Mon, 29 Nov 2021 18:49:40 +0100
Message-Id: <4b79f1491118af96b1ac0735e74aeca02ea4c04e.1638208156.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
References: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638208179; l=2950; s=20211009; h=from:subject:message-id; bh=iVQcuTLGFrRqTJVxnNIHAAXBtfS2roWUnbqKcU3QVJo=; b=IbL3NDi70/rmwLnWd5MQKESgDN8sd/9Ee+zUK3IHJkkJqIcGvEGcDNcywipp7SP0b9jQ/llSv+eT kFB1nlgyCx3Snrn/qPmLLwMCBe1LtFkTUx7/FGvW1l/5VXuhMFkE
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of circular inclusion of asm/hw_breakpoint.h, we
need to move definition of asm/reg.h outside of inst.h
so that asm/hw_breakpoint.h gets it without including
asm/inst.h

Also remove asm/inst.h from asm/uprobes.h as it's not
needed anymore.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: New to support inlining of copy_inst_from_kernel_nofault() in following patch.
---
 arch/powerpc/include/asm/hw_breakpoint.h |  1 -
 arch/powerpc/include/asm/inst.h          | 10 +---------
 arch/powerpc/include/asm/reg.h           | 12 ++++++++++++
 arch/powerpc/include/asm/uprobes.h       |  1 -
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 88053d3c68e6..84d39fd42f71 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -10,7 +10,6 @@
 #define _PPC_BOOK3S_64_HW_BREAKPOINT_H
 
 #include <asm/cpu_has_feature.h>
-#include <asm/inst.h>
 
 #ifdef	__KERNEL__
 struct arch_hw_breakpoint {
diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 7ef5fd3bb167..53a40faf362a 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_INST_H
 
 #include <asm/ppc-opcode.h>
+#include <asm/reg.h>
 
 #define ___get_user_instr(gu_op, dest, ptr)				\
 ({									\
@@ -35,13 +36,6 @@
  */
 
 #if defined(CONFIG_PPC64) || defined(__CHECKER__)
-typedef struct {
-	u32 val;
-#ifdef CONFIG_PPC64
-	u32 suffix;
-#endif
-} __packed ppc_inst_t;
-
 static inline u32 ppc_inst_val(ppc_inst_t x)
 {
 	return x.val;
@@ -50,8 +44,6 @@ static inline u32 ppc_inst_val(ppc_inst_t x)
 #define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
 
 #else
-typedef u32 ppc_inst_t;
-
 static inline u32 ppc_inst_val(ppc_inst_t x)
 {
 	return x;
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e9d27265253b..85501181f929 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1366,6 +1366,18 @@
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
+
+#if defined(CONFIG_PPC64) || defined(__CHECKER__)
+typedef struct {
+	u32 val;
+#ifdef CONFIG_PPC64
+	u32 suffix;
+#endif
+} __packed ppc_inst_t;
+#else
+typedef u32 ppc_inst_t;
+#endif
+
 #define mfmsr()		({unsigned long rval; \
 			asm volatile("mfmsr %0" : "=r" (rval) : \
 						: "memory"); rval;})
diff --git a/arch/powerpc/include/asm/uprobes.h b/arch/powerpc/include/asm/uprobes.h
index fe683371336f..a7ae1860115a 100644
--- a/arch/powerpc/include/asm/uprobes.h
+++ b/arch/powerpc/include/asm/uprobes.h
@@ -11,7 +11,6 @@
 
 #include <linux/notifier.h>
 #include <asm/probes.h>
-#include <asm/inst.h>
 
 typedef ppc_opcode_t uprobe_opcode_t;
 
-- 
2.33.1

