Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF98E51E4C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445855AbiEGGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445865AbiEGGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:51:32 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7885C853
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:47:42 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzW4wtfz9sWC;
        Sat,  7 May 2022 08:47:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VbtUZhoeKJ5y; Sat,  7 May 2022 08:47:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzF2Q4Xz9sWF;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 446118B76E;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6A-jBhsNUua2; Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CAF98B7B2;
        Sat,  7 May 2022 08:46:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kd9B1320485
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:39 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kdLT1320484;
        Sat, 7 May 2022 08:46:39 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 04/25] powerpc/ftrace: Use is_offset_in_branch_range()
Date:   Sat,  7 May 2022 08:46:06 +0200
Message-Id: <912ae51782f5a53c44e435497c8c3fb5cc632387.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905980; l=1631; s=20211009; h=from:subject:message-id; bh=OWDdhcCtR60EJOCWc6cwIHh4xDhD5orD3drnjJOkPJg=; b=DTrJMFszzSiGLpG5XWwH6BJTQVMOEhWIt6cjGoxn5W6rjmv+I8LfDi5DWR3JXWL7Qy5RbaCXnSGG zqQ8vJQ+C58YQoEao++1bMuuWbKAoHbAHKiyB/BLAinnMw29DDfs
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

Use is_offset_in_branch_range() instead of create_branch()
to check if a target is within branch range.

This patch together with the previous one improves
ftrace activation time by 7%

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 3ce3697e8a7c..41c45b9c7f39 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -89,11 +89,9 @@ ftrace_modify_code(unsigned long ip, ppc_inst_t old, ppc_inst_t new)
  */
 static int test_24bit_addr(unsigned long ip, unsigned long addr)
 {
-	ppc_inst_t op;
 	addr = ppc_function_entry((void *)addr);
 
-	/* use the create_branch to verify that this offset can be branched */
-	return create_branch(&op, (u32 *)ip, addr, 0) == 0;
+	return is_offset_in_branch_range(addr - ip);
 }
 
 static int is_bl_op(ppc_inst_t op)
@@ -261,7 +259,6 @@ __ftrace_make_nop(struct module *mod,
 static unsigned long find_ftrace_tramp(unsigned long ip)
 {
 	int i;
-	ppc_inst_t instr;
 
 	/*
 	 * We have the compiler generated long_branch tramps at the end
@@ -270,8 +267,7 @@ static unsigned long find_ftrace_tramp(unsigned long ip)
 	for (i = NUM_FTRACE_TRAMPS - 1; i >= 0; i--)
 		if (!ftrace_tramps[i])
 			continue;
-		else if (create_branch(&instr, (void *)ip,
-				       ftrace_tramps[i], 0) == 0)
+		else if (is_offset_in_branch_range(ftrace_tramps[i] - ip))
 			return ftrace_tramps[i];
 
 	return 0;
-- 
2.35.1

