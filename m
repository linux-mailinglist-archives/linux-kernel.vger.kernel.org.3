Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9484D992A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347351AbiCOKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347253AbiCOKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD132995;
        Tue, 15 Mar 2022 03:43:49 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mmzYc9b/LcoRKMAbTkvhuOjQ0e1B3LxaHEakfD1YVg=;
        b=a3oUOXnvpJTPH/Dd2T+NET0ErmydrbwryYczjxzqK+ROe4ENaHCqVYhLB7Tv5TOUTfZYx+
        3eDprlfLg85giMN5CJLiS2nEVurduwblMK6lamf5I3pGJ0AiqM4OCx0Jai0wArFQsUqiTc
        G5SHcrvEZwYg+DpshSTN0B4igs6w479feRhr9weHtC+BHw7b5lqXluZT0kwwowBIfcE1Fj
        um+Nj7gugzCeIigAEM8bPx87lhheksiaLdfMBt+IOY4fjEWat/LhNjvCoqOIqNJTXQFURw
        IU3ulkspzVfsre300I/maD5fIhcVbqs7zCPctCUNb/mq3N8A6zh5gA1M7pzE6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mmzYc9b/LcoRKMAbTkvhuOjQ0e1B3LxaHEakfD1YVg=;
        b=kWk4yep0bXJqZltZOXgYAaxCXrEP+uuoSYv1UTxs4VTEslmlZJe1UXAKuVmfWfYqWmmAUl
        wIwvltU+0HmJnhDg==
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
Message-ID: <164734102649.16921.17671353163928907701.tip-bot2@tip-bot2>
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

Commit-ID:     0e5b613b4d4be3345dda349fb90dd73d2103302f
Gitweb:        https://git.kernel.org/tip/0e5b613b4d4be3345dda349fb90dd73d2103302f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:44 +01:00

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
index 0c857e7..894c9a7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -395,6 +395,14 @@ static int decode_instructions(struct objtool_file *file)
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
@@ -524,14 +532,6 @@ static int add_dead_ends(struct objtool_file *file)
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
@@ -1114,6 +1114,9 @@ static void annotate_call_site(struct objtool_file *file,
 		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
+
+	if (!sibling && dead_end_function(file, sym))
+		insn->dead_end = true;
 }
 
 static void add_call_dest(struct objtool_file *file, struct instruction *insn,
@@ -2089,10 +2092,6 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_dead_ends(file);
-	if (ret)
-		return ret;
-
 	add_ignores(file);
 	add_uaccess_safe(file);
 
@@ -2131,6 +2130,14 @@ static int decode_sections(struct objtool_file *file)
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
@@ -3138,7 +3145,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 1;
 			}
 
-			if (dead_end_function(file, insn->call_dest))
+			if (insn->dead_end)
 				return 0;
 
 			break;
