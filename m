Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520650B54C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446760AbiDVKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446692AbiDVKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E66D9A;
        Fri, 22 Apr 2022 03:35:03 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZHXcFr5/CUU4yWIdcKqkzcwAp9aFKWYg4vnUWc45rU=;
        b=oHsSCKqrJlZoHfjM4VUFHAp0sKJfittXC3nEBZ3T6sjoBHyTuxhuCNLI3qyaj42y4F7JHd
        zrVwu6zB1VnaBwTg34OxOILUzA4ej/eRzH5GJAlj7RSV48oSIpQ06B99NudLpXWRvuAZ01
        isevSjPoIVZ+qx6P3i/oRuSh7tpnkKPMdVKgelXKHtVfDK5OLXzZ58Tuzj2GIgdRME+RIz
        7K2U9ZAZyl/BLvVohbKbkCTszUboMZBcsYqpy0k7xsUGUO1u/sThLwBkDkJzdSqB6MIREQ
        VSQJtFz73GL615H2mBXyjrX1LiLXotirvAWvuyn6JYSLDaFLQv9MACDxZR0U+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZHXcFr5/CUU4yWIdcKqkzcwAp9aFKWYg4vnUWc45rU=;
        b=h11dljiruMatRwUj41GcEOs3O/942PUX75JY6F7n5U4dlgSVX6afri+BqsK7+hJOIYiMZV
        tDtRAq+Qkszjn/Aw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make static call annotation optional
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d59ac57ef3d6d8380cdce20322314c9e2e556750.1650300597.git.jpoimboe@redhat.com>
References: <d59ac57ef3d6d8380cdce20322314c9e2e556750.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370082.4207.775462247514219491.tip-bot2@tip-bot2>
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

Commit-ID:     26e176896a5bb9222ae3433da902edd2566a61a4
Gitweb:        https://git.kernel.org/tip/26e176896a5bb9222ae3433da902edd2566a61a4
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:03 +02:00

objtool: Make static call annotation optional

As part of making objtool more modular, put the existing static call
code behind a new '--static-call' option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/d59ac57ef3d6d8380cdce20322314c9e2e556750.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  |  1 +
 scripts/link-vmlinux.sh                 |  5 ++++-
 tools/objtool/builtin-check.c           |  2 ++
 tools/objtool/check.c                   | 10 ++++++----
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6eb99cb..3f20d56 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -233,6 +233,7 @@ objtool_args =								\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
+	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1be0116..33f14fe 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -141,11 +141,14 @@ objtool_link()
 			objtoolopt="${objtoolopt} --stackval"
 		fi
 
+		if is_enabled CONFIG_HAVE_STATIC_CALL_INLINE; then
+			objtoolopt="${objtoolopt} --static-call"
+		fi
+
 		if is_enabled CONFIG_X86_SMAP; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
 
-
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 30971cc..c8c4d2b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -40,6 +40,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
 	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
+	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
@@ -93,6 +94,7 @@ static bool opts_valid(void)
 	    opts.retpoline	||
 	    opts.sls		||
 	    opts.stackval	||
+	    opts.static_call	||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3e02126..b9ac351 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3969,10 +3969,12 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	ret = create_static_call_sections(file);
-	if (ret < 0)
-		goto out;
-	warnings += ret;
+	if (opts.static_call) {
+		ret = create_static_call_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
 
 	if (opts.retpoline) {
 		ret = create_retpoline_sites_sections(file);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 24a7ff4..dc47572 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -19,6 +19,7 @@ struct opts {
 	bool retpoline;
 	bool sls;
 	bool stackval;
+	bool static_call;
 	bool uaccess;
 
 	/* options: */
