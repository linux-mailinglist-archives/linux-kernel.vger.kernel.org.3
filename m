Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305D446B81B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhLGJ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41802 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhLGJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C076EB816FB;
        Tue,  7 Dec 2021 09:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2D4C341CF;
        Tue,  7 Dec 2021 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870787;
        bh=0PytsfrVRdv9iy/InB8to/JIZPOk8wHLvV5YqU/qYHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE1W76Q5UJSuPHURKKGn+/lSqNbvL6yJUyeUSbr+sWUWpEi+inK4kJPAxifPfrcnM
         2/KaaGy2RHlMj9ap65jSk1kFmsky+H+6b5B3J6wa2eNJxt1RbZfAGPHeebwsOvOyNI
         kqFCByEbbk5jXsf7SpJGJdBCklaS+CsM43L9rcWK6lhm9EHPA+m+8Hn1mR4F7m1Zs+
         fcpF2S/ghwjeSrZ9enGzD+3iccGxwNcI3cIIB+CWABLOZkO2R1xxZVkUbQ3ol4x3tU
         YCE1YBfyd65yLH5K4khdjw+NK3TVt6ccsSaqKZNf+au8/hBEzmt4nlFYYuqUB3cuIR
         3a5nG0YWAk70w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muX9l-00BVtN-B5; Tue, 07 Dec 2021 10:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] docs: add support for RTD dark mode
Date:   Tue,  7 Dec 2021 10:53:02 +0100
Message-Id: <90d316e055ef7f4c9021b9eada8f8d3b2e750a66.1638870323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually an overlay on the top of the RTD theme, which
requires to include first the RTD theme.

It should be noticed that, when the dark theme is used, the
DOCS_CSS files won't be the last CSS themes. So, it won't
override the dark.css style by default. So, it is needed
to force the them override with "!important".

This small script, for instance, produces a nice output with
the RTD dark theme:

	DOCS_THEME=sphinx_rtd_dark_mode
	cat << EOF > dark_override.css
	  html body {
	    font-family: arial,helvetica,sans-serif;
	  }
	  html[data-theme='dark'] body {
	    color: white !important;
	  }
	  html[data-theme='dark'] .sig-name {
	    color: green !important;
	  }
	  html[data-theme='dark'] .wy-menu-vertical a {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h1, html[data-theme="dark"] h2, html[data-theme="dark"] h3 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h4, html[data-theme="dark"] h5, html[data-theme="dark"] h6 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] h7, html[data-theme="dark"] h8, html[data-theme="dark"] h9 {
	    color: #ffcc00 !important;
	  }
	  html[data-theme="dark"] .wy-nav-content a, html[data-theme="dark"] .wy-nav-content a:visited {
	    color: #ffcc00 !important;
	  }
	EOF

	make DOCS_CSS=dark_override.css DOCS_THEME=sphinx_rtd_dark_mode htmldocs

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/

 Documentation/conf.py                         | 15 +++++++-
 .../sphinx-static/theme_overrides.css         | 16 +-------
 .../sphinx-static/theme_rtd_colors.css        | 37 +++++++++++++++++++
 3 files changed, 53 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/sphinx-static/theme_rtd_colors.css

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c8efe82d1404..f07f2e9b9f2c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -215,7 +215,7 @@ html_css_files = []
 if "DOCS_THEME" in os.environ:
     html_theme = os.environ["DOCS_THEME"]
 
-if html_theme == 'sphinx_rtd_theme':
+if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
     # Read the Docs theme
     try:
         import sphinx_rtd_theme
@@ -227,6 +227,19 @@ if html_theme == 'sphinx_rtd_theme':
         html_css_files = [
             'theme_overrides.css',
         ]
+
+        # Read the Docs dark mode override theme
+        if html_theme == 'sphinx_rtd_dark_mode':
+            try:
+                import sphinx_rtd_dark_mode
+                extensions.append('sphinx_rtd_dark_mode')
+            except ImportError:
+                html_theme == 'sphinx_rtd_theme'
+
+        if html_theme == 'sphinx_rtd_theme':
+                # Add color-specific RTD normal mode
+                html_css_files.append('theme_rtd_colors.css')
+
     except ImportError:
         html_theme = 'classic'
 
diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index 459ec5b29d68..f6f2b941a5d6 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -1,14 +1,14 @@
 /* -*- coding: utf-8; mode: css -*-
  *
  * Sphinx HTML theme customization: read the doc
- *
+ * Please don't add any color definition here, as the theme should
+ * work for both normal and dark modes.
  */
 
 /* Improve contrast and increase size for easier reading. */
 
 body {
 	font-family: serif;
-	color: black;
 	font-size: 100%;
 }
 
@@ -16,17 +16,8 @@ h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
 	font-family: sans-serif;
 }
 
-.wy-menu-vertical li.current a {
-	color: #505050;
-}
-
-.wy-menu-vertical li.on a, .wy-menu-vertical li.current > a {
-	color: #303030;
-}
-
 div[class^="highlight"] pre {
 	font-family: monospace;
-	color: black;
 	font-size: 100%;
 }
 
@@ -104,13 +95,10 @@ div[class^="highlight"] pre {
     /* Menu selection and keystrokes */
 
     span.menuselection {
-	color: blue;
 	font-family: "Courier New", Courier, monospace
     }
 
     code.kbd, code.kbd span {
-	color: white;
-	background-color: darkblue;
 	font-weight: bold;
 	font-family: "Courier New", Courier, monospace
     }
diff --git a/Documentation/sphinx-static/theme_rtd_colors.css b/Documentation/sphinx-static/theme_rtd_colors.css
new file mode 100644
index 000000000000..55b6e1c3664b
--- /dev/null
+++ b/Documentation/sphinx-static/theme_rtd_colors.css
@@ -0,0 +1,37 @@
+/* -*- coding: utf-8; mode: css -*-
+ *
+ * Sphinx HTML theme customization: color settings for RTD (non-dark) theme
+ *
+ */
+
+/* Improve contrast and increase size for easier reading. */
+
+body {
+	color: black;
+}
+
+.wy-menu-vertical li.current a {
+	color: #505050;
+}
+
+.wy-menu-vertical li.on a, .wy-menu-vertical li.current > a {
+	color: #303030;
+}
+
+div[class^="highlight"] pre {
+	color: black;
+}
+
+@media screen {
+
+    /* Menu selection and keystrokes */
+
+    span.menuselection {
+	color: blue;
+    }
+
+    code.kbd, code.kbd span {
+	color: white;
+	background-color: darkblue;
+    }
+}
-- 
2.33.1

