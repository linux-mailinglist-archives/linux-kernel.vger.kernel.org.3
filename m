Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABE50B54D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446691AbiDVKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446697AbiDVKh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DF63AF;
        Fri, 22 Apr 2022 03:35:05 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bj7AWRAXuFzwqpcPEsf8RO/1aLjEBmc0xxFf/dCWvwA=;
        b=k2jLfSI5hrcPei9s9vbpkNCC+51bQbR8xOukXMvMCzCOow/tyPmghrsju1GBOvs8Sxv+13
        u6XCwHl6UOd6Vfbt7Kf+xgF3e5iNfqFt3Amsio5WvSN7NXbb3IM6XpJehKwa2nt3ofboi6
        WGUiWt3BAUvXICFY0ZuDwmJqWbNYj2vlEqCJyQmmv7uvWvAYRpKWamd4POZ/k501h7fSGA
        l/rMfU4/+DZupQGyGV9JHQoW2irN6y6aVkkZN2hw90kN5///ilsDm90+QDf+3WyNft7buF
        vml8IMerrH0QvdL5e+NO+UMjbrUUpaQIspb9JGamTjg6/Hg6v1XLhwSbK/w19Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bj7AWRAXuFzwqpcPEsf8RO/1aLjEBmc0xxFf/dCWvwA=;
        b=G7aAt52ZjP4iUHwQ10YuBET69iD8vCK19Rz08VNrx4AIOLuVgRtwuRyEihias45CbtrkVI
        Mjr10Y87j+1gFtDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Extricate sls from stack validation
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2545c86ffa5f27497f0d0c542540ad4a4be3c5a5.1650300597.git.jpoimboe@redhat.com>
References: <2545c86ffa5f27497f0d0c542540ad4a4be3c5a5.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370345.4207.10679159280235685523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c2bdd61c98d915ad2cc1f8cd4661fcda1f1e4c16
Gitweb:        https://git.kernel.org/tip/c2bdd61c98d915ad2cc1f8cd4661fcda1f1e4c16
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:03 +02:00

objtool: Extricate sls from stack validation

Extricate sls functionality from validate_branch() so they can be
executed (or ported) independently from each other.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/2545c86ffa5f27497f0d0c542540ad4a4be3c5a5.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 56 ++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 85c2888..27126ff 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3271,11 +3271,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (opts.sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after ret",
-					  insn->sec, insn->offset);
-			}
 			return validate_return(func, insn, &state);
 
 		case INSN_CALL:
@@ -3319,13 +3314,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (opts.sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after indirect jump",
-					  insn->sec, insn->offset);
-			}
-
-			/* fallthrough */
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(file, insn, &state);
@@ -3845,6 +3833,41 @@ static int validate_ibt(struct objtool_file *file)
 	return warnings;
 }
 
+static int validate_sls(struct objtool_file *file)
+{
+	struct instruction *insn, *next_insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		next_insn = next_insn_same_sec(file, insn);
+
+		if (insn->retpoline_safe)
+			continue;
+
+		switch (insn->type) {
+		case INSN_RETURN:
+			if (!next_insn || next_insn->type != INSN_TRAP) {
+				WARN_FUNC("missing int3 after ret",
+					  insn->sec, insn->offset);
+				warnings++;
+			}
+
+			break;
+		case INSN_JUMP_DYNAMIC:
+			if (!next_insn || next_insn->type != INSN_TRAP) {
+				WARN_FUNC("missing int3 after indirect jump",
+					  insn->sec, insn->offset);
+				warnings++;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	return warnings;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -3913,7 +3936,7 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	if (opts.stackval || opts.orc || opts.uaccess || opts.sls) {
+	if (opts.stackval || opts.orc || opts.uaccess) {
 		ret = validate_functions(file);
 		if (ret < 0)
 			goto out;
@@ -3939,6 +3962,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.sls) {
+		ret = validate_sls(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	ret = create_static_call_sections(file);
 	if (ret < 0)
 		goto out;
