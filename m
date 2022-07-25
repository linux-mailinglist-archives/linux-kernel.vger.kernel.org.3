Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3365806B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiGYV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiGYV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C027252B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g2so9659986wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCM3yQVLWF86sbYiyvudiotSwDPj8nChQ6qnbaMqhHs=;
        b=vDf+UJQ90Y1OWcD9jAnPyUDj6PkXAIzUZs8Stl2T8Wwp2Ny/rUiqSVophvD3G96yuQ
         lESLHGbb59gI+rUi0Hcjr6568aF+hmWk0pf4X7Ix7akWPPeBUYA/2MoqKJ8BPp9tHw/c
         n/u7RiY1/D7LNPLFE07I49c5y1wM6T5stX3lsJAM54XHJ73/SS6PoNp7Do2wrqbjKfcJ
         Af04ZoPkKxUoECcmKBsZpL4vMk9H3L2qnaiG2l4o5MepqTlXXhnZ2s4eOWJpUp/zYETY
         ke945GH7Dk3mEnAD/zhFbqCnIJzUWsPLq9gsZJw2I+YA8eHItz2G43rEI/AIxfsdVwnm
         PZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCM3yQVLWF86sbYiyvudiotSwDPj8nChQ6qnbaMqhHs=;
        b=YErEx+JJrFn5RUX6ZOY7qKCGMCLjrTAeMNCJ+Vj0uR8Nq7TZ0hD52INywlsyKKkN2+
         eKtCyOnEubgMiD/Dc/1mIXKRD4D+7SEd9ab/WVKf9SCoChIqhalWlJ5vp2Ypr1vfVHL8
         h4SmhGL2laUolS9hQW2j4PB1bpTQqDH2L9/vuE4yu1z1m05SZeNOrg0s6SYp2dECqI5Z
         5cQNLnHRhwL/48ztbdnfUUklpOOLFG/zDaEmJDmUnjyw64S21ZQSC/rErbtK1P4p4+Mf
         cdRyCS4qkZEYr7We/j6uLodCJ9yTlPM8NEf6cIimEHcg5VmnISEZGaQNR7UNs+GNnBju
         w3EQ==
X-Gm-Message-State: AJIora/w0Xc+zxloqBFiGCfzXgz6bAGCswF34NMBlAGP9RNefAJ0LCiZ
        vx58DL7/Plivx/RsjM+7LQZfDA==
X-Google-Smtp-Source: AGRyM1uxSmqjc+KicVfEox4C6+Jx/zNXBWMGNOe4hpzsYpYRTzP2OOFmX4pTibti8j4IRFLYXUoFzA==
X-Received: by 2002:a05:6000:2ab:b0:21e:2e68:52f4 with SMTP id l11-20020a05600002ab00b0021e2e6852f4mr8435661wry.236.1658784475211;
        Mon, 25 Jul 2022 14:27:55 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v2 25/32] ata/drivers/ahci_imx: Switch to new of thermal API
Date:   Mon, 25 Jul 2022 23:26:30 +0200
Message-Id: <20220725212637.2818207-26-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.

So in order to change the function prototype for the get_temp ops which
does not take a void* but a thermal_zone_device* structure, this
function wraps the call.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/ata/ahci_imx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 79aa9f285312..b734e069034d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
 }
 
 /* SATA AHCI temperature monitor */
-static int sata_ahci_read_temperature(void *dev, int *temp)
+static int __sata_ahci_read_temperature(void *dev, int *temp)
 {
 	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
 	u32 str1, str2, str3, str4;
@@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
 	return 0;
 }
 
+static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
+{
+	return __sata_ahci_read_temperature(tz->devdata, temp);
+}
+
 static ssize_t sata_ahci_show_temp(struct device *dev,
 				   struct device_attribute *da,
 				   char *buf)
@@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
 	unsigned int temp = 0;
 	int err;
 
-	err = sata_ahci_read_temperature(dev, &temp);
+	err = __sata_ahci_read_temperature(dev, &temp);
 	if (err < 0)
 		return err;
 
 	return sprintf(buf, "%u\n", temp);
 }
 
-static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
+static const struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
 	.get_temp = sata_ahci_read_temperature,
 };
 
@@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			ret = PTR_ERR(hwmon_dev);
 			goto disable_clk;
 		}
-		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
-					     &fsl_sata_ahci_of_thermal_ops);
+		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
+					      &fsl_sata_ahci_of_thermal_ops);
 		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
 	}
 
-- 
2.25.1

