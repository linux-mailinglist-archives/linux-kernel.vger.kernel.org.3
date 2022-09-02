Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4755AB3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiIBOdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiIBO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:29:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485BB10B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9OeUQ8WKvjmDCQa64vw6vBkwEukGFdObNeGXaylenLQ=; b=McjR//5MoPFNSEkoQkl0Uhh4wU
        TT57WIwusLJBg2g3/TZ3ToxGWMcoQ3bkV50EUoTjEXQO4XQMjZopdCyNncRieMMB6sC885BfEntSB
        uPxD+bNYNeQWcHgUHvUlbd234CQnCdNBonoTnMrnH+qrHVCwFEavPg2vydzc8D/uHn6DVc6fts8ys
        w68n/h6yvneGAuO5zdgDnDIxNshWnkizHMZIJGPAf4qT32W2csJID8N+5ijWR33zm6ZIwQ48KaWQk
        LmM1ddXc+XaH6dEsHuCY1jmPNFg2ocvgP5a/Y8xXiAB1fkhEwqkGs1PGsS5oktyLkcbVQZKMw29/H
        yXTfPSSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8J-Su; Fri, 02 Sep 2022 13:54:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FC0E30220F;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0492B2B8EF7F7; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130949.893888696@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 34/59] objtool: Allow symbol range comparisons for IBT/ENDBR
References: <20220902130625.217071627@infradead.org>
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

From: Peter Zijlstra <peterz@infradead.org>

A semi common pattern is where code checks if a code address is
within a specific range. All text addresses require either ENDBR or
ANNOTATE_ENDBR, however the ANNOTATE_NOENDBR past the range is
unnatural.

Instead, suppress this warning when this is exactly at the end of a
symbol that itself starts with either ENDBR/ANNOTATE_ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64_compat.S |    1 -
 tools/objtool/check.c            |   28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -128,7 +128,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
-	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4016,6 +4016,24 @@ static void mark_endbr_used(struct instr
 		list_del_init(&insn->call_node);
 }
 
+static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *sym = find_symbol_containing(insn->sec, insn->offset-1);
+	struct instruction *first;
+
+	if (!sym)
+		return false;
+
+	first = find_insn(file, sym->sec, sym->offset);
+	if (!first)
+		return false;
+
+	if (first->type != INSN_ENDBR && !first->noendbr)
+		return false;
+
+	return insn->offset == sym->offset + sym->len;
+}
+
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
@@ -4088,9 +4106,19 @@ static int validate_ibt_insn(struct objt
 			continue;
 		}
 
+		/*
+		 * Accept anything ANNOTATE_NOENDBR.
+		 */
 		if (dest->noendbr)
 			continue;
 
+		/*
+		 * Accept if this is the instruction after a symbol
+		 * that is (no)endbr -- typical code-range usage.
+		 */
+		if (noendbr_range(file, dest))
+			continue;
+
 		WARN_FUNC("relocation to !ENDBR: %s",
 			  insn->sec, insn->offset,
 			  offstr(dest->sec, dest->offset));


