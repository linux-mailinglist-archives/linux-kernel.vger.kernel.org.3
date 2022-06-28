Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD855C5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiF1HJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiF1HJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:09:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012BB1F7;
        Tue, 28 Jun 2022 00:09:14 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:09:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy+XD8mz3VN2o4J93LZY58fy3wWA/2D2rYBycdqgE3Y=;
        b=VYFOgEcFpTunWGY78MJd9ksH2o+W7h+tSwJ3XL212fwsOCa6DCnB/A9kcwDhh0hvG0a4/y
        6gk+rp7bYLWJCmCAAmpk1Wojs+0C2RlGt/FWoypks260HYm0L7DRYKMA0nIDENzI3noI0k
        a48O1A7Uia/GQcrHH9eVGQ8g8plvhArfmAqVHdKL12Di+if8DKSHLzhn/lwdqThZyRopG9
        /IwCutn6ByFbIQn21Q1e11kThznlB/UrrogJGd/buB4DyHdj/bmiQs34sFNuyJRZ/2v98Z
        Qm2TLJKf7KzLtYLvPjildnrLwh7gehCu8kMsvEh6bPdzGP1vV840BadwE+8k0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy+XD8mz3VN2o4J93LZY58fy3wWA/2D2rYBycdqgE3Y=;
        b=BFxiW9nUoUD122GOoi6aDoNrWjCw0fxCFdT5Z+RArFI3hEYADHmeKYZfYk/2NxPwjwlNGV
        WjrwuxHt4225FzCg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: make initial NOP patching the special case
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220615154142.1574619-4-ardb@kernel.org>
References: <20220615154142.1574619-4-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <165640015213.4207.5782268583305110396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7e6b9db27de9f69a705c1a046d45882c768e16c3
Gitweb:        https://git.kernel.org/tip/7e6b9db27de9f69a705c1a046d45882c768e16c3
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 15 Jun 2022 17:41:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Jun 2022 09:48:55 +02:00

jump_label: make initial NOP patching the special case

Instead of defaulting to patching NOP opcodes at init time, and leaving
it to the architectures to override this if this is not needed, switch
to a model where doing nothing is the default. This is the common case
by far, as only MIPS requires NOP patching at init time. On all other
architectures, the correct encodings are emitted by the compiler and so
no initial patching is needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220615154142.1574619-4-ardb@kernel.org
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
 include/linux/jump_label.h            |  2 --
 kernel/jump_label.c                   | 14 +++++---------
 11 files changed, 7 insertions(+), 85 deletions(-)

diff --git a/Documentation/staging/static-keys.rst b/Documentation/staging/static-keys.rst
index 38290b9..b0a519f 100644
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
index b8600dc..70b74a5 100644
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
index 303b3ab..eb9c24b 100644
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
index fc98037..faf88ec 100644
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
index 3185fd3..c5c6864 100644
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
index d2f3cb1..e253b13 100644
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
index 20e0905..e669475 100644
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
index d764f0d..e808bb8 100644
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
index 68f091b..f5b8ef0 100644
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
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2003a09..570831c 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -220,8 +220,6 @@ extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
 				      enum jump_label_type type);
-extern void arch_jump_label_transform_static(struct jump_entry *entry,
-					     enum jump_label_type type);
 extern bool arch_jump_label_transform_queue(struct jump_entry *entry,
 					    enum jump_label_type type);
 extern void arch_jump_label_transform_apply(void);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b1ac294..714ac4c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -332,17 +332,13 @@ static int __jump_label_text_reserved(struct jump_entry *iter_start,
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
+#ifndef arch_jump_label_transform_static
+static void arch_jump_label_transform_static(struct jump_entry *entry,
+					     enum jump_label_type type)
 {
-	arch_jump_label_transform(entry, type);
+	/* nothing to do on most architectures */
 }
+#endif
 
 static inline struct jump_entry *static_key_entries(struct static_key *key)
 {
