Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8046548E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352099AbhLASDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:03:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48032 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbhLASCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38062CE204D;
        Wed,  1 Dec 2021 17:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B1C53FCD;
        Wed,  1 Dec 2021 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381551;
        bh=y+N1ZF8MrQsIvf88S/+6Ah0F2a8HV+X0HZA1R2daOWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNywv1CWFBgAkTGr89TrC2S8/nl0v9csdHkmfeI+9HVqf24w5X/Pp+wkwD/gD3OJV
         0i+SGCTphyDoGljYBZJS5yH0uPNgf6bNSZVdXrJNzo7Qebs/RMRFRFxtP0Yzmoiqf6
         SUpAvlKVgqWkRRDUPuJNL6JejdPbkOZqfLHxJ/GHR5V83DXNb6IbO4sxg1ey/08GQi
         s5AN7CkCjneACeV11pcA/uMGF8Y4zn//50GEEzHBf5C8LZjTyhK8IgAOcep8nZtxTS
         jXpkJVBy4bvecI9WEjNOdbagTbTQvjVyH9CZxMXoKT3jJCWzzKCTycXaehoBniy9bj
         2YM1IK5h9m0og==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msTsr-004I6l-Dv; Wed, 01 Dec 2021 18:59:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Randy Dunlap" <rdunlap@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] docs: allow to pass extra CSS themes via make
Date:   Wed,  1 Dec 2021 18:59:06 +0100
Message-Id: <77038995f9cc3205bc1c694ef71848a83d979744.1638369365.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638369365.git.mchehab+huawei@kernel.org>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
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

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/

 Documentation/Makefile             | 8 +++++++-
 Documentation/conf.py              | 7 +++++++
 Documentation/doc-guide/sphinx.rst | 3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d4039d77b32a..b3ccd1925cd3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -20,6 +20,7 @@ SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
 SPHINXDIRS    = .
 THEME         =
+CSS           =
 _SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
@@ -85,7 +86,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
 	$(ALLSPHINXOPTS) \
 	$(abspath $(srctree)/$(src)/$5) \
-	$(abspath $(BUILDDIR)/$3/$4)
+	$(abspath $(BUILDDIR)/$3/$4) && \
+	if [ "x$(CSS)" != "x" ]; then \
+		cp $(CSS) $(BUILDDIR)/$3/_static/; \
+	fi
 
 htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
@@ -157,4 +161,6 @@ dochelp:
 	@echo
 	@echo '   make THEME={sphinx-theme} selects a different Sphinx theme.'
 	@echo
+	@echo '   make CSS={a .css file} adds a CSS override file for html/epub output.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 082c3ac9dd33..0e2593e4d357 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -210,6 +210,7 @@ highlight_language = 'none'
 
 # Default theme
 html_theme = 'sphinx_rtd_theme'
+html_css_files = []
 
 if "THEME" in os.environ:
     html_theme = os.environ["THEME"]
@@ -229,6 +230,12 @@ if html_theme == 'sphinx_rtd_theme':
     except ImportError:
         html_theme = 'classic'
 
+if "CSS" in os.environ:
+    css = os.environ["CSS"].split(" ")
+
+    for l in css:
+        html_css_files.append(l)
+
 if major <= 1 and minor < 8:
     html_context = {
         'css_files': [],
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 33a527f5ae64..e25bc033aad3 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -138,6 +138,9 @@ To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
 variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
 output.
 
+It is also possible to pass an extra CSS overlay file, in order to customize
+the html layout, by using the ``CSS`` make variable.
+
 By default, the build will try to use the Read the Docs sphinx theme:
 
     https://github.com/readthedocs/sphinx_rtd_theme
-- 
2.33.1

