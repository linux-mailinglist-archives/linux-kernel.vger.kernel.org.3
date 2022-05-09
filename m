Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA851F448
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiEIFrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiEIFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:46:43 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF715E75A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:42:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKc3PLKz9sW9;
        Mon,  9 May 2022 07:36:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MvxXOftsaf4D; Mon,  9 May 2022 07:36:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKF6G45z9sW7;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE4148B76E;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VuS5VDGUey6H; Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 723BB8B780;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aT0G1591239
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:29 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aTIL1591238;
        Mon, 9 May 2022 07:36:29 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 08/25] powerpc: Add CONFIG_PPC64_ELF_ABI_V1 and CONFIG_PPC64_ELF_ABI_V2
Date:   Mon,  9 May 2022 07:36:06 +0200
Message-Id: <1eca1addbc550167da9841c7340a010d0c4b2200.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074581; l=2625; s=20211009; h=from:subject:message-id; bh=NBoBcjsTO1tovFFuP2hBDk2AHE9R2iPK5NfoSRq7M98=; b=HRQc/3CrXc8/4Z0lkCGnXifgCtBr3PfIptOJHdq93TN9cEQ+yqTmWT/bzKDS0qNsO40+SgprPROk A7ZXYCHBCmYkv/I4u9gj1zH2iTHQLu7F9FzDa005cck3ZDQfEcCh
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

At the time being, we use CONFIG_CPU_LITTLE_ENDIAN and
CONFIG_CPU_BIG_ENDIAN to pass -mabi=elfv1 or elfv2 to
compiler, then define a PPC64_ELF_ABI_v1 or PPC64_ELF_ABI_v2
macro in asm/types.h based on _CALL_ELF define set by the compiler.

Make it more straight forward with a CONFIG option that
is directly usable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Makefile                  | 10 +++++-----
 arch/powerpc/boot/Makefile             |  2 ++
 arch/powerpc/platforms/Kconfig.cputype |  6 ++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index eb541e730d3c..1ba98be84101 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -89,10 +89,10 @@ endif
 
 ifdef CONFIG_PPC64
 ifndef CONFIG_CC_IS_CLANG
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
-aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
-aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
+cflags-$(CONFIG_PPC64_ELF_ABI_V1)	+= $(call cc-option,-mabi=elfv1)
+cflags-$(CONFIG_PPC64_ELF_ABI_V1)	+= $(call cc-option,-mcall-aixdesc)
+aflags-$(CONFIG_PPC64_ELF_ABI_V1)	+= $(call cc-option,-mabi=elfv1)
+aflags-$(CONFIG_PPC64_ELF_ABI_V2)	+= -mabi=elfv2
 endif
 endif
 
@@ -141,7 +141,7 @@ endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
 ifndef CONFIG_CC_IS_CLANG
-ifdef CONFIG_CPU_LITTLE_ENDIAN
+ifdef CONFIG_PPC64_ELF_ABI_V2
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4b4827c475c6..b6d4fe04c594 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -49,6 +49,8 @@ ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
 else
 BOOTCFLAGS	+= -mlittle-endian
+endif
+ifdef CONFIG_PPC64_ELF_ABI_V2
 BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e2e1fec91c6e..9bfcf972d21d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -556,6 +556,12 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
+config PPC64_ELF_ABI_V1
+	def_bool PPC64 && CPU_BIG_ENDIAN
+
+config PPC64_ELF_ABI_V2
+	def_bool PPC64 && CPU_LITTLE_ENDIAN
+
 config PPC64_BOOT_WRAPPER
 	def_bool n
 	depends on CPU_LITTLE_ENDIAN
-- 
2.35.1

