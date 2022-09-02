Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339B5ABAD6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiIBWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIBWfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:35:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349F39B96
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:35:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so3124368pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=k8yYWPAH+FrzvXCJG0ZWciOBWtZoMzZKnrk6j/yrfMY=;
        b=hKKtUMT65I/KJlGI3FQ2gGnFuNLwef7eZuOoHzfatn0TfYZ30KLecH68afetL693n4
         CN1EN7lGStpK36Pbw5IbRrvB0w3D/HGqoKp41r8UL7bO3Pivspsy878g7Z8AKaLE/GPu
         PvbT565m/LLs7dKuZdiOr1/VxeUYZXzjHBaRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=k8yYWPAH+FrzvXCJG0ZWciOBWtZoMzZKnrk6j/yrfMY=;
        b=UbH8PLaXEyw3kdIA6ES/GqBDeb82guHvsJae0QO9B6HCWZUCRqsi5ik/GWw3FTjerg
         5FbrePAiIiey5cwkGCdU9g6X3JFbqM9kCAP/sKfpEMoN/cux0toLwU5qAalFJa2dsK6D
         K8+mqs1MWJQbgrxaTPGT9rAVoIRLOc21Gwi7hfjWujgUiCp751+W1sDVrcn8r44LqHhr
         dJZMUgV8ndGZnwTFwAFegjOEjG9UfUxX0qULWX8vGyWuwesyR8U1iOyA8opEqGXLhEs3
         rYOiP9i4svgdi6oViPKgJhMY4s35nEWnDHmvKhdjKY5gOJrSiaVhgqOh+u7Jtx/cHDmR
         +bWA==
X-Gm-Message-State: ACgBeo0zvDBJf1ADuXGMm5BxfpdRPTAWyB5au6xVUz1qDkcP6PCX9s9g
        lymOHbtmGs/tGAMypZKlZwtQsQ==
X-Google-Smtp-Source: AA6agR4W58WQIOAHftGDp28coRvwNw+c2rMtIhJvh55G+8KvkXQi2cO8Q2pqaQibsMoDcW4UreBgMQ==
X-Received: by 2002:a63:1c9:0:b0:42c:254a:d15f with SMTP id 192-20020a6301c9000000b0042c254ad15fmr21831523pgb.468.1662158111317;
        Fri, 02 Sep 2022 15:35:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a630b00b001fd7fe7d369sm1963607pjj.54.2022.09.02.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:35:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC] docs: Define c_paren_attributes for attributes with arguments
Date:   Fri,  2 Sep 2022 15:35:07 -0700
Message-Id: <20220902223507.2537469-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; h=from:subject; bh=krkzNp8MzvJRoREZ+a3qKDeiPUHiUHeBSeI88OmDfAs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEoUbHWOodEWn9NRH6ZbCMgDGrUee/ErJz9txSAKY iA43r+aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxKFGwAKCRCJcvTf3G3AJhaqEA CgNEbnzZxMeQaOdv+t6/dOLj63XGp69xpTy0FvYG8DhR3ySPJeIDOHezg2REsGRi6bi2WH/vDfXfzL ZEiQd/+ofKMrEilNMWn0WcFFEYl4OUN3sqlCRbgyiuq0AOuQOrSTdcRAKf8OqUFwBOSaVCmdKX6FOZ 60TD57Ll+AzbwyoCxqJ6nYJYtpYuBqdyGWe7qFjhVWOA3zabmdpVUWuz0KsIJGIT8Xu+w1zZkLbIJx yxpD5hgCkJXyAzQwOC1RGmhKFmsKI7uWJ09uIvmb394qeNec2MLWwjyFUQFqoKBBdPyVSIXIaFI7uF pb61XhqTlarUXBbxJBlmr57YfiZePaBWi2WoJAxW/EuOoPnobAlmr72WspxDZCx2zEV6+em5U4vORi IgPmilICnUsi6JQ1V8FEy22W64q0SJoUwXQlMTt1aEl49QTQto5vKWYfM724Cj9q6MAuVv0FXUV/G6 FxMf8mjun4u7xHTY/vjkp2mLrvL/cEmt8OU5GtvPS/rSEnxuxCJOqIMdP4BcEFSx8rWPhElpL9ZiIR GdLTGPlXYTFcPLGJs5qZ/RbLBnEMlcOjSSgfVHhKXdrj2IFMpzzaAHXIijejRVFMFXi5pAUCbJYSML I4GlMRGQtSoUuTem86wZ+904pjTdFwvVETPII9zm4Dni8NgipXCIB6wfQXLw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While Sphinx's "c_id_attributes" is needed for basic attributes, any
attributes with arguments need to be defined in "c_paren_attributes"
to avoid errors like:

include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'

Move such attributes to "c_paren_attributes" and add __alloc_size
and __diagnose_as to the list.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This patch is a lie (the above warning is actually not fixed), but I
was hoping someone could help with this. The Sphinx documentation says:

c_paren_attributes
  A list of strings that the parser additionally should accept as
  attributes with one argument. That is, if my_align_as is in the list,
  then my_align_as(X) is parsed as an attribute for all strings X that
  have balanced braces ((), [], and {}). This can for example be used
  when attributes have been #define d for portability.

However, this appears to only work for attributes with literally a single
argument not "all strings X", so things like __printf and __diagnose_as
don't work.

Does this need fixing in Sphinx? Or am I missing something?
---
 Documentation/conf.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 934727e23e0e..17f996e3709f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -59,18 +59,14 @@ if major >= 3:
 
             # include/linux/compiler_attributes.h:
             "__alias",
-            "__aligned",
             "__aligned_largest",
             "__always_inline",
-            "__assume_aligned",
             "__cold",
             "__attribute_const__",
             "__copy",
             "__pure",
             "__designated_init",
             "__visible",
-            "__printf",
-            "__scanf",
             "__gnu_inline",
             "__malloc",
             "__mode",
@@ -80,7 +76,6 @@ if major >= 3:
             "__noreturn",
             "__packed",
             "__pure",
-            "__section",
             "__always_unused",
             "__maybe_unused",
             "__used",
@@ -97,6 +92,21 @@ if major >= 3:
 
             # include/linux/linkage.h:
             "asmlinkage",
+
+            # include/linux/fortify-string.h:
+            "__FORTIFY_INLINE",
+        ]
+
+        # Same as c_id_attributes above, but for those with arguments.
+        c_paren_attributes = [
+            # include/linux/compiler_attributes.h:
+            "__aligned",
+            "__alloc_size",
+            "__assume_aligned",
+            "__diagnose_as",
+            "__printf",
+            "__scanf",
+            "__section",
         ]
 
 else:
-- 
2.34.1

