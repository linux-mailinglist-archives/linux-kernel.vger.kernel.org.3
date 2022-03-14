Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CCD4D7FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiCNK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiCNK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:29:10 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C03C4AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:27:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KHCRJ5r0tz9sRx;
        Mon, 14 Mar 2022 11:27:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZV1HWJixw3eq; Mon, 14 Mar 2022 11:27:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KHCRJ4t2wz9sRn;
        Mon, 14 Mar 2022 11:27:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92C178B76D;
        Mon, 14 Mar 2022 11:27:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VTHrXJMVcorN; Mon, 14 Mar 2022 11:27:56 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C3918B763;
        Mon, 14 Mar 2022 11:27:56 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22EARkmA4139705
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 11:27:46 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22EAReXf4135139;
        Mon, 14 Mar 2022 11:27:40 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v1 1/2] static_call: Properly initialise DEFINE_STATIC_CALL_RET0()
Date:   Mon, 14 Mar 2022 11:27:35 +0100
Message-Id: <1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1647253655; l=4450; s=20211009; h=from:subject:message-id; bh=mtB8sSS5LTVjOGBbjCgyRtyvPACLaZttxYP+lcczsR8=; b=7bP7OAbkHz+/6afFcUTRv8eGwDx5YECqQXL5L+DDGNp+oAKSLi4QSEGQy6HKgnit9SY8FThsSKgB H7A3V2V8Ayq9RSUJlPG0Ynmt0Wk3In7Pcvfrmgw+WpCLM6Uorz6r
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

When a static call is updated with __static_call_return0() as target,
arch_static_call_transform() set it to use an optimised set of
instructions which are meant to lay in the same cacheline.

But when initialising a static call with DEFINE_STATIC_CALL_RET0(),
we get a branch to the real __static_call_return0() function instead
of getting the optimised setup:

	c00d8120 <__SCT__perf_snapshot_branch_stack>:
	c00d8120:	4b ff ff f4 	b       c00d8114 <__static_call_return0>
	c00d8124:	3d 80 c0 0e 	lis     r12,-16370
	c00d8128:	81 8c 81 3c 	lwz     r12,-32452(r12)
	c00d812c:	7d 89 03 a6 	mtctr   r12
	c00d8130:	4e 80 04 20 	bctr
	c00d8134:	38 60 00 00 	li      r3,0
	c00d8138:	4e 80 00 20 	blr
	c00d813c:	00 00 00 00 	.long 0x0

Add ARCH_DEFINE_STATIC_CALL_RET0_TRAMP() defined by each architecture
to setup the optimised configuration, and rework
DEFINE_STATIC_CALL_RET0() to call it:

	c00d8120 <__SCT__perf_snapshot_branch_stack>:
	c00d8120:	48 00 00 14 	b       c00d8134 <__SCT__perf_snapshot_branch_stack+0x14>
	c00d8124:	3d 80 c0 0e 	lis     r12,-16370
	c00d8128:	81 8c 81 3c 	lwz     r12,-32452(r12)
	c00d812c:	7d 89 03 a6 	mtctr   r12
	c00d8130:	4e 80 04 20 	bctr
	c00d8134:	38 60 00 00 	li      r3,0
	c00d8138:	4e 80 00 20 	blr
	c00d813c:	00 00 00 00 	.long 0x0

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/static_call.h |  1 +
 arch/x86/include/asm/static_call.h     |  2 ++
 include/linux/static_call.h            | 20 +++++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index 0a0bc79bd1fa..de1018cc522b 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -24,5 +24,6 @@
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index ed4f8bb6c2d9..2455d721503e 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -38,6 +38,8 @@
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; int3; nop; nop; nop")
 
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
 
 #define ARCH_ADD_TRAMP_KEY(name)					\
 	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index fcc5b48989b3..3c50b0fdda16 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -196,6 +196,14 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
+#define DEFINE_STATIC_CALL_RET0(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = __static_call_return0,				\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
+
 #define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
@@ -231,6 +239,12 @@ static inline int static_call_init(void) { return 0; }
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
+#define DEFINE_STATIC_CALL_RET0(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = __static_call_return0,				\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)
 
 #define static_call_cond(name)	(void)__static_call(name)
 
@@ -284,6 +298,9 @@ static inline long __static_call_return0(void)
 		.func = NULL,						\
 	}
 
+#define DEFINE_STATIC_CALL_RET0(name, _func)				\
+	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+
 static inline void __static_call_nop(void) { }
 
 /*
@@ -327,7 +344,4 @@ static inline int static_call_text_reserved(void *start, void *end)
 #define DEFINE_STATIC_CALL(name, _func)					\
 	__DEFINE_STATIC_CALL(name, _func, _func)
 
-#define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
-
 #endif /* _LINUX_STATIC_CALL_H */
-- 
2.35.1

