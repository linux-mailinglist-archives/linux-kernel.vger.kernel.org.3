Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F65227D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiEJXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiEJXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:54:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC891EAF39
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:54:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso3335672pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn5a9HjO1GhmDzOO11q+Hc7KRgg6exeS8MV4lHY8oSs=;
        b=OaQz79+/QD+9VraX3Cm/WRnUhOcJbQ9muzTGKz4r0dfJ2eCqxaVOuKvOlpt0HHJd1f
         ppd5uv8R0tZuCNsxbpxkfeESKqEJX3HGxpME4GZArqcvGGO82IFeOJpIQATQktMAviX6
         ZW91L5WdPBN9Dhe84DIYj5rFg4Be73ewM2eOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yn5a9HjO1GhmDzOO11q+Hc7KRgg6exeS8MV4lHY8oSs=;
        b=KjJhRUQALZub8UZ8CJbJeZjG+FxdN97ZgxeWBrf/H7+69vSTTob1ClU2Smw0lvgqSC
         aH8oqD9/iM9jn0GJYtpeG6k8OoaW5ZFsnCknnHf6lUVTouurEYgDv+FQ129PseD8ZRkf
         8oASEK+x/sHj5bzYC33Rkxd7XigOLb0tW5IJuWmBe9MqpIEsRLbRSefg/oeoL+wl28W4
         7Q1DNvksILVz/8GhHHAqyWTjKI0O4kKLXwH992o1NlMvhUwGh3cVCmbQTs9LKHQ0BdD8
         fIxI14s1pQDue5SOkVMYYvNa1B4SWTvlDjwkl/9XR/o5fH/LO4Iw85bFkiEnyJ+7ET22
         Vzgg==
X-Gm-Message-State: AOAM532WkI4G41xjvcS183FRQuqZ3cYiKs0HIVVsPTZa1R4niFtOK1rO
        XJUv6/gy+KZSHFy7thZhLoVZCA==
X-Google-Smtp-Source: ABdhPJw0AsevaV/K9pMdp84wc/T7v3PVrn1iWK+dRjfUzyytLYvqidkyGANq7GSYoGpdvdSrt6n+yw==
X-Received: by 2002:a17:90b:2250:b0:1dc:588d:6d94 with SMTP id hk16-20020a17090b225000b001dc588d6d94mr2258233pjb.219.1652226854942;
        Tue, 10 May 2022 16:54:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b0050dc762816dsm125073pfe.71.2022.05.10.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:54:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: Change all version strings match kernel
Date:   Tue, 10 May 2022 16:54:12 -0700
Message-Id: <20220510235412.3627034-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4369; h=from:subject; bh=PRNQgbLAI/EZUk9V33vYJAUwhj+yNfA2MLK6x3KRlTk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBievskFJ+QVhYWO3/viaO68Z8TrVJyG3tDMiZgtfbb ceu/cTqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnr7JAAKCRCJcvTf3G3AJvrbD/ 9/hysMgsoU1JFeq6giiE6F2m1iBzkadp4AstB/XUhTMSouVOLtI0SjZN8rjUjU1HNnyH2it+SB/XQZ i6918746LhmqX+zRK4yndc2uH3TWr7HVcHDsrXgEI/YwWUg1WxujD85tS1DmSXRwNP1iAYvnuTujfH q65xjxLCJkLRnr+mGjY4j96OouhgMhZi+OpVbYU8catWqhZPAjZGSK3V5VWEXapYmaI7ZoxgHz0tPI /UintO/TRPPc9bTLnlplvqV/JbHK53+wSwEyJUSnW6uVnJZLo/s96NJ82NEfMkuneO7bPhlAid3Hrh ZxrQZHksZ8ppbWUXXIQ+P1rzGqRsM/OKWsVgYLnZV5Y7VXSHiBxU8sh8KG6WginsJ99qOQM2jo93oO 59NxaMzM3AWmDt4wypyY1THUoahb57Ayjs0dh5AlXXeetEoYyCTxpJAc2cOiirtHJdzU9GNRaiuI9U 003vGQiHZrWj8E4ujvYDmTvmKnFXxxJ4KI5btplqkeT5AJKif5WRfF1M/EYJxWvHpsVU/5OnwiPWgu tnQ4AWkDWObDB8OyWcBAtzIHgL4V3V2hWJVBoXXwudSkr8XN791EinDtoP26a5SOvHUjyaMJ2PDzb0 2wixIfWqMXv10hB5BIJ8DskzETBBrljJ1oBZopCpeGsQTWdvlE72DxEZyywg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not meaningful for the GCC plugins to track their versions separately
from the rest of the kernel. Switch all versions to the kernel version.

Fix mismatched indenting while we're at it.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/Makefile                  | 9 +++++----
 scripts/gcc-plugins/latent_entropy_plugin.c   | 2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
 scripts/gcc-plugins/sancov_plugin.c           | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c        | 2 +-
 scripts/gcc-plugins/structleak_plugin.c       | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 148f4639cf09..6f0aecad5d67 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -28,10 +28,11 @@ GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
 		  -include $(srctree)/include/linux/compiler-version.h \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
-		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
-		   -ggdb -Wno-narrowing -Wno-unused-variable \
-		   -Wno-format-diag
+		  -include $(objtree)/include/generated/utsrelease.h \
+		  -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		  -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
+		  -ggdb -Wno-narrowing -Wno-unused-variable \
+		  -Wno-format-diag
 
 plugin_ldflags	= -shared
 
diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index 8425da41de0d..5d415b2572a8 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -82,7 +82,7 @@ __visible int plugin_is_GPL_compatible;
 static GTY(()) tree latent_entropy_decl;
 
 static struct plugin_info latent_entropy_plugin_info = {
-	.version	= "201606141920vanilla",
+	.version	= UTS_RELEASE,
 	.help		= "disable\tturn off latent entropy instrumentation\n",
 };
 
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 65aee5d6d91e..ea2aea570404 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -34,7 +34,7 @@ __visible int plugin_is_GPL_compatible;
 static int performance_mode;
 
 static struct plugin_info randomize_layout_plugin_info = {
-	.version	= "201402201816vanilla",
+	.version	= UTS_RELEASE,
 	.help		= "disable\t\t\tdo not activate plugin\n"
 			  "performance-mode\tenable cacheline-aware layout randomization\n"
 };
diff --git a/scripts/gcc-plugins/sancov_plugin.c b/scripts/gcc-plugins/sancov_plugin.c
index 23bd023a283b..f3d629555b84 100644
--- a/scripts/gcc-plugins/sancov_plugin.c
+++ b/scripts/gcc-plugins/sancov_plugin.c
@@ -26,7 +26,7 @@ __visible int plugin_is_GPL_compatible;
 tree sancov_fndecl;
 
 static struct plugin_info sancov_plugin_info = {
-	.version	= "20160402",
+	.version	= UTS_RELEASE,
 	.help		= "sancov plugin\n",
 };
 
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 42f0252ee2a4..de817d54b8af 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -44,7 +44,7 @@ static bool verbose = false;
 static GTY(()) tree track_function_decl;
 
 static struct plugin_info stackleak_plugin_info = {
-	.version = "201707101337",
+	.version = UTS_RELEASE,
 	.help = "track-min-size=nn\ttrack stack for functions with a stack frame size >= nn bytes\n"
 		"arch=target_arch\tspecify target build arch\n"
 		"disable\t\tdo not activate the plugin\n"
diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index 74e319288389..86b608a24ec0 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -37,7 +37,7 @@
 __visible int plugin_is_GPL_compatible;
 
 static struct plugin_info structleak_plugin_info = {
-	.version	= "20190125vanilla",
+	.version	= UTS_RELEASE,
 	.help		= "disable\tdo not activate plugin\n"
 			  "byref\tinit structs passed by reference\n"
 			  "byref-all\tinit anything passed by reference\n"
-- 
2.32.0

