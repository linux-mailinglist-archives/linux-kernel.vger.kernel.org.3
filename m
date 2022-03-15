Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C44D998E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiCOKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiCOKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4F50E3E;
        Tue, 15 Mar 2022 03:44:13 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKm8bnnr+rW/jkTW5jITWcTDsplyawMvoVH4+3yWbVI=;
        b=jKn06OsmQHktFyw+cl4B34KhIbAzxHgB8e8cp9lrWxASIPsq4hhlyAA8PJ3WLYiwwJFdxQ
        p7c1QmLs1o6vQl9jdr38MpnweRNnLIb4tLWkmARnJLMHciEU/HM2rNW+1ILk6hMPLj5Y9W
        teQIQ0EFCjzcPyBfQOHJzPHqiJXXMBpzWJhWvH5cRSjtPt6mWnmlHLHvqBuQLnRpRkYH6F
        zvXhKwa0l1myPdjbyu8hAqPWKkQm0t3SFzp03pRungjM8q4RCUzRBzeJX09jrtqcW3bIOa
        ODRAUmX84igtFVCwkNCXwUpDhHiUR4aSXmdLnw3zhSyiMSDNWseaJwAY3N1kdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKm8bnnr+rW/jkTW5jITWcTDsplyawMvoVH4+3yWbVI=;
        b=FjrTUpKaclw9y2LhrIrj0tusTydoGVC98eyBU22T7I+p9QxlmP5KZW6pUwtCEhB32WpxSu
        EH2YVy+5v+v7a+CA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.697253958@infradead.org>
References: <20220308154317.697253958@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105064.16921.15259204948431866651.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ba27d1a80871eb8dbeddf34ec7d396c149cbb8d7
Gitweb:        https://git.kernel.org/tip/ba27d1a80871eb8dbeddf34ec7d396c149cbb8d7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:34 +01:00

x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()

Less duplication is more better.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.697253958@infradead.org
---
 arch/x86/include/asm/text-patching.h | 20 ++++++++++++++------
 arch/x86/kernel/paravirt.c           | 23 +++--------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 1c4cfb1..c6015b4 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -96,32 +96,40 @@ union text_poke_insn {
 };
 
 static __always_inline
-void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+void __text_gen_insn(void *buf, u8 opcode, const void *addr, const void *dest, int size)
 {
-	static union text_poke_insn insn; /* per instance */
-	int size = text_opcode_size(opcode);
+	union text_poke_insn *insn = buf;
+
+	BUG_ON(size < text_opcode_size(opcode));
 
 	/*
 	 * Hide the addresses to avoid the compiler folding in constants when
 	 * referencing code, these can mess up annotations like
 	 * ANNOTATE_NOENDBR.
 	 */
+	OPTIMIZER_HIDE_VAR(insn);
 	OPTIMIZER_HIDE_VAR(addr);
 	OPTIMIZER_HIDE_VAR(dest);
 
-	insn.opcode = opcode;
+	insn->opcode = opcode;
 
 	if (size > 1) {
-		insn.disp = (long)dest - (long)(addr + size);
+		insn->disp = (long)dest - (long)(addr + size);
 		if (size == 2) {
 			/*
 			 * Ensure that for JMP8 the displacement
 			 * actually fits the signed byte.
 			 */
-			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+			BUG_ON((insn->disp >> 31) != (insn->disp >> 7));
 		}
 	}
+}
 
+static __always_inline
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* per instance */
+	__text_gen_insn(&insn, opcode, addr, dest, text_opcode_size(opcode));
 	return &insn.text;
 }
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4420499..06af2cf 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -69,29 +69,12 @@ noinstr void paravirt_BUG(void)
 	BUG();
 }
 
-struct branch {
-	unsigned char opcode;
-	u32 delta;
-} __attribute__((packed));
-
 static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 				    unsigned long addr, unsigned len)
 {
-	const int call_len = 5;
-	struct branch *b = insn_buff;
-	unsigned long delta = (unsigned long)target - (addr+call_len);
-
-	if (len < call_len) {
-		pr_warn("paravirt: Failed to patch indirect CALL at %ps\n", (void *)addr);
-		/* Kernel might not be viable if patching fails, bail out: */
-		BUG_ON(1);
-	}
-
-	b->opcode = 0xe8; /* call */
-	b->delta = delta;
-	BUILD_BUG_ON(sizeof(*b) != call_len);
-
-	return call_len;
+	__text_gen_insn(insn_buff, CALL_INSN_OPCODE,
+			(void *)addr, target, CALL_INSN_SIZE);
+	return CALL_INSN_SIZE;
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
