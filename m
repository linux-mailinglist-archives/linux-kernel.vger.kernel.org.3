Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B116B57FEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiGYMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiGYMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:08:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A95DF61;
        Mon, 25 Jul 2022 05:08:24 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658750902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oMdJNO8Q18/poUtr1F/51rn98EPl62mt6vQplKcYNc=;
        b=3RXlDyDtnV8NAaN7O69ictD0qukaCxX3pfwivsy/u3Qf/ANTqfPJw28fyA/WaGmWySSMDM
        cpTculevD7z8sj/rH5TVlKqHGVBnagIhE5IN5DF+Ipq71CTf9sBWf63+/4w7/Qp6DpZzFI
        rvKAyPAOBtb1REvypRxe1dpb9v8Sx2pjVVN57zVcZC08rf0VwGmxp4V+DiVmqDOQ13H63H
        LIQYrvIN9NkBxPNRTKCED4ijB8Rs1SlmeQwf+2yMsKX5QhgxLKMc5MMHJsCZFK74V4t45i
        705GQA2Cr+5WTjbRKcAnkL4dybpHZYsHlaChzKJmNoD837p2L5Rqq1qBZ6FwEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658750902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oMdJNO8Q18/poUtr1F/51rn98EPl62mt6vQplKcYNc=;
        b=ibxmdoLpL7AqOBmSdTS4Eo0CYO49WoPDpBUvkKXrWY/FkajgZ/1U9/s/M//Fbz2r7uL15y
        oBKGnlAb0hjiVJDQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/purgatory: Omit use of bin2c
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220725020812.622255-2-masahiroy@kernel.org>
References: <20220725020812.622255-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <165875090068.15455.6422328179935086784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     2d17bd24b0169d3fdbf003dfd55af600e9a30553
Gitweb:        https://git.kernel.org/tip/2d17bd24b0169d3fdbf003dfd55af600e9a30553
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 25 Jul 2022 11:08:12 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Jul 2022 10:32:32 +02:00

x86/purgatory: Omit use of bin2c

The .incbin assembler directive is much faster than bin2c + $(CC).

Do similar refactoring as in

  4c0f032d4963 ("s390/purgatory: Omit use of bin2c").

Please note the .quad directive matches to size_t in C (both 8
byte) because the purgatory is compiled only for the 64-bit kernel.
(KEXEC_FILE depends on X86_64).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220725020812.622255-2-masahiroy@kernel.org
---
 arch/x86/.gitignore                  |  2 --
 arch/x86/Kconfig                     |  1 -
 arch/x86/purgatory/Makefile          |  8 +-------
 arch/x86/purgatory/kexec-purgatory.S | 14 ++++++++++++++
 scripts/remove-stale-files           |  2 ++
 5 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/purgatory/kexec-purgatory.S

diff --git a/arch/x86/.gitignore b/arch/x86/.gitignore
index 677111a..f2e1d6c 100644
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
index 076adde..901cb59 100644
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
index 248b009..31c634a 100644
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
index 0000000..8530fe9
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
index 7adab46..379e86c 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -41,3 +41,5 @@ if [ -n "${building_out_of_srctree}" ]; then
 fi
 
 rm -f scripts/extract-cert
+
+rm -f arch/x86/purgatory/kexec-purgatory.c
