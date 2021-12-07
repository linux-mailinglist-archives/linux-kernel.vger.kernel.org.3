Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA846B820
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhLGJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49964 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhLGJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D259CE1A40;
        Tue,  7 Dec 2021 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763ECC341CB;
        Tue,  7 Dec 2021 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870787;
        bh=qlICAFzm+D6w1ruP34UoHH0PgpDypDO8ULo8Sw/MQNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7Dy3uNLgQOfePeBRkqpnCwUIi86/a4Snn27zAKLDJoWSzWaSD7woDC/MZYBX82NW
         2Lcl3xLKhiBcIJmQ+FT0+IXpHQjcK8a5h5TS3uVEQaCG8nhkvVvmgTyDaEPBaEv54P
         J/vvmHtA93r7CyBijGqP1jqiM5oWkQy1Y9zrVNU60lVKHduMcwJcXw/i3eT4BPBU8N
         7ApJpQa2Bl5oKT1TvREAM4m3Tt4o4R99cxE20S+yuQCFHaw4M36CdnvxVmp2ogj+/y
         VBHtS9SbZtzfwshmwlYg7w8SQRTQ177/ilh7ezJiK0jEuZJH88iQye0VunlgHVbiGB
         q2alEGAuExvcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muX9l-00BVtH-8j; Tue, 07 Dec 2021 10:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Randy Dunlap" <rdunlap@infradead.org>,
        Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] docs: allow to pass extra DOCS_CSS themes via make
Date:   Tue,  7 Dec 2021 10:53:00 +0100
Message-Id: <03d09bf41ad39aa0abfe2ea3c879b09aa3a0948d.1638870323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specially when the RTD theme is not used, it makes sense to
allow specifying extra CSS files via a make variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/

 Documentation/Makefile             | 8 +++++++-
 Documentation/conf.py              | 7 +++++++
 Documentation/doc-guide/sphinx.rst | 3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 11f8b3b9a7ef..9f0f53db2f10 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -20,6 +20,7 @@ SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
+DOCS_CSS      =
 _SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
@@ -85,7 +86,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
 	$(ALLSPHINXOPTS) \
 	$(abspath $(srctree)/$(src)/$5) \
-	$(abspath $(BUILDDIR)/$3/$4)
+	$(abspath $(BUILDDIR)/$3/$4) && \
+	if [ "x$(DOCS_CSS)" != "x" ]; then \
+		cp $(DOCS_CSS) $(BUILDDIR)/$3/_static/; \
+	fi
 
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
@@ -157,4 +161,6 @@ dochelp:
 	@echo
 	@echo '   make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
 	@echo
+	@echo '   make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 9a6a1009c2c4..923496396c3f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -210,6 +210,7 @@ highlight_language = 'none'
 
 # Default theme
 html_theme = 'sphinx_rtd_theme'
+html_css_files = []
 
 if "DOCS_THEME" in os.environ:
     html_theme = os.environ["DOCS_THEME"]
@@ -229,6 +230,12 @@ if html_theme == 'sphinx_rtd_theme':
     except ImportError:
         html_theme = 'classic'
 
+if "DOCS_CSS" in os.environ:
+    css = os.environ["DOCS_CSS"].split(" ")
+
+    for l in css:
+        html_css_files.append(l)
+
 if major <= 1 and minor < 8:
     html_context = {
         'css_files': [],
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bef276c58ebe..7fb6e6168bbb 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -138,6 +138,9 @@ To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
 variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
 output.
 
+It is also possible to pass an extra DOCS_CSS overlay file, in order to customize
+the html layout, by using the ``DOCS_CSS`` make variable.
+
 By default, the build will try to use the Read the Docs sphinx theme:
 
     https://github.com/readthedocs/sphinx_rtd_theme
-- 
2.33.1

