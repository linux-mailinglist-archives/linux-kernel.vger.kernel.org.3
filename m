Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76358AC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiHEOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiHEOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:22:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4A5C34F;
        Fri,  5 Aug 2022 07:22:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so2770816pgc.12;
        Fri, 05 Aug 2022 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gvfjl9OgW7oKULwG0V9MP7wEf5nbK9Je3oX1ODMbHCE=;
        b=Sdd/1wVliKDgMzgVEJG/3jV1wUZBdOwfmKm0sXyoyvBXhrmzcBJA77KyS5bFLIhyNZ
         6sFD9Gn4Vl+jPjGnjXC/3dmcdLTAJjbh6RnetILr+cuijvJrsc/VAz3NV35XMZZeQSFk
         VGIdAVlf5r8rn0rfiVUo/RRIQPpbfYURiBbvKtoI+b4QkY9QMVVuHbLBE6PgF0Tvnndw
         Xpo6b0GpE0WQdlO+jSkK1hPr79OJWp/mkKysV+NmOpZ/uC+L+NVAmEuksYsuGOkaNIhI
         s3onldSv7E0+cdJnCvCWJoonxJaes3V8huyMgiX9YEuf/tSNwBcFggIwvf+RsDImfF3Q
         5JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gvfjl9OgW7oKULwG0V9MP7wEf5nbK9Je3oX1ODMbHCE=;
        b=lJobbH2p6sd9xB7DqGmJUeALGsDVeMF4fTm7+2wnnx42GMPv8aHG8IIRKjtIDiNOki
         HHVBIWr/jk/QaylLfAK/yjyIZraaF45RxolDyf900wBU4u70xCzXbrZoBHrH3Qv1Tlm2
         Ebu0InzAJ27OpYwU0Uem2IbmkBXAmJ5MTwNYgW7o/+mkKtES28S1I4zwoXuhwWn1iZxH
         bieCixbeOfc81V8DuJYp+WA4ZJXek+TgQtHck8J63YRhOtvWqxokIPbJTEAPQC/q3OZr
         /xaf6noT+SYDfIV+MCjyrJ4lNw2L7Ph8qnezoUjq7aw861TkstcsTW2ElHz3pzwcf5tR
         xZDg==
X-Gm-Message-State: ACgBeo1RKaknfyXJbkzgXOuhbMkNANTHoHlersuWIw00HGcHV9MaOkyu
        2f8Tuvistj7+z+LWgnhDXoU=
X-Google-Smtp-Source: AA6agR4Z12BjhC/EGtDn0xlsN5OVyNwdQnjwPaXzSrD7lH8ChYZOEyvGExbJmMKg6ZP1J3d74Z6ZwQ==
X-Received: by 2002:a63:c1f:0:b0:41a:9b73:a89e with SMTP id b31-20020a630c1f000000b0041a9b73a89emr5912637pgl.342.1659709377122;
        Fri, 05 Aug 2022 07:22:57 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b0016be681f008sm3112839ple.290.2022.08.05.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:22:56 -0700 (PDT)
Message-ID: <c5bf0f4a-2852-204f-cfdd-01bb921cfe8f@gmail.com>
Date:   Fri, 5 Aug 2022 23:22:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/3] docs/conf.py: Treat mathjax as fallback math renderer
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
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

For epub docs, keep the same behavior of always loading imgmath.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/conf.py | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 934727e23e0e..3ec1f845c839 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -15,6 +15,23 @@
 import sys
 import os
 import sphinx
+from subprocess import check_output
+
+# helper
+# ------
+
+def have_command(cmd, ver_opt, str_in_ver):
+    """Run ```cmd`` with ``ver_opt`` and see if ``str_in_ver`` is found
+    or not.
+    """
+
+    try:
+        ver_str = check_output([cmd, ver_opt]).decode('utf-8', 'ignore')
+        have_cmd = str_in_ver in ver_str
+    except:
+        have_cmd = False
+
+    return have_cmd
 
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
@@ -106,7 +123,22 @@ else:
 autosectionlabel_prefix_document = True
 autosectionlabel_maxdepth = 2
 
-extensions.append("sphinx.ext.imgmath")
+# Load math renderer:
+# For html builder, load imgmath only when its dependencies are met.
+# mathjax is the default math renderer since Sphinx 1.8.
+have_latex =  have_command('latex', '--version', 'pdfTeX')
+have_dvipng = have_command('dvipng', '--version', 'dvipng')
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


