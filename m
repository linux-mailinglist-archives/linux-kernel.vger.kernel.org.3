Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D304C2F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiBXPVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E401451F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dtE4TxbRN5b4MUyKtNVPCJTQt/NBj65e8QNm1bw+r8Q=; b=FRfFCipFL2Iqn1EYtRVe/caWwU
        6fIz141euuHxQ2P2t0QOhx0Mj241faFdqV2n3aV/QBsmVsqJTaFJsIYP/KlkHnXvRIfhrPs6wptSn
        GaIferDd90Cor80E1UAWh/IQZ/c4bX1IeLnjztN4THZzJsRE3lW7EsQic5mitpuPiOTvVck5wO4LA
        caAeRht5HeFR+x/QznDerxXVmkr6WWsmPzQXDHTC/jLpqBEB2s+QK/uzCzCMX2bEQ8lBT53st8qU+
        MJsX4GVG6chjUOn33tz36DJ5RTn/HUwGv+v4k85NFYUdEvmyViuSvdsj4v3wZukyXbje9pwBY3e1F
        Nd/69yaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-004s2D-Vl; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49373302D48;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 92AB82B3547A1; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.721065568@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 29/39] objtool: Rename --duplicate to --lto
References: <20220224145138.952963315@infradead.org>
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

In order to prepare for LTO like objtool runs for modules, rename the
duplicate argument to lto.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/link-vmlinux.sh                 |    2 +-
 tools/objtool/builtin-check.c           |    4 ++--
 tools/objtool/check.c                   |    7 ++++++-
 tools/objtool/include/objtool/builtin.h |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -115,7 +115,7 @@ objtool_link()
 			objtoolcmd="orc generate"
 		fi
 
-		objtoolopt="${objtoolopt} --duplicate"
+		objtoolopt="${objtoolopt} --lto"
 
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3501,6 +3501,11 @@ int check(struct objtool_file *file)
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
@@ -3521,7 +3526,7 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (vmlinux && !validate_dup) {
+	if (vmlinux && !lto) {
 		ret = validate_vmlinux_functions(file);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
+	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 


