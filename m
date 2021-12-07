Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2446B81F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhLGJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49950 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhLGJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 325E4CE19B7;
        Tue,  7 Dec 2021 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5825AC341C7;
        Tue,  7 Dec 2021 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870787;
        bh=LEGFpAQA+3z6jGzQpKdJ6GEqmt46E4mEudOvD7V41t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3+HiLSYocA36sj7QmWQOBwPG7SO43+DIlzPTGFzcCdHmV3Ldd1kEEclC3JwNNSFM
         Wyyjf1h01wVl2owP63JpPbIPFj6lmkyEPhgn+7EURjJUtfXWUN2uOvjy+MhgFX/Kg0
         IvooV8Ws7IS1Swrd/DJ0clO7gazOCe9ZZisuJ5iKEIlRJ3MygZQo8X1fiUULYs8bVW
         qHsGdjbE9N1rMDPELgvsbYjw9RRHEirjy/86AzTYf+ugae99zndp4MGD+Y/Qm5dreC
         NF77kLqP0ODragjVY+KYA4yZUMsMwRvBoxgmUvfTHw/Jxg4wU2oijbxHDpTaOFcgv6
         Ft9tgrqN2Qk1w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muX9l-00BVtE-7X; Tue, 07 Dec 2021 10:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Randy Dunlap" <rdunlap@infradead.org>,
        Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] docs: allow selecting a Sphinx theme
Date:   Tue,  7 Dec 2021 10:52:59 +0100
Message-Id: <bd20adabfd428fd3cd0e69c2cf146aa354932936.1638870323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having RTD as an almost mandatory theme, allow the
user to select other themes via DOCS_THEME environment var.

There's a catch, though: as the current theme override logic is
dependent of the RTD theme, we need to move the code which
adds the CSS overrides to be inside the RTD theme logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/

 Documentation/Makefile             |  3 ++
 Documentation/conf.py              | 52 +++++++++++++++++-------------
 Documentation/doc-guide/sphinx.rst |  8 +++++
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c3feb657b654..11f8b3b9a7ef 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,6 +19,7 @@ endif
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
 SPHINXDIRS    = .
+DOCS_THEME    =
 _SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
@@ -154,4 +155,6 @@ dochelp:
 	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
 	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
 	@echo
+	@echo '   make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 76e5eb5cb62b..9a6a1009c2c4 100644
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
+if "DOCS_THEME" in os.environ:
+    html_theme = os.environ["DOCS_THEME"]
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
index e445cb146efe..bef276c58ebe 100644
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
+The Sphinx theme can be overriden by using the ``DOCS_THEME`` make variable.
+
 To remove the generated documentation, run ``make cleandocs``.
 
 Writing Documentation
-- 
2.33.1

