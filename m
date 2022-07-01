Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33587562EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiGAIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiGAItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D87393F;
        Fri,  1 Jul 2022 01:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FF76223C;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A96C341CD;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665335;
        bh=PLCPy3kenRuiCw55qBC87u1/3uZ+m0MdzA/eDR9lqTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qF6GHEaLEf1Xgz7PFa23y+vrD9QMIlSGvQjlsFMgTqni8uuBQhKWtSHBSzfbug7za
         fZUXgy/U1Qc5lGUEso6KV8+Vkw52atUEvEsITiyHt3P3eRYpcnsswOQTZLjJGcX6IS
         6iNu68zGm/YUu1UQMN4yJRwYu1aucbFzSa2rtNl7pRy/zSJn5ixa+R9rk2mvP//KGv
         jNPM5l068MGB1CnvP/UG2cVXDb5o6U0Z/lrgpb2uCzpNBUN4llbqtNaVpy2Fdi7yDn
         wzm/CTJZpZxJtiFFyvQrW0CtvKo6aVwJqHba9XvgrYQ6ThuNUDBmh+wYGEChQmWpwX
         cSaeCA3Ws75Zg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7CKZ-006T98-Pr;
        Fri, 01 Jul 2022 09:48:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Address some issues with sphinx detection
Date:   Fri,  1 Jul 2022 09:48:45 +0100
Message-Id: <cover.1656664906.git.mchehab@kernel.org>
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

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 ksummit-discuss@lists.linuxfoundation.org
Cc: "Jonathan Corbet" <corbet@lwn.net>
Cc: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: ksummit-discuss@lists.linuxfoundation.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

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

Mauro Carvalho Chehab (4):
  scripts: sphinx-pre-install: fix venv version check logic
  scripts: sphinx-pre-install: report broken venv
  scripts: sphinx-pre-install: check for PDF min version later on
  scripts: sphinx-pre-install: provide both venv and package installs

 scripts/sphinx-pre-install | 74 ++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 19 deletions(-)

-- 
2.36.1


