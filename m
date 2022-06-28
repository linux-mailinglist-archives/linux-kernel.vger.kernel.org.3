Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F155CEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiF1HJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiF1HJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD289FDD;
        Tue, 28 Jun 2022 00:09:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:09:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgpa+GS2NOqfAar7IJ31QaA1euzHBhmjkKYbQS/Wltw=;
        b=cTEkBDdFrYiOpqdGHRKw1gFXpRLQMfHoBKo9Yf9u6uWG/ZshndbhyPRN2zHAnHhKFJZPev
        EScp08s0pdB/fGWxcfMUlY5tBU8b/oLRaiKkn7arEvsEksnDo6B0AudsTwUXau5YNJq6Vw
        9VCUwQRzLW85xdgkEKxrb8BbZdTIqoN/Pyq1QpHLcG642VJf7nKNeZ8c9VRmPkqbskUUpo
        QhE3Iuxl57jvDqSe7JXWXdJV1p+5rXJ2fxf7r0GQNKofJm46baaJfmepAKrYo8H65fNvMe
        B/cFu68yTj1nakjSgr2X7A3FG/Cdy6ex5F6QqL5qEHBOzJ9ubpcS2IKy24H/2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgpa+GS2NOqfAar7IJ31QaA1euzHBhmjkKYbQS/Wltw=;
        b=fFPYbQPHfSZdQUiDl7kwfkMNMZgp3tml4dtwRfw1rkUkmKXSbtdE4d/kvQ4D7pBHktFDGz
        RQq1NyElQkIfbUBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: s390: avoid pointless initial NOP patching
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220615154142.1574619-2-ardb@kernel.org>
References: <20220615154142.1574619-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <165640015422.4207.10034265393643139435.tip-bot2@tip-bot2>
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

Commit-ID:     0c3b61e00a0d0872c521586494ec23f6016c317a
Gitweb:        https://git.kernel.org/tip/0c3b61e00a0d0872c521586494ec23f6016c317a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 15 Jun 2022 17:41:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Jun 2022 09:48:54 +02:00

jump_label: s390: avoid pointless initial NOP patching

Patching NOPs into other NOPs at boot time serves no purpose, so let's
use the same NOP encodings at compile time and runtime.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220615154142.1574619-2-ardb@kernel.org
---
 arch/s390/include/asm/jump_label.h |  5 ++---
 arch/s390/kernel/jump_label.c      | 23 +++++------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 916cfcb..895f774 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -10,7 +10,6 @@
 #include <linux/stringify.h>
 
 #define JUMP_LABEL_NOP_SIZE 6
-#define JUMP_LABEL_NOP_OFFSET 2
 
 #ifdef CONFIG_CC_IS_CLANG
 #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
@@ -21,12 +20,12 @@
 #endif
 
 /*
- * We use a brcl 0,2 instruction for jump labels at compile time so it
+ * We use a brcl 0,<offset> instruction for jump labels so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+	asm_volatile_goto("0:	brcl 0,%l[label]\n"
 			  ".pushsection __jump_table,\"aw\"\n"
 			  ".balign	8\n"
 			  ".long	0b-.,%l[label]-.\n"
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 6bec000..d764f0d 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -44,14 +44,8 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 	panic("Corrupted kernel text");
 }
 
-static struct insn orignop = {
-	.opcode = 0xc004,
-	.offset = JUMP_LABEL_NOP_OFFSET >> 1,
-};
-
 static void jump_label_transform(struct jump_entry *entry,
-				 enum jump_label_type type,
-				 int init)
+				 enum jump_label_type type)
 {
 	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
@@ -63,27 +57,22 @@ static void jump_label_transform(struct jump_entry *entry,
 		jump_label_make_branch(entry, &old);
 		jump_label_make_nop(entry, &new);
 	}
-	if (init) {
-		if (memcmp(code, &orignop, sizeof(orignop)))
-			jump_label_bug(entry, &orignop, &new);
-	} else {
-		if (memcmp(code, &old, sizeof(old)))
-			jump_label_bug(entry, &old, &new);
-	}
+	if (memcmp(code, &old, sizeof(old)))
+		jump_label_bug(entry, &old, &new);
 	s390_kernel_write(code, &new, sizeof(new));
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 0);
+	jump_label_transform(entry, type);
 	text_poke_sync();
 }
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 0);
+	jump_label_transform(entry, type);
 	return true;
 }
 
@@ -95,6 +84,4 @@ void arch_jump_label_transform_apply(void)
 void __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
 						       enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 1);
-	text_poke_sync();
 }
