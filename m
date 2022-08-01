Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6053587321
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiHAVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiHAVXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E132474D5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so15610989wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Dxp2C7hOahM111jOQKxvW4vMPiwlgfAm7+eoRoP/H0c=;
        b=pcZJblaRye/CU2ZG2aS4bfkarrAJPR8cXC0LFsksRkWtGR161vS7ze8cLfF1rEfblK
         rQ6kSCvE+KyYpyEs/GNjMbzN2/vz1n3UU6EulgZbrKdFKdW0sXzesEUMR5J8thSwWXoU
         yX++xLcaVyfCdUB5Gyvw8PuyqMbFDcp0wCA1saq8q5/jyY3IRW7xRin8SuVw0/MFAt2n
         QqfyQ3Whi2/+mM4SkTIeFUEdb07Ej4EMCr2PEeEktE5U8f4wjm8RKXfA+v7rEYj+0zN6
         Cd4rLRzeBBmGZSKrxOXEYaEgNfAIV3r3FMQwTHHy7ZzK2l5Bld6ikof1C13L5ArqnNPT
         3oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Dxp2C7hOahM111jOQKxvW4vMPiwlgfAm7+eoRoP/H0c=;
        b=hr9PB/SmsVXV712S9BMk9YVh66Zq8H0Pg5DBqVeC5qXPwX5kCFARtzCEkIe23oy5EI
         RMmwxmFi1wJ1EQWKHveg2g/RWzFu0upt0nBgPOk2onfdiKNr1LNyWt7oMKRQjFmpY7el
         gpJZnTW4Q1n+RTmPgIdkeQhn5mSCRb8t+EzBmKOTfDzATijL0gFt9lYLs3uJy+AdFW4w
         K6UwNrbGdwwMhyuIUMCiOvS4QA2lbx4AhmK8TNbZ8j4jRDX0cm5bvksKV3jsdF/jQZ5d
         m5tiJU7k2gwlqVT4Ka4EBe06A1G26nh3OdPIew48lX81zXDqDOcITDlhgqR3Mb7JzBIu
         q/IA==
X-Gm-Message-State: ACgBeo1CIS6H7dQe11i5YNyHYDAfpHE3SMBRPUsD7AiXjoNeRdHM1XIj
        RDYLFnI4HrywCttjab7f26izsA==
X-Google-Smtp-Source: AA6agR6btACMuEpyA6/viNcHMHjs1GPLsxuLBfadlyEO6Vct9/gpgVno3agbcYvw+AmU0aYsslXq1Q==
X-Received: by 2002:a5d:6dad:0:b0:21e:903f:f45e with SMTP id u13-20020a5d6dad000000b0021e903ff45emr11488602wrs.385.1659389016074;
        Mon, 01 Aug 2022 14:23:36 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:35 -0700 (PDT)
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
Subject: [PATCH v4 12/32] thermal/drivers/st: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:24 +0200
Message-Id: <20220801212244.1124867-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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

