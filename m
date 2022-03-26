Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612294E8011
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiCZIpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCZIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FDDFDD6;
        Sat, 26 Mar 2022 01:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFFEDB8013C;
        Sat, 26 Mar 2022 08:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B1AC2BBE4;
        Sat, 26 Mar 2022 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648284217;
        bh=HHV9Ri58ctEofpGBkf5IU36ecNuwh1ugqE59mUikbtE=;
        h=From:To:Cc:Subject:Date:From;
        b=qpSodZ3b4PzAzV69sS5ZEwVpwP3kcP1grU144zhP4WapQ2MXLUVfexK/FmdgfwxcP
         55Ou1TaXozl2cC7aDKU9ZtDo4j5ABc4qOI0qWZ6Xcrz3ohndq/I76AjqfklrKG0vu9
         7F/g8+f1HS04gS041W2+AWD+9nCJtKZQVxVQ9xyLqX+kyfXYariHvE3FNQHLQkoDRn
         dv84CKSTZWlD6C8FxGzSgxIJDeWtJIMGBjR072nUQeFPPoBXQQR+BSl/4Gqj0LZNlM
         VEu7AMvNw77mflC20ie2ySygMJeqJvTUoALoOFxRlmUgzWCVDNidfKpZOcZPv1E6cc
         3jn2jQpcg5cEw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/1] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
Date:   Sat, 26 Mar 2022 10:43:31 +0200
Message-Id: <20220326084331.28310-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

