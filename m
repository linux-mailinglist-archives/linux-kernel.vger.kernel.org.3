Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8157C471F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhLMDK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:10:29 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:43286 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhLMDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:10:27 -0500
X-Greylist: delayed 1737 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 22:10:27 EST
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1BD39GWs026488;
        Mon, 13 Dec 2021 12:09:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BD39GWs026488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639364957;
        bh=DNaVTszSB+se76j/UUJJ0jQxxrG7do0Mb4/6mfpPU/0=;
        h=From:To:Cc:Subject:Date:From;
        b=MbJP+BBRCs7TGIT6xW640IVcy/Y+IeNA4ADSsBUk+klaymwanzP67zJfK0iUc7iCR
         hH1YAiIMEBpBFZUC4x6DgojjHg7YSKxg+8iYI3YvQyVClDftU9iOmDCDm3tRjkVysI
         +9PLIhM/8LELCQeiTQvut3UD9H7EKE7oASdgxxkOZaR8FUil3jqHgfZfKLCu0Tyv15
         WiSc2xsZAiIoQ+IWCUouVZGAl/Tv6BXz64r5pjROcWO+ZdsJfglSHkQs4OL06+810K
         f3Oh0LEnUbLDKcrKB77fLomRSZnRPyWgvdbdcgin92onitx9fv5xn1MqBYqtk7O4l0
         Acyik9NLDdx9g==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] parisc: decompressor: do not copy source files while building
Date:   Mon, 13 Dec 2021 12:09:15 +0900
Message-Id: <20211213030915.1170219-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
builds") stated, copying source files during the build time may not
end up with as clean code as expected.

Do similar for parisc to clean up the Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/boot/compressed/.gitignore | 2 --
 arch/parisc/boot/compressed/Makefile   | 8 --------
 arch/parisc/boot/compressed/firmware.c | 2 ++
 arch/parisc/boot/compressed/real2.S    | 2 ++
 scripts/remove-stale-files             | 5 +++++
 5 files changed, 9 insertions(+), 10 deletions(-)
 create mode 100644 arch/parisc/boot/compressed/firmware.c
 create mode 100644 arch/parisc/boot/compressed/real2.S

diff --git a/arch/parisc/boot/compressed/.gitignore b/arch/parisc/boot/compressed/.gitignore
index b9853a356ab2..a5839aa16706 100644
--- a/arch/parisc/boot/compressed/.gitignore
+++ b/arch/parisc/boot/compressed/.gitignore
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-firmware.c
-real2.S
 sizes.h
 vmlinux
 vmlinux.lds
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index bf4f2891d0b7..116bd5c1873c 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -13,7 +13,6 @@ OBJECTS := head.o real2.o firmware.o misc.o piggy.o
 targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
 targets += $(OBJECTS) sizes.h
-targets += real2.S firmware.c
 
 KBUILD_CFLAGS := -D__KERNEL__ -O2 -DBOOTLOADER
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -42,14 +41,7 @@ $(obj)/head.o: $(obj)/sizes.h
 CFLAGS_misc.o += -I$(objtree)/$(obj)
 $(obj)/misc.o: $(obj)/sizes.h
 
-$(obj)/firmware.o: $(obj)/firmware.c
-$(obj)/firmware.c: $(srctree)/arch/$(SRCARCH)/kernel/firmware.c
-	$(call cmd,shipped)
-
 AFLAGS_real2.o += -DBOOTLOADER
-$(obj)/real2.o: $(obj)/real2.S
-$(obj)/real2.S: $(srctree)/arch/$(SRCARCH)/kernel/real2.S
-	$(call cmd,shipped)
 
 CPPFLAGS_vmlinux.lds += -I$(objtree)/$(obj) -DBOOTLOADER
 $(obj)/vmlinux.lds: $(obj)/sizes.h
diff --git a/arch/parisc/boot/compressed/firmware.c b/arch/parisc/boot/compressed/firmware.c
new file mode 100644
index 000000000000..16a07137fe92
--- /dev/null
+++ b/arch/parisc/boot/compressed/firmware.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../kernel/firmware.c"
diff --git a/arch/parisc/boot/compressed/real2.S b/arch/parisc/boot/compressed/real2.S
new file mode 100644
index 000000000000..cdc6a4da3240
--- /dev/null
+++ b/arch/parisc/boot/compressed/real2.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../kernel/real2.S"
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index f0d53227fe7b..80430b8fb617 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -33,4 +33,9 @@ if [ -n "${building_out_of_srctree}" ]; then
 	do
 		rm -f arch/mips/boot/compressed/${f}
 	done
+
+	for f in firmware.c real2.S
+	do
+		rm -f arch/parisc/boot/compressed/${f}
+	done
 fi
-- 
2.32.0

