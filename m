Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA82E507AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357090AbiDSULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356787AbiDSULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20C387AE;
        Tue, 19 Apr 2022 13:08:34 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4f2mUU5Nhzbx4YIfuwYom0MZjYdlhh0Zzh5PnA/Vb0=;
        b=V7arBujfG8YfPX60WEBJjcPobbADilEb0dAsRPno2UoEF1/bR0GfopfrTuqgP1IksqM/SL
        4Dgfv+Xhxg3Fpeld7us+nCRai/Vrt2czRb3tOY0PWz/a52pQBmDSuYG+GrwaRfUTvu4rF0
        Lr8d8TE+lKo56vAf2rnQOO0qO9L6fESqyf6lCZVcgz4Hpw9owzlGXKTIMpxOmMbnyU7KO7
        MASUupqIOtvRWZ0F0arxYDWUgKkI4Xs/Jld2tYbvhjwaYBeuF9qJ4ehvdDRrZcRZi5zhcC
        Mmv7JZSI8SCfueAyVD48u8+z6O5QWVCWZ3JRyp5/BkgPFlASPWijf1985u0u5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4f2mUU5Nhzbx4YIfuwYom0MZjYdlhh0Zzh5PnA/Vb0=;
        b=S4k9HzfvvMocYREhLLDmtL9urbl2byIqjCv8/OeMhUE+9Fj5LJagBY8Zzh0858hZ/qWnzi
        ikpyNV1V4rZe3oCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Don't set 'jump_dest' for sibling calls
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8737d6b9d1691831aed73375f444f0f42da3e2c9.1649718562.git.jpoimboe@redhat.com>
References: <8737d6b9d1691831aed73375f444f0f42da3e2c9.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891242.4207.17901506310697157021.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     26ff604102c98df79c3fe2614d1b9bb068d4c28c
Gitweb:        https://git.kernel.org/tip/26ff604102c98df79c3fe2614d1b9bb068d4c28c
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 11 Apr 2022 16:10:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:53 +02:00

objtool: Don't set 'jump_dest' for sibling calls

For most sibling calls, 'jump_dest' is NULL because objtool treats the
jump like a call and sets 'call_dest'.  But there are a few edge cases
where that's not true.  Make it consistent to avoid unexpected behavior.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8737d6b9d1691831aed73375f444f0f42da3e2c9.1649718562.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c8..6f49278 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1271,7 +1271,7 @@ static bool is_first_func_insn(struct objtool_file *file, struct instruction *in
  */
 static int add_jump_destinations(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *jump_dest;
 	struct reloc *reloc;
 	struct section *dest_sec;
 	unsigned long dest_off;
@@ -1291,7 +1291,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			add_retpoline_call(file, insn);
 			continue;
 		} else if (insn->func) {
-			/* internal or external sibling call (with reloc) */
+			/*
+			 * External sibling call or internal sibling call with
+			 * STT_FUNC reloc.
+			 */
 			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
@@ -1303,8 +1306,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 		}
 
-		insn->jump_dest = find_insn(file, dest_sec, dest_off);
-		if (!insn->jump_dest) {
+		jump_dest = find_insn(file, dest_sec, dest_off);
+		if (!jump_dest) {
 
 			/*
 			 * This is a special case where an alt instruction
@@ -1323,8 +1326,8 @@ static int add_jump_destinations(struct objtool_file *file)
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn->func && insn->jump_dest->func &&
-		    insn->func != insn->jump_dest->func) {
+		if (insn->func && jump_dest->func &&
+		    insn->func != jump_dest->func) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1342,16 +1345,22 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * subfunction is through a jump table.
 			 */
 			if (!strstr(insn->func->name, ".cold") &&
-			    strstr(insn->jump_dest->func->name, ".cold")) {
-				insn->func->cfunc = insn->jump_dest->func;
-				insn->jump_dest->func->pfunc = insn->func;
+			    strstr(jump_dest->func->name, ".cold")) {
+				insn->func->cfunc = jump_dest->func;
+				jump_dest->func->pfunc = insn->func;
 
-			} else if (!same_function(insn, insn->jump_dest) &&
-				   is_first_func_insn(file, insn->jump_dest)) {
-				/* internal sibling call (without reloc) */
-				add_call_dest(file, insn, insn->jump_dest->func, true);
+			} else if (!same_function(insn, jump_dest) &&
+				   is_first_func_insn(file, jump_dest)) {
+				/*
+				 * Internal sibling call without reloc or with
+				 * STT_SECTION reloc.
+				 */
+				add_call_dest(file, insn, jump_dest->func, true);
+				continue;
 			}
 		}
+
+		insn->jump_dest = jump_dest;
 	}
 
 	return 0;
