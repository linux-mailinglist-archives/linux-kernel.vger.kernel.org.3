Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73539481222
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbhL2Lph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhL2Lpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:45:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F8C061574;
        Wed, 29 Dec 2021 03:45:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b22so18551695pfb.5;
        Wed, 29 Dec 2021 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKdlhmcVD7lx7exWlxB+MNpaYzA1fLFMOv8Gdpt2wq8=;
        b=hrjEYQk1QD8RJLJ/ozZ2dQkXbg7x7KEGE8NMQxR30ZtDmsx5L05UzINN5+y3J2SQ2q
         TGDsqWsZidW6YOIJbzPv0oquRLym5ojTJG9HPQL6VvVPNHccJEnN0+CWzx83BRrI9un0
         jr9twSDyl/3dWCZn2/+vmRrgRKz7/4kSB24IAE2VIg/+pMKzxy6hVmres+TlcmicsmVN
         5YEMLwCwYd2YsIu7RQUCOv4+UjURhFbmTrog68FdBKl3MzZ9UJuCOXgZ6s43M2bxO1Y1
         /z9vQV027UPiZREkmfz7tTzZOmpSKZmo2Zgn9HHbwetMvGIurBAa/S940dIHRRU4xfeF
         V08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKdlhmcVD7lx7exWlxB+MNpaYzA1fLFMOv8Gdpt2wq8=;
        b=GBlHP9ydjAEUlqqRUHn7gXBRyzl/OK/zH+aGno9zFhnsWTJTxCeXMBHZmuOYFglGua
         xOmKyIRIILXFIfHdkBKeBZ2vKemM9DFjzS0rWm8HfuBP+TnsmcQKjx9jPInow2aFQkj8
         x9ipDrCf/AfWx0ru7wxaFXLaU3sR6/IKVjTNV6DBsvPEj6fxcukn1qYRL+N6ASUg2xQm
         rSlacHWwmxprVjqsKmTECCDWyftKRdv34mYt82sP4fkb08jVwAdA/eGlU3ZBAVsVwVrU
         naf2N98JCubGtHOiD99ODlgh9v1c3Yd3CDVFw4FrOZCvoLG58AvXRZuee0QpSlqJTQFW
         HwDw==
X-Gm-Message-State: AOAM531VPmIDvjAswrVmlyrXWQQZoB9RSCgw/xdv3z3968EGW0HcZUbn
        cyiVHubgYwx/EXp0Gx5vXUDmFTgD0H0=
X-Google-Smtp-Source: ABdhPJwk2VjpnGiLu3EmF+KavAr/nTGRdOYLJTP1w+azgFsqHyHJcRoCc/5677DNw8+rjkxo1B1LSw==
X-Received: by 2002:a05:6a00:1a43:b0:4bb:8507:9568 with SMTP id h3-20020a056a001a4300b004bb85079568mr25566530pfv.42.1640778333404;
        Wed, 29 Dec 2021 03:45:33 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p10sm23582749pfw.69.2021.12.29.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 03:45:33 -0800 (PST)
Subject: [PATCH v2 2/4] docs: sphinx/kfigure.py: Add check of 'dot -Tpdf'
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e76f61e1-7366-ba00-b119-8ea6a2499861@gmail.com>
Date:   Wed, 29 Dec 2021 20:45:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent any regression on existing build systems, limit the
fallback of converting DOT -> raster PDF only when both of the
following conditions are met.

 o dot(1) doesn't support -Tpdf
 o rsvg-convert(1) is not found

While we are here, add kernellog.verbose messages related to
rsvg-convert, 'dot -Tpdf', and 'dot -Tsvg' commands.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kfigure.py | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index 955e3ec5de5a..77b0d15dba31 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -51,6 +51,7 @@ import os
 from os import path
 import subprocess
 from hashlib import sha1
+import re
 from docutils import nodes
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives
@@ -111,6 +112,8 @@ def pass_handle(self, node):           # pylint: disable=W0613
 
 # Graphviz's dot(1) support
 dot_cmd = None
+# dot(1) -Tpdf should be used
+dot_Tpdf = False
 
 # ImageMagick' convert(1) support
 convert_cmd = None
@@ -165,7 +168,7 @@ def setupTools(app):
 
     This function is called once, when the builder is initiated.
     """
-    global dot_cmd, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
+    global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
     kernellog.verbose(app, "kfigure: check installed tools ...")
 
     dot_cmd = which('dot')
@@ -174,6 +177,16 @@ def setupTools(app):
 
     if dot_cmd:
         kernellog.verbose(app, "use dot(1) from: " + dot_cmd)
+
+        try:
+            dot_Thelp_list = subprocess.check_output([dot_cmd, '-Thelp'],
+                                    stderr=subprocess.STDOUT)
+        except subprocess.CalledProcessError as err:
+            dot_Thelp_list = err.output
+            pass
+
+        dot_Tpdf_ptn = b'pdf'
+        dot_Tpdf = re.search(dot_Tpdf_ptn, dot_Thelp_list)
     else:
         kernellog.warn(app, "dot(1) not found, for better output quality install "
                        "graphviz from https://www.graphviz.org")
@@ -185,9 +198,17 @@ def setupTools(app):
             "ImageMagick (https://www.imagemagick.org)")
     if rsvg_convert_cmd:
         kernellog.verbose(app, "use rsvg-convert(1) from: " + rsvg_convert_cmd)
+        kernellog.verbose(app, "use 'dot -Tsvg' and rsvg-convert(1) for DOT -> PDF conversion")
+        dot_Tpdf = False
     else:
-        kernellog.verbose(app, "rsvg-convert(1) not found, "
-                          "falling back to raster image conversion")
+        kernellog.verbose(app,
+            "rsvg-convert(1) not found.\n"
+            "  SVG -> PDF conversion by convert() can be poor quality.\n"
+            "  Install librsvg (https://gitlab.gnome.org/GNOME/librsvg)")
+        if dot_Tpdf:
+            kernellog.verbose(app, "use 'dot -Tpdf' for DOT -> PDF conversion")
+        else:
+            kernellog.verbose(app, "use 'dot -Tsvg' and convert(1) for DOT -> PDF conversion")
 
 
 # integrate conversion tools
@@ -277,11 +298,12 @@ def convert_image(img_node, translator, src_fname=None):
 
             if in_ext == '.dot':
                 kernellog.verbose(app, 'convert DOT to: {out}/' + _name)
-                if translator.builder.format == 'latex':
+                if translator.builder.format == 'latex' and not dot_Tpdf:
                     svg_fname = path.join(translator.builder.outdir, fname + '.svg')
                     ok1 = dot2format(app, src_fname, svg_fname)
                     ok2 = svg2pdf_by_rsvg(app, svg_fname, dst_fname)
                     ok = ok1 and ok2
+
                 else:
                     ok = dot2format(app, src_fname, dst_fname)
 
-- 
2.17.1


