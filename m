Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81D505CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbiDRQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346510AbiDRQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9067332ED8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8a1RSwZRwZa7WB4b2xc1Iz/do+hexW0HjVpkJirC0vM=;
        b=hCpvN2TEa1Syk4rfjPmynQGpgMRUAfozhFq4u/1A3DOhEquIEkcy1biQOazwkjkOUswqSx
        VRKhK7E41D6o5fBT6SyCLoxJp12VNmL3pNLLjPNEFJqLDn17Wq03b4PpqNao2pAQjVzR+Z
        PSx0nbP9LJgiwgkbHaNCkRosREroR1o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-CdS-3ZOBNYWcr4FDV8wx6w-1; Mon, 18 Apr 2022 12:51:14 -0400
X-MC-Unique: CdS-3ZOBNYWcr4FDV8wx6w-1
Received: by mail-qv1-f70.google.com with SMTP id o1-20020ad44561000000b0044635418a3cso7674439qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8a1RSwZRwZa7WB4b2xc1Iz/do+hexW0HjVpkJirC0vM=;
        b=JewRCWKq4qz6Z57YxfnTHZ7xdnUvoIW54CC47QeZVDR/N077i+zRIvioKr5XlaqUAo
         yQwPoyt2EUHtSd9BH6LUFoFlvhFNHYyUCU9YEWbQNHKIKhTryQsfTe6VS24g4CwUd7bn
         tbmV7FUt98p6XTrxXEyydw6J9Ai45qQ8taVbVaM/rjcs9TpuIIQPsTtyi8/3dcJO8wsx
         nB9Tw8AUjlxCyocUdiYmCNFsXmUJTpqkUy73rvTx+go7SijWYrXEsVI48tAuwV+3NoCu
         BIx4kTv67mgTYMOjIOLGWxCE2ILbKV7fH+MjZuFI1VZY6HVgvWbfka310IMgYPwioPf6
         R0Dw==
X-Gm-Message-State: AOAM532wrJbFJKhl49PG8QwsJHJk9O7lc7ILyjiFjXSm8B7vOzgFoIS2
        H+ZgW3kJoSCMYv0hev3/GcJ/iRGEbOn1l4vH3KDpMMdEtcx6OCOcQVXnZbVMXeNWSmo83w/omLX
        d8HPNR44eFJRyG9XUpvu2Ul2U
X-Received: by 2002:a05:622a:6091:b0:2f1:d379:1973 with SMTP id hf17-20020a05622a609100b002f1d3791973mr7638384qtb.495.1650300673819;
        Mon, 18 Apr 2022 09:51:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzys19uRmL1M1K12mF9KHOzsp2sgSqgqd9V2D4+Na4KZH0mq+1SWPr+v2QSJjGgPcgLomBrug==
X-Received: by 2002:a05:622a:6091:b0:2f1:d379:1973 with SMTP id hf17-20020a05622a609100b002f1d3791973mr7638368qtb.495.1650300673579;
        Mon, 18 Apr 2022 09:51:13 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:13 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 14/25] objtool: Make stack validation optional
Date:   Mon, 18 Apr 2022 09:50:33 -0700
Message-Id: <52da143699574d756e65ca4c9d4acaffe9b0fe5f.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make stack validation an explicit cmdline option so that individual
objtool features can be enabled individually by other arches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  |  1 +
 scripts/link-vmlinux.sh                 |  4 ++++
 tools/objtool/builtin-check.c           |  2 ++
 tools/objtool/check.c                   | 28 +++++++++++++------------
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 116c7272b41c..d5e15ae29156 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -232,6 +232,7 @@ objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_SLS), --sls)					\
+	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f6db79b11573..0140bfa32c0c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -126,6 +126,10 @@ objtool_link()
 			objtoolopt="${objtoolopt} --orc"
 		fi
 
+		if is_enabled CONFIG_STACK_VALIDATION; then
+			objtoolopt="${objtoolopt} --stackval"
+		fi
+
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 6acfebd2c6ca..d4e6930ad0a0 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -39,6 +39,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
+	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate stack unwinding rules"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
@@ -92,6 +93,7 @@ static bool opts_valid(void)
 	    opts.orc		||
 	    opts.retpoline	||
 	    opts.sls		||
+	    opts.stackval	||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 49d5f0986a52..8dc6035fabd2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3900,25 +3900,27 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	ret = validate_functions(file);
-	if (ret < 0)
-		goto out;
-	warnings += ret;
-
-	ret = validate_unwind_hints(file, NULL);
-	if (ret < 0)
-		goto out;
-	warnings += ret;
+	if (opts.stackval || opts.orc || opts.uaccess || opts.ibt || opts.sls) {
+		ret = validate_functions(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 
-	if (opts.ibt) {
-		ret = validate_ibt(file);
+		ret = validate_unwind_hints(file, NULL);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		if (!warnings) {
+			ret = validate_reachable_instructions(file);
+			if (ret < 0)
+				goto out;
+			warnings += ret;
+		}
 	}
 
-	if (!warnings) {
-		ret = validate_reachable_instructions(file);
+	if (opts.ibt) {
+		ret = validate_ibt(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index e0972fbfa09e..8618585bb742 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -18,6 +18,7 @@ struct opts {
 	bool orc;
 	bool retpoline;
 	bool sls;
+	bool stackval;
 	bool uaccess;
 
 	/* options: */
-- 
2.34.1

