Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3151E4B9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445776AbiEGGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445773AbiEGGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:51:02 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64165A2CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:47:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzM1fS7z9sW1;
        Sat,  7 May 2022 08:46:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3eZ30I4hs7Sl; Sat,  7 May 2022 08:46:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzD604Zz9sW3;
        Sat,  7 May 2022 08:46:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B57EE8B76E;
        Sat,  7 May 2022 08:46:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xp8lsz4OR5vd; Sat,  7 May 2022 08:46:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3A488B792;
        Sat,  7 May 2022 08:46:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kdw91320489
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:39 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kd181320488;
        Sat, 7 May 2022 08:46:39 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/25] powerpc/code-patching: Inline create_branch()
Date:   Sat,  7 May 2022 08:46:07 +0200
Message-Id: <69851cc9a7bf8f03d025e6d29e165f2d0bd3bb6e.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905980; l=2728; s=20211009; h=from:subject:message-id; bh=d2swIJrMmUDKV+uH13vJ0j/DNa2ajgVmApWQwP8siB0=; b=cAVkegxnUg/vbrAo4viSfRjnGlY+RVxxca1/1xW777/8jULdJni865HTnQyzLxFuNcPJcNmSIR86 KqsTTcVCDILOQo4X1iOnzGNULprSZT9DKKeo9zqEO06BKCvS4AuL
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

create_branch() is a good candidate for inlining because:
- Flags can be folded in.
- Range tests are likely to be already done.

Hence reducing the create_branch() to only a set of instructions.

So inline it.

It improves ftrace activation by 10%.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 22 ++++++++++++++++++++--
 arch/powerpc/lib/code-patching.c         | 20 --------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index e7c5df50cb4e..4260e89f62b1 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -49,8 +49,26 @@ static inline bool is_offset_in_cond_branch_range(long offset)
 	return offset >= -0x8000 && offset <= 0x7fff && !(offset & 0x3);
 }
 
-int create_branch(ppc_inst_t *instr, const u32 *addr,
-		  unsigned long target, int flags);
+static inline int create_branch(ppc_inst_t *instr, const u32 *addr,
+				unsigned long target, int flags)
+{
+	long offset;
+
+	*instr = ppc_inst(0);
+	offset = target;
+	if (! (flags & BRANCH_ABSOLUTE))
+		offset = offset - (unsigned long)addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (!is_offset_in_branch_range(offset))
+		return 1;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	*instr = ppc_inst(0x48000000 | (flags & 0x3) | (offset & 0x03FFFFFC));
+
+	return 0;
+}
+
 int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
 		       unsigned long target, int flags);
 int patch_branch(u32 *addr, unsigned long target, int flags);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 58262c7e447c..7adbdb05fee7 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -230,26 +230,6 @@ bool is_conditional_branch(ppc_inst_t instr)
 }
 NOKPROBE_SYMBOL(is_conditional_branch);
 
-int create_branch(ppc_inst_t *instr, const u32 *addr,
-		  unsigned long target, int flags)
-{
-	long offset;
-
-	*instr = ppc_inst(0);
-	offset = target;
-	if (! (flags & BRANCH_ABSOLUTE))
-		offset = offset - (unsigned long)addr;
-
-	/* Check we can represent the target in the instruction format */
-	if (!is_offset_in_branch_range(offset))
-		return 1;
-
-	/* Mask out the flags and target, so they don't step on each other. */
-	*instr = ppc_inst(0x48000000 | (flags & 0x3) | (offset & 0x03FFFFFC));
-
-	return 0;
-}
-
 int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
 		       unsigned long target, int flags)
 {
-- 
2.35.1

