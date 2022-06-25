Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3055ACF4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiFYWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:36:27 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9064BE31
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:36:23 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25PMYreL012075;
        Sun, 26 Jun 2022 07:34:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25PMYreL012075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656196495;
        bh=lbkFgqQiQu+Q3HO8EUdOPNSxleofFd7eWayRksMuI0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c09GldJ6mwPUANUpNjLWdMi+FnQhvvLLQGErZr54l8Ey9hnalBHa1gF8ZEr1Xy2ZV
         AwxXRX4wJlEitlG85DJyiC4Sd59N8ws0zycPLQ+t6kT6YuEg9sPqUuGBbScSgb9PUg
         ndZbM9LitC/aJx8uOM9H84JY/52YlK5Oz/qaZSIHtszrvQ/JA92GRAz6ZxabjoN9ag
         8r0uHLMOW+msFlDTjqx3W8vsCjyiYLHzXCxTmQ4FWxhn85mXtKWj7g+PiAXqrPfK/9
         sElzsDpz0DDjw/0iftDtiDLSLC7lTM7JRmAppl7Q9wDd2PKNAKUhxW6tzBvKZEKZ2Z
         lKhmqCv8l2hVg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv/purgatory: Omit use of bin2c
Date:   Sun, 26 Jun 2022 07:34:37 +0900
Message-Id: <20220625223438.835408-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220625223438.835408-1-masahiroy@kernel.org>
References: <20220625223438.835408-1-masahiroy@kernel.org>
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
(KEXEC_FILE depends on 64BIT).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Kconfig                     |  1 -
 arch/riscv/purgatory/.gitignore        |  1 -
 arch/riscv/purgatory/Makefile          |  8 +-------
 arch/riscv/purgatory/kexec-purgatory.S | 14 ++++++++++++++
 scripts/remove-stale-files             |  2 ++
 5 files changed, 17 insertions(+), 9 deletions(-)
 create mode 100644 arch/riscv/purgatory/kexec-purgatory.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 32ffef9f6e5b..218c2f12b3ef 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -447,7 +447,6 @@ config KEXEC_FILE
 
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
-	select BUILD_BIN2C
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
 
diff --git a/arch/riscv/purgatory/.gitignore b/arch/riscv/purgatory/.gitignore
index 38d7d1bda4d7..6e4dfb024ad2 100644
--- a/arch/riscv/purgatory/.gitignore
+++ b/arch/riscv/purgatory/.gitignore
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 purgatory.chk
 purgatory.ro
-kexec-purgatory.c
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index c2d14e2f345d..dd58e1d99397 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -84,12 +84,6 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
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
diff --git a/arch/riscv/purgatory/kexec-purgatory.S b/arch/riscv/purgatory/kexec-purgatory.S
new file mode 100644
index 000000000000..0e9188815718
--- /dev/null
+++ b/arch/riscv/purgatory/kexec-purgatory.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.section .rodata, "a"
+
+	.align	8
+kexec_purgatory:
+	.globl	kexec_purgatory
+	.incbin	"arch/riscv/purgatory/purgatory.ro"
+.Lkexec_purgatroy_end:
+
+	.align	8
+kexec_purgatory_size:
+	.globl	kexec_purgatory_size
+	.quad	.Lkexec_purgatroy_end - kexec_purgatory
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 7adab4618035..d75a52199a38 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -40,4 +40,6 @@ if [ -n "${building_out_of_srctree}" ]; then
 	done
 fi
 
+rm -f arch/riscv/purgatory/kexec-purgatory.c
+
 rm -f scripts/extract-cert
-- 
2.32.0

