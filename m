Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642358349D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiG0VFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiG0VEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:04:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713761112
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h8so26064791wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=x+88BBJb57JukKqCcxtbzhuJ1izDyDxxyEMwGBi9sRsQElVLfC/KEGAmf8s4wJXVFx
         4+64HP3I1uRrT2vODAKBvbrB00FVGlVbMQU5HhvwIw9KW2F7FLLLDwgabrdAXGj+Akf6
         8Mk3FHtwywA3nqhYXq3y9VaQaDY3VnjBdVjGEh/8kbQA7oRhPentpoLGnsMtDSV4P4Fn
         T/puU7Lyo+pchOSrsXUAGlooCHHrODdVcPEwSdLdfPlqsZ/5sWG2ANbCdedDuweJP0/o
         Sds9i9n0Owi80qRvI3/8FvR6sddk/85654or77qvOSty+uWQN0GEKStWAIhv2g8JLmsw
         k1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=LU7oYOgpjaF6E0VuN6RM24lFQgn9kDbs/VG34EELhl3cm3v/PghnADJqy1RaFdqwZh
         mQ0DhiwK1t4ICPbqi7Yoe0XFq0ftoGs5tyJYpQD9cTfNjJJ+yUtVPqI/FgUcQYApjp+m
         gwGkY/u4N/O+Ym3Ibf3cUN2eZLvfIC7fvPcK3ihPiNFI9W5/sfIM1o9bxVLrl2py21dX
         Jd97qDh9VWdE+/SYobPtPkd0ds4amEFPZUZjRqgJoN2WtBIRk5cQx3jl5/N9kHW4no+e
         QgVEIE/ve+9WQ5irS3B0mCbN0ASC0UC/VR+BaFuVGBJfR9e9mPY1Kwaa2vsX6Cc7751W
         ay9g==
X-Gm-Message-State: AJIora//i5EXz9hH1Nu2o5XTqK8XCyH9qxEA1YMAtgT4X5/IbGEvZYtW
        omPVOBZykdLrR4mA5sjyrz4GUQ==
X-Google-Smtp-Source: AGRyM1slQQd537zbhaxi6R16/WJLy9sr0CulGmuYdFM7k5O2+9TcSk2qXRezXHRFGXF3/fBRBSrJWg==
X-Received: by 2002:a5d:6f0d:0:b0:21e:3c6f:f67c with SMTP id ay13-20020a5d6f0d000000b0021e3c6ff67cmr14497675wrb.606.1658955849378;
        Wed, 27 Jul 2022 14:04:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:09 -0700 (PDT)
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
Subject: [PATCH v3 25/32] ata/drivers/ahci_imx: Switch to new of thermal API
Date:   Wed, 27 Jul 2022 23:02:46 +0200
Message-Id: <20220727210253.3794069-26-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

