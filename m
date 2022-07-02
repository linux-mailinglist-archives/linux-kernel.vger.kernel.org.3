Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3BA563F68
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiGBKLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiGBKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D418B2D;
        Sat,  2 Jul 2022 03:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8396F60BBF;
        Sat,  2 Jul 2022 10:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD37C385A5;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=2cPnueYfcyPLeWd1Vx9za0f/VkxYofU2dhMu+bNUAP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iy/R/QTjg/Xw8RZ0M2F4IFIYYzB8jLqQe+kQ7RGpm5KX2RMNp2CDtqGNHMaWKOEDp
         sbAkRDv0ZVUoAsm+mDFLc5IEl4/RomYXe06lRm2ZS6QK7lxo55pjgbPjK+1jLxjH8T
         dgQrlU7wUshZZ8quhKVa+zK1qTYiuzdcGqY8nx8HvPFmM47s5fD32BE4RJ2jqM8clf
         X/BAk/4W9nstbwbVXAjkbHJ6vOXU6/6KciPdHmNvvRtEH92cRrNECy+VvzG51zKA3+
         a1PZmGCCumW6kY4EHnvtyxIBGmKznijza3UgC7A7SQWZcPX0/v6VrLQVNI9LEeGavG
         zeIN0UU2iUl2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMa-Kr;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: [PATCH v2 0/5] Address some issues with sphinx detection
Date:   Sat,  2 Jul 2022 11:11:24 +0100
Message-Id: <cover.1656756450.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAHk-=wjYBONGGhiQu2iTP6zWu8y2a4=ii4byoomf6N77-pJNeA@mail.gmail.com>
References: <CAHk-=wjYBONGGhiQu2iTP6zWu8y2a4=ii4byoomf6N77-pJNeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if Sphinx is available and read to run is tricky, and may involve
installing several packages for the document build to happen.

There are two options to install Sphinx:

	- via distro-provided packages;
	- via pip, using virtualenv/venv.

Some recent discussions showed a couple of misleading instructions.

This series improves the Sphinx detection by:

- Fixing the logich with checks if a past venv is working and recommend
  just enabling it instead of installing a new venv;
- Detect if sphinx-build stopped working on a venv. This may happen during
  distribution updates;
- Move the PDF minimal version to be later, in order for it to be printed only
  after finishing the Sphinx version check;

Additionally, as now the Sphinx provided on almost all modern distros are
above the minimal required version, place instructions about how to install
Sphinx from the distro-provided packages after placing the instructions for
installing it via venv.

This will hopefully help to have more developers checking documentation
builds with

	make htmldocs

---

v2:
- Fix some issues at the logic that was recommending installing via
  distro-package manager;
- Add a notice about Sphinx 3.0+ false-positive warnings due to a
  Sphinx bug. People using a version different than the recommended
  one should know about that.

Mauro Carvalho Chehab (5):
  scripts: sphinx-pre-install: fix venv version check logic
  scripts: sphinx-pre-install: report broken venv
  scripts: sphinx-pre-install: check for PDF min version later on
  scripts: sphinx-pre-install: provide both venv and package installs
  scripts: sphinx-pre-install: place a warning for Sphinx >= 3.0

 scripts/sphinx-pre-install | 90 +++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 21 deletions(-)

-- 
2.36.1


