Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64324D998C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbiCOKrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347414AbiCOKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E65133A;
        Tue, 15 Mar 2022 03:44:18 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q09XAzJjkLf7Xkw/YaQeeAhtQSprnJ4QqL0hxdYpv9w=;
        b=jm+NsyMeVGDdT45J/XRWYZq7kUoPzTeVHqmRA5gK9JhSEo/tKkXzLcPJ3qGVkHKMivJOag
        vJW3T5wZjIn7MWcAcOtiXytn+pKvER7x28ijfve48Xle+1NIDvPhAkfajl97zWeTZFAZIS
        spL7xi2Ptk7My908+AQ0kO0YXbH+C3tuJ1R7Ls9hG7bUJrIAxdzHrOSTYnS/GBG4A541DZ
        FjNK/Y6Ua0H+lh+8WkYuW4UHdg6zui+pdHAtB1RqDIB7wgzlHu6PwOoILcgX6px11haPo9
        YfVgGJUsdjFkFMEXzrHTxoz7NO4KkoaimEyiJWOx+RVFFiH7Oz0/MvMFjawPgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q09XAzJjkLf7Xkw/YaQeeAhtQSprnJ4QqL0hxdYpv9w=;
        b=7FyjIflxZqyWuiQm/1adrVylrNGVrMO/ek4XxSDTPaHR+FrQnwlVwc7uSVP40zdlEmTeGW
        HWtPbufwadoI0tCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add --dry-run
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.282720146@infradead.org>
References: <20220308154317.282720146@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105637.16921.360308990098148427.tip-bot2@tip-bot2>
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

Commit-ID:     f2d3a250897133cc36c13a641bd6a9b4dd5ad234
Gitweb:        https://git.kernel.org/tip/f2d3a250897133cc36c13a641bd6a9b4dd5ad234
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:32 +01:00

objtool: Add --dry-run

Add a --dry-run argument to skip writing the modifications. This is
convenient for debugging.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.282720146@infradead.org
---
 tools/objtool/builtin-check.c           | 3 ++-
 tools/objtool/elf.c                     | 3 +++
 tools/objtool/include/objtool/builtin.h | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 38070f2..853af93 100644
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
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4b384c9..456ac22 100644
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
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 89ba869..7b4b124 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup, sls;
+            validate_dup, vmlinux, mcount, noinstr, backup, sls, dryrun;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
