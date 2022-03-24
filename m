Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1574E6548
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351168AbiCXOed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351003AbiCXOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:32 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB5CAC922
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSML1bSVz9sV0;
        Thu, 24 Mar 2022 15:31:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1YKqJW-0bzco; Thu, 24 Mar 2022 15:31:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLz0qQcz9sV2;
        Thu, 24 Mar 2022 15:30:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 066018B786;
        Thu, 24 Mar 2022 15:30:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id x9Ib-xYEu1Id; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA3418B79F;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUgsx1811710
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:42 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUgpB1811709;
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
Subject: [PATCH v1 08/22] powerpc/ftrace: Make __ftrace_make_{nop/call}() common to PPC32 and PPC64
Date:   Thu, 24 Mar 2022 15:29:58 +0100
Message-Id: <fb60b19f154db8132a00c2df7aca7db3e85603b5.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648131740.git.christophe.leroy@csgroup.eu>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132151; l=5520; s=20211009; h=from:subject:message-id; bh=fu95AZd5FCaJwPMbMGXXiOSwiaAzLnBguw3AN73/rHU=; b=c57TYtigamK9L6iS+hoKb5BfbBfbpqatqfGhnG01f9CeAFCk5o9x63y1Mu3iq3supveTng05F8FX RlFTPDGKAhSlbV4jOmHVIgYhvUeQtsr1Xyoy3KCpbPZgd0ExX1G8
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

Since c93d4f6ecf4b ("powerpc/ftrace: Add module_trampoline_target()
for PPC32"), __ftrace_make_nop() for PPC32 is very similar to the
one for PPC64.

Same for __ftrace_make_call().

Make them common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace.c | 108 +++--------------------------
 1 file changed, 8 insertions(+), 100 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 1b05d33f96c6..2c7e42e439bb 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -114,7 +114,6 @@ static unsigned long find_bl_target(unsigned long ip, ppc_inst_t op)
 }
 
 #ifdef CONFIG_MODULES
-#ifdef CONFIG_PPC64
 static int
 __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
@@ -154,10 +153,11 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_MPROFILE_KERNEL
-	/* When using -mkernel_profile there is no load to jump over */
+	/* When using -mkernel_profile or PPC32 there is no load to jump over */
 	pop = ppc_inst(PPC_RAW_NOP());
 
+#ifdef CONFIG_PPC64
+#ifdef CONFIG_MPROFILE_KERNEL
 	if (copy_inst_from_kernel_nofault(&op, (void *)(ip - 4))) {
 		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
 		return -EFAULT;
@@ -201,6 +201,7 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 #endif /* CONFIG_MPROFILE_KERNEL */
+#endif /* PPC64 */
 
 	if (patch_instruction((u32 *)ip, pop)) {
 		pr_err("Patching NOP failed.\n");
@@ -209,48 +210,6 @@ __ftrace_make_nop(struct module *mod,
 
 	return 0;
 }
-
-#else /* !PPC64 */
-static int
-__ftrace_make_nop(struct module *mod,
-		  struct dyn_ftrace *rec, unsigned long addr)
-{
-	ppc_inst_t op;
-	unsigned long ip = rec->ip;
-	unsigned long tramp, ptr;
-
-	if (copy_from_kernel_nofault(&op, (void *)ip, MCOUNT_INSN_SIZE))
-		return -EFAULT;
-
-	/* Make sure that that this is still a 24bit jump */
-	if (!is_bl_op(op)) {
-		pr_err("Not expected bl: opcode is %s\n", ppc_inst_as_str(op));
-		return -EINVAL;
-	}
-
-	/* lets find where the pointer goes */
-	tramp = find_bl_target(ip, op);
-
-	/* Find where the trampoline jumps to */
-	if (module_trampoline_target(mod, tramp, &ptr)) {
-		pr_err("Failed to get trampoline target\n");
-		return -EFAULT;
-	}
-
-	if (ptr != addr) {
-		pr_err("Trampoline location %08lx does not match addr\n",
-		       tramp);
-		return -EINVAL;
-	}
-
-	op = ppc_inst(PPC_RAW_NOP());
-
-	if (patch_instruction((u32 *)ip, op))
-		return -EPERM;
-
-	return 0;
-}
-#endif /* PPC64 */
 #endif /* CONFIG_MODULES */
 
 static unsigned long find_ftrace_tramp(unsigned long ip)
@@ -437,13 +396,12 @@ int ftrace_make_nop(struct module *mod,
 }
 
 #ifdef CONFIG_MODULES
-#ifdef CONFIG_PPC64
 /*
  * Examine the existing instructions for __ftrace_make_call.
  * They should effectively be a NOP, and follow formal constraints,
  * depending on the ABI. Return false if they don't.
  */
-#ifndef CONFIG_MPROFILE_KERNEL
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 static int
 expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
 {
@@ -465,7 +423,7 @@ expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
 static int
 expected_nop_sequence(void *ip, ppc_inst_t op0, ppc_inst_t op1)
 {
-	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
+	/* look for patched "NOP" on ppc64 with -mprofile-kernel or ppc32 */
 	if (!ppc_inst_equal(op0, ppc_inst(PPC_RAW_NOP())))
 		return 0;
 	return 1;
@@ -484,8 +442,10 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	if (copy_inst_from_kernel_nofault(op, ip))
 		return -EFAULT;
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	if (copy_inst_from_kernel_nofault(op + 1, ip + 4))
 		return -EFAULT;
+#endif
 
 	if (!expected_nop_sequence(ip, op[0], op[1])) {
 		pr_err("Unexpected call sequence at %p: %s %s\n",
@@ -531,58 +491,6 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	return 0;
 }
-
-#else  /* !CONFIG_PPC64: */
-static int
-__ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
-{
-	int err;
-	ppc_inst_t op;
-	u32 *ip = (u32 *)rec->ip;
-	struct module *mod = rec->arch.mod;
-	unsigned long tramp;
-
-	/* read where this goes */
-	if (copy_inst_from_kernel_nofault(&op, ip))
-		return -EFAULT;
-
-	/* It should be pointing to a nop */
-	if (!ppc_inst_equal(op,  ppc_inst(PPC_RAW_NOP()))) {
-		pr_err("Expected NOP but have %s\n", ppc_inst_as_str(op));
-		return -EINVAL;
-	}
-
-	/* If we never set up a trampoline to ftrace_caller, then bail */
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
-#else
-	if (!mod->arch.tramp) {
-#endif
-		pr_err("No ftrace trampoline\n");
-		return -EINVAL;
-	}
-
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	if (rec->flags & FTRACE_FL_REGS)
-		tramp = mod->arch.tramp_regs;
-	else
-#endif
-		tramp = mod->arch.tramp;
-	/* create the branch to the trampoline */
-	err = create_branch(&op, ip, tramp, BRANCH_SET_LINK);
-	if (err) {
-		pr_err("REL24 out of range!\n");
-		return -EINVAL;
-	}
-
-	pr_devel("write to %lx\n", rec->ip);
-
-	if (patch_instruction(ip, op))
-		return -EPERM;
-
-	return 0;
-}
-#endif /* CONFIG_PPC64 */
 #endif /* CONFIG_MODULES */
 
 static int __ftrace_make_call_kernel(struct dyn_ftrace *rec, unsigned long addr)
-- 
2.35.1

