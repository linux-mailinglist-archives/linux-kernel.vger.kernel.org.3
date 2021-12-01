Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21080465494
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhLASDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352067AbhLASCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:02:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4BFC06179B;
        Wed,  1 Dec 2021 09:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 683BCCE2054;
        Wed,  1 Dec 2021 17:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BFFC53FD1;
        Wed,  1 Dec 2021 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381551;
        bh=DU8pXdz6zRzBeud2Boo3ERaXo+fTGmA5QlgLc669oPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdGR+6z+S0eSlgYtjv5IwrL7qwlsaEA8tf/Zxy9g5Pd6rtS5oobQFhHzt7vwIIX6A
         SYSl6Rnn5FxiYX+r/uKgpgZqqtmHabAsRPCc3HwMKl01Mgq8CjyvkYRSEfaRkh3lNy
         mDNqq7izrVWQy4hPpuTfz4/+/6l97ys0+1Y+WLOqwqiNw6rmR2RXAp3JbdlGenf7T0
         SHImXsoig9U1miT5BgAnRVmjiLWKxuwMTeTWOxUVqHtHI4SXvWd81R9M0aosE0EI38
         /9dM4FvKXrHRGQ4J4ZQQ51vdtYmeFzKgRtXd4y+d4TlejaE+/V5k2su8b+k2SpBAR2
         6jyGkPsbcx2dQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msTsr-004I6u-GF; Wed, 01 Dec 2021 18:59:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] docs: add support for RTD dark mode
Date:   Wed,  1 Dec 2021 18:59:08 +0100
Message-Id: <aa434dc911c27d3af5126d5c2532b25b1d3f2326.1638369365.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638369365.git.mchehab+huawei@kernel.org>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually an overlay on the top of the RTD theme, which
requires to include first the RTD theme.

While the CSS overlay file for RTD can be used here, the color
settings can't be applied, as they would do weird things. So,
we need to split the color-dependent logic in order to place it
into a separate file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/

 Documentation/conf.py                         | 15 +++++++-
 .../sphinx-static/theme_overrides.css         | 16 +-------
 .../sphinx-static/theme_rtd_colors.css        | 37 +++++++++++++++++++
 3 files changed, 53 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/sphinx-static/theme_rtd_colors.css

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d1b6f602b34d..6f4b35bccf3a 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -215,7 +215,7 @@ html_css_files = []
 if "THEME" in os.environ:
     html_theme = os.environ["THEME"]
 
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

