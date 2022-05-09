Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B751F42C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiEIFuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiEIFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:47:57 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A0126C3A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:44:04 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKn0kMLz9sWH;
        Mon,  9 May 2022 07:37:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G2G3Rqetc9sH; Mon,  9 May 2022 07:37:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKH4kVxz9sWK;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E1418B763;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DRe330hselgB; Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BE688B76E;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aV6N1591291
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:31 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aVO01591290;
        Mon, 9 May 2022 07:36:31 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 21/25] powerpc/ftrace: Don't use copy_from_kernel_nofault() in module_trampoline_target()
Date:   Mon,  9 May 2022 07:36:19 +0200
Message-Id: <c55559103e014b7863161559d340e8e9484eaaa6.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074582; l=2705; s=20211009; h=from:subject:message-id; bh=CfrUCzqErjkJ1BZ8LHw9+4wpcEnd2IhUoh9LhAGXY+w=; b=YOzklA9WshRXJoWz/vL2ydfXuPpqPlkb1zNRY5YKGdK2hfy+hK1QunRD+f/fAduTLVNB0cMdrOMz q7Ayb0u+CU3mt9WoSRNIqPyy501HRL4jnIi1SU5DDCNOvoRDIVoV
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

module_trampoline_target() is quite a hot path used when
activating/deactivating function tracer.

Avoid the heavy copy_from_kernel_nofault() by doing four calls
to copy_inst_from_kernel_nofault().

Use __copy_inst_from_kernel_nofault() for the 3 last calls. First call
is done to copy_from_kernel_nofault() to check address is within
kernel space. No risk to wrap out the top of kernel space because the
last page is never mapped so if address is in last page the first copy
will fails and the other ones will never be performed.

And also make it notrace just like all functions that call it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Use ppc_inst_t to fix sparse warnings and split trampoline verification in one line per instruction.
---
 arch/powerpc/kernel/module_32.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index a0432ef46967..715a42f383d0 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -289,23 +289,32 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-int module_trampoline_target(struct module *mod, unsigned long addr,
-			     unsigned long *target)
+notrace int module_trampoline_target(struct module *mod, unsigned long addr,
+				     unsigned long *target)
 {
-	unsigned int jmp[4];
+	ppc_inst_t jmp[4];
 
 	/* Find where the trampoline jumps to */
-	if (copy_from_kernel_nofault(jmp, (void *)addr, sizeof(jmp)))
+	if (copy_inst_from_kernel_nofault(jmp, (void *)addr))
+		return -EFAULT;
+	if (__copy_inst_from_kernel_nofault(jmp + 1, (void *)addr + 4))
+		return -EFAULT;
+	if (__copy_inst_from_kernel_nofault(jmp + 2, (void *)addr + 8))
+		return -EFAULT;
+	if (__copy_inst_from_kernel_nofault(jmp + 3, (void *)addr + 12))
 		return -EFAULT;
 
 	/* verify that this is what we expect it to be */
-	if ((jmp[0] & 0xffff0000) != PPC_RAW_LIS(_R12, 0) ||
-	    (jmp[1] & 0xffff0000) != PPC_RAW_ADDI(_R12, _R12, 0) ||
-	    jmp[2] != PPC_RAW_MTCTR(_R12) ||
-	    jmp[3] != PPC_RAW_BCTR())
+	if ((ppc_inst_val(jmp[0]) & 0xffff0000) != PPC_RAW_LIS(_R12, 0))
+		return -EINVAL;
+	if ((ppc_inst_val(jmp[1]) & 0xffff0000) != PPC_RAW_ADDI(_R12, _R12, 0))
+		return -EINVAL;
+	if (ppc_inst_val(jmp[2]) != PPC_RAW_MTCTR(_R12))
+		return -EINVAL;
+	if (ppc_inst_val(jmp[3]) != PPC_RAW_BCTR())
 		return -EINVAL;
 
-	addr = (jmp[1] & 0xffff) | ((jmp[0] & 0xffff) << 16);
+	addr = (ppc_inst_val(jmp[1]) & 0xffff) | ((ppc_inst_val(jmp[0]) & 0xffff) << 16);
 	if (addr & 0x8000)
 		addr -= 0x10000;
 
-- 
2.35.1

