Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F20465493
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhLASDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352068AbhLASCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:02:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6BC061799;
        Wed,  1 Dec 2021 09:59:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EF72CE204E;
        Wed,  1 Dec 2021 17:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF3BC53FCC;
        Wed,  1 Dec 2021 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381551;
        bh=x01xGgIcDI/mapp5XkWaAXhsMo2TWBP6Jkwnis/Jhoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjgPB6nL62pmsdIQLcwtymQdMj7ShA/HqqxEEiq81PnOxyaVQGa9DWUYZpm3DVTbR
         fh2LuhnOOcACXFhORC7rYiPxteILh5YSk21Oe46Jr0A+LvaG0ALGCAhVbHZnUR3BJP
         UQcV7zVomTOxIPtG0o4WVx7uBydva3AfFoIbAWJQ9rhOwhZOMqLtqH04aQPYPzSKSX
         0FtKwV+PbSoiFT/iCbiwOId53EsCIHcpB/G1GJPQA7+DJ9F7PN93c8kRQK/z3ysbqL
         GmHHSvgp5L5/w1vxQ/L5hxo4lTCPzdgNg2oHKo4rWO2H1p6lPuHTNX77cV69XjJ4ln
         uu582CGbDHDIw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msTsr-004I6i-CR; Wed, 01 Dec 2021 18:59:09 +0100
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
Subject: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
Date:   Wed,  1 Dec 2021 18:59:05 +0100
Message-Id: <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638369365.git.mchehab+huawei@kernel.org>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
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

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/

 Documentation/Makefile             |  3 ++
 Documentation/conf.py              | 52 +++++++++++++++++-------------
 Documentation/doc-guide/sphinx.rst |  8 +++++
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c3feb657b654..d4039d77b32a 100644
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
@@ -154,4 +155,6 @@ dochelp:
 	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
 	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
 	@echo
+	@echo '   make THEME={sphinx-theme} selects a different Sphinx theme.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 76e5eb5cb62b..082c3ac9dd33 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -208,16 +208,36 @@ highlight_language = 'none'
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
+        html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
+
+        # Add any paths that contain custom static files (such as style sheets) here,
+        # relative to this directory. They are copied after the builtin static files,
+        # so a file named "default.css" will overwrite the builtin "default.css".
+        html_css_files = [
+            'theme_overrides.css',
+        ]
+    except ImportError:
+        html_theme = 'classic'
+
+if major <= 1 and minor < 8:
+    html_context = {
+        'css_files': [],
+    }
+
+    for l in html_css_files:
+        html_context['css_files'].append('_static/' + l)
+
+sys.stderr.write("Using %s theme\n" % html_theme)
 
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
@@ -246,20 +266,8 @@ except ImportError:
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
-
 html_static_path = ['sphinx-static']
 
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

