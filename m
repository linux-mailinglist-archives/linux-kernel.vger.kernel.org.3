Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676D4D1C76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348187AbiCHP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348041AbiCHP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D154F9CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iwGCnfXB3kwKpXZ2OxhUFUJdGuoD7mQ0N21yE4UJlcY=; b=gdZplKgAVvGkpPjjoOpbLc3mD7
        eijW3uIpZJ6506Uzm5URs176gq+RqCIqOYQG0Q59ZUgP68pnW3HaAN1WEzvgnpnr/CxyMIegWM1uo
        U7b5ZWSiDfFvv3mu3y12QeC/+uMKcjgCdkmYeiU+dbMT0NWu7Te0ZB4ilVJKm4sahCsP5vXU4axUf
        E7OX1AOxKBjwmaWD6TQDUBxMTlmqQ3sf771fefEYQex1SrUbmuAhXW+e104KmTKsdCA17Xs223fhP
        pCU1vwuPmQ1aR2a4++B28G5cIhy5l/SBWOguq1QJxrbJzH/EwbI6/Qo7+T6FqGuURG/LUsSpvMztz
        jimxGV5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAb-00GIup-Fz; Tue, 08 Mar 2022 15:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7C423003BC;
        Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BA3A12B55FFB7; Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Message-ID: <20220308154317.282720146@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 02/45] objtool: Add --dry-run
References: <20220308153011.021123062@infradead.org>
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

Add a --dry-run argument to skip writing the modifications. This is
convenient for debugging.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/objtool/builtin-check.c           |    3 ++-
 tools/objtool/elf.c                     |    3 +++
 tools/objtool/include/objtool/builtin.h |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,7 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     validate_dup, vmlinux, mcount, noinstr, backup, sls;
+     validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -46,6 +46,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
+	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_END(),
 };
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1019,6 +1019,9 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
+	if (dryrun)
+		return 0;
+
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup, sls;
+            validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 


