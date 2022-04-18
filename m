Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E90505CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbiDRQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbiDRQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B3733A06
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQoyovupvdmzpIsOfZKyWaT6DU8UOCQIfFucXJdIDMw=;
        b=WVhtdQUx7+bldXZTpBBV72jSu5/+cygfj+2aj2J6oOJzGmA9YjM0ut/K9EEESped8piVHy
        NWVS02mr0+w0rTZVJnW+j/Gjvek/2a8LYHPCB9Y8DdOmgRxR+S5TJDPoOwNoEq2fUuOVQy
        Dil/T2+B/1ZmIRZznhRb1eCNzIESbxI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-163KuWMqPha-487EadufAw-1; Mon, 18 Apr 2022 12:51:22 -0400
X-MC-Unique: 163KuWMqPha-487EadufAw-1
Received: by mail-qt1-f200.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso8831403qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQoyovupvdmzpIsOfZKyWaT6DU8UOCQIfFucXJdIDMw=;
        b=u8c4TVn8FX5yjIp0gDiQuDzYSrDhe+0qbP9nFCpvkb+sIe+2DvL3q/OUahlEOG/+85
         X7vKznhjnSlaamdoFH6xfV4Vrs3lcComNkbHel5SeJz9QazetwON/3bykFdp02HYvhjN
         sB2bj/WoJ/6QOumUZ5OvOX6ADQZ9qpAqA2vJ49PnmHirDftFG7feA0aUcnf7NXqlGbhp
         zmDVhfA3NIPcD9HpppnqVqpNMEqtxZVJYVYRaWaJRyPXN/6WWmP1bJLSgRKsPlq4PCde
         dOmwOTJSOSpD7MfiaYiBRtwGnIiiLFgt9k3YQqnawKyhGPh/E4JiGnaNJ2MxueyahNDN
         +Xcg==
X-Gm-Message-State: AOAM532qm3wNQCMu2dpZJ1jzUFmLkMVe6qvey2jJPcIAanXNpVXwZe5H
        M6S+5SuquUnlbiIm/pFWKJ7e1FixnNyl9MI5fUyBlDvBX0xj2D8Qbojk110cUyIHTCqQQGXTSkP
        0HshLCPcvQ3MKeh33q3P1KeI2
X-Received: by 2002:a05:620a:270d:b0:69e:bfab:6455 with SMTP id b13-20020a05620a270d00b0069ebfab6455mr90687qkp.360.1650300681662;
        Mon, 18 Apr 2022 09:51:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw338a2jjmdLrNBnGkKFRTZsAYTOaTkBdyQpiJYOXVUCeuXFusEo9YaO3sdR/Hrd9HvrPVKww==
X-Received: by 2002:a05:620a:270d:b0:69e:bfab:6455 with SMTP id b13-20020a05620a270d00b0069ebfab6455mr90673qkp.360.1650300681429;
        Mon, 18 Apr 2022 09:51:21 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:20 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 19/25] objtool: Make static call annotation optional
Date:   Mon, 18 Apr 2022 09:50:38 -0700
Message-Id: <d59ac57ef3d6d8380cdce20322314c9e2e556750.1650300597.git.jpoimboe@redhat.com>
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
index 30971cc50c63..c8c4d2bab42f 100644
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
index 81688f6c46c0..ffb843ef372d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3970,10 +3970,12 @@ int check(struct objtool_file *file)
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
index 24a7ff4f37cc..dc4757205b8d 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -19,6 +19,7 @@ struct opts {
 	bool retpoline;
 	bool sls;
 	bool stackval;
+	bool static_call;
 	bool uaccess;
 
 	/* options: */
-- 
2.34.1

