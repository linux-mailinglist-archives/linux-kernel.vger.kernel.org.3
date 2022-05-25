Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8299B5340E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbiEYP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiEYP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:58:56 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452B972BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:58:55 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L7bMn2chTz9tFN;
        Wed, 25 May 2022 17:58:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9vEVZE9HpWyB; Wed, 25 May 2022 17:58:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L7bMk5NFmz9tFP;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FE958B77A;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id htU6u_JrvheR; Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 28D0E8B778;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24PFwR0e419152
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:58:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24PFwRZn419151;
        Wed, 25 May 2022 17:58:27 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org,
        aik@ozlabs.ru, sv@linux.ibm.com, rostedt@goodmis.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v1 4/4] powerpc/static_call: Implement inline static calls
Date:   Wed, 25 May 2022 17:58:17 +0200
Message-Id: <2e74b10072ca594c394dd1c445d827505725f27a.1653494186.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1653494186.git.christophe.leroy@csgroup.eu>
References: <cover.1653494186.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653494295; l=4004; s=20211009; h=from:subject:message-id; bh=Si7ViaXO/clzpQWdQFEHD12KLid8Hfc27sgBafOTn9A=; b=1u5j19ZyGAUOZn2Be1bpzfdF3Xi2Yq69UCl1H3WI+qNHuP6EbAvpWnSmUmfc2ZpXvf04Wy3rRcpp U79BvpfHCtkQcDPtHARpwiTtn1Wu3Tw0mXJ4Jt1PDGSvb0bEGsTW
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

Implement inline static calls:
- Put a 'bl' to the destination function
- Put a 'nop' when the destination function is NULL
- Put a 'li r3,0' when the destination is the RET0 function

For the time being it only works if the destination is
within 32Mb from the caller.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/static_call.h        |  2 +
 arch/powerpc/kernel/static_call.c             | 41 ++++++++++++-------
 tools/objtool/arch/powerpc/include/arch/elf.h |  1 +
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5ef8bf8eb202..3257a1c258d8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
 	select HAVE_STATIC_CALL			if PPC32
+	select HAVE_STATIC_CALL_INLINE		if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index de1018cc522b..e3d5d3823dac 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -26,4 +26,6 @@
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
+#define CALL_INSN_SIZE		4
+
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 863a7aa24650..fd25954cfd24 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -9,25 +9,38 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 	int err;
 	bool is_ret0 = (func == __static_call_return0);
 	unsigned long target = (unsigned long)(is_ret0 ? tramp + PPC_SCT_RET0 : func);
-	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
-
-	if (!tramp)
-		return;
 
 	mutex_lock(&text_mutex);
 
-	if (func && !is_short) {
-		err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(target));
-		if (err)
-			goto out;
+	if (tramp) {
+		bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
+
+		if (func && !is_short) {
+			err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(target));
+			if (err)
+				goto out;
+		}
+
+		if (!func)
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
+		else if (is_short)
+			err = patch_branch(tramp, target, 0);
+		else
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
 	}
 
-	if (!func)
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
-	else if (is_short)
-		err = patch_branch(tramp, target, 0);
-	else
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
+	if (site) {
+		bool is_short = is_offset_in_branch_range((long)func - (long)site);
+
+		if (!func)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_NOP()));
+		else if (is_ret0)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_LI(_R3, 0)));
+		else if (is_short)
+			err = patch_branch(site, target, BRANCH_SET_LINK);
+		else
+			panic("%s: function %pS is out of reach of %pS\n", __func__, func, site);
+	}
 out:
 	mutex_unlock(&text_mutex);
 
diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
index 3c8ebb7d2a6b..18784c764c14 100644
--- a/tools/objtool/arch/powerpc/include/arch/elf.h
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -4,5 +4,6 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_PPC_NONE
+#define R_REL32	R_PPC_REL32
 
 #endif /* _OBJTOOL_ARCH_ELF */
-- 
2.35.3

