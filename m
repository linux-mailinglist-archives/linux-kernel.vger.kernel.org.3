Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC0577247
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGPXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiGPXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A191222BD3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:44 -0700 (PDT)
Message-ID: <20220716230953.858048083@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jzk1Ro7moQj4/ZNdqGDe6vOHP2eSGjateMVY4xuPVLw=;
        b=ABOqAJ8ZC4ybwE0awspMk33HahjgcjGnviUBghK+dC9qnrV8SnCm6lTrZMxLuZYupBjdo5
        Hzl79sPZcu8H5By4Ta/YWxKPOR98XlsQNkXAwNbu6+nGGB3HtP4RbT6urZBuBh+Q/byCMC
        c8e1nlgTJBOIxuehEm3qtVTaUogEwUOBFtXCJQp8iwlrQi14uhorOuxqPX/fRn0B+XcsCb
        zeYe6VWHF8ime4A3WbJQv1cnXneJM6BJWPSPA+KtZ5Tv0dLRsd+aBRz9xd3zBOn58vs+up
        cwfBwHa5E1lyiYppeElTRdCes0zp6ZlspRAuR6u9CfJkCNaZVui9SP5l3fOhkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jzk1Ro7moQj4/ZNdqGDe6vOHP2eSGjateMVY4xuPVLw=;
        b=5EUd6EGPJWOJ58Rki0DfMwZwyqF9oxESgWMLkJkvEILhwWyMNNcx9fj+0aX+ajxMHp4A2v
        EBtK/o0Q4h6wJHAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 20/38] x86/alternatives: Provide text_poke_[copy|set]_locked()
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming call thunk patching must hold text_mutex and needs access to
text_poke_copy() and text_poke_set(), which take text_mutex.

Provide _locked postfixed variants to expose the inner workings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/text-patching.h |    2 +
 arch/x86/kernel/alternative.c        |   48 +++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,8 @@ extern void *text_poke(void *addr, const
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
+extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len);
+extern void *text_poke_set_locked(void *addr, int c, size_t len);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1225,6 +1225,26 @@ void *text_poke_kgdb(void *addr, const v
 	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
+void *text_poke_copy_locked(void *addr, const void *opcode, size_t len)
+{
+	unsigned long start = (unsigned long)addr;
+	size_t patched = 0;
+
+	if (WARN_ON_ONCE(core_kernel_text(start)))
+		return NULL;
+
+	while (patched < len) {
+		unsigned long ptr = start + patched;
+		size_t s;
+
+		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
+
+		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
+		patched += s;
+	}
+	return addr;
+}
+
 /**
  * text_poke_copy - Copy instructions into (an unused part of) RX memory
  * @addr: address to modify
@@ -1239,23 +1259,29 @@ void *text_poke_kgdb(void *addr, const v
  */
 void *text_poke_copy(void *addr, const void *opcode, size_t len)
 {
+	mutex_lock(&text_mutex);
+	addr = text_poke_copy_locked(addr, opcode, len);
+	mutex_unlock(&text_mutex);
+	return addr;
+}
+
+void *text_poke_set_locked(void *addr, int c, size_t len)
+{
 	unsigned long start = (unsigned long)addr;
 	size_t patched = 0;
 
 	if (WARN_ON_ONCE(core_kernel_text(start)))
 		return NULL;
 
-	mutex_lock(&text_mutex);
 	while (patched < len) {
 		unsigned long ptr = start + patched;
 		size_t s;
 
 		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
 
-		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
+		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
 		patched += s;
 	}
-	mutex_unlock(&text_mutex);
 	return addr;
 }
 
@@ -1270,22 +1296,8 @@ void *text_poke_copy(void *addr, const v
  */
 void *text_poke_set(void *addr, int c, size_t len)
 {
-	unsigned long start = (unsigned long)addr;
-	size_t patched = 0;
-
-	if (WARN_ON_ONCE(core_kernel_text(start)))
-		return NULL;
-
 	mutex_lock(&text_mutex);
-	while (patched < len) {
-		unsigned long ptr = start + patched;
-		size_t s;
-
-		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
-
-		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
-		patched += s;
-	}
+	addr = text_poke_set_locked(addr, c, len);
 	mutex_unlock(&text_mutex);
 	return addr;
 }

