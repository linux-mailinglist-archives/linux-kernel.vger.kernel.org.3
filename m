Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0662058069B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiGYV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiGYV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745F248DC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v13so9937699wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dxp2C7hOahM111jOQKxvW4vMPiwlgfAm7+eoRoP/H0c=;
        b=s0JsTCXNvt2WXkcPVxGiAIXsDZBIj5/AZesH2AAmCTyIEv16R//Vuw19MnW0bj3ZRG
         XuDTksIpw4MlrYs/cjNUee35Kgmoe3mzLas8SPOGTENfmGVbH62AekMDGcRqLfQfWx47
         QHIJhEK+pvoQ3OsvU0bIKjNE0bSLJAMh1vWLYkZRZ1FM0BBm/fy51sDs8JmlHV2m1ZWk
         uGOZ46cC8LTcgJ2lt0ZmOzv5Is22R7LxCyO8G3Ly7NxpLMANhOBsRN4SMSvI3Ld25F+S
         /xlPKQnTOzN6Ag/mIT7OrSfged+na2T1jYMqAO/K8bndS3mUwyKaqU4VBTJR8Fqq3L01
         eW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dxp2C7hOahM111jOQKxvW4vMPiwlgfAm7+eoRoP/H0c=;
        b=zMXG7Uo6/HXW/oW69ZH0iukagUT9RIxoRA0rG8oeTY0m4gvr9iWt81azKm+E7+vvlu
         uOKPX7j+0//UmHQe9LDWyRI+iS136vJotDn8egDqtLrbFGEzZdxV/wuPalsW5hM5aRDA
         ziB7Od/1YafLpsP+ipV1Nibf8GZ15iXsTF1CkFz/MTpZjeX/Iv/mrozRHqegsBZmkuHp
         Wgq1i8078wwUVWywI0fkiA2GGaak4iZg6VYA651UkUw3aBtyMLHNmseEihFShH3XJBwP
         rdWUFhijRV81z/rNIw/XGaWJFT2G8LLwWQLi1G+x/zKSxKfUzWYMCUJzjnJErOeg2mNb
         WryQ==
X-Gm-Message-State: AJIora99jSR87rVoH8f35lOTxFcS/Lc4Kz6Wp75RAXamZviDPcqjW7fy
        G2OyxRtrzA/gVY7hbRmxROk3PQ==
X-Google-Smtp-Source: AGRyM1tLUg/TxD3ibkRz8emLONGbMJ+9j8IhiFQVSF+CzEDj/RrI348CxZMU0187ugCaQfxFAjyrsQ==
X-Received: by 2002:a05:6000:1a85:b0:21e:88f9:848d with SMTP id f5-20020a0560001a8500b0021e88f9848dmr4392788wry.82.1658784447240;
        Mon, 25 Jul 2022 14:27:27 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:26 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH v2 12/32] thermal/drivers/st: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:17 +0200
Message-Id: <20220725212637.2818207-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/st/stm_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5fd3fb8912a6..e4ca0d504a4f 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -302,9 +302,9 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 	return 0;
 }
 
-static int stm_thermal_set_trips(void *data, int low, int high)
+static int stm_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 itr1, th;
 	int ret;
 
@@ -350,9 +350,9 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 }
 
 /* Callback to get temperature from HW */
-static int stm_thermal_get_temp(void *data, int *temp)
+static int stm_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 periods;
 	int freqM, ret;
 
@@ -474,7 +474,7 @@ static int stm_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
 			 stm_thermal_suspend, stm_thermal_resume);
 
-static const struct thermal_zone_of_device_ops stm_tz_ops = {
+static const struct thermal_zone_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
 	.set_trips	= stm_thermal_set_trips,
 };
@@ -539,9 +539,9 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sensor->th_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
-							      sensor,
-							      &stm_tz_ops);
+	sensor->th_dev = devm_thermal_of_zone_register(&pdev->dev, 0,
+						       sensor,
+						       &stm_tz_ops);
 
 	if (IS_ERR(sensor->th_dev)) {
 		dev_err(&pdev->dev, "%s: thermal zone sensor registering KO\n",
-- 
2.25.1

