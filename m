Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BD50B553
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446738AbiDVKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446704AbiDVKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C8FFE;
        Fri, 22 Apr 2022 03:35:07 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z14qlveAJgr2IpHOPg+W3PLgnKtqfhRVA1JAtSdReOc=;
        b=p7+Esk+aNtvRWDgOuZAolcVFneeFxxUZIcgA3pw9gBXb4DVkgi67Tr0ysTYtLJuYVr90k5
        q6RgaJIVjaQR6Agccu/Tp+tqG6thXdAxeal3UCbEyJxfVjmTCK1tFqMKELhhgw9KBUlNzB
        4CCL0D01rMXOJvHIcyB6CUIxfCq/0rIM93MX9EBmJRRLFsW2SBlxanwwvYCj9srO35WiaE
        20gZmFMOK4ydyEOyrjJ3VArPDu/LMJwjL9Et9SePNlj38Ehj8I7tkkiI8XJRW0q5GiPyN1
        T4O47+rDBdVqMzSsfYPhRV5ywP0ylKuvJBdoWPvjVis99FJRq42CcWBeMxpIuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z14qlveAJgr2IpHOPg+W3PLgnKtqfhRVA1JAtSdReOc=;
        b=oDEFfl2weFqLT80gs2vOTXxcBLCAoFGrdSZbp+MrtNeJqquG2F0am45Ub68H/0nGueGisN
        0vwkrMsbMaDAMRCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make stack validation optional
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <52da143699574d756e65ca4c9d4acaffe9b0fe5f.1650300597.git.jpoimboe@redhat.com>
References: <52da143699574d756e65ca4c9d4acaffe9b0fe5f.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370525.4207.1726961368974699514.tip-bot2@tip-bot2>
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

Commit-ID:     7dce62041ac34b613a5ed1bd937117e492e06dc8
Gitweb:        https://git.kernel.org/tip/7dce62041ac34b613a5ed1bd937117e492e06dc8
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:02 +02:00

objtool: Make stack validation optional

Make stack validation an explicit cmdline option so that individual
objtool features can be enabled individually by other arches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/52da143699574d756e65ca4c9d4acaffe9b0fe5f.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  |  1 +-
 scripts/link-vmlinux.sh                 |  4 +++-
 tools/objtool/builtin-check.c           |  2 ++-
 tools/objtool/check.c                   | 28 ++++++++++++------------
 tools/objtool/include/objtool/builtin.h |  1 +-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 116c727..d5e15ae 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -232,6 +232,7 @@ objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_SLS), --sls)					\
+	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f6db79b..0140bfa 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -126,6 +126,10 @@ objtool_link()
 			objtoolopt="${objtoolopt} --orc"
 		fi
 
+		if is_enabled CONFIG_STACK_VALIDATION; then
+			objtoolopt="${objtoolopt} --stackval"
+		fi
+
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 6acfebd..d4e6930 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -39,6 +39,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
+	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate stack unwinding rules"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
@@ -92,6 +93,7 @@ static bool opts_valid(void)
 	    opts.orc		||
 	    opts.retpoline	||
 	    opts.sls		||
+	    opts.stackval	||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 16a6c4b..3456eb9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3899,25 +3899,27 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	ret = validate_functions(file);
-	if (ret < 0)
-		goto out;
-	warnings += ret;
-
-	ret = validate_unwind_hints(file, NULL);
-	if (ret < 0)
-		goto out;
-	warnings += ret;
+	if (opts.stackval || opts.orc || opts.uaccess || opts.ibt || opts.sls) {
+		ret = validate_functions(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 
-	if (opts.ibt) {
-		ret = validate_ibt(file);
+		ret = validate_unwind_hints(file, NULL);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		if (!warnings) {
+			ret = validate_reachable_instructions(file);
+			if (ret < 0)
+				goto out;
+			warnings += ret;
+		}
 	}
 
-	if (!warnings) {
-		ret = validate_reachable_instructions(file);
+	if (opts.ibt) {
+		ret = validate_ibt(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index e0972fb..8618585 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -18,6 +18,7 @@ struct opts {
 	bool orc;
 	bool retpoline;
 	bool sls;
+	bool stackval;
 	bool uaccess;
 
 	/* options: */
