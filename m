Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A754DB82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359246AbiFPH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359288AbiFPH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:26:01 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2A5C37C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:26:00 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25G7OEsG031436;
        Thu, 16 Jun 2022 16:24:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25G7OEsG031436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655364256;
        bh=+UChpnutO8NUWrayLWCckLkfeguNyYFqZbas2ZeTgNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBNOKkuRliKchlVMC41y6Od+PKWirrzGYaP+BI0bmuc8q5PcQlvt7RSFNfAZgrP73
         CDtk4VxunKuU8o2TUDmvGXBvQaXRBgR3SeI8A3tnyuYOlZZvDj17rnCF27T1mAysMs
         0fFApaOJ3NHjZMZ5zIEwdlKzornwkKz8EEEk68r+6M53cA3EOBViHa23/Cd3HwJAgW
         go/DcZtjCno+xROwjuT0937SqhABqU2XEisG2tc2vjA91XhbThD3J6bB+bNseCwFiu
         6awXrTO3hU2jQMt/7vvgO6Xp3BptSgEIWWoqpo5MZ2Ly97Blj4imEzH0jjsdLXxbxU
         9yTbqQDaGrwXw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] x86/purgatory: Omit use of bin2c
Date:   Thu, 16 Jun 2022 16:24:07 +0900
Message-Id: <20220616072407.2317131-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616072407.2317131-1-masahiroy@kernel.org>
References: <20220616072407.2317131-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 000000000000..1a1abf6268bc
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
+.Lkexec_purgatroy_end:
+
+	.align	8
+kexec_purgatory_size:
+	.globl	kexec_purgatory_size
+	.quad	.Lkexec_purgatroy_end - kexec_purgatory
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
2.32.0

