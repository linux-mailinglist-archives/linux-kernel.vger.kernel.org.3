Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819324AE25E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386179AbiBHTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBHTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:40:28 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A196C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:40:27 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l14so3387690qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8OOhMPiL2g7dZ4KQkAzRGSsEf6CgBqobcbl60qNN4I=;
        b=BeTGhE6kfd0itErFlri8GBsQfNcO5MBAbc8WM3Azl/dqzm1t2XjxXWIIfCnBDk695I
         vJUXwKjmJrN9G5ZHO1MbQeZ9HKP1JfgMwcyWYTOhyvKx3AJERs8yKkJVXRAXDCfp0wfl
         VfQOLBQlpzZVJoiOagcddSArbGYvEx+ENRBVHsVqQgLFUP0jiXqKuDk/AzTD+dV+lkdt
         MC2UpRUWl91kGu/Z5oX+oDMRMsMUvmLJbbBQTYoH57t6skU1ppG/NKckqMvj3cqwS+nX
         tX2bU2hjyPH+44PYtEb8yTk4kc8zfH2PdDG6rJ68ZHX4D+ypyE6Gd22G7CZ8vAIPHd+I
         fQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8OOhMPiL2g7dZ4KQkAzRGSsEf6CgBqobcbl60qNN4I=;
        b=KbcLw3qxsPdv6wDFsR0C/jn5QCjE+qJBbh5eaHyvoO72lF3mt1BkUanLP/buzc1ZQw
         mVJqZxYbsknY6TQ1nkS8HsDfFRO5UECCQaUI6b440ERF7ZIQv+6/8xw6Z1dhVmGeUyPV
         vXzqAlmUYuD/mJOm1JpZO95GQ6GURZ8QGm7FenMZFhTvf9y6ggFfV0Q6ZaTttgdhCcj8
         JsB2xlmhVBpkfiS0H8GyKNfCC6qL3tY9AuMPK5nCk3EvsAXAOK17S86K/RbM1mp89/4l
         YLVlFTsD+O//VpzDEjxZsFPHvVVE+KjCDvLXF6anEDKqOtS2FTyXA/OjzO6KI+7qbzDJ
         ZMfw==
X-Gm-Message-State: AOAM530/hdCi1LUHH+CnJPWQghe1xBJQifYaYY2BzWArwXEWrOrjZib9
        fEEFJmNafk5oiPtEz3bWqJOcYOu8evbX9g==
X-Google-Smtp-Source: ABdhPJxHcmZ6eQPEwiU+PLQpJM+WPBGZxZkUYzZyCfh/jLWZpzXVb0zegpoDS8mpDGkRcBBSRM8gPQ==
X-Received: by 2002:ac8:578a:: with SMTP id v10mr4292435qta.14.1644349226236;
        Tue, 08 Feb 2022 11:40:26 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id c78sm7167202qkg.42.2022.02.08.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:40:26 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] mfd: rk808: add reboot support to rk808.c
Date:   Tue,  8 Feb 2022 14:40:23 -0500
Message-Id: <20220208194023.929720-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds reboot support to the rk808 pmic driver and enables it for
the rk809 and rk817 devices.
This only enables if the rockchip,system-power-controller flag is set.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
---
Changelog:
V5:
- Fix length of error print.

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
index b181fe401330..4142b638e5fa 100644
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
+				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
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

