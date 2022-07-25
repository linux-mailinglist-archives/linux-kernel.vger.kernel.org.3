Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDC57F830
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiGYCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGYCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:11:21 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C9E0C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:11:19 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26P28hG0024554;
        Mon, 25 Jul 2022 11:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26P28hG0024554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658714924;
        bh=fBshU7A7Rde9m6PAxG1uCGgXJuFDSJp0LWPguc3FMLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYn3kYIHBv3BbtTm/AOpEJ4+M4l/+DfG+TMkXA+NI4dPD5qNgJhiyY2ZJAd7DiSaR
         71HF/bcO3Ov6yvDm7/wKC8z4DbRrYEP37CU7zkzHyA3+SOy8rJgOhBLR7VpNXCHGoU
         TuNs58fbO4V+Hsb2S7MLwd18KtRGEwPrXnt/bJiGGgui2KBgbMgM27Y8x9YsiGk6m4
         vgRK9Me2hZncA9/ikylNvBTlb5E1wmxVWCSF6gXgrsubVADQ/kV4873xoxroINfDvb
         9JkYZeUQKWyOpKvdlqU9SvM2wmy/WnDRewOwT1s5IQcvznfPYsNIgFAFdtrotObdPt
         qENjrqKBe50Bg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/purgatory: Omit use of bin2c
Date:   Mon, 25 Jul 2022 11:08:12 +0900
Message-Id: <20220725020812.622255-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220725020812.622255-1-masahiroy@kernel.org>
References: <20220725020812.622255-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .incbin assembler directive is much faster than bin2c + $(CC).

Do similar refactoring as in commit 4c0f032d4963 ("s390/purgatory:
Omit use of bin2c").

Please note the .quad directive matches to size_t in C (both 8 byte)
because the purgatory is compiled only for the 64-bit kernel.
(KEXEC_FILE depends on X86_64).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix a typo (kexec_purgatroy_end -> kexec_purgatory_end)

 arch/x86/.gitignore                  |  2 --
 arch/x86/Kconfig                     |  1 -
 arch/x86/purgatory/Makefile          |  8 +-------
 arch/x86/purgatory/kexec-purgatory.S | 14 ++++++++++++++
 scripts/remove-stale-files           |  2 ++
 5 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/purgatory/kexec-purgatory.S

diff --git a/arch/x86/.gitignore b/arch/x86/.gitignore
index 677111acbaa3..f2e1d6c347fb 100644
--- a/arch/x86/.gitignore
+++ b/arch/x86/.gitignore
@@ -3,6 +3,4 @@ boot/compressed/vmlinux
 tools/test_get_len
 tools/insn_sanity
 tools/insn_decoder_test
-purgatory/kexec-purgatory.c
 purgatory/purgatory.ro
-
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..2c1d37cd479f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2032,7 +2032,6 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
-	select BUILD_BIN2C
 	depends on X86_64
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 248b009c4061..31c634a22818 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -73,12 +73,6 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 $(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
 		$(call if_changed,ld)
 
-targets += kexec-purgatory.c
-
-quiet_cmd_bin2c = BIN2C   $@
-      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
-
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
-	$(call if_changed,bin2c)
+$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
 
 obj-y += kexec-purgatory.o
diff --git a/arch/x86/purgatory/kexec-purgatory.S b/arch/x86/purgatory/kexec-purgatory.S
new file mode 100644
index 000000000000..8530fe93b718
--- /dev/null
+++ b/arch/x86/purgatory/kexec-purgatory.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.section .rodata, "a"
+
+	.align	8
+kexec_purgatory:
+	.globl	kexec_purgatory
+	.incbin	"arch/x86/purgatory/purgatory.ro"
+.Lkexec_purgatory_end:
+
+	.align	8
+kexec_purgatory_size:
+	.globl	kexec_purgatory_size
+	.quad	.Lkexec_purgatory_end - kexec_purgatory
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 7adab4618035..379e86c71bed 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -41,3 +41,5 @@ if [ -n "${building_out_of_srctree}" ]; then
 fi
 
 rm -f scripts/extract-cert
+
+rm -f arch/x86/purgatory/kexec-purgatory.c
-- 
2.34.1

