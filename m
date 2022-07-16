Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98E577242
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiGPXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiGPXRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C587A1AF19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:23 -0700 (PDT)
Message-ID: <20220716230953.080514530@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=l2lzGHvFrgNLjFsSfHpJzcBOALkxr+/ChBRuIFW3BaA=;
        b=XONyBgQq0seJpfnpxivemXHQE6LTkW160Y2Kc05nkwQMtyGGWMjpnAP9LOgWZe+psc0A4X
        LPTKvPvFpivllkiFQhzYIeDu8IOwzBgFLSNs1Ml9KFgC8d3nf4M7gHUnF6ip4JV4wPvFAi
        DGENKBqU89blXosybfItpdtQ3XQUlYkiUNnKI0vgCCjCfVpVM+/vl+dbXPelhNnuQuSLz5
        hir4SERcmTYaMPO23zu4Z99s+U+3Our9b1OCjzb1PQ+zI2NzXZ8anL/FxGAOtOVewTdZoB
        3AfUwY3p9kzL9QzvaRD/wN9II2lABQMX5xfgTRKjK7oRqN7/dSw60tZ4CRbVEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=l2lzGHvFrgNLjFsSfHpJzcBOALkxr+/ChBRuIFW3BaA=;
        b=OWbQxHqw/P1t2rc6hxBIsazunE0+o6TPZck5IeDtbgI9NDEzaX8Q1e8J+CuU7jsoV0fPEp
        3gN/yNKSEdQWbkAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 07/38] objtool: Track init section
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

