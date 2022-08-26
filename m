Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA115A31D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiHZWQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbiHZWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:16:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C73D8E32;
        Fri, 26 Aug 2022 15:16:01 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jiWlfnR4Dc+1x5LbQ2rXbcpOpfQk5sT6NEo3T1ZOvg=;
        b=drCABWJmfe+RyFRBjv3tJCc45MacNgGKjMaHHcT9m7ygsgBILAOku628cHlXjl350Vjbuv
        ltwjlYGOTD3pGK0EYHz2Rip5Lk0gPvTNIMzZzmoSeykWhloOomz3393ZgeqIz8sIRsg+tp
        sPu4617l2N3KB9+trzQ335hM9opxDeQxRBFYZ+0Sfp0N7gDed/UaeHk3q3Z13yb3kR9F6L
        jS+fHsWDm3G5mziKLB4i4RdkdK7D56J03pDj+I3wtJmcwrggLjT/QIjXXI9ebUSYDEvrIL
        0IJ4VwgL6xkxIOAOhV+idy0yr0fRk/i/VvYcloJLWknIOOWFQ72eMh1irPmnDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jiWlfnR4Dc+1x5LbQ2rXbcpOpfQk5sT6NEo3T1ZOvg=;
        b=4k3jRhn+DK5eZHWUI6W6lM6vtK9iBjNPR0/pCJw6Bxl95bUOcFb4TCL/FLYq6Hyvzl/Y1S
        l5sq4XWz2u06c7Aw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Make branch classifier fusion-aware
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb6bb0abaa8a54c0b6d716344700ee11a1793d709=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb6bb0abaa8a54c0b6d716344700ee11a1793d709=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155215807.401.15488868627967329609.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     df3e9612f758fb5f9c251cbe262e3c68ffe67b2c
Gitweb:        https://git.kernel.org/tip/df3e9612f758fb5f9c251cbe262e3c68ffe67b2c
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:58 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:44 +02:00

perf/x86: Make branch classifier fusion-aware

With branch fusion and other optimizations, branch sampling hardware in
some processors can report a branch from address that points to an
instruction preceding the actual branch by several bytes.

In such cases, the classifier cannot determine the branch type which leads
to failures such as with the recently added test from commit b55878c90ab9
("perf test: Add test for branch stack sampling"). Branch information is
also easier to consume and annotate if branch from addresses always point
to branch instructions.

Add a new variant of the branch classifier that can account for instruction
fusion. If fusion is expected and the current branch from address does not
point to a branch instruction, it attempts to find the first branch within
the next (MAX_INSN_SIZE - 1) bytes and if found, additionally provides the
offset between the reported branch from address and the address of the
expected branch instruction.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/b6bb0abaa8a54c0b6d716344700ee11a1793d709.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/perf_event.h |   2 +-
 arch/x86/events/utils.c      | 169 ++++++++++++++++++++--------------
 2 files changed, 102 insertions(+), 69 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2de9cd6..93263b9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1271,6 +1271,8 @@ enum {
 
 int common_branch_type(int type);
 int branch_type(unsigned long from, unsigned long to, int abort);
+int branch_type_fused(unsigned long from, unsigned long to, int abort,
+		      int *offset);
 
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index a323689..e013243 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -3,6 +3,68 @@
 
 #include "perf_event.h"
 
+static int decode_branch_type(struct insn *insn)
+{
+	int ext;
+
+	if (insn_get_opcode(insn))
+		return X86_BR_ABORT;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0xf:
+		switch (insn->opcode.bytes[1]) {
+		case 0x05: /* syscall */
+		case 0x34: /* sysenter */
+			return X86_BR_SYSCALL;
+		case 0x07: /* sysret */
+		case 0x35: /* sysexit */
+			return X86_BR_SYSRET;
+		case 0x80 ... 0x8f: /* conditional */
+			return X86_BR_JCC;
+		}
+		return X86_BR_NONE;
+	case 0x70 ... 0x7f: /* conditional */
+		return X86_BR_JCC;
+	case 0xc2: /* near ret */
+	case 0xc3: /* near ret */
+	case 0xca: /* far ret */
+	case 0xcb: /* far ret */
+		return X86_BR_RET;
+	case 0xcf: /* iret */
+		return X86_BR_IRET;
+	case 0xcc ... 0xce: /* int */
+		return X86_BR_INT;
+	case 0xe8: /* call near rel */
+		if (insn_get_immediate(insn) || insn->immediate1.value == 0) {
+			/* zero length call */
+			return X86_BR_ZERO_CALL;
+		}
+		fallthrough;
+	case 0x9a: /* call far absolute */
+		return X86_BR_CALL;
+	case 0xe0 ... 0xe3: /* loop jmp */
+		return X86_BR_JCC;
+	case 0xe9 ... 0xeb: /* jmp */
+		return X86_BR_JMP;
+	case 0xff: /* call near absolute, call far absolute ind */
+		if (insn_get_modrm(insn))
+			return X86_BR_ABORT;
+
+		ext = (insn->modrm.bytes[0] >> 3) & 0x7;
+		switch (ext) {
+		case 2: /* near ind call */
+		case 3: /* far ind call */
+			return X86_BR_IND_CALL;
+		case 4:
+		case 5:
+			return X86_BR_IND_JMP;
+		}
+		return X86_BR_NONE;
+	}
+
+	return X86_BR_NONE;
+}
+
 /*
  * return the type of control flow change at address "from"
  * instruction is not necessarily a branch (in case of interrupt).
@@ -13,14 +75,22 @@
  * If a branch type is unknown OR the instruction cannot be
  * decoded (e.g., text page not present), then X86_BR_NONE is
  * returned.
+ *
+ * While recording branches, some processors can report the "from"
+ * address to be that of an instruction preceding the actual branch
+ * when instruction fusion occurs. If fusion is expected, attempt to
+ * find the type of the first branch instruction within the next
+ * MAX_INSN_SIZE bytes and if found, provide the offset between the
+ * reported "from" address and the actual branch instruction address.
  */
-int branch_type(unsigned long from, unsigned long to, int abort)
+static int get_branch_type(unsigned long from, unsigned long to, int abort,
+			   bool fused, int *offset)
 {
 	struct insn insn;
 	void *addr;
-	int bytes_read, bytes_left;
+	int bytes_read, bytes_left, insn_offset;
 	int ret = X86_BR_NONE;
-	int ext, to_plm, from_plm;
+	int to_plm, from_plm;
 	u8 buf[MAX_INSN_SIZE];
 	int is64 = 0;
 
@@ -83,77 +153,27 @@ int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	if (insn_get_opcode(&insn))
-		return X86_BR_ABORT;
+	ret = decode_branch_type(&insn);
+	insn_offset = 0;
 
-	switch (insn.opcode.bytes[0]) {
-	case 0xf:
-		switch (insn.opcode.bytes[1]) {
-		case 0x05: /* syscall */
-		case 0x34: /* sysenter */
-			ret = X86_BR_SYSCALL;
-			break;
-		case 0x07: /* sysret */
-		case 0x35: /* sysexit */
-			ret = X86_BR_SYSRET;
-			break;
-		case 0x80 ... 0x8f: /* conditional */
-			ret = X86_BR_JCC;
-			break;
-		default:
-			ret = X86_BR_NONE;
-		}
-		break;
-	case 0x70 ... 0x7f: /* conditional */
-		ret = X86_BR_JCC;
-		break;
-	case 0xc2: /* near ret */
-	case 0xc3: /* near ret */
-	case 0xca: /* far ret */
-	case 0xcb: /* far ret */
-		ret = X86_BR_RET;
-		break;
-	case 0xcf: /* iret */
-		ret = X86_BR_IRET;
-		break;
-	case 0xcc ... 0xce: /* int */
-		ret = X86_BR_INT;
-		break;
-	case 0xe8: /* call near rel */
-		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
-			/* zero length call */
-			ret = X86_BR_ZERO_CALL;
+	/* Check for the possibility of branch fusion */
+	while (fused && ret == X86_BR_NONE) {
+		/* Check for decoding errors */
+		if (insn_get_length(&insn) || !insn.length)
 			break;
-		}
-		fallthrough;
-	case 0x9a: /* call far absolute */
-		ret = X86_BR_CALL;
-		break;
-	case 0xe0 ... 0xe3: /* loop jmp */
-		ret = X86_BR_JCC;
-		break;
-	case 0xe9 ... 0xeb: /* jmp */
-		ret = X86_BR_JMP;
-		break;
-	case 0xff: /* call near absolute, call far absolute ind */
-		if (insn_get_modrm(&insn))
-			return X86_BR_ABORT;
 
-		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
-		switch (ext) {
-		case 2: /* near ind call */
-		case 3: /* far ind call */
-			ret = X86_BR_IND_CALL;
+		insn_offset += insn.length;
+		bytes_read -= insn.length;
+		if (bytes_read < 0)
 			break;
-		case 4:
-		case 5:
-			ret = X86_BR_IND_JMP;
-			break;
-		}
-		break;
-	default:
-		ret = X86_BR_NONE;
+
+		insn_init(&insn, addr + insn_offset, bytes_read, is64);
+		ret = decode_branch_type(&insn);
 	}
+
+	if (offset)
+		*offset = insn_offset;
+
 	/*
 	 * interrupts, traps, faults (and thus ring transition) may
 	 * occur on any instructions. Thus, to classify them correctly,
@@ -179,6 +199,17 @@ int branch_type(unsigned long from, unsigned long to, int abort)
 	return ret;
 }
 
+int branch_type(unsigned long from, unsigned long to, int abort)
+{
+	return get_branch_type(from, to, abort, false, NULL);
+}
+
+int branch_type_fused(unsigned long from, unsigned long to, int abort,
+		      int *offset)
+{
+	return get_branch_type(from, to, abort, true, offset);
+}
+
 #define X86_BR_TYPE_MAP_MAX	16
 
 static int branch_map[X86_BR_TYPE_MAP_MAX] = {
