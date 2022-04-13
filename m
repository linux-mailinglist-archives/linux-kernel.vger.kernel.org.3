Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00A500281
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiDMXXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbiDMXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 328D123BF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgoysvRYI7jiT6YTcwzlIA96pkBT7Y5XEienP3vKiOM=;
        b=J5Th5tgrEEyIhguyNWqcMz89AHT9Ob14f28OODBrV328I176NVtVpzEihPDgXH6bLjMEZ4
        HO86cHh02pqY/Yc2n8BIVK/IESe1XOMlcybfje4g6CD7++gSle9y3iG4ZMg3PajUWtYhrI
        ELY2IG28fGq4NPaxjKuJewIQtZ/tF/Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-4T5RH9FANm-CK4Hu7lSdrQ-1; Wed, 13 Apr 2022 19:20:12 -0400
X-MC-Unique: 4T5RH9FANm-CK4Hu7lSdrQ-1
Received: by mail-qk1-f197.google.com with SMTP id ay14-20020a05620a178e00b0069a9c319c64so2174930qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgoysvRYI7jiT6YTcwzlIA96pkBT7Y5XEienP3vKiOM=;
        b=LPBXN0LdHs4RXTgtKbMgehiq/SAs299yLWBE7aiUL6q3jCxu8CPpETGSQvgbuY1gYh
         Qoy4JU4TPAAXtjfgs/XgrhuSH5uSY17dhtlc2wRSY+QDkgNGT/D611eRR08UzV4n0V0p
         3F5EVWZtdXSCaIc7WKuT6w7sircvHuZmxIUvnUZEPUaE7SYx3YGmv4yoY8kPmNypXMFz
         pwLUbv6JYzlsRDAJ/B5CFqo9U9csVGF9zeO4vZWONBtnht5KUVYddWYr4aa3H6kifkVi
         /MbvRRg67jePWeNhukIJwMR8sDL4kse9UimVuFEJ6Y8ks52mn+PyYa/2poGlNy5qZI+h
         0Dbg==
X-Gm-Message-State: AOAM5305QFVAQgJDuVuQseE/cZAfq5JYROlTjAjM6Z3nb1a+owZ2CzYc
        hMcZHvHbyPbSQxT9aPGoM0XC/uQaQ1Pj7Aen4Tgqji+JcKkGs4PF9fW9owHJ5NyDjv+4L+L77a4
        w/N6mDbVQFV6BVp+jmud95cTq
X-Received: by 2002:a05:6214:d87:b0:443:6f15:fe33 with SMTP id e7-20020a0562140d8700b004436f15fe33mr10692040qve.50.1649892011629;
        Wed, 13 Apr 2022 16:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/pZEa9SgFWf0W/cHE7busWtIbByRWu+vm20SnbmxjMNMYejlz00594UibKGPkjnMR/mH25Q==
X-Received: by 2002:a05:6214:d87:b0:443:6f15:fe33 with SMTP id e7-20020a0562140d8700b004436f15fe33mr10692028qve.50.1649892011419;
        Wed, 13 Apr 2022 16:20:11 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:10 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 09/18] objtool: Add stack validation cmdline option
Date:   Wed, 13 Apr 2022 16:19:44 -0700
Message-Id: <a13c502a91ae0bef8dfeb502d7dee88e73039355.1649891421.git.jpoimboe@redhat.com>
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
index 3df46e9b4b03..a6a86e2d0598 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -44,6 +44,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('S', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
+	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate stack unwinding rules"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_CALLBACK(0, "dump", NULL, "orc", "dump object data", parse_dumpstr),
 
@@ -96,6 +97,7 @@ static bool opts_valid(void)
 	    opts.orc		||
 	    opts.retpoline	||
 	    opts.sls		||
+	    opts.stackval	||
 	    opts.uaccess) {
 		if (opts.dump) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 490ed3560d99..bb25937b2d1c 100644
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
+	if (opts.stackval || opts.orc || opts.uaccess) {
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
index 0cac9bd6a97f..edb0f550727b 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -23,6 +23,7 @@ struct opts {
 	bool orc;
 	bool retpoline;
 	bool sls;
+	bool stackval;
 	bool uaccess;
 
 	/* options: */
-- 
2.34.1

