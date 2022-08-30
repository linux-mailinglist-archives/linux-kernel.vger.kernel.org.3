Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D75A6121
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiH3KuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH3KuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:50:00 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB919FEF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661856587;
        bh=CgtmaUw0UwaoZn+tYjzbKz/lFf1KH1RSTMazBd+mvWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+zhDhRipw1yMd4IOtKMoMNQRQJG1G3mn5K6IrCkp27OQvIPYQKCasQPtz61T1oJH
         279Yv/8gsLxtygbo45fJ5vqKwq1d8VcRBF73WWqpXM9J31OEA7dVhh8y68DwHVr39D
         oohqCuiEjtzHFDFuNhSTwEXBjdnat4yREszVBBh4=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id AACC5660A9;
        Tue, 30 Aug 2022 06:49:43 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7 2/5] LoongArch: Adjust symbol addressing for CONFIG_AS_HAS_EXPLICIT_RELOCS
Date:   Tue, 30 Aug 2022 18:48:03 +0800
Message-Id: <20220830104806.128365-3-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830104806.128365-1-xry111@xry111.site>
References: <20220830104806.128365-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If explicit relocation hints is used by the toolchain, -Wa,-mla-*
options will be useless for C code.  Only use them for
!CONFIG_AS_HAS_EXPLICIT_RELOCS.

Replace "la" with "la.pcrel" in head.S to keep the semantic consistent
with new and old toolchains for the low level startup code.

For per-CPU variables, the "address" of the symbol is actually an
offset from $r21.  The value is nearing the loading address of main
kernel image, but far from the address of modules.  Use model("extreme")
attibute to tell the compiler that a  a PC-relative addressing with
32-bit offset is not sufficient for local per-CPU variables.

The behavior with different assemblers and compilers are summarized in
the following table:

AS has            CC has
explicit reloc    explicit reloc *  Behavior
==============================================================
No                No                Use la.* macros.
                                    No change from Linux 6.0.
--------------------------------------------------------------
No                Yes               Disable explicit reloc.
                                    No change from Linux 6.0.
--------------------------------------------------------------
Yes               No                Not supported.
--------------------------------------------------------------
Yes               Yes               Use explicit relocs.
                                    No -Wa,-mla* options.
==============================================================
*: We assume CC must have model attribute if it has explicit reloc.
   Both features are added in GCC 13 development cycle, so any GCC
   release >= 13 should be OK.  Using early GCC 13 development snapshots
   may produce modules with unsupported relocations.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f09482a
Link: https://gcc.gnu.org/r13-1834
Link: https://gcc.gnu.org/r13-2199
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Makefile             | 17 +++++++++++++++++
 arch/loongarch/include/asm/percpu.h |  8 ++++++++
 arch/loongarch/kernel/head.S        | 10 +++++-----
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 7051a95f7f31..92c4a52c4c3e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -40,10 +40,27 @@ endif
 
 cflags-y			+= -G0 -pipe -msoft-float
 LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
+
+# When the assembler supports explicit relocation hint, we must use it.
+# GCC may have -mexplicit-relocs off by default if it was built with an old
+# assembler, so we force it via an option.
+#
+# When the assembler does not supports explicit relocation hint, we can't use
+# it.  Disable it if the compiler supports it.
+#
+# If you've seen "unknown reloc hint" message building the kernel and you are
+# now wondering why "-mexplicit-relocs" is not wrapped with cc-option: the
+# combination of a "new" assembler and "old" compiler is not supported.  Either
+# upgrade the compiler or downgrade the assembler.
+ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
+cflags-y			+= -mexplicit-relocs
+else
+cflags-y			+= $(call cc-option,-mno-explicit-relocs)
 KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
 KBUILD_CFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
 KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
 KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
+endif
 
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 0bd6b0110198..dd7fcc553efa 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -8,6 +8,14 @@
 #include <asm/cmpxchg.h>
 #include <asm/loongarch.h>
 
+#if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
+/* The "address" (in fact, offset from $r21) of a per-CPU variable is close
+ * to the load address of main kernel image, but far from where the modules are
+ * loaded.  Tell the compiler this fact.
+ */
+# define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
+#endif
+
 /* Use r21 for fast access */
 register unsigned long __my_cpu_offset __asm__("$r21");
 
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 01bac62a6442..eb3f641d5915 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -55,17 +55,17 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
 	csrwr		t0, LOONGARCH_CSR_EUEN
 
-	la		t0, __bss_start		# clear .bss
+	la.pcrel	t0, __bss_start		# clear .bss
 	st.d		zero, t0, 0
-	la		t1, __bss_stop - LONGSIZE
+	la.pcrel	t1, __bss_stop - LONGSIZE
 1:
 	addi.d		t0, t0, LONGSIZE
 	st.d		zero, t0, 0
 	bne		t0, t1, 1b
 
-	la		t0, fw_arg0
+	la.pcrel	t0, fw_arg0
 	st.d		a0, t0, 0		# firmware arguments
-	la		t0, fw_arg1
+	la.pcrel	t0, fw_arg1
 	st.d		a1, t0, 0
 
 	/* KSave3 used for percpu base, initialized as 0 */
@@ -73,7 +73,7 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	/* GPR21 used for percpu base (runtime), initialized as 0 */
 	move		u0, zero
 
-	la		tp, init_thread_union
+	la.pcrel	tp, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
 	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
 	PTR_ADD		sp, sp, tp
-- 
2.37.0

