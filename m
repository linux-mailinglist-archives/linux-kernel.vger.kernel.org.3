Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E64F3424
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354533AbiDEKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF3167E2;
        Tue,  5 Apr 2022 01:29:01 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKtQgQl2WL+t6Vvv8+1Y5NloAnAVsYokjajxXuTsIZY=;
        b=4FtWHMvcGrBeeby2pw+UQxoUMhsmuLpQmcAZGsbJeS002gJOmCb/jVQ4BnDfofBt35OWRm
        C8FWMvHZfYAfxc3LkddQBY6CTj51zGU37OoPAJOwqTUXNrR95febyQeiIlAq6qta1G/b/h
        hadbQjCupqRadkrhcqRv3XCj2DVYqQZmWpwDEc3txJk50xaR6tID8RMTk1SVEO2VDQzZPS
        jyhqq9+8mj45//HinOWDjtzFwfpbqg0HAyAgXiTgwMzvwjDYb66Eok3lGNHwxEuHE7NI5b
        MXpgsiAGGV9neyhWfWtD6DDMrdbVRP1QttDsIBcz/RnNDaPSrXrp0ghiEiM0lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKtQgQl2WL+t6Vvv8+1Y5NloAnAVsYokjajxXuTsIZY=;
        b=C7R5TBjPh80Cqm8N1tnE3/UL9/hc2DkE3VJqsOkYY4yHgIgg2iEbN2btKuKz72kDmSEE2I
        kdepZRI83jzQLoBg==
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Properly initialise
 DEFINE_STATIC_CALL_RET0()
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8=2E16472?=
 =?utf-8?q?53456=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8=2E164725?=
 =?utf-8?q?3456=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
MIME-Version: 1.0
Message-ID: <164914733865.389.5032863985634352422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     5517d500829c683a358a8de04ecb2e28af629ae5
Gitweb:        https://git.kernel.org/tip/5517d500829c683a358a8de04ecb2e28af629ae5
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 14 Mar 2022 11:27:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:38 +02:00

static_call: Properly initialise DEFINE_STATIC_CALL_RET0()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/1e0a61a88f52a460f62a58ffc2a5f847d1f7d9d8.1647253456.git.christophe.leroy@csgroup.eu
---
 arch/powerpc/include/asm/static_call.h |  1 +
 arch/x86/include/asm/static_call.h     |  2 ++
 include/linux/static_call.h            | 20 +++++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index 0a0bc79..de1018c 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -24,5 +24,6 @@
 
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)	__PPC_SCT(name, "b " #func)
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index ed4f8bb..2455d72 100644
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
index fcc5b48..3c50b0f 100644
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
