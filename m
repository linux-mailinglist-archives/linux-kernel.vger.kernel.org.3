Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485E4D1C69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348079AbiCHP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348029AbiCHP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5C4F9C5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k/abB95HyZ4yVzC9H+oSdjTaOAtR+ZDe4ZWon4lptYI=; b=NoOjtUwog2fpeL6HnVcqsFE/DZ
        1gSeslNyKlbMHnDZvL/s239pAxXgmPwuQEm63fj4UFKbE5bMDhf30OXT8fWewRArow6dlqUhYE27Z
        OsUqUUUYdMc90AhlffzxUGcUtM1fc4V18CtkwZlmPBYpLyPqRGorz+BO+c4xANOzxHa7Jo4V8GZf9
        DQNMgSsbhOeDIaHlNFtTjLTCgW9/JXh96WyagClIwEapOp5oswacVcCUgyPQeE+sT1I4nxkzZtvJK
        V/xcIwBthv00Gx0HevzDXqLbIg22UmBh6IXMsKjN7DdWjUtLdao8BHuhiq1gniuREYVrofu20JyZ3
        ssjMkfXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAd-00GIvT-EF; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 515F7302DDB;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D466A2B5649D4; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.410010807@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 38/45] objtool: Rework ASM_REACHABLE
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -394,6 +394,14 @@ static int decode_instructions(struct ob
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
@@ -532,14 +541,6 @@ static int add_dead_ends(struct objtool_
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
@@ -1174,6 +1175,9 @@ static void annotate_call_site(struct ob
 		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
+
+	if (!sibling && dead_end_function(file, sym))
+		insn->dead_end = true;
 }
 
 static void add_call_dest(struct objtool_file *file, struct instruction *insn,
@@ -2198,10 +2202,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = add_dead_ends(file);
-	if (ret)
-		return ret;
-
 	add_ignores(file);
 	add_uaccess_safe(file);
 
@@ -2247,6 +2247,14 @@ static int decode_sections(struct objtoo
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
@@ -3363,7 +3371,7 @@ static int validate_branch(struct objtoo
 				return 1;
 			}
 
-			if (dead_end_function(file, insn->call_dest))
+			if (insn->dead_end)
 				return 0;
 
 			break;


