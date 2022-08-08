Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF658C50F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiHHIv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:51:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A356664F8;
        Mon,  8 Aug 2022 01:51:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k14so5511888pfh.0;
        Mon, 08 Aug 2022 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WdlmAhmTO50ldoDbQ+PZvnuCd0y6F9q0hDrlrfqFysM=;
        b=RD12lbblj+F1PQng3Ub3L0sE30e2I3jWjsmmZ79NIPBE9kFjNx9gXOB29Jeku74YG8
         imzdfxCUbd0yF8sMNrNr4g7J04jacHHaydcZBKO6jXBZUxW/G88NCXBk3lGLl84kchzJ
         SkuCwuAZ4GnIrEzW3K3UQBfyQmQ9FnaDWRVTgLGSCIcKaq60J+37oSiNSL+pnqt91vfG
         d1XbRDYf9HQSNTnWaHjZpMAylJ5UZ4049Ewxhlo0lSvmGZ7sGk90Wn5TMONp3RNfSZfW
         I5wB5me29UDMTGPjnsTfeFYTemQAOowwYNPE45p5TUWoUVpz4d1t4IONJ0d9uEUp0rpD
         8cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WdlmAhmTO50ldoDbQ+PZvnuCd0y6F9q0hDrlrfqFysM=;
        b=PhFfdu+w7hszuc6N/1vqFo22W6b4giegTzJqYcHmV8ilMwV2dXIcSlN8G3Wd4twOdS
         DfzhnJmrkifPV/xIW9+P75s5/shXJqRTn5nLUtn+zuoWkLKzmp/PmnmPhM0PD2jqpU7B
         vVx8lk/Ad3/VVyIc+mq7jLrC6X861B8EmNfQA8F5J0UMz6Wdf+Mu6nu3GS2zQQlJm4pG
         /QkZPHedhMvjkrY9r4vJHjVVNDSwlTrwFbWPA+acf5JcvptfU9ekY9rVYHu7lsOQB9/e
         H8fKMEvvdjEnWoD5/mpjtfUTZIFASwaea9XhbDCAfJQ97P6MxiQTVcTeuTAxU245E5MG
         tKyA==
X-Gm-Message-State: ACgBeo23Teah4pxA7WCeYOHUiRV/LS3y3QR7rrnWDGQ/QBEyEgM+6Ur5
        7N47pttb3cLZEyQdMdUQcCe0U521HRE=
X-Google-Smtp-Source: AA6agR4C6vFwlhnt+IadrXeMkWmhu1BEU/GZE+ZmqFPE0+5IkUy89guN4FbL46zPvkemFVCRhgtrGw==
X-Received: by 2002:a65:6b94:0:b0:3fb:16f4:3620 with SMTP id d20-20020a656b94000000b003fb16f43620mr14774195pgw.464.1659948685117;
        Mon, 08 Aug 2022 01:51:25 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g6-20020a63fa46000000b0041c35462316sm5899853pgk.26.2022.08.08.01.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:51:24 -0700 (PDT)
Message-ID: <a45f1aec-a2cb-0ef2-7100-378a5130c492@gmail.com>
Date:   Mon, 8 Aug 2022 17:51:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 1/3] docs/conf.py: Treat mathjax as fallback math renderer
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
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
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Changes sinve v1:
 - Acked-by from Mauro

--
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


