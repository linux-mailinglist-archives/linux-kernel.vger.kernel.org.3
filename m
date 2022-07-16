Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0357726E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiGPXR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiGPXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7922BE7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:28 -0700 (PDT)
Message-ID: <20220716230953.265188514@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3supOg+sDQQOfSp9ifUSIygdjymw6D8ncsEppKfmHZA=;
        b=lprSnZOrYsVcKhla+weKD3GW8WaOjVFwhF5vQ7tqfZr7swIkUCxUaWUEmFfVrlVmf+P2Dl
        iBkimFBI6lVycjhXXYg3zoBkiocSn1AIOAl04A00I7oaarB1ExIr15g8LFG+UhXvxi4h60
        rQzpNxoqDS0lQpA1mFgMXsjoWdSiFEnp07CX2uG3ezJJkdx1slb0RDpC7VG1YnfmnlIyZ1
        VrtL2GWlu2Z6PDWQklZL5fkTL0O6djafREywpx18Ligr1JBEWofhHDTkEQ9I56OANqWhxD
        Fo4Dij2OfRM9xFAFjFUgOeVOApqT9CKKcKI6uyH5hsTcuKnTrK9lKSesZPi6kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3supOg+sDQQOfSp9ifUSIygdjymw6D8ncsEppKfmHZA=;
        b=NYy2oXk2xptMAHSOgKlFJOeSqUAAOCZIiYPMmqpSGFiXoEU6nWjlfbJ1ADNlu0rCgNzxiL
        0zGgfqqGJDYk+SBg==
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
Subject: [patch 10/38] objtool: Add --hacks=skylake
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:25 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Make the call/func sections selectable via the --hacks option.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/Makefile.lib                    |    3 ++-
 tools/objtool/builtin-check.c           |    7 ++++++-
 tools/objtool/check.c                   |   18 ++++++++++--------
 tools/objtool/include/objtool/builtin.h |    1 +
 4 files changed, 19 insertions(+), 10 deletions(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -231,7 +231,8 @@ objtool := $(objtree)/tools/objtool/objt
 
 objtool_args =								\
 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
-	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
+	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)              \
+	$(if $(CONFIG_CALL_DEPTH_TRACKING), --hacks=skylake)            \
 	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -57,12 +57,17 @@ static int parse_hacks(const struct opti
 		found = true;
 	}
 
+	if (!str || strstr(str, "skylake")) {
+		opts.hack_skylake = true;
+		found = true;
+	}
+
 	return found ? 0 : -1;
 }
 
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4372,15 +4372,17 @@ int check(struct objtool_file *file)
 			goto out;
 		warnings += ret;
 
-		ret = create_direct_call_sections(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		if (opts.hack_skylake) {
+			ret = create_direct_call_sections(file);
+			if (ret < 0)
+				goto out;
+			warnings += ret;
 
-		ret = create_sym_thunk_sections(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+			ret = create_sym_thunk_sections(file);
+			if (ret < 0)
+				goto out;
+			warnings += ret;
+		}
 	}
 
 	if (opts.mcount) {
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -14,6 +14,7 @@ struct opts {
 	bool dump_orc;
 	bool hack_jump_label;
 	bool hack_noinstr;
+	bool hack_skylake;
 	bool ibt;
 	bool mcount;
 	bool noinstr;

