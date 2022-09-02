Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F555AB38A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiIBOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiIBO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA8168A07
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KetPcUlF1b8CoRduWYRVJ1Z0OAFAjWB3tdLqyvUvF+o=; b=Q+LN1KJ5tTML0ppwIjo9awpJFF
        YTRMCTltV1xg0UBdjueEEpetKChLxj719aEN149U5fjpOJ0u6K0iRj9SHZrDIq+N9Sc/mnJfs8A2K
        LG+UGD/IUcsVZ6boMmQxYRy+wzm76RZm0UlZJYqCz+eRWcXtXJVLe2MGuUHSDyDUwA9F2oEkHSNLH
        D18MJfCo8IFZ4Njbxz8h6+7UEzQHr/qNDQh+KiZEKeUl0QZ503ZyRuA7g8wxTGmHwjBb1FOOwBSIM
        2RByOfoO5Jp9VcsU4cylaaNE66DPHj06TezT/rTjFyo5Oli01hfPBrDCxKYSuUaQSBfyDYflPwWzB
        xivfqgxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8C-BV; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26CC4301D06;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5C952B8EF7F3; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.370354037@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:54 +0200
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
Subject: [PATCH v2 29/59] objtool: Track init section
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

For future usage of .init.text exclusion track the init section in the
instruction decoder and use the result in retpoline validation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |   17 ++++++++++-------
 tools/objtool/include/objtool/elf.h |    2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -380,6 +380,15 @@ static int decode_instructions(struct ob
 		    !strncmp(sec->name, ".text.__x86.", 12))
 			sec->noinstr = true;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(sec->name, ".init.text") && !opts.module)
+			sec->init = true;
+
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -3720,13 +3729,7 @@ static int validate_retpoline(struct obj
 		if (insn->retpoline_safe)
 			continue;
 
-		/*
-		 * .init.text code is ran before userspace and thus doesn't
-		 * strictly need retpolines, except for modules which are
-		 * loaded late, they very much do need retpoline in their
-		 * .init.text
-		 */
-		if (!strcmp(insn->sec->name, ".init.text") && !opts.module)
+		if (insn->sec->init)
 			continue;
 
 		if (insn->type == INSN_RETURN) {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, init;
 };
 
 struct symbol {


