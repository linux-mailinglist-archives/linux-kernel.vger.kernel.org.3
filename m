Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715C563FB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiGBLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiGBLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4015A23;
        Sat,  2 Jul 2022 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0C8FB81D65;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12272C341CF;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=MUtQumptp1S/XDH3DSm7yGwg6amST7HBoH5oOaTodtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZOBBQfHQAfaDPDZTrfoZWmJyP+X7FYFjcgB0pE7CCFFDQQVM6gdwmRjfyKWuptVW
         +xanstIS4FDR7LkZyhSt2f5/mWmtZbaf1r7rnojJ4hRNP3srJOMXYM8feMsB+7GUJT
         oVFnOKPQj9C4gihRlVjPpEzi6//Cju8UesjMNBlM4L2xQ4gOphowDZQTVZXd52vVz9
         /2LDAlT1VWJ5ddJDz170pesDwCQWouNTDiW8xh8rewCBRJ2H2CScNCSbdVIx0xn6jT
         bLK8uA7IIaSPFTGSD/YfYiq0t9TXvg1bx070UUn6Srrr0SBdSwIobVSLcq6CLu4+h6
         Thhroy1iqNPlQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gru-KO;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 02/12] docs: tegra194-hte.rst: don't include gpiolib.c twice
Date:   Sat,  2 Jul 2022 12:07:34 +0100
Message-Id: <de81b472f552bd651f140f0aa779a29652fffa62.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
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

All extern functions of drivers/gpio/gpiolib.c are already
inside the Kernel documentation, as driver-api/gpio/index.rst
already includes it.

Placing a kernel-doc here will only cause mess, as the same symbol
will be placed on two parts of the document, causing breakages
in cross-references.

So, instead, add a cross-reference there.

This solves those Sphinx 3.1+ warnings:
    .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gpiolib.c:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
    .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gpiolib.c:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2464.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.
    .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Duplicate C declaration, also defined at driver-api/gpio/index:2493.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/driver-api/hte/tegra194-hte.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
index d29b7fe86f31..f2d617265546 100644
--- a/Documentation/driver-api/hte/tegra194-hte.rst
+++ b/Documentation/driver-api/hte/tegra194-hte.rst
@@ -25,8 +25,7 @@ and userspace consumers. The kernel space consumers can directly talk to HTE
 subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
 framework to HTE subsystem.
 
-.. kernel-doc:: drivers/gpio/gpiolib.c
-   :functions: gpiod_enable_hw_timestamp_ns gpiod_disable_hw_timestamp_ns
+See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
 
 For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
 specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, which
-- 
2.36.1

