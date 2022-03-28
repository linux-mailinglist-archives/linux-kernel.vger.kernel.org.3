Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50794E9316
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiC1LPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiC1LPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:15:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98E5522A;
        Mon, 28 Mar 2022 04:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D769B81053;
        Mon, 28 Mar 2022 11:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4495C34100;
        Mon, 28 Mar 2022 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466008;
        bh=HHV9Ri58ctEofpGBkf5IU36ecNuwh1ugqE59mUikbtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOKBPbUl3yJ+h0ZtAw3ZOQaBlNQxuRKO0XrTQ9kxYwDX1gYIuZFer9DINmoP805nn
         PgtB3e8geazD7VfV8prZbCgzkZaNsPtL9qQm+/84Pf5m6JQAAp84IO7ZpwJ/Z5FeZ8
         FlZs8VQDfgpLcsGDOwQPR+ofvZoro9GEmXRO8sxZXBSM91bC4EhsPSKjS4P+0it6CH
         l4fOxQ1YEaSL7noipHSTndhP8RB8nNF6STys3OKcS9OtY14UVdw5t3AlgKfJcz0HQE
         6+wQrVwYuRSIiub/0Ls1NZ4pcyPAg/eHDIFbwLA/SmK7P6jzho47e3MENkN50Ipr+d
         y+MEP3cmhMWJw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
Date:   Mon, 28 Mar 2022 14:13:18 +0300
Message-Id: <20220328111319.1236-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328111319.1236-1-rogerq@kernel.org>
References: <20220328111319.1236-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far for armv7 TI platforms, GPMC was being selected by
arch/arm/mach-* architecture Kconfig files.

For K3 platforms, GPMC is no longer required for basic boot
and cannot be always enabled by default by mach- Kconfig.

We need a way for user (or board defconfig) to enable
it if required so ake OMAP_GPMC Kconfig option always visible.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 30bff6cb1b8d..da2af9c38fe3 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,8 +103,8 @@ config TI_EMIF
 	  temperature changes
 
 config OMAP_GPMC
-	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
-	depends on OF_ADDRESS
+	bool "Texas Instruments OMAP SoC GPMC driver"
+	depends on OF_ADDRESS || COMPILE_TEST
 	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
-- 
2.17.1

