Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1604764E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhLOVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhLOVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:50:04 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Dec 2021 13:50:04 PST
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:50:04 -0800 (PST)
Received: from mxout3.routing.net (unknown [192.168.10.111])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id DC8492C443
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:33:14 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id F22186005E;
        Wed, 15 Dec 2021 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1639603991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWzxlx8Nu1TPpJuRyawo3q2Yic58WXyHq727goeDI64=;
        b=UlZuhgjD+l69zDOV6n5WQYu+twE27OiIjIapVcRzDjuXX2x8h90XXXU5M9T89PAO66NhfO
        S14jHhQ2UBUcgOiuwvIHWON2jdAMKkrwZ0yMzD+SaUSRhKgD7+oJiPRngv/DW0o8NWp77c
        G3ExuGqSP9zb7+3XyWxb/B9s7649q2A=
Received: from localhost.localdomain (fttx-pool-80.245.79.169.bambit.de [80.245.79.169])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 61540405D6;
        Wed, 15 Dec 2021 21:33:10 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
Date:   Wed, 15 Dec 2021 22:32:59 +0100
Message-Id: <20211215213300.4778-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215213300.4778-1-linux@fw-web.de>
References: <20211215213300.4778-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 5268f42b-9bee-4701-a1c8-c6f8dd6d6554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

This adds reboot support to the rk808 pmic. This only enables if the
rockchip,system-power-controller flag is set.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/mfd/rk808.c       | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index b181fe401330..afbd7e01df50 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 struct rk808_reg_data {
 	int addr;
@@ -533,6 +534,7 @@ static void rk808_pm_power_off(void)
 	int ret;
 	unsigned int reg, bit;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	dev_err(&rk808_i2c_client->dev, "poweroff device!\n");
 
 	switch (rk808->variant) {
 	case RK805_ID:
@@ -552,6 +554,7 @@ static void rk808_pm_power_off(void)
 		bit = DEV_OFF;
 		break;
 	default:
+		dev_err(&rk808_i2c_client->dev, "poweroff device not supported!\n");
 		return;
 	}
 	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
@@ -559,6 +562,44 @@ static void rk808_pm_power_off(void)
 		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
+static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
+{
+	int ret;
+	unsigned int reg, bit;
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+
+	switch (rk808->variant) {
+	case RK805_ID:
+		reg = RK805_DEV_CTRL_REG;
+		bit = DEV_OFF_RST;
+		break;
+	case RK808_ID:
+		reg = RK808_DEVCTRL_REG,
+		bit = DEV_OFF;
+		break;
+	case RK817_ID:
+		reg = RK817_SYS_CFG(3);
+		bit = DEV_RST;
+		break;
+	case RK818_ID:
+		reg = RK818_DEVCTRL_REG;
+		bit = DEV_OFF_RST;
+		break;
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
+	.priority = 255,
+};
+
 static void rk8xx_shutdown(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
@@ -727,6 +768,13 @@ static int rk808_probe(struct i2c_client *client,
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client = client;
 		pm_power_off = rk808_pm_power_off;
+		rk808->nb = &rk808_restart_handler;
+
+		dev_warn(&client->dev, "register restart handler\n");
+
+		ret = register_restart_handler(rk808->nb);
+		if (ret)
+			dev_err(&client->dev, "failed to register restart handler, %d\n", ret);
 	}
 
 	return 0;
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a96e6d43ca06..5dfe0c4ceab1 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -373,6 +373,7 @@ enum rk805_reg {
 #define SWITCH2_EN	BIT(6)
 #define SWITCH1_EN	BIT(5)
 #define DEV_OFF_RST	BIT(3)
+#define DEV_RST		BIT(2)
 #define DEV_OFF		BIT(0)
 #define RTC_STOP	BIT(0)
 
@@ -701,5 +702,6 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
+	struct notifier_block		*nb;
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.25.1

