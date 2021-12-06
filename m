Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6546907D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhLFGvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:51:14 -0500
Received: from cpanel.siel.si ([46.19.9.99]:43350 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237922AbhLFGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vZCZcj5C5fQdVQXJ2dLCDmj5tpTww7mWFs7wRr+gs+s=; b=bWxslIDkTdg8ZftYgAxXHhS6Lw
        fzgwRPNbzkkTIrgVxK92nOp0b1JpENxHhtcDaZa6teYkEPPBrkLEPIcjdy0/pFHpSZUW9NmFXq/M7
        4iPkeccSo3OlSbNwDvFSnMSdqYvHh+VzvAjRn5T/9JpYcvLpAtfydKP0aaLIp7VzMBaLLSZKMq0D6
        leu2rJdt/M4C4KM8xc8pqPUzmxigLZlo/aHzGprdG+4CXSZ6g7bHsisgcykyl5ts9trlMV17Qx6lj
        31l6ObOaNxwl/a570c4OU0U0SE0/uqLxE0xmi6GvONBwg3InBq5vbc0TJZcoD36h9bUXPmZmN78jc
        +jXC/TEg==;
Received: from [89.212.21.243] (port=40020 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mu7me-00GJXR-LI; Mon, 06 Dec 2021 07:47:40 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com
Subject: [PATCH v5 3/5] watchdog: da9062: reset board on watchdog timeout
Date:   Mon,  6 Dec 2021 07:47:30 +0100
Message-Id: <20211206064732.280375-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206064732.280375-1-andrej.picej@norik.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
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
binding ("dlg,wdt-sd"). There is a possibility to change the behaviour
of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
clearing it enables POWERDOWN mode on watchdog timeout.

If no DT binding is specified the WATCHDOG_SD bit stays in default
configuration, not breaking behaviour of devices which might depend on
default fuse configuration.

Note: This patch requires that the config register CONFIG_I is
configured as writable in the da9061/2 multi function device.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v5:
 - fix spelling mistake in commit message

Changes in v4:
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

