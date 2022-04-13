Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7950028D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiDMXX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiDMXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C02623BCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxZmUhHhFjqsME70R0S3WFA4slATzlbh3Kd5lEw3AX8=;
        b=dWUBJKwfFBGkl4P++2Ryx2oJz7BFQ9PSYHXyVAJH2kMrxkEnQo9oNIU6YAdnCaW9SY0/Fz
        t2B/f24UQ83NulIH2QMJaY3K2J9rcjNVYHs8SpnL+K6F5sUaOzo6NxmHik9FEcz231ysA/
        cMTDpKVCyHoaDdeCD7mtFkHjraX/LEM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-WJI3u08INW-vYxiq4WR3KA-1; Wed, 13 Apr 2022 19:20:17 -0400
X-MC-Unique: WJI3u08INW-vYxiq4WR3KA-1
Received: by mail-qv1-f71.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so2972026qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxZmUhHhFjqsME70R0S3WFA4slATzlbh3Kd5lEw3AX8=;
        b=557GZjuuNiGvCmCm7ML1q6vDDaHr2xWYYp8+J0F6elzGC1tY278a0ziU9x7K/TFEFC
         KZm1Iw9yCvAnJkjStusSsoL8gUCiNmdH8fcTljtafT31wtCIxm63I55twW5ad0k0tuOw
         d8ZfNhZB/MexVaerR9BzI0ZgnV0BAwFGsZWG+WYZASF/uxNppwfymDrNrRa/DexGNcwf
         by3LhKzHbM1D2zqbvk+poDq4hQpnpdGgjIosjKqLZEnf+rNXjiK7sSqOpw1cHHC6w3eA
         g2WqFCXj7iEh1kTF8lk2tt2Ity2atKdQlZbOSinKdoUZWg1lka+36k54BbYBh0CMKaD+
         a5Kg==
X-Gm-Message-State: AOAM530GnJoNeMYx8LhUAQAQJy9PFJQBNd7sDesdRF0KrIUQl5Cln3YK
        TrszJMR7d05qJ2lv2uMDzGQnV7HU69KiqktmoWdpvdGBtHcr+ESpqNBCTQK6H7Anl1tKFZ5Tl+l
        2m8WS8jJNTVfJwpeKVsZtdcu9
X-Received: by 2002:a05:622a:6115:b0:2f1:d8fa:84aa with SMTP id hg21-20020a05622a611500b002f1d8fa84aamr730199qtb.689.1649892016555;
        Wed, 13 Apr 2022 16:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAitcQonxumnJh9FNiein1nry7WcY5sM/uYLh59j6qEQIt3FSSA0Crgsoe6/42DTBWuyVkbg==
X-Received: by 2002:a05:622a:6115:b0:2f1:d8fa:84aa with SMTP id hg21-20020a05622a611500b002f1d8fa84aamr730183qtb.689.1649892016284;
        Wed, 13 Apr 2022 16:20:16 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:15 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 12/18] objtool: Make stack validation frame-pointer-specific
Date:   Wed, 13 Apr 2022 16:19:47 -0700
Message-Id: <060241d8a392b079c60d83eef3335a8d45c6b20d.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index a6a86e2d0598..28bdcffb4267 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -44,7 +44,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('S', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
-	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate stack unwinding rules"),
+	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK(0, "dump", NULL, "orc", "dump object data", parse_dumpstr),
 
@@ -54,7 +54,6 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
-	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1b1e7a4ae18b..9a6d77a3c5d4 100644
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
@@ -3285,7 +3285,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!opts.no_fp && func && !is_fentry_call(insn) &&
+			if (opts.stackval && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index edb0f550727b..ac94db3470d2 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -32,7 +32,6 @@ struct opts {
 	bool dryrun;
 	bool lto;
 	bool module;
-	bool no_fp;
 	bool no_unreachable;
 	bool stats;
 	bool vmlinux;
-- 
2.34.1

