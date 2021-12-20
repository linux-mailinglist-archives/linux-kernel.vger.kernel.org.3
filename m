Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE92047B1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhLTRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhLTRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:06:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:06:31 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m25so10327775qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGYvrUtcghNdhEHNpV4zTbBKAn05WIfjj570cL025P4=;
        b=kshNHzUY2obZ0uKu7oBvpu8+FHTQ+GFaNQpgHRiCva7ekM+sbtJug+bdhtlD3Gy7Ny
         rZulrb7YtimRUMrZGcAmi0HK5LCl9vSxwYIfcE4+c2k2/6dhJxmeNNdWf7gEpdpojm92
         h5k3S3KdCNu+6H5DMyK2/GKZmhoNMRsdskSiswvRma/r+5kVDPxi3AHwlilMi9NAdP5E
         p+PZNk3ihYYIZoE5+EPKa+zZwLjOnxyunAXmI6krxBZ9VErCqWRKfHPFWg5NaxqCHbnv
         7jwJP8kmhl68sXXXMt7ViIaQ2EDlc+xRqneqdfCqt638viro9NGiK4lxbw3RMRIU1wvN
         W3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGYvrUtcghNdhEHNpV4zTbBKAn05WIfjj570cL025P4=;
        b=XwEFeCOJzJwcWE0XrHckG1vcB44vY/wK2vQ6/9dqKWOUM2jmS/fffnjLLUjAhk8vUk
         e4V6t3/HPtWcBRi1GRLeYi7o2mEZDAXEQUVLo8YlLPz5dDJMXBN5elxAsc0Lv8QJrMI0
         tPOhl+NDi43f5PVKMSUglk9K8CV+rr0D3JfHaaxHas48fAh6pA46AsoOxskmF5HkXqOI
         qTKhSPBnxm1rJPrXZSJ86Ol6khhUou6upgaaDUr4YLLHmqB4AMT1fGKJ+4+i2JiDLOch
         UNx89bgqQ1vejSClREMuBHuv+ZLrAdpymJsNmDDS+S1NuSltQ0igboa8y1JDGcXvVcWz
         qmCQ==
X-Gm-Message-State: AOAM530qCcnESV1lyniIH8yWL+KNAhXdfWbwFOfFQevoVWAdTE9QIqKd
        YeeKJfJZQ8X1iweYcauIuO4=
X-Google-Smtp-Source: ABdhPJxNkuI9f9OKfjxbNW1p9h3QXWO/lbDR/xtZaS/oFHRgHuUq/TX/xNDCJ8JMRMR67znY4Glo1A==
X-Received: by 2002:ac8:5742:: with SMTP id 2mr13245137qtx.554.1640019990549;
        Mon, 20 Dec 2021 09:06:30 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id y73sm11296270qkb.113.2021.12.20.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:06:30 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Date:   Mon, 20 Dec 2021 12:06:23 -0500
Message-Id: <20211220170624.1009898-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds reboot support to the rk808 pmic driver and enables it for
the rk809 and rk817 devices.
This only enables if the rockchip,system-power-controller flag is set.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
This patch was created to address issues with psci-reset on rk356x
chips. Until the rk356x series ATF open source code is released so we
can fix the issue at the source, this is the only way to ensure reliable
resetting on devices using these chips.

After testing the rk808 (thanks Robin!), it was found DEV_OFF_RST does
not reset the PMIC to a power on state. Since the rk805 and rk818 match
this register layout, I'm removing support for all three in the v2.
It may be possible to add support to them using an RTC wakeup, but that
has not been explored and is outside the scope of this patch.

Changelog:
V4:
- reorder rk808_restart_notify (Thanks Dmitry)
- drop of_property_read_bool before unregister (Good catch Frank)

V3: Thanks Dmitry!
- Adjust priority to be in line with other pmic drivers
- Move ret handling to case switch
- Make default registration debug
- Add unregister function on removal

V2:
- Squash the patch from Frank Wunderlich for rk809 support.
- Remove support for the rk805, rk808, and rk818 devices.
- Only register the reset handler for supported devices.
- Remove unnecessary dev_err and dev_warn statements.
- Register the reset handler directly

 drivers/mfd/rk808.c       | 44 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index b181fe401330..874d461dda44 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 struct rk808_reg_data {
 	int addr;
@@ -543,6 +544,7 @@ static void rk808_pm_power_off(void)
 		reg = RK808_DEVCTRL_REG,
 		bit = DEV_OFF_RST;
 		break;
+	case RK809_ID:
 	case RK817_ID:
 		reg = RK817_SYS_CFG(3);
 		bit = DEV_OFF;
@@ -559,6 +561,34 @@ static void rk808_pm_power_off(void)
 		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
+static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
+{
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	unsigned int reg, bit;
+	int ret;
+
+	switch (rk808->variant) {
+	case RK809_ID:
+	case RK817_ID:
+		reg = RK817_SYS_CFG(3);
+		bit = DEV_RST;
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
+	if (ret)
+		dev_err(&rk808_i2c_client->dev, "Failed to restart device!\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rk808_restart_handler = {
+	.notifier_call = rk808_restart_notify,
+	.priority = 192,
+};
+
 static void rk8xx_shutdown(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
@@ -727,6 +757,18 @@ static int rk808_probe(struct i2c_client *client,
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client = client;
 		pm_power_off = rk808_pm_power_off;
+
+		switch (rk808->variant) {
+		case RK809_ID:
+		case RK817_ID:
+			ret = register_restart_handler(&rk808_restart_handler);
+			if (ret)
+				dev_warn(&client->dev, "failed to register restart handler, %d\n", ret);
+			break;
+		default:
+			dev_dbg(&client->dev, "pmic controlled board reset not supported\n");
+			break;
+		}
 	}
 
 	return 0;
@@ -749,6 +791,8 @@ static int rk808_remove(struct i2c_client *client)
 	if (pm_power_off == rk808_pm_power_off)
 		pm_power_off = NULL;
 
+	unregister_restart_handler(&rk808_restart_handler);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a96e6d43ca06..58602032e642 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -373,6 +373,7 @@ enum rk805_reg {
 #define SWITCH2_EN	BIT(6)
 #define SWITCH1_EN	BIT(5)
 #define DEV_OFF_RST	BIT(3)
+#define DEV_RST		BIT(2)
 #define DEV_OFF		BIT(0)
 #define RTC_STOP	BIT(0)
 
-- 
2.25.1

