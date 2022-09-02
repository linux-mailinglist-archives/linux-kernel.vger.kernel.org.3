Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D345AB3B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiIBOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiIBO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:29:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11FC317
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZlEOD9v5avy/olHFrLm+o6b9KaDGaNLliYExb9rswpk=; b=EMfm5CDrtFkDFSIExK9du3Jafl
        bMrBWq4qp9d9Ilzt1Rqk3UpAOfCGeh39tTN+VeboGd3m6aAWJEhuDEKVn/jCYGRqpx3DvCzUACoXB
        FjHn1VgpkwNkgOAvTxfmwwdyY6hZ2cG9R8Y9yf2Cwv+0jdvu1l2+wYKmPS7sX8sNn2y1MX11gbJp8
        Tu8OJKPlIfjdWtUV63l34IzM7Um0WAfAM2A8G1FinYrtG5x5k+mFuUjudZcocue4FIfXzmLtBqTn/
        zahLWnKrNeltNNWQbEuySciUxfDsCDd9mF6A5kLxRSCIdYSeqYh4DwZcPNpT2AOOc6WtXd0q8jfTI
        DWljinmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77N-0074TO-NU; Fri, 02 Sep 2022 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A2CF301FC4;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E7B6A2B8EF7F5; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.578815518@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:56 +0200
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
Subject: [PATCH v2 31/59] objtool: Add --hacks=skylake
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

Make the call/func sections selectable via the --hacks option.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.lib                    |    3 ++-
 tools/objtool/builtin-check.c           |    7 ++++++-
 tools/objtool/check.c                   |   10 ++++++----
 tools/objtool/include/objtool/builtin.h |    1 +
 4 files changed, 15 insertions(+), 6 deletions(-)

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
@@ -4321,10 +4321,12 @@ int check(struct objtool_file *file)
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


