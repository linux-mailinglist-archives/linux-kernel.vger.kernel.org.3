Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8A478E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhLQOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhLQOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:55:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:55:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id p19so2783542qtw.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtcOS73MMuTSnqyUtIZf+L5nKHAZxvPbB6o8V1hZyjM=;
        b=pKzUbHI9kfxRcJMTXcxX2W7LVyGkKWWnRlhLTz18NC3a6Uw4UYaNyPZtpwt6qBxBEO
         67k5oPomwL3gtNL1xQh6P65FuwlhK2Db0I48xQZiCiNXGfqpeia3DrOzV5uC52XmInc1
         jkaLNT+DWr9r4CAwPxzeY679YTNtSJBbbb85BBmJxZM52rK/v+hQ/yTVF7WfasqSBG9S
         QV2RCbNA+KUT345Yc99H59W/c09gh1m8/GMiJqc063Qdi0lUC7ny5i48aF1dBPlTiUEy
         eqTbjt8wqgRoyp130yPT78Hwdhr+nkcIG+bB93N3U3h1d/yI2wZa1pr2NFr/Yk109xL8
         7ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtcOS73MMuTSnqyUtIZf+L5nKHAZxvPbB6o8V1hZyjM=;
        b=7kKS1gYzisFamh5vbietDItS7xLPSnNGdqHXqDYoAK3PNwsqFb8a5Eky+72Qa6i2ZM
         hbmtC2JZNRLPo9eH0ExOAm7FJyZCaMmTiiTPtXmbaFM8QNHe6Xyae4Bwa8vFNcGBzVGH
         27gaUGgwJBSptUjYm2O1iuikN/vO4/nO9/PZ5+R4bDtMZdN9d2f5BCak71H3oAL9DapE
         URmqQSPC4DNlIgki6toeZ5MbNJWF3HxnNXXcan6H1bdDI+SJ18DaZ9yUvFITzoLLIh3G
         44TAoMG+U7NsFfptVy8OZwtKbSx8Lfg4rm3qUdxjPEXNdNFH6+GMGUMHqFP1tESR9ync
         8q5A==
X-Gm-Message-State: AOAM532ZATAVaoUoYrGpEgTMbVQqpLsdp7M90G+BqnZM2CCQ0Uhl8hAV
        oN7Fyyx5RtYRfwc1nrKQepCYY8kWQHUxjg==
X-Google-Smtp-Source: ABdhPJw8N/0bg1xJaQNrA1IXrd7by/PdqZLXyIW33rKr6C/KJpBOUuMXNA18L5ZKhPD9XSKNURmCDw==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr2604178qtw.1.1639752947547;
        Fri, 17 Dec 2021 06:55:47 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t35sm8310727qtc.83.2021.12.17.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:55:47 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: rk808: add reboot support to rk808.c
Date:   Fri, 17 Dec 2021 09:55:43 -0500
Message-Id: <20211217145544.341617-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds reboot support to the rk808o pmic driver and enables it for
the rk809 and rk817 devices.
This only enables if the rockchip,system-power-controller flag is set.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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
V2:
- Squash the patch from Frank Wunderlich for rk809 support.
- Remove support for the rk805, rk808, and rk818 devices.
- Only register the reset handler for supported devices.
- Remove unnecessary dev_err and dev_warn statements.
- Register the reset handler directly

 drivers/mfd/rk808.c       | 43 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index b181fe401330..6fa7fbf9b695 100644
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
+	int ret;
+	unsigned int reg, bit;
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
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
+	.priority = 255,
+};
+
 static void rk8xx_shutdown(struct i2c_client *client)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(client);
@@ -727,6 +757,19 @@ static int rk808_probe(struct i2c_client *client,
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client = client;
 		pm_power_off = rk808_pm_power_off;
+
+		switch (rk808->variant) {
+		case RK809_ID:
+		case RK817_ID:
+			ret = register_restart_handler(&rk808_restart_handler);
+			break;
+		default:
+			dev_info(&client->dev, "pmic controlled board reset not supported\n");
+			break;
+		}
+
+		if (ret)
+			dev_err(&client->dev, "failed to register restart handler, %d\n", ret);
 	}
 
 	return 0;
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

