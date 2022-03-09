Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670A4D2A32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiCIH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCIH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE4166A72;
        Tue,  8 Mar 2022 23:55:18 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8/4N8JaSBdR6mS3YbiVfpQNfFZWqC/Iyz06bwsJhz8=;
        b=maLNT6nRb6sNzu/X8HcOzOSBzdhMqKFXM3fWcXHgHH+gKBkjF8kq0Q2LgY3V0GfIfquWpp
        +Y60JQwPsLC/t+xESUBfGsUfW8yfaJEZAQMHNODU5RAaqV4w/ViMVF1ll47h/S3HJlIAxP
        KtisVofBmJ/sb4z9a1PNG+qlJTzv2OYMsKTdEvdMcisDxAP0Pj2OWddDHEvo37AVG0XbMF
        7Ab1+jGzmf6Tl+4+18N2SeZT5h5x5x5p1myLbL6kA0SW/SZnXPUtzw6H7kEbOyrXquz/79
        SzaPVIdQSn0ykI2XjDs+fE4OhmUAn5C+E1lBcLZZw8E/DXkDZR3idYFDuV1UoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8/4N8JaSBdR6mS3YbiVfpQNfFZWqC/Iyz06bwsJhz8=;
        b=nESRsv0GVTs30AH3o8OxF6LSTulhNc8rwkhB04hx4qjSwaHjKiYd57Wb9fdsZjvH0UmI7R
        J+2MwteOvektWEDw==
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
Message-ID: <164681251606.16921.7759685904767601146.tip-bot2@tip-bot2>
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

Commit-ID:     951c6aeb3bda02073895ace47630f4796a8b6a9d
Gitweb:        https://git.kernel.org/tip/951c6aeb3bda02073895ace47630f4796a8b6a9d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:27 +01:00

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
 
