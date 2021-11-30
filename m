Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC84635B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbhK3NqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:46:23 -0500
Received: from cpanel.siel.si ([46.19.9.99]:38798 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhK3NqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GQkn179EA6RB5tPAroeqjE3Zjye4M/4SllOBH6o7hPI=; b=TwXaE1j6UOw7LwmcPgBY3TuMI8
        hxX6aOKGkZB8N5jrOxtlMTeUeHYEQPDTe8mgESYBDbipsVVftHpfKy/VByaSmw6/vLuTrfQKATEha
        2hd+Tb2eT6pKW12bfgUt8IXUtxRjXQEc1HKYKP/ZgEPxqvDjU5Y4YYkgo+YmiV8eohQV7KWC88SDP
        kugBwzn5MwXe7x3OWOlqb2wjq5sGw0TprfR1lHFqkCaHitQWrMy8MrXddlJFqCLxFmpva2D1wKMp+
        hQtedl3lK+cazrJOSamrJ6II/cBmyziOFIHczXKmh+6eixy+tykLoBYJlSfYMzM+jOuU4PVppe5Dl
        58SGsy6g==;
Received: from [89.212.21.243] (port=49710 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3PJ-0039GW-C2; Tue, 30 Nov 2021 14:42:53 +0100
From:   Andrej Picej <andrej.picej@norik.com>
Cc:     andrej.picej@norik.com, support.opensource@diasemi.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] watchdog: da9062: reset board on watchdog timeout
Date:   Tue, 30 Nov 2021 14:42:40 +0100
Message-Id: <20211130134242.3516619-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130134242.3516619-1-andrej.picej@norik.com>
References: <20211130134242.3516619-1-andrej.picej@norik.com>
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
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/watchdog/da9062_wdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index f02cbd530538..e342e9e50cb1 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -85,8 +85,33 @@ static int da9062_wdt_start(struct watchdog_device *wdd)
 {
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
 	unsigned int selector;
+	unsigned int mask;
+	u32 val;
 	int ret;
 
+	/* Configure what happens on watchdog timeout. Can be specified with
+	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
+	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
+	 */
+	ret = device_property_read_u32(wdd->parent, "dlg,wdt-sd", &val);
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
+			dev_err(wdt->hw->dev, "failed to set wdt reset mode: %d\n",
+				ret);
+	}
+
 	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
 	ret = da9062_wdt_update_timeout_register(wdt, selector);
 	if (ret)
-- 
2.25.1

