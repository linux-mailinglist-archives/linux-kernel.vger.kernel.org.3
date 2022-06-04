Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B666653D431
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbiFDBBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFDBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:01:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A0537BE5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:01:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s23-20020a257717000000b00660719d9f2fso4177963ybc.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RAgbyFTnXHd2EZQOA5JUlRHzTD1WbpQcsTK6b7kUvvY=;
        b=mzm5BpNUjxLU8SESrQmStz6SQ3J+XNC1tGlqjvOEqWTvXJFpWKuDmr1BRysdJwIvP3
         0zRDsErip3mxko0aQ9dgw/5spK/aS0VUKR66GKNFqK7vF1gVy9FJyeGpi5kD+5jvhKrR
         1FJF+5Hd+LI0DO7nSwxEBoo5WCzFN20j2SBRfRfUMl7PeskT0BSULIuv2qdohuak1Mdw
         vTlBXdz+GOFACD33k9svrkDmfkwfxpt6BbeWNpYorJKgLCAtfGHZM3g8Tf6wtdwnft+6
         DEuh0xbr8gJhECmZT4qvKiiHnLXA6outMtHOYsc3kz1IcRILhpe6epWvzY+UFZzvV1d0
         dV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RAgbyFTnXHd2EZQOA5JUlRHzTD1WbpQcsTK6b7kUvvY=;
        b=okB+Jni8IaIRCxNcHIgy73yHaJ52Y/9l7Y2DEwuL3cLQ2iAkA2CFTuDhvScWYFTULX
         bDPrAhnrzkJPXccKAAABKKoMAA7NRGFn53ZQnFNDMeQPAT/QaiMRj0ONeQCYfCyZ8UHJ
         FU+vfNCitjE3igK8Fbn1we6FcQbRvgiEWzeWb63bAIfq0bKhRNXNrWtIi2m76/beDfbl
         eh5WIhSDswxxacQVISRZ0aV3d/eOspm7peXisyetwKI8jGtT36ZJ3+6u/jLsBaKybc7K
         ahR71GZzCIvSzqh71cs3Gybo7DIkXo/lSMpsNp23dpfUXk3H45YpEj1DUErXuEU/aedK
         /3lQ==
X-Gm-Message-State: AOAM533ivY+9kYLTfyZdN0kdf0gx0rHR6YXPmOysxnvyf3y6FhzCnun+
        6mxV8IqQW8hxdN6nqg2MfQUfTCxoCTVlJ58=
X-Google-Smtp-Source: ABdhPJyNbz4Hrf3hy86F6wrLj1ZFqn12F959I1VHUKOAWqS1n29aJeybX34fekgnfKT8n7ttNLWrF34kDhOIIhA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f95e:2d1c:c00f:e866])
 (user=saravanak job=sendgmr) by 2002:a81:19c3:0:b0:310:1042:e847 with SMTP id
 186-20020a8119c3000000b003101042e847mr6843667ywz.311.1654304464832; Fri, 03
 Jun 2022 18:01:04 -0700 (PDT)
Date:   Fri,  3 Jun 2022 18:01:00 -0700
Message-Id: <20220604010101.719508-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] module: Add support for default value for module async_probe
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module.async_probe kernel command line option that allows enabling
async probing for all modules. When this command line option is used,
there might still be some modules for which we want to explicitly force
synchronous probing, so extend <modulename>.async_probe to take an
optional bool input so that async probing can be disabled for a specific
module.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
v1->v2:
- Updated the documentation to capture all the details/changes.

 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++--
 kernel/module/main.c                            | 11 ++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 710b52d87bdd..5174a08e20b0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1147,8 +1147,12 @@
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	<module>.async_probe [KNL]
-			Enable asynchronous probe on this module.
+	<module>.async_probe[=<bool>] [KNL]
+			If no <bool> value is specified or if the value
+			specified is not a valid <bool>, enable asynchronous
+			probe on this module.  Otherwise, enable/disable
+			asynchronous probe on this module as indicated by the
+			<bool> value. See also: module.async_probe
 
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
@@ -3201,6 +3205,15 @@
 			log everything. Information is printed at KERN_DEBUG
 			so loglevel=8 may also need to be specified.
 
+	module.async_probe=<bool>
+			[KNL] When set to true, modules will use async probing
+			by default. To enable/disable async probing for a
+			specific module, use the module specific control that
+			is documented under <module>.async_probe. When both
+			module.async_probe and <module>.async_probe are
+			specified, <module>.async_probe takes precedence for
+			the specific module.
+
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..47085795f037 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2410,6 +2410,12 @@ static void do_free_init(struct work_struct *w)
 	}
 }
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+/* Default value for module->async_probe_requested */
+static bool async_probe;
+module_param(async_probe, bool, 0644);
+
 /*
  * This is where the real work happens.
  *
@@ -2630,7 +2636,8 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	int ret;
 
 	if (strcmp(param, "async_probe") == 0) {
-		mod->async_probe_requested = true;
+		if (strtobool(val, &mod->async_probe_requested))
+			mod->async_probe_requested = true;
 		return 0;
 	}
 
@@ -2797,6 +2804,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto bug_cleanup;
 
+	mod->async_probe_requested = async_probe;
+
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
 				  -32768, 32767, mod,
-- 
2.36.1.255.ge46751e96f-goog

