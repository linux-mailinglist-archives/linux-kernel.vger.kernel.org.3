Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59D747ADD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhLTOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhLTOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:52:05 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29604C08EAFB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:46:59 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id js9so9497456qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLMO4XLtzBSrwFCLcbN4dCmvE/DOyGne8QsxmfrRPks=;
        b=hFL9lwQeHWdwyGEbBdZhyBQx9V6FPycpQZ6JogRSqz1PXr4adEjRdpLOct0EWGJiC8
         4jyMKaGrGbPXMaNxOhLlVsGAdMLdeMF71GgJ26BgOFFAkbYAKo7XhxCa/0HVX55Z1g/C
         za0I8/asEWr/JZTaNnT0nt5zq5+ctnkqB5WgENBurpB4ow2PcRvsUah338tnUg7dsFSO
         KqFZ5yt1hpXckcdTpQBWZaHlTCBdT2Hld+0MoFzEzmmW3EMF6ARiQ0/GDu3PEVpFe8SW
         xjEw3r/cA7+Jppy2jJlQOCIIxPkP7sHBNQhdrIMMpsL9J0anvPFqVujTb90MV2SmRR70
         WsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLMO4XLtzBSrwFCLcbN4dCmvE/DOyGne8QsxmfrRPks=;
        b=fChgrxxNQf8TCo6qZ6k9CBHOKYXcvvL545Yk5eRxONArmstgzFmJMtPZW+sHUYsK3j
         d8sIez6c8njVS1vgxTHBmOXdjLybhVQzLKFBvEox6rS/OXOKaV7BlhhAR6aMMNO0vmkY
         TdcGln/PKbcE4ZWz9ayWlYrOjgfEkldOvo/Dqg0odq2L/o/X0mz7R9cZzXv6X8DkI7N9
         VwbNhZsrpxxi7YnOKld8TvjsN6IZGNIOduB2gkC11Qb3afgqeFORMhXwGwerJXhpWL/A
         TYizSiuWUZ7wPayyX2BOE97ixSltziCoQGBzpVx551nxwWr0RQom4sQ5dUYJ6HGtXemi
         giOQ==
X-Gm-Message-State: AOAM533PXP4K3zkNlUQzXtXnJdio8qufFRiHSaCpPOcFH/Wbez17Yfhy
        unv/UAf/9UKRlYmavalP/YM=
X-Google-Smtp-Source: ABdhPJz1vNr89++rWsFg/jH/h5clBKL6gqXxI3El918AEw51NdmM3jXbOMth4FrfX+X7Ae9FW8PH9g==
X-Received: by 2002:a05:6214:caf:: with SMTP id s15mr13151311qvs.33.1640011617247;
        Mon, 20 Dec 2021 06:46:57 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id v12sm14965011qtx.80.2021.12.20.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:46:56 -0800 (PST)
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
Date:   Mon, 20 Dec 2021 09:46:54 -0500
Message-Id: <20211220144654.926112-1-pgwipeout@gmail.com>
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

 drivers/mfd/rk808.c       | 45 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index b181fe401330..f3a79e23ac6e 100644
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
@@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client *client)
 	if (pm_power_off == rk808_pm_power_off)
 		pm_power_off = NULL;
 
+	if (of_property_read_bool(np, "rockchip,system-power-controller"))
+		unregister_restart_handler(&rk808_restart_handler);
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

