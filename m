Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A792346B822
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhLGJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhLGJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6BC061574;
        Tue,  7 Dec 2021 01:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3DF01CE1A3D;
        Tue,  7 Dec 2021 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D70C341CA;
        Tue,  7 Dec 2021 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870787;
        bh=zeZfppCVLYnimOLGMvRHb0o3IEliVfErt0XugGBvb5k=;
        h=From:To:Cc:Subject:Date:From;
        b=DZOyVypa1VkKaLbLtpbXxCjGopca4OSQkLaPtYPrKKJN7KeeXsveiP6n1n6bcq1To
         fCvvx+CPeJwo9r/MAI5KEg9SsSwi0QUceQBMoGo7xPB3E5/+Y6mCCEPD8vN1NU0yGF
         EanWzY8/pBJZX4dD338RuWpZuugI43KiGm5aWMK3tmrtENkGhIlv2LormVNDAhemyS
         IJrfUNcX9pFdrgQQIKoK39RGyybENrXnhW8A+PcPDaAE+JrVT4aqR5L8WKP3uku3Rb
         11Qe6SCfjQbWWQIKvIfSb9juJ5scuWZMvYjLXPvPCsDxOba8usD7D60n9C/b7CJ5Dz
         27/okRW5rN3GA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muX9l-00BVtB-6O; Tue, 07 Dec 2021 10:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>
Subject: [PATCH v4 0/4] docs: add better support for Sphinx themes and CSS
Date:   Tue,  7 Dec 2021 10:52:58 +0100
Message-Id: <cover.1638870323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This series comes after my patch fixing Sphinx support for RTD 1.0.0:
 https://lore.kernel.org/lkml/80009f0d17ea0840d81e7e16fff6e7677919fdfc.1638004294.git.mchehab+huawei@kernel.org/

On this version, I renamed the vars to DOCS_CSS and DOCS_THEME,
based on our previous discussion.

I also changed the description of patch 4, better explaining how to
override the CSS theme and giving an example that looks fine,
at least for my eyes.

-

Sphinx allows using different output templates for HTML (and e-pub).

Right now, the Kernel was hardcoded to use the Read the Docs theme,
falling back to whatever default is setup on a given Sphinx version.

Well, themes and templates are actually an user preference.

This patch set allows selecting different themes and even provide
extra CSS override files.

With that, one could, for instance, do things like:

$ echo "body { color: darkgreen; } div.body { color: darkgreen; } " >my_css.css && make SPHINXDIRS=input DOCS_CSS=my_css.css DOCS_THEME=nature htmldocs

In order to use the Sphinx nature theme with the normal font in green.

patch 1 adds a theme selection make variable (DOCS_THEME);
patch 2 adds a css selection variable (DOCS_CSS);
patch 3 sets the classic theme to look a little better, as this will be
  used if  the RTD theme is not installed;
patch 4 adds support for the RTD dark mode theme, which seems to
  be currently the only theme that allows the user to switch between
  dark/light mode when visualizing the documentation.

---

v4:
  - vars were renamed to DOCS_CSS and DOCS_THEME;
  - improved description of patch 4.
v3:
   - Fixed an issue at the logic which copies the extra CSS files on patch 2.

Mauro Carvalho Chehab (4):
  docs: allow selecting a Sphinx theme
  docs: allow to pass extra DOCS_CSS themes via make
  docs: set format for the classic mode
  docs: add support for RTD dark mode

 Documentation/Makefile                        |  11 +-
 Documentation/conf.py                         | 102 ++++++++++++++----
 Documentation/doc-guide/sphinx.rst            |  11 ++
 .../sphinx-static/theme_overrides.css         |  16 +--
 .../sphinx-static/theme_rtd_colors.css        |  37 +++++++
 5 files changed, 140 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/sphinx-static/theme_rtd_colors.css

-- 
2.33.1


