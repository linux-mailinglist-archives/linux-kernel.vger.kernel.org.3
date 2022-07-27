Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE958346A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiG0VDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiG0VDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962F56B8D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l22so4520031wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=p63s96nLXYTWShwkb3HveYC0wkd/lEVcTmY2Q5o4FA4IK0014u0g5vrlXI6K6w2lVE
         hIIHPXMoQYIuBWWGCApeJ7mz3m0XWMohh+0JDjVs9B9zrUW4/Y3U8ZOBAuvAhequS5l6
         FbkluvrI9BRS1pmsot1hIl6eMEOyGiS4gwt9SAE77zaIb69fvcIPjOE+PpEWuf95XT1S
         ObtHpbpF1H352sTctBt3q+iVuyOzArfvsq4dw5oYWVuCTvTs+Qa2VvsatLqQekDSIR8S
         lyTLo5N1gVcLhc24OHoUGkGhANMKGTlHK5/EsikQnzvmgXxMO1aPfBcZb2SvFSHv02Tp
         Bubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=bVciKX/KmtB4v8AePI6Ua9OQGTwiPK+/KItd/V1SaawegIcQGivP4diudSeAnO2wVj
         5tsBnhmoPvBGbO7T0yhSzmPjs2/9k9Be7KWdk/e66wwzlEXgOD18B7IkvE1ZozyPQvIP
         /0AM6rfyVntn7YnSy6LGGBRNbMgCUnaNdDuLRB/yoGskwusr4FGEyMJo6DNQdyfzDDCZ
         jXBQmtA9iFWRG4lmXu3I5zBjPlYdqIrb73J6NgYpm5Yhazcx0V93Sx6/mU5CTksHHBdl
         COxbRCerwN70I2ucoghL9YY+BM8nnoIbZNhvWO8+2hg8gjS1BzfO8rgOYNHCIZYPiAMa
         idmA==
X-Gm-Message-State: AJIora9EpDNar+0E4Ct/Ga4WyUSYElcCPPPho0Z3InELSuuN+a2dJNKJ
        Ruo6tteMF5eUvhtsK7i2rKMLMQ==
X-Google-Smtp-Source: AGRyM1vQb9Z86kPxNJ7n+LQMTHrUrGuInE6ax98pWLxqN9sI/+rRfh27NczTMyZzSKOSKsPjmCwl4A==
X-Received: by 2002:adf:ce0c:0:b0:21d:929e:1522 with SMTP id p12-20020adfce0c000000b0021d929e1522mr14544199wrn.126.1658955808783;
        Wed, 27 Jul 2022 14:03:28 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:28 -0700 (PDT)
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
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v3 09/32] thermal/drivers/sprd: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:30 +0200
Message-Id: <20220727210253.3794069-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/sprd_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fff80fc18002..ac884514f116 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -204,9 +204,9 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
 }
 
-static int sprd_thm_read_temp(void *devdata, int *temp)
+static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sprd_thermal_sensor *sen = devdata;
+	struct sprd_thermal_sensor *sen = tz->devdata;
 	u32 data;
 
 	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
@@ -217,7 +217,7 @@ static int sprd_thm_read_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sprd_thm_ops = {
+static const struct thermal_zone_device_ops sprd_thm_ops = {
 	.get_temp = sprd_thm_read_temp,
 };
 
@@ -408,10 +408,10 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 		sprd_thm_sensor_init(thm, sen);
 
-		sen->tzd = devm_thermal_zone_of_sensor_register(sen->dev,
-								sen->id,
-								sen,
-								&sprd_thm_ops);
+		sen->tzd = devm_thermal_of_zone_register(sen->dev,
+							 sen->id,
+							 sen,
+							 &sprd_thm_ops);
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
@@ -523,8 +523,8 @@ static int sprd_thm_remove(struct platform_device *pdev)
 
 	for (i = 0; i < thm->nr_sensors; i++) {
 		sprd_thm_toggle_sensor(thm->sensor[i], false);
-		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
-						       thm->sensor[i]->tzd);
+		devm_thermal_of_zone_unregister(&pdev->dev,
+						thm->sensor[i]->tzd);
 	}
 
 	clk_disable_unprepare(thm->clk);
-- 
2.25.1

