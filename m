Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984F5A9607
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiIALtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiIALtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:49:22 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B689139F5E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:49:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJK7y0s3xz9spG;
        Thu,  1 Sep 2022 13:49:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9C26P2oxqw8L; Thu,  1 Sep 2022 13:49:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJK7t34jDz9spJ;
        Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FD718B780;
        Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EuLa8HTRY4s9; Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.131])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD9DC8B781;
        Thu,  1 Sep 2022 13:48:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 281BmseE1768901
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 13:48:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 281Bmsgp1768900;
        Thu, 1 Sep 2022 13:48:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        bgray@linux.ibm.com, agust@denx.de, jpoimboe@kernel.org,
        peterz@infradead.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v3 6/6] powerpc/static_call: Implement inline static calls
Date:   Thu,  1 Sep 2022 13:48:25 +0200
Message-Id: <73de83279d8a8cdcffa411a525d60eb8e1901bf5.1662032631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662032631.git.christophe.leroy@csgroup.eu>
References: <cover.1662032631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662032901; l=2913; s=20211009; h=from:subject:message-id; bh=TvtmX4ECN9pg2ZGuTVxGQDwg0x2MKLzYnuieB2MCpwA=; b=+rUtG7bfs80qmRGzX7EsUv8yDVc6/0BPG5hLed+TUPAQfCOIjHWiG98lGSXdtrXkGM44BmnWmx3h R/eZNgA8DY5eQrY3gY3fAf8SfAaetBeNtvlUn+jNC72Vbye+XXg9
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
- Put a 'bl' to the destination function ('b' if tail call)
- Put a 'nop' when the destination function is NULL ('blr' if tail call)
- Put a 'li r3,0' when the destination is the RET0 function and not
a tail call.

If the destination is too far (over the 32Mb limit), go via the
trampoline.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/static_call.h |  2 ++
 arch/powerpc/kernel/static_call.c      | 24 +++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6be2e68fa9eb..9deb97c28304 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -251,6 +251,7 @@ config PPC
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
index 97765b9e1c5b..ba59e987f92d 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -15,7 +15,29 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 
 	mutex_lock(&text_mutex);
 
-	if (tramp) {
+	if (site && tail) {
+		if (!func)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_BLR()));
+		else if (is_ret0)
+			err = patch_branch(site, _ret0, 0);
+		else if (is_short)
+			err = patch_branch(site, _func, 0);
+		else if (tramp)
+			err = patch_branch(site, _tramp, 0);
+		else
+			err = 0;
+	} else if (site) {
+		if (!func)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_NOP()));
+		else if (is_ret0)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_LI(_R3, 0)));
+		else if (is_short)
+			err = patch_branch(site, _func, BRANCH_SET_LINK);
+		else if (tramp)
+			err = patch_branch(site, _tramp, BRANCH_SET_LINK);
+		else
+			err = 0;
+	} else if (tramp) {
 		if (func && !is_short) {
 			err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(_func));
 			if (err)
-- 
2.37.1

