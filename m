Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BC464B30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbhLAKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:09:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44488 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhLAKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:09:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16C03CE1DB2;
        Wed,  1 Dec 2021 10:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B13DC53FAD;
        Wed,  1 Dec 2021 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638353186;
        bh=0C75OUzsuOvjSjHVd8BAkQdTaXENoTUBSRzSPj6bc1w=;
        h=From:To:Cc:Subject:Date:From;
        b=USPZ621+99LFm+lyH6JTHHOp9Zong9H5/GVuykxLum+M7vQIqDA66tauOi7hGWV6D
         9NYXUrbmtwZxqU7Q86KC2H7PffO/Tq6YajJ+4POZ6X2XRu+dkBNHLG7vjmIwnPFQ1w
         q/mkjpWyW16sYm0KDPKJv8fO3TAIpSIF7vCVULO99B5Ug9Qlf8mKHhEuuGdPBDwOYo
         mNSfxUHWGM2m23vH196MdlFrafUrPicIG663xjwhv3KwBO7PKv0caBnEF5Tcae+biq
         2krr6nBynrZv7N/fOgpIf9Y2w3jEJitmU0IJFFu7Hcwe/zTON/BfxT1Hls1UeN6mi2
         i1oXun0mW882w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msMVL-0045wd-VP; Wed, 01 Dec 2021 11:06:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Randy Dunlap" <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: allow selecting a Sphinx theme
Date:   Wed,  1 Dec 2021 11:06:22 +0100
Message-Id: <8a33f4516c937556b9a38157e236b2f55ef67540.1638353179.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having RTD as an almost mandatory theme, allow the
user to select other themes via a THEMES environment var.

There's a catch, though: as the current theme override logic is
dependent of the RTD theme, we need to move the code which
adds the CSS overrides to be inside the RTD theme logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile             |  1 +
 Documentation/conf.py              | 59 ++++++++++++++++--------------
 Documentation/doc-guide/sphinx.rst |  8 ++++
 3 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c3feb657b654..c8d8067b647a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,6 +19,7 @@ endif
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
 SPHINXDIRS    = .
+THEME         =
 _SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 76e5eb5cb62b..9e0020fb4f40 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -208,16 +208,38 @@ highlight_language = 'none'
 # The theme to use for HTML and HTML Help pages.  See the documentation for
 # a list of builtin themes.
 
-# The Read the Docs theme is available from
-# - https://github.com/snide/sphinx_rtd_theme
-# - https://pypi.python.org/pypi/sphinx_rtd_theme
-# - python-sphinx-rtd-theme package (on Debian)
-try:
-    import sphinx_rtd_theme
-    html_theme = 'sphinx_rtd_theme'
-    html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
-except ImportError:
-    sys.stderr.write('Warning: The Sphinx \'sphinx_rtd_theme\' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.\n')
+# Default theme
+html_theme = 'sphinx_rtd_theme'
+
+if "THEME" in os.environ:
+    html_theme = os.environ["THEME"]
+
+if html_theme == 'sphinx_rtd_theme':
+    # Read the Docs theme
+    try:
+        import sphinx_rtd_theme
+        html_theme = 'sphinx_rtd_theme'
+        html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
+
+        # Add any paths that contain custom static files (such as style sheets) here,
+        # relative to this directory. They are copied after the builtin static files,
+        # so a file named "default.css" will overwrite the builtin "default.css".
+        html_css_files = [
+            'theme_overrides.css',
+        ]
+
+        if major <= 1 and minor < 8:
+            html_context = {
+                'css_files': [
+                    '_static/theme_overrides.css',
+                ],
+            }
+    except:
+        html_theme = 'classic'
+
+sys.stderr.write("Using %s theme\n" % html_theme)
+
+html_static_path = ['sphinx-static']
 
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
@@ -243,23 +265,6 @@ except ImportError:
 # pixels large.
 #html_favicon = None
 
-# Add any paths that contain custom static files (such as style sheets) here,
-# relative to this directory. They are copied after the builtin static files,
-# so a file named "default.css" will overwrite the builtin "default.css".
-
-html_static_path = ['sphinx-static']
-
-html_css_files = [
-    'theme_overrides.css',
-]
-
-if major <= 1 and minor < 8:
-    html_context = {
-        'css_files': [
-            '_static/theme_overrides.css',
-        ],
-    }
-
 # Add any extra paths that contain custom files (such as robots.txt or
 # .htaccess) here, relative to this directory. These files are copied
 # directly to the root of the documentation.
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index e445cb146efe..33a527f5ae64 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -138,6 +138,14 @@ To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
 variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
 output.
 
+By default, the build will try to use the Read the Docs sphinx theme:
+
+    https://github.com/readthedocs/sphinx_rtd_theme
+
+If the theme is not available, it will fall-back to the classic one.
+
+The Sphinx theme can be overriden by using the ``THEME`` make variable.
+
 To remove the generated documentation, run ``make cleandocs``.
 
 Writing Documentation
-- 
2.33.1

