Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C724B9F99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiBQMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiBQMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:51 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2E2AE285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:02:34 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jztjt0h4Tz9sS8;
        Thu, 17 Feb 2022 13:02:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7QMqHOalYBL3; Thu, 17 Feb 2022 13:02:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jztjr3TVvz9sST;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 617998B783;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id O7UuHt6ePd_a; Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.225])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D0678B77E;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21HC2FRo400833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 13:02:15 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21HC2DQ2400831;
        Thu, 17 Feb 2022 13:02:13 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/4] powerpc/ftrace: Don't use lmw/stmw in ftrace_regs_caller()
Date:   Thu, 17 Feb 2022 13:01:56 +0100
Message-Id: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645099315; l=1304; s=20211009; h=from:subject:message-id; bh=a5SXTmNHRsDZErob3HMcylE9GgHIQeQ3cYBbiuJRKcM=; b=8Oh2uOKVAafJJtp/3RQH3Fu4bQdEy/Mtn9S0Ci0nQbZ71PBpU474m891U2vwRTcnBwT4IPKABOPH AtDhi4VKAPe85OOsIGUukp2AvVH3OPZWxeQ9v6YAT0X8NYK7MdiB
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

For the same reason as commit a85c728cb5e1 ("powerpc/32: Don't use
lmw/stmw for saving/restoring non volatile regs"), don't use
lmw/stmw in ftrace_regs_caller().

Use the same macros for PPC32 and PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace_mprofile.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_mprofile.S b/arch/powerpc/kernel/trace/ftrace_mprofile.S
index 89639e64acd1..76dab07fd8fd 100644
--- a/arch/powerpc/kernel/trace/ftrace_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_mprofile.S
@@ -43,18 +43,16 @@ _GLOBAL(ftrace_regs_caller)
 
 	/* Save all gprs to pt_regs */
 	SAVE_GPR(0, r1)
-#ifdef CONFIG_PPC64
 	SAVE_GPRS(2, 11, r1)
 
+#ifdef CONFIG_PPC64
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
 	beq	ftrace_no_trace
+#endif
 
 	SAVE_GPRS(12, 31, r1)
-#else
-	stmw	r2, GPR2(r1)
-#endif
 
 	/* Save previous stack pointer (r1) */
 	addi	r8, r1, SWITCH_FRAME_SIZE
@@ -120,11 +118,7 @@ ftrace_regs_call:
 #endif
 
 	/* Restore gprs */
-#ifdef CONFIG_PPC64
 	REST_GPRS(2, 31, r1)
-#else
-	lmw	r2, GPR2(r1)
-#endif
 
 	/* Restore possibly modified LR */
 	PPC_LL	r0, _LINK(r1)
-- 
2.34.1

