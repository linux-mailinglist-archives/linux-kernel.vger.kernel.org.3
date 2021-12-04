Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C903846852B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385137AbhLDNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbhLDNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:55:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E45C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3Mq3MPRzhEpLdFTDP2gw0OlbLcjiym+uTPQaYhoXpJY=; b=a0h1sfhRsHmbeIgkMwrWZ3K53+
        HD8zIf6xHfVbaEsA4Cn9iKL3lPIh5z3vJlrn0dCX/c5f70lHeV+Xcz6KM50xAp9L6E9Zuz3z0ong7
        brfhCkJxzxYd6HI9Je58uA3krHbATm4+hciM5fClPmLa5TlTUmIBaLYU0SG/DrSJDgWP/Swi5iXYy
        2PGZPMlpYbthKsm0jXSHhBeafEeYDRus5kFU1V6BsX6ZFhOSO2gUku2zHnC0//141ErZ00p6rE0b+
        rdd+JgMj65PrGRE4zCjg+S2hg5ggY6Djoee2+glktwOrER0g9GFKsw/e8PDdxPp1cHSqi5f1YT5Sv
        nUC8FCCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtVRm-002CkU-6G; Sat, 04 Dec 2021 13:51:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5E0C3004E7;
        Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 84C1F2DD2562A; Sat,  4 Dec 2021 14:51:24 +0100 (CET)
Message-ID: <20211204134908.023037659@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 04 Dec 2021 14:43:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v2 4/6] objtool: Add straight-line-speculation validation
References: <20211204134338.760603010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to validate the straight-line-speculation constraints:

 - speculation trap after indirect calls
 - speculation trap after ret

Notable: when an instruction is annotated RETPOLINE_SAFE, indicating
  speculation isn't a problem, also don't care about sls for that
  instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c         |   13 +++++++++----
 tools/objtool/builtin-check.c           |    3 ++-
 tools/objtool/check.c                   |   14 ++++++++++++++
 tools/objtool/include/objtool/arch.h    |    1 +
 tools/objtool/include/objtool/builtin.h |    2 +-
 5 files changed, 27 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -531,6 +531,11 @@ int arch_decode_instruction(struct objto
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
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3084,6 +3084,12 @@ static int validate_branch(struct objtoo
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
@@ -3127,6 +3133,14 @@ static int validate_branch(struct objtoo
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
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -26,6 +26,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_TRAP,
 	INSN_OTHER,
 };
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup;
+            validate_dup, vmlinux, mcount, noinstr, backup, sls;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 


