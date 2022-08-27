Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A035A348D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiH0Eh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0EhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:37:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5991D333;
        Fri, 26 Aug 2022 21:37:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 72so3346671pfx.9;
        Fri, 26 Aug 2022 21:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IhCtCt7xUVdmEi8KPUgqmHyWKIflwsN7bIzGfwY7bdQ=;
        b=GhjKS05oVLRs6NiQ5Evb/3S/bSmoXAWHCZylVi4Poux54vSKgLevmdWB6McKCaXO9b
         2t2SELt8vH/ki8S4dvp7DwXJDRlzy3EsXW9ozIG/2QZeQT7irAjNbtgZcZnAXi3hSkE4
         yL9pimCkFF36aZyBCYsmbkJc/8WPj2tOigpUi7PUPtd0dPbQ79RzJcjXx7WExRdH6bSA
         Qftlioux7MVpq6I0KmZUPNxqoZI96uv2TA8KPxLfk53jQEl6aXeleX//aYmN7WDWZVvB
         3bmeeRq8wooBKUPKAsorB7erhgJZTvt5nmPZa2gUEQ+m6cHpLliKb1ucq2yiqHJUCS3h
         RdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IhCtCt7xUVdmEi8KPUgqmHyWKIflwsN7bIzGfwY7bdQ=;
        b=ujoNUjyw5xf3PWIto5BKJS/e0CL6uYBcTExgmZWsWx6x8mL54gzPFfgTHDfjbc/W/o
         jhRxIKL7MjpqsVhS/HauPf4bb/3JeqFo3Tw4TCpFWEO0nMVGDRYw/n2crHl+gRCEUTPr
         J5x3N7O1yXB1/unw+amqlyQoeCJFbZixx8G4UiRfgYYnfYoHlR6nNhC1xyDB6gV6Yy59
         adIOEyAuPPb0fOJov961JBKrsovvCJxS46TRQx7CQoCBCFU8XsRbJ6prDAHxyqL4oRNT
         KpaplOENaYrhX6xjsVuGie3h5ApfQW33x1MWSUnX3DuyvDUQj7x3jFJhiz4kCObCK6Q3
         Oe2Q==
X-Gm-Message-State: ACgBeo2wNkE9qikcH6M3BHSpp5F9RBIxcI1pKSrolkD9Y+kSmbvGrro7
        OBsEwcqle0ePXTyQEQFjMiE=
X-Google-Smtp-Source: AA6agR5FMIAquCy2mWRAoGIPCDoaF2wtrdSLn37OrQrafMDQzMwLXYekcuDRvSpxQHWTHuMtddVOAQ==
X-Received: by 2002:a63:914a:0:b0:42b:4eaf:7c75 with SMTP id l71-20020a63914a000000b0042b4eaf7c75mr5798107pge.306.1661575042929;
        Fri, 26 Aug 2022 21:37:22 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b00172dc6e1916sm2451488plb.220.2022.08.26.21.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 21:37:20 -0700 (PDT)
Message-ID: <a6a877fc-dc93-2bda-a6d3-37001d99942a@gmail.com>
Date:   Sat, 27 Aug 2022 13:37:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v3 1/2] docs/conf.py: Treat mathjax as fallback math renderer
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, math expressions using the "math::" directive or
the ":math:" role of Sphinx need the imgmath extension for proper
rendering in html and epub builds.
imgmath requires dvipng (and latex).
Otherwise, "make htmldocs" will complain of missing commands.

As a matter of fact, the mathjax extension is loaded by default since
Sphinx v1.8 and it is good enough for html docs without any dependency
on texlive packages.

Stop loading the imgmath extension for html docs unless requirements
for imgmath are met.

To find out whether required commands are available, add a helper
find_command(), which is a wrapper of shutil.which().

For epub docs, keep the same behavior of always loading imgmath.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Changes since v2:
 - Mention find_command() in the changelog.
 - Simplify find_command() by using shutil.which().

Changes sinve v1:
 - Acked-by from Mauro
--
 Documentation/conf.py | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 255384d094bf..c4aaedd96220 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -15,6 +15,18 @@
 import sys
 import os
 import sphinx
+import shutil
+
+# helper
+# ------
+
+def have_command(cmd):
+    """Search ``cmd`` in the ``PATH`` environment.
+
+    If found, return True.
+    If not found, return False.
+    """
+    return shutil.which(cmd) is not None
 
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
@@ -107,7 +119,22 @@ else:
 autosectionlabel_prefix_document = True
 autosectionlabel_maxdepth = 2
 
-extensions.append("sphinx.ext.imgmath")
+# Load math renderer:
+# For html builder, load imgmath only when its dependencies are met.
+# mathjax is the default math renderer since Sphinx 1.8.
+have_latex =  have_command('latex')
+have_dvipng = have_command('dvipng')
+load_imgmath = ((have_latex and have_dvipng)
+                or (major == 1 and minor < 8)
+                or 'epub' in sys.argv)
+
+if load_imgmath:
+    extensions.append("sphinx.ext.imgmath")
+    math_renderer = 'imgmath'
+else:
+    math_renderer = 'mathjax'
+
+sys.stderr.write("math_renderer: %s\n" % math_renderer)
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
-- 
2.25.1


