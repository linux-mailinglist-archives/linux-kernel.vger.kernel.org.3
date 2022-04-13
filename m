Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C150028B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiDMXXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiDMXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E745237FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJJ7mXb8AQJ47BJDDLW4QsJJu3BnPE4fGx2ZfDAl8F4=;
        b=gRzsHYNwWTk8fiEHx2qjAgKxZYYfzRQhIh78W/MvwYmrESmopBVz/unYtUa94pz7cRUL/D
        IJt8GL1JqnmtnnM+67SZUxy7DftJJMsgQXjQMp/Ma0dxM8c0fCIK8QpifONpGGHf7askhM
        Ip6ZKke4CwOGqeqWAYGQ2W13rF/dAdU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-bRld9LkAMlqIU8HvT56oqg-1; Wed, 13 Apr 2022 19:20:18 -0400
X-MC-Unique: bRld9LkAMlqIU8HvT56oqg-1
Received: by mail-qt1-f198.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so2204323qtm.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJJ7mXb8AQJ47BJDDLW4QsJJu3BnPE4fGx2ZfDAl8F4=;
        b=27zg0GKomY/84yM/94Exorezl7LlyH7NIpXgjn4sF2xmjyxVcjNs272czJJlaj0a7M
         LlBFUrmPt5AHY/NZI0VouWp+XlMvZtU3DtGu7iHFJeMDUGf1G5uE4cmzkfiU1jZWbyXI
         ea+snwSbEMqSnJ9VPk7oXeXRv5tbtem+O6tE+ZucIp8Vxe+EUiuNM9Ulto4g+L9acU7y
         xIcXbh5MQCUBubNC+XiXUuz/3ulJRDo2GwSjkSzQsSmB7tlblX1ihhSysCUMY3FVNrF5
         B6ZbEJWVh9v9zNv23RR2DrX1T/iDtPrnSU6Wq5KZSZ94d1maGHQGR2NRGAeO3MnkSnJ7
         RUiQ==
X-Gm-Message-State: AOAM532Gow6P649mY+OoazfemfZgdgylYSssnvvctqBrx9Eq7+BDJNOi
        fjpHK9Zl1QcmbGBRRCm4YHjGKcNw2NikrTuuCaCOx6M3N29K+h5c1HdTdpgOcYkYHMyhBY565Uz
        12ldXeMMWK85ZiMZ626BM+tQM
X-Received: by 2002:ac8:5883:0:b0:2e1:c6f9:a12f with SMTP id t3-20020ac85883000000b002e1c6f9a12fmr9057580qta.439.1649892018321;
        Wed, 13 Apr 2022 16:20:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnszQAoRKzrQqL0TrRhcZ/o4oNBCZgJYWzsaqLjCCjRGpljzm1/kfHtDtMTT+XL4OWnGCRyA==
X-Received: by 2002:ac8:5883:0:b0:2e1:c6f9:a12f with SMTP id t3-20020ac85883000000b002e1c6f9a12fmr9057565qta.439.1649892017902;
        Wed, 13 Apr 2022 16:20:17 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:17 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 13/18] objtool: Add static call cmdline option
Date:   Wed, 13 Apr 2022 16:19:48 -0700
Message-Id: <3abc167576d593f4f726d614a16f588a63fa7744.1649891421.git.jpoimboe@redhat.com>
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

As part of making objtool more modular, put the existing static call
code behind a new '--static-call' option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  |  1 +
 scripts/link-vmlinux.sh                 |  5 ++++-
 tools/objtool/builtin-check.c           |  2 ++
 tools/objtool/check.c                   | 10 ++++++----
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6eb99cb08821..3f20d565733c 100644
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
index 1be01163a9c5..33f14fe1ddde 100755
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
index 28bdcffb4267..c663828834e1 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -45,6 +45,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('S', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
 	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
+	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK(0, "dump", NULL, "orc", "dump object data", parse_dumpstr),
 
@@ -97,6 +98,7 @@ static bool opts_valid(void)
 	    opts.retpoline	||
 	    opts.sls		||
 	    opts.stackval	||
+	    opts.static_call	||
 	    opts.uaccess) {
 		if (opts.dump) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9a6d77a3c5d4..511b76aaa6de 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3913,10 +3913,12 @@ int check(struct objtool_file *file)
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
index ac94db3470d2..6ffa6b5dc276 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -24,6 +24,7 @@ struct opts {
 	bool retpoline;
 	bool sls;
 	bool stackval;
+	bool static_call;
 	bool uaccess;
 
 	/* options: */
-- 
2.34.1

