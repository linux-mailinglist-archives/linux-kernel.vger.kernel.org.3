Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF17471E43
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhLLWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:34:47 -0500
Received: from mail.wizzup.org ([95.217.97.174]:43970 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229838AbhLLWep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HjeuObHTxT5SBm5noxlsZ0/REB/4irXmfOfjaJve7Wg=; b=VQ7jL4+uH6pIGb9SPySu3HP1eT
        fsX2I1R5z6YlAJqgPr5+sLvvtMYDvz8mA6EeehfWlUd0ljB10mPTu2IEWh4mi/JDRPbilYu1vRdet
        bTe2MItfSKb8Wt3tf5QpmtEcH3WnsAB4WLrw2GJmw/lfefWSNwb4/+CDNuk57GFScuWFRrONBg1cy
        LooAFXH/AyAvnNyfwsb1gn676yW/r5LO4/iqbz+C4X1ZK6Stpd6ZXFgmugVNzs5xfP/LWQsa7SBIO
        wQPGcb+HauQX7zEEe0OOEqw8y3P3jRIdLT8Ci6Uqh9cjLPomyiKYkePe9Pl2m3sDduxshtTnVvwyG
        33ZcrYIA==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwXQS-0001do-Kw; Sun, 12 Dec 2021 22:34:36 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Doug Zobel <dougdev334@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] leds: lp55xx: initialise output direction from dts
Date:   Sun, 12 Dec 2021 23:40:07 +0100
Message-Id: <20211212224007.10293-3-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212224007.10293-1-merlijn@wizzup.org>
References: <20211212224007.10293-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a5d3d1adc95f ("leds: lp55xx: Initialize enable GPIO direction to
output") attempts to fix this, but the fix did not work since at least
for the Nokia N900 the value needs to be set to HIGH, per the device
tree. So rather than hardcoding the value to a potentially invalid value
for some devices, let's set direction in lp55xx_init_device.

Fixes: a5d3d1adc95f ("leds: lp55xx: Initialize enable GPIO direction to output")
Fixes: 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
Fixes: ac219bf3c9bd ("leds: lp55xx: Convert to use GPIO descriptors")
Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/leds/leds-lp55xx-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index d1657c46ee2f..9fdfc1b9a1a0 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -439,6 +439,8 @@ int lp55xx_init_device(struct lp55xx_chip *chip)
 		return -EINVAL;
 
 	if (pdata->enable_gpiod) {
+		gpiod_direction_output(pdata->enable_gpiod, 0);
+
 		gpiod_set_consumer_name(pdata->enable_gpiod, "LP55xx enable");
 		gpiod_set_value(pdata->enable_gpiod, 0);
 		usleep_range(1000, 2000); /* Keep enable down at least 1ms */
@@ -694,7 +696,7 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 	of_property_read_u8(np, "clock-mode", &pdata->clock_mode);
 
 	pdata->enable_gpiod = devm_gpiod_get_optional(dev, "enable",
-						      GPIOD_OUT_LOW);
+						      GPIOD_ASIS);
 	if (IS_ERR(pdata->enable_gpiod))
 		return ERR_CAST(pdata->enable_gpiod);
 
-- 
2.32.0

