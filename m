Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9346548F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352156AbhLASDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:03:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38476 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbhLASCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD6AFB8206B;
        Wed,  1 Dec 2021 17:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F652C53FCF;
        Wed,  1 Dec 2021 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381551;
        bh=pyTtgt77BWW0zJYMdiBNfZhN445Jrn3OiB1TvEnvV40=;
        h=From:To:Cc:Subject:Date:From;
        b=l5GxVJZo7T1TE0IiFejhV5bRzNDhGczB8I53VCoNcycFCviE+i/FkMwK7PLkSQ/MN
         tTwUEVvsS2b67geCITyzJcl+p2PHZLOVvhrezeUrFXlQLv4jFp42ZHgqvJTm/cT0d6
         HCTou5BvrBk1WXY8tmze8NuaRQRV878YP5JL1uiuVJ/sMY3zCgjpnLEQQKi4mfPXmj
         jDLsmVmiN6S4nUXF4dUwyioteijrOqTCWt/mSFRQIC/PTbPA4FZcVyJ1Zt4BNQ9vM0
         H+GIdFEQPPWltzJt70I8+EGoMH7FIg3yAXPYWFLTIPCEaWl3ulCKxjRhkG40xVictM
         oYd/eAASLMCfA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msTsr-004I6f-B4; Wed, 01 Dec 2021 18:59:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v3 0/4] docs: add better support for Sphinx themes and CSS
Date:   Wed,  1 Dec 2021 18:59:04 +0100
Message-Id: <cover.1638369365.git.mchehab+huawei@kernel.org>
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

---

v3:
   - Fixed an issue at the logic which copies the extra CSS files on patch 2.

Mauro Carvalho Chehab (4):
  docs: allow selecting a Sphinx theme
  docs: allow to pass extra CSS themes via make
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


