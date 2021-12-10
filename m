Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC446FF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhLJLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:08:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbhLJLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:53 -0500
Date:   Fri, 10 Dec 2021 11:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639134317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfJkQqJBW+lIt19T6oBxxvHclw7Mu9VaDOyOcY/p8C4=;
        b=QKs8bpQYNXi6McxNZnSE2Ss8jAA/bOzjyRlFhVqVwQYHZSgw6xHLfxP0FZaCiiOdGvj8hM
        bdcFpWRAeVU1EQYpL7R7LC2H6UXq5pdPdW6dMsdf4ZwJBOxNGCTz2jpilicEBaChyj8VuC
        SK222dHU4SKOJREGL/UA7ipHbnbsa0D9W23/AAfYYlBw3eF4bPGiN8GKzr43y8h7xsFX6C
        pc0irq9AwOFy0idMN0ACmeeXbA0nGoiubKNbT9vMZDtRx9DujzElI6YDL0fR/+KwTbqRRm
        loGariyhBiN+1b/Wl1L+71/pN+3xhrlYX+l0EqiW9EUDVHQ/JcSSW6vsUAy49A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639134317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfJkQqJBW+lIt19T6oBxxvHclw7Mu9VaDOyOcY/p8C4=;
        b=OifokVbsndQHeL5RyMTPuikP1CRbNRucT6tHbpczpWwZ0+xYgsKci4fg6ef9CMBWyywxpl
        feZmUp9dQ1KnHqBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add straight-line-speculation validation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211204134908.023037659@infradead.org>
References: <20211204134908.023037659@infradead.org>
MIME-Version: 1.0
Message-ID: <163913431630.23020.14198515120467250046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1cc1e4c8aab4213bd4e6353dec2620476a233d6d
Gitweb:        https://git.kernel.org/tip/1cc1e4c8aab4213bd4e6353dec2620476a233d6d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Dec 2021 14:43:42 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 19:26:50 +01:00

objtool: Add straight-line-speculation validation

Teach objtool to validate the straight-line-speculation constraints:

 - speculation trap after indirect calls
 - speculation trap after RET

Notable: when an instruction is annotated RETPOLINE_SAFE, indicating
  speculation isn't a problem, also don't care about sls for that
  instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211204134908.023037659@infradead.org
---
 tools/objtool/arch/x86/decode.c         | 13 +++++++++----
 tools/objtool/builtin-check.c           |  3 ++-
 tools/objtool/check.c                   | 14 ++++++++++++++
 tools/objtool/include/objtool/arch.h    |  1 +
 tools/objtool/include/objtool/builtin.h |  2 +-
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4d6d7fc..c10ef78 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -531,6 +531,11 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		}
 		break;
 
+	case 0xcc:
+		/* int3 */
+		*type = INSN_TRAP;
+		break;
+
 	case 0xe3:
 		/* jecxz/jrcxz */
 		*type = INSN_JUMP_CONDITIONAL;
@@ -697,10 +702,10 @@ const char *arch_ret_insn(int len)
 {
 	static const char ret[5][5] = {
 		{ BYTE_RET },
-		{ BYTE_RET, BYTES_NOP1 },
-		{ BYTE_RET, BYTES_NOP2 },
-		{ BYTE_RET, BYTES_NOP3 },
-		{ BYTE_RET, BYTES_NOP4 },
+		{ BYTE_RET, 0xcc },
+		{ BYTE_RET, 0xcc, BYTES_NOP1 },
+		{ BYTE_RET, 0xcc, BYTES_NOP2 },
+		{ BYTE_RET, 0xcc, BYTES_NOP3 },
 	};
 
 	if (len < 1 || len > 5) {
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 8b38b5d..38070f2 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,7 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     validate_dup, vmlinux, mcount, noinstr, backup;
+     validate_dup, vmlinux, mcount, noinstr, backup, sls;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -45,6 +45,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
+	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2173582..e28172f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3084,6 +3084,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (next_insn && next_insn->type == INSN_TRAP) {
+				next_insn->ignore = true;
+			} else if (sls && !insn->retpoline_safe) {
+				WARN_FUNC("missing int3 after ret",
+					  insn->sec, insn->offset);
+			}
 			return validate_return(func, insn, &state);
 
 		case INSN_CALL:
@@ -3127,6 +3133,14 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
+			if (next_insn && next_insn->type == INSN_TRAP) {
+				next_insn->ignore = true;
+			} else if (sls && !insn->retpoline_safe) {
+				WARN_FUNC("missing int3 after indirect jump",
+					  insn->sec, insn->offset);
+			}
+
+			/* fallthrough */
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(file, insn, &state);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 589ff58..76bae30 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -26,6 +26,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_TRAP,
 	INSN_OTHER,
 };
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 15ac0b7..89ba869 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup;
+            validate_dup, vmlinux, mcount, noinstr, backup, sls;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
