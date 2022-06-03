Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0C53C4B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiFCFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiFCFy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:54:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E2369ED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:54:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c87716af6so60275107b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 22:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RoBwt0zHEU67rWp9+CrvlYFHsmCCA3p1PhfaqmCXOeo=;
        b=eyKFF1dCiNQ57w+ZE4SE0yw/Wk1OUn8JtcfiepC6euZILuQsEFeufqeYpMcWksZMK7
         /ptJkoZXkNKzLA6PvqA0DSYuN54L6fTY2qpHmADDonr8NFRrHYfTeXgdNLOFdsUzWxRc
         WQtR2vhz6vdFUPnjsbaQPV3pbT3l/em6jjE4W+JiqIJsIFs/Z19Ni4bJ7j5zXvx44V1B
         trF2eged2CrGSyMshmoMhuJgQOVuhWTASkJW6zVPTS0okM8lVKOeluWgQNLUqpkvhIKo
         RnnRehXjulITx8JOuKh4aV5T98Z9vBni8p09a99k8lqRlXpD3iUxci4TCQ3CMRqKzFGD
         lMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RoBwt0zHEU67rWp9+CrvlYFHsmCCA3p1PhfaqmCXOeo=;
        b=MdK9Jnd6GibLGYiShXVP4Zn1tha7dY+7hJEkZk3AeiARjcRYLCS36HeRmenBLMNBRK
         0wRO3peZf74IJpsyU9BEtwDeZNXMZu4Ue+sXS8BT/zHFNbNYgMZzvkDZm/1qLAiqT55r
         Wvh7QO1CBPTmrQneRxBR/eXjzPyhZXJbZRdKn/NjVQGig/FotykhdS3eh6PubDZZ0b85
         Z8RK4LVTrn9FS0s+kzE1h6MGk9z2NKiNAqH0Wt/q6/Ccm9Ggqnk9yC1ILV3s2i3yENdu
         D4a3pf3I4mVIaFkEUlERF8FH7jk5V8aRaKYABsyyaDG02ksl4tdJXcRT+mKlVKgwZkDA
         W08g==
X-Gm-Message-State: AOAM531vKDKlqX3wTKKlUPxIVqMHTBowGiGw55zV2hMLaOaosU4XmvV9
        pOeep5e/37nuYUgTOkH22UJoiGnkp13dPJc=
X-Google-Smtp-Source: ABdhPJy8VzzznD94DSeEqNKWVPj7DmQUo3V9uDzsA9D0R+CJlbAToM3qWHIj6HjhA2UkYUUKPkhabzvAsKaUU7E=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f95e:2d1c:c00f:e866])
 (user=saravanak job=sendgmr) by 2002:a25:7c1:0:b0:65c:c093:134 with SMTP id
 184-20020a2507c1000000b0065cc0930134mr9648263ybh.356.1654235695989; Thu, 02
 Jun 2022 22:54:55 -0700 (PDT)
Date:   Thu,  2 Jun 2022 22:54:41 -0700
Message-Id: <20220603055442.521888-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v1] module: Add support for default value for module async_probe
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
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++--
 kernel/module/main.c                            | 11 ++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 710b52d87bdd..32083056bd25 100644
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
+			<bool> value.
 
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
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

