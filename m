Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E304E6531
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbiCXOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350985AbiCXOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:32:35 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BABAC904
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:30:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSM04rHzz9sV4;
        Thu, 24 Mar 2022 15:30:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Tx_OdezBQfe; Thu, 24 Mar 2022 15:30:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLy2rCrz9sTg;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B8498B780;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wc8Ix20xu7pd; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 990748B783;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUgIN1811722
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:43 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUghe1811721;
        Thu, 24 Mar 2022 15:30:42 +0100
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
Subject: [PATCH v1 11/22] powerpc/ftrace: Remove ftrace_plt_tramps[]
Date:   Thu, 24 Mar 2022 15:30:01 +0100
Message-Id: <28451f97a8cdb81df3815e782cbf7667cb3fc2e1.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132151; l=1209; s=20211009; h=from:subject:message-id; bh=dZRIRMj2lQWqilcKJIhxE8xIuJIJKrLrXF3bOa75tG0=; b=Jm5S2lkZJ1ZbTPIGJG7ai1Ps7p6F+hBFwYko30rigipKhirNyFtFQvkWB6tNmfeC4t7ZlaS23HZD 62dwgV8LCupttGxc6AWPs0dK5+GiO6zES0ugxRwoeux3OsVhTHVs
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

ftrace_plt_tramps table is never filled so it is useless.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 188f59f4ee4a..b6c5223e26b2 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -250,7 +250,6 @@ static int setup_mcount_compiler_tramp(unsigned long tramp)
 	int i;
 	ppc_inst_t op;
 	unsigned long ptr;
-	static unsigned long ftrace_plt_tramps[NUM_FTRACE_TRAMPS];
 
 	/* Is this a known long jump tramp? */
 	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
@@ -259,13 +258,6 @@ static int setup_mcount_compiler_tramp(unsigned long tramp)
 		else if (ftrace_tramps[i] == tramp)
 			return 0;
 
-	/* Is this a known plt tramp? */
-	for (i = 0; i < NUM_FTRACE_TRAMPS; i++)
-		if (!ftrace_plt_tramps[i])
-			break;
-		else if (ftrace_plt_tramps[i] == tramp)
-			return -1;
-
 	/* New trampoline -- read where this goes */
 	if (copy_inst_from_kernel_nofault(&op, (void *)tramp)) {
 		pr_debug("Fetching opcode failed.\n");
-- 
2.35.1

