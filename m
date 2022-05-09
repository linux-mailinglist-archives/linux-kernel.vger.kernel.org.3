Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879451F412
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiEIFtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiEIFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:46:29 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4D15E499
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:42:36 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKW0sWKz9sW3;
        Mon,  9 May 2022 07:36:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3VCec8f1JckO; Mon,  9 May 2022 07:36:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKF5tpdz9sVq;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6D268B773;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JMyJ9JAKuTsQ; Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A8238B779;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aUB51591247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:30 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aUpD1591246;
        Mon, 9 May 2022 07:36:30 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 10/25] powerpc: Finalise cleanup around ABI use
Date:   Mon,  9 May 2022 07:36:08 +0200
Message-Id: <709d9d69523c14c8a9fba4486395dca0f2d675b1.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074581; l=4161; s=20211009; h=from:subject:message-id; bh=WxVopPaHaxL4NhbA6gDzSbUKU21wfZC2s9FczOO6P/8=; b=1ndoSdj89H5/B1LcUVAVDtrq1kGRMDqityfCFTWjafvdSc028UoG4hB9Eq1YR696xb1BGk+jNWr0 q4z/ciE9Bt9UOQwkn9S/aZINfZKDV9pD80F5DCloaxY8zshA+rzI
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

Now that we have CONFIG_PPC64_ELF_ABI_V1 and CONFIG_PPC64_ELF_ABI_V2,
get rid of all indirect detection of ABI version.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                |  2 +-
 arch/powerpc/Makefile               |  2 +-
 arch/powerpc/include/asm/types.h    |  8 --------
 arch/powerpc/kernel/fadump.c        | 13 ++++++++-----
 arch/powerpc/kernel/ptrace/ptrace.c |  6 ------
 arch/powerpc/net/bpf_jit_comp64.c   |  4 ++--
 6 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..5514fed3f072 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -208,7 +208,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_FUNCTION_DESCRIPTORS	if PPC64 && !CPU_LITTLE_ENDIAN
+	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1ba98be84101..8bd3b631f094 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -213,7 +213,7 @@ CHECKFLAGS	+= -m$(BITS) -D__powerpc__ -D__powerpc$(BITS)__
 ifdef CONFIG_CPU_BIG_ENDIAN
 CHECKFLAGS	+= -D__BIG_ENDIAN__
 else
-CHECKFLAGS	+= -D__LITTLE_ENDIAN__ -D_CALL_ELF=2
+CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
 ifdef CONFIG_476FPE_ERR46
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index 84078c28c1a2..93157a661dcc 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -11,14 +11,6 @@
 
 #include <uapi/asm/types.h>
 
-#ifdef __powerpc64__
-#if defined(_CALL_ELF) && _CALL_ELF == 2
-#define PPC64_ELF_ABI_v2 1
-#else
-#define PPC64_ELF_ABI_v1 1
-#endif
-#endif /* __powerpc64__ */
-
 #ifndef __ASSEMBLY__
 
 typedef __vector128 vector128;
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 65562c4a0a69..5f7224d66586 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -968,11 +968,14 @@ static int fadump_init_elfcore_header(char *bufp)
 	elf->e_entry = 0;
 	elf->e_phoff = sizeof(struct elfhdr);
 	elf->e_shoff = 0;
-#if defined(_CALL_ELF)
-	elf->e_flags = _CALL_ELF;
-#else
-	elf->e_flags = 0;
-#endif
+
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
+		elf->e_flags = 2;
+	else if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))
+		elf->e_flags = 1;
+	else
+		elf->e_flags = 0;
+
 	elf->e_ehsize = sizeof(struct elfhdr);
 	elf->e_phentsize = sizeof(struct elf_phdr);
 	elf->e_phnum = 0;
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 9fbe155a9bd0..4d2dc22d4a2d 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -444,10 +444,4 @@ void __init pt_regs_check(void)
 	 * real registers.
 	 */
 	BUILD_BUG_ON(PT_DSCR < sizeof(struct user_pt_regs) / sizeof(unsigned long));
-
-#ifdef CONFIG_PPC64_ELF_ABI_V1
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS));
-#else
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS));
-#endif
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index d7b42f45669e..594c54931e20 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -126,7 +126,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 {
 	int i;
 
-	if (__is_defined(CONFIG_PPC64_ELF_ABI_V2))
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
 		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 
 	/*
@@ -266,7 +266,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	int b2p_index = bpf_to_ppc(BPF_REG_3);
 	int bpf_tailcall_prologue_size = 8;
 
-	if (__is_defined(CONFIG_PPC64_ELF_ABI_V2))
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
 		bpf_tailcall_prologue_size += 4; /* skip past the toc load */
 
 	/*
-- 
2.35.1

