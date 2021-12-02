Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196C246607A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356500AbhLBJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:36:16 -0500
Received: from cpanel.siel.si ([46.19.9.99]:49382 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356459AbhLBJgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dyIk5hA78X16RFXD8OnNYW+CBD5Jfl4vJx9AyepYcHU=; b=aJ0EvSL2k0vuhA7rwQH18H+CMp
        OTZr1itL/2y8MI7DI5ZrLklpDX2b+Fxn/u2zgLNK6E2+aUZGhOTcUitSvPCU4j4P8LNwCqv6NsZQj
        mfxMFItk67iaH+tDbvs1LNGejuAlbfl6fTboiMYN7LNtdoeXkimQPmz2d8TppIYgN5as08PIP8e3P
        P9pTc1NsF5tLqwKqHlLSqeV1LYQCF5NA/DCCJDhx1DV2qmt199Epb5V+n84k1PyotqON2fFlTYxSS
        MAs6LtX/nm6XgC/zi64JqgD84IW7EBfvli5EFdY0rrqK98R20ukRwdayH0tUowS7hJVHaxcFruA8o
        7vmTcu7w==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52018 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1msiSB-00DPB6-1h; Thu, 02 Dec 2021 10:32:42 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] watchdog: da9062: reset board on watchdog timeout
Date:   Thu,  2 Dec 2021 10:32:28 +0100
Message-Id: <20211202093230.3951996-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202093230.3951996-1-andrej.picej@norik.com>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a method to change watchdog timeout configuration based on DT
binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
clearing it enables POWERDOWN mode on watchdog timeout.

If no DT binding is specified the WATCHDOG_SD bit stays in default
configuration, not breaking behaviour of devices which might depend on
default fuse configuration.

Note: This patch requires that the config register CONFIG_I is
configured as writable in the da9062 multi function device.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Chnages in v4:
 - move the code to probe function

Changes in v3:
 - no changes

Changes in v2:
 - don't force the "reset" for all da9062-watchdog users, instead add DT
   binding where the behavior can be selected
---
 drivers/watchdog/da9062_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index f02cbd530538..bd85f84b0fd4 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -195,8 +195,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	unsigned int timeout;
+	unsigned int mask;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
+	int ret;
+	u32 val;
 
 	chip = dev_get_drvdata(dev->parent);
 	if (!chip)
@@ -236,6 +239,30 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
 	}
 
+	/*
+	 * Configure what happens on watchdog timeout. Can be specified with
+	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
+	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
+	 */
+	ret = device_property_read_u32(dev, "dlg,wdt-sd", &val);
+	if (!ret) {
+		if (val)
+			/* Use da9062's SHUTDOWN mode */
+			mask = DA9062AA_WATCHDOG_SD_MASK;
+		else
+			/* Use da9062's POWERDOWN mode. */
+			mask = 0x0;
+
+		ret = regmap_update_bits(wdt->hw->regmap,
+						DA9062AA_CONFIG_I,
+						DA9062AA_WATCHDOG_SD_MASK,
+						mask);
+
+		if (ret)
+			dev_err(dev, "failed to set wdt reset mode: %d\n",
+				ret);
+	}
+
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-- 
2.25.1

