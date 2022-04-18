Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A33505CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbiDRQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiDRQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD8A933A00
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su7xnkFX9GDMnGX5AHNxfwzIatMl5dH/eJkyCjImLTE=;
        b=NRmERpGsjQjP3QxW6Xoy1ZeJY7IkmygqZJ09FPhKyCm26VKhSKQ4KWY9Sb2gEC9BIlWwP8
        dY3I9Eue4oRnZXuIL5Y2MEmdtyFJCqjeOZ2x6mUcAnavH9VMOMOepncC++dgGQ98v4hYy9
        qFasGqD9zNVhedmOjjcMaXyknpP6EFk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-0PT5eZuqNjGd9T1iCVNUng-1; Mon, 18 Apr 2022 12:51:20 -0400
X-MC-Unique: 0PT5eZuqNjGd9T1iCVNUng-1
Received: by mail-qt1-f198.google.com with SMTP id ay26-20020a05622a229a00b002f20573a0faso994183qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su7xnkFX9GDMnGX5AHNxfwzIatMl5dH/eJkyCjImLTE=;
        b=XLml2A6pQ9QPsZqK9D5Q+wW13ck5Q7AggCynI9jKvLI6xIECutLPWERd7P0GhrHtj6
         NgVrDzMus6hZENWIheVz+J3KOxkCVy0hxHZAlzA2Jr+x6R7NTtxl4tGXN7+JszTDWmCo
         +JP5Cpdk/z4LYNKIxGfPRI3sYXGm33U5wKgwWj0NmdINs4OtJJbEYGFMKY832MiaJH/E
         P009CgELGSjss32jHmErentPJzj1HaJkljc8G7zB3tb2uXm9bKVVlxK+PC+ezbtS9XcM
         8QCI8nCmhKqjx5y4Ne2xBL04J7tV6tiBQPpMp11lPNTY+pnzFD1ymZwA7C/8Bu/7WbBL
         7pwQ==
X-Gm-Message-State: AOAM533Dl4MMmazUcAI5p4RL+LitveornGPSnZlG+Ek8xs/jGONgSTdO
        MyAxeFrPbPsdZy9cNnnARRpgC91cxLU8C97kaZBiOo4c9u5kpS4DkZNx5FGuikK1UijtQhKh9do
        aYxnzFk4PnjnM8dVJVxdvpghD
X-Received: by 2002:a37:b8d:0:b0:69e:870a:e2d5 with SMTP id 135-20020a370b8d000000b0069e870ae2d5mr5354392qkl.657.1650300680135;
        Mon, 18 Apr 2022 09:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjwgVUnEZP7BIGm6tdFBVZf8vJqaL+YIqBVusNg6bbr0Y2zJqwfbkyvMfzeeO9OqP1Nf+3vQ==
X-Received: by 2002:a37:b8d:0:b0:69e:870a:e2d5 with SMTP id 135-20020a370b8d000000b0069e870ae2d5mr5354381qkl.657.1650300679874;
        Mon, 18 Apr 2022 09:51:19 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:19 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 18/25] objtool: Make stack validation frame-pointer-specific
Date:   Mon, 18 Apr 2022 09:50:37 -0700
Message-Id: <f563fa064b3b63d528de250c72012d49e14742a3.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CONFIG_STACK_VALIDATION is frame-pointer specific, do the same
for the '--stackval' option.  Now the '--no-fp' option is redundant and
can be removed.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  | 1 -
 scripts/link-vmlinux.sh                 | 4 ----
 tools/objtool/builtin-check.c           | 3 +--
 tools/objtool/check.c                   | 4 ++--
 tools/objtool/include/objtool/builtin.h | 1 -
 5 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0f73e02b7cf1..6eb99cb08821 100644
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
index 5101a7fbfaaf..1be01163a9c5 100755
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
index d4e6930ad0a0..30971cc50c63 100644
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
index 88b527b3eb37..81688f6c46c0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2807,7 +2807,7 @@ static int update_cfi_state(struct instruction *insn,
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (!opts.no_fp && insn->func && op->src.reg == CFI_BP &&
+		if (opts.stackval && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3280,7 +3280,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!opts.no_fp && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 8618585bb742..24a7ff4f37cc 100644
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
-- 
2.34.1

