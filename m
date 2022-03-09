Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22454D29FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiCIH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCIHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD315F094;
        Tue,  8 Mar 2022 23:54:52 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOYPQX0hnM+UEqm4tGg4h48WYSQAELUj8VjwDxaWwG0=;
        b=EXfjnplJsUG0nY4+7iIcM7wmwaL7X3NB35DmLdt3qrdYKYvaq9mUHRdB3kRaLpK9aZjMQB
        jzlQvCDi31KjN52Uxy/K08sgrRXEkB4593MJIApQW2jXhFxyNKXAZtDYXTzGVTDUDcM/r1
        1/zLYOTNQstnPdBYoMc9T9Un/3tx1PZLK4hY9NZJiuyqoVtkJzWjHlfU/RS9r2quAVhTvu
        cg7KQRshx64oPJMj2m3DJIdwW2t6973GYMfxacsitBCWrOVYtHHxx/d91R+LhS72gFA3uH
        1O0RB//3knQmg4DvbFLEcYikgGF3TSkKhnXfbJG1/wn6JGbu0/UOkRo3Ke5aKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TOYPQX0hnM+UEqm4tGg4h48WYSQAELUj8VjwDxaWwG0=;
        b=felNXmbPBsUU5xrhukDrpMU7EOIa8RIBv7ov6KWZxcOvXD4u/Tngc4tBHRwbT6e9RPPR3x
        thqB+2R/lcblrkCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Rename --duplicate to --lto
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.172584233@infradead.org>
References: <20220308154319.172584233@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248980.16921.1319544160468023266.tip-bot2@tip-bot2>
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

Commit-ID:     5af720d0563adc652ac1e98bc4ab423ba1336927
Gitweb:        https://git.kernel.org/tip/5af720d0563adc652ac1e98bc4ab423ba1336927
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:36 +01:00

objtool: Rename --duplicate to --lto

In order to prepare for LTO like objtool runs for modules, rename the
duplicate argument to lto.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.172584233@infradead.org
---
 scripts/link-vmlinux.sh                 | 2 +-
 tools/objtool/builtin-check.c           | 4 ++--
 tools/objtool/check.c                   | 7 ++++++-
 tools/objtool/include/objtool/builtin.h | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 666f7bb..9b08dca 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -115,7 +115,7 @@ objtool_link()
 			objtoolcmd="orc generate"
 		fi
 
-		objtoolopt="${objtoolopt} --duplicate"
+		objtoolopt="${objtoolopt} --lto"
 
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 853af93..5c2fcaa 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,7 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
+     lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -40,7 +40,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
 	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
-	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
+	OPT_BOOLEAN(0, "lto", &lto, "whole-archive like runs"),
 	OPT_BOOLEAN('n', "noinstr", &noinstr, "noinstr validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 311bfc6..ae1d4f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3499,6 +3499,11 @@ int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
+	if (lto && !(vmlinux || module)) {
+		fprintf(stderr, "--lto requires: --vmlinux or --module\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3519,7 +3524,7 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (vmlinux && !validate_dup) {
+	if (vmlinux && !lto) {
 		ret = validate_vmlinux_functions(file);
 		if (ret < 0)
 			goto out;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 7b4b124..0cbe739 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
+	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
