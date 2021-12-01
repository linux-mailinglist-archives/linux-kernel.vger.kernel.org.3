Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31486464F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbhLANzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbhLANxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666FC0613FD;
        Wed,  1 Dec 2021 05:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D625CE1ECA;
        Wed,  1 Dec 2021 13:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC6C53FD1;
        Wed,  1 Dec 2021 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366607;
        bh=KgT8MZyyZTB9atKNORLUb1HZx3CjIv+yR6zou4vpou8=;
        h=From:To:Cc:Subject:Date:From;
        b=XP9cSSDUy4T8b8D6kPl5w0KDd+xrrIl5sl3oZ6qai7EZxlXwH2rxh4JYnl+CDsEeg
         mz9cjFWctjUaJDEPb2+K8UavQFcTzqEUgNQgdGKpdJJT/9GGKTrapK4pAkro6uPhbN
         hafF0f4rE3n3USJb4lvREyCiS/tY4F1o9QddlAWVBy86R+mMUExtBk4+xSSdl3XZCt
         mBgA/7zGfgHLTasnuDQmXJ1HiwrGDUY3eslySw0a4snLz07yeisWDIcazE81/Q+VV7
         cYQ/lzSsWHiB9IuJV/FwUqFPBSdHjfYV/AR6b5RMCJy5/gI1JPWStHcYRTp4Yh9Tt+
         UURt/D7YB1/ug==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msPzp-004F89-2B; Wed, 01 Dec 2021 14:50:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2 0/4] docs: add better support for Sphinx themes and CSS
Date:   Wed,  1 Dec 2021 14:50:00 +0100
Message-Id: <cover.1638366497.git.mchehab+huawei@kernel.org>
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

It provides, IMHO, a nice improvement on themes selection. This series
is a v2 of the other theme-related patches I sent today.

-

Sphinx allows using different output templates for HTML (and e-pub).

Right now, the Kernel was hardcoded to use the Read the Docs theme,
falling back to whatever default is setup on a given Sphinx version.

Well, themes and templates are actually an user preference.

This patch set allows selecting different themes and even provide
extra CSS override files.

With that, one could, for instance, do things like:

$ echo "body { color: darkgreen; } div.body { color: darkgreen; } " >my_css.css && make SPHINXDIRS=input CSS=my_css.css THEME=nature htmldocs

In order to use the Sphinx nature theme with the normal font in green.

patch 1 adds a theme selection make variable (THEME);
patch 2 adds a css selection variable (CSS);
patch 3 sets the classic theme to look a little better;
patch 4 adds support for the RTD dark mode theme.

It should be noticed that the RTD dark mode currently has some issues,
as it is actually an override on the top of the original RTD theme.
I suspect it needs to be updated to properly support Sphinx 4.3.0 and
RTD 1.0.0 theme. Yet, it seems useful, as one can always switch to daylight
mode in runtime, if something looks odd with it enabled.

Mauro Carvalho Chehab (4):
  docs: allow selecting a Sphinx theme
  docs: allow to pass extra CSS themes via make
  docs: set format for the classic mode
  docs: add support for RTD dark mode

 Documentation/Makefile                        |   9 +-
 Documentation/conf.py                         | 102 ++++++++++++++----
 Documentation/doc-guide/sphinx.rst            |  11 ++
 .../sphinx-static/theme_overrides.css         |  16 +--
 .../sphinx-static/theme_rtd_colors.css        |  37 +++++++
 5 files changed, 138 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/sphinx-static/theme_rtd_colors.css

-- 
2.33.1


