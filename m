Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84802468527
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbhLDNzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLDNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:55:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11CC0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=riiiYROrrVBFujSWLh3fK1mjpDCb2VUBgV91y4GbMc4=; b=oJl0NiZirJR/EyJCfiSAckuwnJ
        32vggRcOCaRNcA192O5wCSaGBmMtnYXXKulzmNM4kcevgXz1I87khe0nIssW30JGABI+/PtWv5UBd
        hN42pzQ7JhsVevIhp8scsA0ZdR2iG61exNPYN6iaHYyRvHsA9AQtj/WF8kab4DH7G6vqd7Q3ARI4Z
        XWvRhKVWV6EAdESv0V6ipYdG2JTimECKZdTRf6iaHzkdrmAjsIe8nBAnYRMUDpm4Y+x+A6v4ixO+6
        uJVJj2em8njStM4QOWJ8Bz8Mb7QyRT5uYAfzxCB3RVsn5iHSULx49TIDyCsrx8xGLwdPkn+u6d8ns
        wFRU7wNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtVRm-00DG3K-2v; Sat, 04 Dec 2021 13:51:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23458300792;
        Sat,  4 Dec 2021 14:51:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 87FBA2DD2562C; Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Message-ID: <20211204134908.082342723@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 04 Dec 2021 14:43:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v2 5/6] x86/alternative: Relax text_poke_bp() constraint
References: <20211204134338.760603010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently text_poke_bp() is very strict to only allow patching a
single instruction; however with straight-line-speculation it will be
required to patch: ret; int3, which is two instructions.

As such, relax the constraints a little to allow int3 padding for all
instructions that do not imply the execution of the next instruction,
ie: RET, JMP.d8 and JMP.d32.

While there, rename the text_poke_loc::rel32 field to ::disp.

Note: this fills up the text_poke_loc structure which is now a round
  16 bytes big.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   44 ++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1114,10 +1114,11 @@ void text_poke_sync(void)
 
 struct text_poke_loc {
 	s32 rel_addr; /* addr := _stext + rel_addr */
-	s32 rel32;
+	s32 disp;
+	u8 len;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
-	u8 old;
+	u8 old; /* see text_poke_bp_batch() */
 };
 
 struct bp_patching_desc {
@@ -1165,7 +1166,7 @@ noinstr int poke_int3_handler(struct pt_
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
-	int len, ret = 0;
+	int ret = 0;
 	void *ip;
 
 	if (user_mode(regs))
@@ -1205,8 +1206,7 @@ noinstr int poke_int3_handler(struct pt_
 			goto out_put;
 	}
 
-	len = text_opcode_size(tp->opcode);
-	ip += len;
+	ip += tp->len;
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
@@ -1221,12 +1221,12 @@ noinstr int poke_int3_handler(struct pt_
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
@@ -1301,7 +1301,7 @@ static void text_poke_bp_batch(struct te
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
-		int len = text_opcode_size(tp[i].opcode);
+		int len = tp[i].len;
 
 		if (len - INT3_INSN_SIZE > 0) {
 			memcpy(old + INT3_INSN_SIZE,
@@ -1378,20 +1378,36 @@ static void text_poke_loc_init(struct te
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
 
+	switch(tp->opcode) {
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
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
@@ -1400,7 +1416,7 @@ static void text_poke_loc_init(struct te
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		tp->rel32 = insn.immediate.value;
+		tp->disp = insn.immediate.value;
 		break;
 
 	default: /* assume NOP */
@@ -1408,13 +1424,13 @@ static void text_poke_loc_init(struct te
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


