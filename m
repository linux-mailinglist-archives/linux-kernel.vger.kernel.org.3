Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5744D29EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiCIH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiCIHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC715F087;
        Tue,  8 Mar 2022 23:54:48 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0H+nWZrEoL9C0Jbz7R9b4TStI1vVa7COc7hRaM/CoA=;
        b=YmNGKnPc8O8WbVht8ain1JQZtrf6yLilyWdbsvBgERYcHs1YhkHaX/bj74PpsgCDrWUpSy
        O2A74jTU4kmV1zsmxb33Wph8vYVKqq4GjZsHiSo3yy+/l8JWhTQzloGIXKM+T+Z4EJnf+r
        PZOqju7vdY3Kuxoob77SX1KX2YwArmqbIGkNiOf94il6SOQKqeInE9aRbh0ciXIkGTan1I
        xLG2SfZtp//UoamfxxFdE2OFYottURqin1qsfCy7zkm4mhyDVx2/VU+b3SNGkZEYhBNRDO
        V+foqqkblYfyrlIE9/sHiztLMvpl3q130/IOzP8shB4DGv1NF6sHuVWE4h1D/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0H+nWZrEoL9C0Jbz7R9b4TStI1vVa7COc7hRaM/CoA=;
        b=EpglWonjfPTsTh5flrB/PacpDyVSzuDSoTjki5Qg2pP7bFkiKXCDDrA7Vk5/49AaRqarlE
        FLJ8Zbe2ltk6PCAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Rework ASM_REACHABLE
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.410010807@infradead.org>
References: <20220308154319.410010807@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248582.16921.6244900075385887859.tip-bot2@tip-bot2>
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

Commit-ID:     0d5b64134b49881d62029a1a9923c604507e973b
Gitweb:        https://git.kernel.org/tip/0d5b64134b49881d62029a1a9923c604507e973b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:37 +01:00

objtool: Rework ASM_REACHABLE

Currently ASM_REACHABLE only works for UD2 instructions; reorder
things to also allow over-riding dead_end_function().

To that end:

 - Mark INSN_BUG instructions in decode_instructions(), this saves
   having to iterate all instructions yet again.

 - Have add_call_destinations() set insn->dead_end for
   dead_end_function() calls.

 - Move add_dead_ends() *after* add_call_destinations() such that
   ASM_REACHABLE can clear the ->dead_end mark.

 - have validate_branch() only check ->dead_end.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.410010807@infradead.org
---
 tools/objtool/check.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9896562..aee6246 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -394,6 +394,14 @@ static int decode_instructions(struct objtool_file *file)
 			if (ret)
 				goto err;
 
+			/*
+			 * By default, "ud2" is a dead end unless otherwise
+			 * annotated, because GCC 7 inserts it for certain
+			 * divide-by-zero cases.
+			 */
+			if (insn->type == INSN_BUG)
+				insn->dead_end = true;
+
 			hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset));
 			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
@@ -523,14 +531,6 @@ static int add_dead_ends(struct objtool_file *file)
 	struct instruction *insn;
 
 	/*
-	 * By default, "ud2" is a dead end unless otherwise annotated, because
-	 * GCC 7 inserts it for certain divide-by-zero cases.
-	 */
-	for_each_insn(file, insn)
-		if (insn->type == INSN_BUG)
-			insn->dead_end = true;
-
-	/*
 	 * Check for manually annotated dead ends.
 	 */
 	sec = find_section_by_name(file->elf, ".rela.discard.unreachable");
@@ -1113,6 +1113,9 @@ static void annotate_call_site(struct objtool_file *file,
 		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
+
+	if (!sibling && dead_end_function(file, sym))
+		insn->dead_end = true;
 }
 
 static void add_call_dest(struct objtool_file *file, struct instruction *insn,
@@ -2088,10 +2091,6 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_dead_ends(file);
-	if (ret)
-		return ret;
-
 	add_ignores(file);
 	add_uaccess_safe(file);
 
@@ -2130,6 +2129,14 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_call_destinations() such that it can override
+	 * dead_end_function() marks.
+	 */
+	ret = add_dead_ends(file);
+	if (ret)
+		return ret;
+
 	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
@@ -3137,7 +3144,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 1;
 			}
 
-			if (dead_end_function(file, insn->call_dest))
+			if (insn->dead_end)
 				return 0;
 
 			break;
