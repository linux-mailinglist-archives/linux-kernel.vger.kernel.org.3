Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE5542E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiFHKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiFHKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534072AE11;
        Wed,  8 Jun 2022 03:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C80B826B8;
        Wed,  8 Jun 2022 10:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487FCC341C6;
        Wed,  8 Jun 2022 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654685132;
        bh=IUkks1rKSJ/NdE5ptUYvV5ETNPKdfPh+xYmfyDN6j5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3DH+BPm08KVSut05Senfp4vB0Ejiz90/0DzI4vHCNQF16R43bm9dX0GsLcK8wSpK
         plrR1TLzk5K/Qat9LG5AiN84lz9yBdURg1nRZ5wniBrPOMmDXCft6VEwf2ePW0UaO/
         FVOeSu0qQBF1TU/ywvAWyjf2kUVucSdIMPerJSs75FMqBbnmcsEaKVPHtgYZf5QOWf
         cV/jySGcmUoNAsA2qd+ohhIyMDuAMABCr2rMK9SexxphliKJ4L+/URsW6eQ0qI7yLG
         DVqLtbIGZcSO2dOy3he82ehh6trVRaOjMN0KpC3PuYXvxSPp7rojL7Qb7P1bVGkRIi
         4mr+zRf+Pg+uw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] jump_label: make initial NOP patching the special case
Date:   Wed,  8 Jun 2022 12:45:12 +0200
Message-Id: <20220608104512.1176209-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608104512.1176209-1-ardb@kernel.org>
References: <20220608104512.1176209-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7711; h=from:subject; bh=IUkks1rKSJ/NdE5ptUYvV5ETNPKdfPh+xYmfyDN6j5A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBioH23z/sItwB00nGMha5Ha+zYBS5GkKeFiVirkyRz Z6sfHB+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqB9twAKCRDDTyI5ktmPJEPOC/ 90LIbIy+/gbgiX0AcTzY9J5qxBHb2tBJg57qdy0vZgq6YXW9lk1TbqhSB5oRSWenMgxFwgSV4pp/VS F0X8MC5aaIZMfaJb7AMP9o/n6MUHqaMI3Y/x9DbuK1LedWYrAU0pEgmA3Cp/Sh2zDl0lM3c7JJmxT5 iig2vO3AVMNxDkCpOIkvv49syUB4oNyRJdaHM/eBkkI4xuj4IFFEjrJ/wzHasavLpGBnIl97rpw/oN bEkHxz7TBWVXruTXcgcW4JwVFbrUGqVt5Zj5lKuuIr7YUf80r+6wz4xAj13Vxu94ierpwqVaze07vR rDcCaJo0SjwDVg/Sgu36X4sM8oSreMmHS/oT+CY3c6gtrIaVAto8wSwRBp/9goBEhst6To1wIkwwAy pjpVxGND5LfUI1EKLKlsAsogQ+mxaqTNn2Wn1tAT+9RGJZphb6BGs2wYj90u2tQECZlhnLUYjLrfh7 asC8ZlLoRWywY2bTprQg0YXwCam51umh4rvV5XP7SLUg4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defaulting to patching NOP opcodes at init time, and leaving
it to the architectures to override this if this is not needed, switch
to a model where doing nothing is the default. This is the common case
by far, as only MIPS requires NOP patching at init time. On all other
architectures, the correct encodings are emitted by the compiler and so
no initial patching is needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/staging/static-keys.rst |  3 ---
 arch/arc/kernel/jump_label.c          | 13 -------------
 arch/arm/kernel/jump_label.c          |  6 ------
 arch/arm64/kernel/jump_label.c        | 11 -----------
 arch/mips/include/asm/jump_label.h    |  2 ++
 arch/parisc/kernel/jump_label.c       | 11 -----------
 arch/riscv/kernel/jump_label.c        | 12 ------------
 arch/s390/kernel/jump_label.c         |  5 -----
 arch/x86/kernel/jump_label.c          | 13 -------------
 kernel/jump_label.c                   | 14 +++-----------
 10 files changed, 5 insertions(+), 85 deletions(-)

diff --git a/Documentation/staging/static-keys.rst b/Documentation/staging/static-keys.rst
index 38290b9f25eb..b0a519f456cf 100644
--- a/Documentation/staging/static-keys.rst
+++ b/Documentation/staging/static-keys.rst
@@ -201,9 +201,6 @@ static_key->entry field makes use of the two least significant bits.
 * ``void arch_jump_label_transform(struct jump_entry *entry, enum jump_label_type type)``,
     see: arch/x86/kernel/jump_label.c
 
-* ``__init_or_module void arch_jump_label_transform_static(struct jump_entry *entry, enum jump_label_type type)``,
-    see: arch/x86/kernel/jump_label.c
-
 * ``struct jump_entry``,
     see: arch/x86/include/asm/jump_label.h
 
diff --git a/arch/arc/kernel/jump_label.c b/arch/arc/kernel/jump_label.c
index b8600dc325b5..70b74a5d047b 100644
--- a/arch/arc/kernel/jump_label.c
+++ b/arch/arc/kernel/jump_label.c
@@ -96,19 +96,6 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);
 }
 
-void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	/*
-	 * We use only one NOP type (1x, 4 byte) in arch_static_branch, so
-	 * there's no need to patch an identical NOP over the top of it here.
-	 * The generic code calls 'arch_jump_label_transform' if the NOP needs
-	 * to be replaced by a branch, so 'arch_jump_label_transform_static' is
-	 * never called with type other than JUMP_LABEL_NOP.
-	 */
-	BUG_ON(type != JUMP_LABEL_NOP);
-}
-
 #ifdef CONFIG_ARC_DBG_JUMP_LABEL
 #define SELFTEST_MSG	"ARC: instruction generation self-test: "
 
diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
index 303b3ab87f7e..eb9c24b6e8e2 100644
--- a/arch/arm/kernel/jump_label.c
+++ b/arch/arm/kernel/jump_label.c
@@ -27,9 +27,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 {
 	__arch_jump_label_transform(entry, type, false);
 }
-
-void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	__arch_jump_label_transform(entry, type, true);
-}
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index fc98037e1220..faf88ec9c48e 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -26,14 +26,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 
 	aarch64_insn_patch_text_nosync(addr, insn);
 }
-
-void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	/*
-	 * We use the architected A64 NOP in arch_static_branch, so there's no
-	 * need to patch an identical A64 NOP over the top of it here. The core
-	 * will call arch_jump_label_transform from a module notifier if the
-	 * NOP needs to be replaced by a branch.
-	 */
-}
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index 3185fd3220ec..c5c6864e64bc 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_MIPS_JUMP_LABEL_H
 #define _ASM_MIPS_JUMP_LABEL_H
 
+#define arch_jump_label_transform_static arch_jump_label_transform
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
diff --git a/arch/parisc/kernel/jump_label.c b/arch/parisc/kernel/jump_label.c
index d2f3cb12e282..e253b134500d 100644
--- a/arch/parisc/kernel/jump_label.c
+++ b/arch/parisc/kernel/jump_label.c
@@ -42,14 +42,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 
 	patch_text(addr, insn);
 }
-
-void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	/*
-	 * We use the architected NOP in arch_static_branch, so there's no
-	 * need to patch an identical NOP over the top of it here. The core
-	 * will call arch_jump_label_transform from a module notifier if the
-	 * NOP needs to be replaced by a branch.
-	 */
-}
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 20e09056d141..e6694759dbd0 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -39,15 +39,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	patch_text_nosync(addr, &insn, sizeof(insn));
 	mutex_unlock(&text_mutex);
 }
-
-void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	/*
-	 * We use the same instructions in the arch_static_branch and
-	 * arch_static_branch_jump inline functions, so there's no
-	 * need to patch them up here.
-	 * The core will call arch_jump_label_transform  when those
-	 * instructions need to be replaced.
-	 */
-}
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index d764f0d229ab..e808bb8bc0da 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -80,8 +80,3 @@ void arch_jump_label_transform_apply(void)
 {
 	text_poke_sync();
 }
-
-void __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
-						       enum jump_label_type type)
-{
-}
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 68f091ba8443..f5b8ef02d172 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -146,16 +146,3 @@ void arch_jump_label_transform_apply(void)
 	text_poke_finish();
 	mutex_unlock(&text_mutex);
 }
-
-static enum {
-	JL_STATE_START,
-	JL_STATE_NO_UPDATE,
-	JL_STATE_UPDATE,
-} jlstate __initdata_or_module = JL_STATE_START;
-
-__init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
-				      enum jump_label_type type)
-{
-	if (jlstate == JL_STATE_UPDATE)
-		jump_label_transform(entry, type, 1);
-}
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b1ac2948be79..ff8576c00893 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -332,17 +332,9 @@ static int __jump_label_text_reserved(struct jump_entry *iter_start,
 	return 0;
 }
 
-/*
- * Update code which is definitely not currently executing.
- * Architectures which need heavyweight synchronization to modify
- * running code can override this to make the non-live update case
- * cheaper.
- */
-void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
-					    enum jump_label_type type)
-{
-	arch_jump_label_transform(entry, type);
-}
+#ifndef arch_jump_label_transform_static
+#define arch_jump_label_transform_static(entry, type)
+#endif
 
 static inline struct jump_entry *static_key_entries(struct static_key *key)
 {
-- 
2.30.2

