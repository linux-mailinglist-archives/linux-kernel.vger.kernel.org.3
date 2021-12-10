Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76646FF59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhLJLIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:08:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbhLJLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:53 -0500
Date:   Fri, 10 Dec 2021 11:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qw5aHKxzpF47ZaQY0VcCOGzbwKppaFE1f3Z0nSAZRw=;
        b=pjt93j1ofyXQ6QAqLntHbAZzimwpjgSfu8E7Trotg/t8luXLmugBsRGItdJPT816WlUcu9
        MHkN0A4x/ugEEPd17Iz0CHxx/JcMMXqFpfDq3g3oJEJ0DlAyCWAs3YQtwPLpRFbSqU/VWj
        qg9wrYS23FsIFyqFzhwWvyTyZsTX2a2g9PlIT2urPgWDY0Xx8bHkn9xSRSGPxcDVSlk5nN
        oXkrAyCPVzkq2KrhkGUslClrDoHeIH0GVP7n0oPjj6RsYSc9sIyZLyrNOLblprl/kBa1Yi
        qYnJv6IqPk01Yb3Uh1zc1tMMi5YV6+7R2tieKtbSwkjvITKzF/jPYA6OiGwuPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qw5aHKxzpF47ZaQY0VcCOGzbwKppaFE1f3Z0nSAZRw=;
        b=V4bm3zhPplQZJeAjBHcP6tKNBzrJhStePO+CqlGi9ymTD0NJ5F4a3wuB83IKgmQmtqGQYq
        sahuBmjmMxZboqDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Relax text_poke_bp() constraint
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134908.082342723@infradead.org>
References: <20211204134908.082342723@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431544.23020.14669039851912666888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     26c44b776dba4ac692a0bf5a3836feb8a63fea6b
Gitweb:        https://git.kernel.org/tip/26c44b776dba4ac692a0bf5a3836feb8a63fea6b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:43 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 09 Dec 2021 11:04:50 +01:00

x86/alternative: Relax text_poke_bp() constraint

Currently, text_poke_bp() is very strict to only allow patching a
single instruction; however with straight-line-speculation it will be
required to patch: ret; int3, which is two instructions.

As such, relax the constraints a little to allow int3 padding for all
instructions that do not imply the execution of the next instruction,
ie: RET, JMP.d8 and JMP.d32.

While there, rename the text_poke_loc::rel32 field to ::disp.

Note: this fills up the text_poke_loc structure which is now a round
  16 bytes big.

  [ bp: Put comments ontop instead of on the side. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134908.082342723@infradead.org
---
 arch/x86/kernel/alternative.c | 49 +++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 175cde6..5007c3f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1113,10 +1113,13 @@ void text_poke_sync(void)
 }
 
 struct text_poke_loc {
-	s32 rel_addr; /* addr := _stext + rel_addr */
-	s32 rel32;
+	/* addr := _stext + rel_addr */
+	s32 rel_addr;
+	s32 disp;
+	u8 len;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
+	/* see text_poke_bp_batch() */
 	u8 old;
 };
 
@@ -1131,7 +1134,8 @@ static struct bp_patching_desc *bp_desc;
 static __always_inline
 struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
-	struct bp_patching_desc *desc = __READ_ONCE(*descp); /* rcu_dereference */
+	/* rcu_dereference */
+	struct bp_patching_desc *desc = __READ_ONCE(*descp);
 
 	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
 		return NULL;
@@ -1165,7 +1169,7 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
-	int len, ret = 0;
+	int ret = 0;
 	void *ip;
 
 	if (user_mode(regs))
@@ -1205,8 +1209,7 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 			goto out_put;
 	}
 
-	len = text_opcode_size(tp->opcode);
-	ip += len;
+	ip += tp->len;
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
@@ -1221,12 +1224,12 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		break;
 
 	case CALL_INSN_OPCODE:
-		int3_emulate_call(regs, (long)ip + tp->rel32);
+		int3_emulate_call(regs, (long)ip + tp->disp);
 		break;
 
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		int3_emulate_jmp(regs, (long)ip + tp->rel32);
+		int3_emulate_jmp(regs, (long)ip + tp->disp);
 		break;
 
 	default:
@@ -1301,7 +1304,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
-		int len = text_opcode_size(tp[i].opcode);
+		int len = tp[i].len;
 
 		if (len - INT3_INSN_SIZE > 0) {
 			memcpy(old + INT3_INSN_SIZE,
@@ -1378,21 +1381,37 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
-	int ret;
+	int ret, i;
 
 	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;
 
 	ret = insn_decode_kernel(&insn, emulate);
-
 	BUG_ON(ret < 0);
-	BUG_ON(len != insn.length);
 
 	tp->rel_addr = addr - (void *)_stext;
+	tp->len = len;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
+	case RET_INSN_OPCODE:
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		/*
+		 * Control flow instructions without implied execution of the
+		 * next instruction can be padded with INT3.
+		 */
+		for (i = insn.length; i < len; i++)
+			BUG_ON(tp->text[i] != INT3_INSN_OPCODE);
+		break;
+
+	default:
+		BUG_ON(len != insn.length);
+	};
+
+
+	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
 		break;
@@ -1400,7 +1419,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		tp->rel32 = insn.immediate.value;
+		tp->disp = insn.immediate.value;
 		break;
 
 	default: /* assume NOP */
@@ -1408,13 +1427,13 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 		case 2: /* NOP2 -- emulate as JMP8+0 */
 			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP8_INSN_OPCODE;
-			tp->rel32 = 0;
+			tp->disp = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
 			BUG_ON(memcmp(emulate, x86_nops[len], len));
 			tp->opcode = JMP32_INSN_OPCODE;
-			tp->rel32 = 0;
+			tp->disp = 0;
 			break;
 
 		default: /* unknown instruction */
