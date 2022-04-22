Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E450B52E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387183AbiDVKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446693AbiDVKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2AFFE;
        Fri, 22 Apr 2022 03:35:04 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtPY+McC2X3GmLxhfhh8W+7jnWnYDzaFOqZql0H3+eA=;
        b=eO8EEaGILApUtwdRUHubkYvE2AdP+YGg0nIcQUgtbvkL3syh8oxU+XNE1vBfbUGN2o0xbG
        miEOpNfECjQxBKu79M0wwuq37/75Xgy/yhETjav5m8dWr16joW4HkjBQv0g8x8mdMHXjZo
        IdLZADMd2YvDLRPOOxlPxz1D5hw1mvesSqDqOQuKkXWmON+Nctv37D8XzYzDXnPOOJbZSX
        hmMYQ6s+H5GxgnE3yXDQnrG0V1NiFUfuqSFTow1vSj1npiKqDEGGIkxY5U85ywKa9bawLS
        AKOCL79Gptl612ptXHGmEkydhiVuh28hlSayz8fF9JRwpa5IGDUJzP7ml5na7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtPY+McC2X3GmLxhfhh8W+7jnWnYDzaFOqZql0H3+eA=;
        b=/mj8qvJ/TfIb3vNB1InQ9bFYg6I5l8i5yMp1yUcJ5Cs1JelT7jGk3FYFbiU2/rTpaktBTH
        BI4UilKf6Gh1HKBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make stack validation frame-pointer-specific
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f563fa064b3b63d528de250c72012d49e14742a3.1650300597.git.jpoimboe@redhat.com>
References: <f563fa064b3b63d528de250c72012d49e14742a3.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370171.4207.2165496648398690010.tip-bot2@tip-bot2>
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

Commit-ID:     72064474964724c59ddff58a581a31b1ede75cf9
Gitweb:        https://git.kernel.org/tip/72064474964724c59ddff58a581a31b1ede75cf9
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:03 +02:00

objtool: Make stack validation frame-pointer-specific

Now that CONFIG_STACK_VALIDATION is frame-pointer specific, do the same
for the '--stackval' option.  Now the '--no-fp' option is redundant and
can be removed.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/f563fa064b3b63d528de250c72012d49e14742a3.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  | 1 -
 scripts/link-vmlinux.sh                 | 4 ----
 tools/objtool/builtin-check.c           | 3 +--
 tools/objtool/check.c                   | 4 ++--
 tools/objtool/include/objtool/builtin.h | 1 -
 5 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0f73e02..6eb99cb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -235,7 +235,6 @@ objtool_args =								\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(part-of-module), --module)				\
-	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
 
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5101a7f..1be0116 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -155,10 +155,6 @@ objtool_link()
 
 	if [ -n "${objtoolopt}" ]; then
 
-		if ! is_enabled CONFIG_FRAME_POINTER; then
-			objtoolopt="${objtoolopt} --no-fp"
-		fi
-
 		if is_enabled CONFIG_GCOV_KERNEL; then
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index d4e6930..30971cc 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -39,7 +39,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
-	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate stack unwinding rules"),
+	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
@@ -49,7 +49,6 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
-	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27126ff..3e02126 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2806,7 +2806,7 @@ static int update_cfi_state(struct instruction *insn,
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (!opts.no_fp && insn->func && op->src.reg == CFI_BP &&
+		if (opts.stackval && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3279,7 +3279,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!opts.no_fp && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 8618585..24a7ff4 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -27,7 +27,6 @@ struct opts {
 	bool dryrun;
 	bool lto;
 	bool module;
-	bool no_fp;
 	bool no_unreachable;
 	bool sec_address;
 	bool stats;
