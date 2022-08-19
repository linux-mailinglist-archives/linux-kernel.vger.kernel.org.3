Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5311599C65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbiHSMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiHSMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E3C6CDE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBix0R020060;
        Fri, 19 Aug 2022 07:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=lx4GAB9Um5dfe7Rhlz40yyU1J88HrCUqmJv6PhWbfXU=;
 b=En1JpMJpH3HLLQKPGiD/l8+t5r2Y+PQwGq41J853g82pjHy7cdqgkgI72vcvBsukGfoi
 PvDyouNqj+QWSHYyVLCqW+f6ExD0kYfzOL9bMrftPtuR7zbP0hT89eQX9M3vcHi1BDMp
 kCxXJLS1TPiWsnI8lirI1zMnn/xQ0KBcBAIwO5hCJTWtyXjKfLv/E/NpVr3VLUwzgjcq
 UONodQUIX7eK2Nyf/ETLmnudHmM/yLp4Bf0NnG1YORscVBS+pZqaFHcVeC4WJBiEqMUr
 zYX4wlGKNJ/WpYR5r4I9zv+v//wzs49oiN8pZUrdAhyZc54PctChiXkGoUzplfmDsl+c RQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpfuvn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:37 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:34 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B2874476;
        Fri, 19 Aug 2022 12:52:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 05/12] ASoC: cs42l42: Use cs42l42->dev instead of &i2c_client->dev
Date:   Fri, 19 Aug 2022 13:52:23 +0100
Message-ID: <20220819125230.42731-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220819125230.42731-1-rf@opensource.cirrus.com>
References: <20220819125230.42731-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: osanZQ1CaN8e6fU7t7wsdiq0TeoF9Ic9
X-Proofpoint-GUID: osanZQ1CaN8e6fU7t7wsdiq0TeoF9Ic9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for splitting cs42l42_i2c_probe() into multiple functions
replace use of &i2c_client->dev with cs42l42->dev. This reduces diff
clutter in the patch that splits the function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 946b2a935256..4c81bda6b593 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2233,7 +2233,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
 	if (IS_ERR(cs42l42->regmap)) {
 		ret = PTR_ERR(cs42l42->regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		dev_err(cs42l42->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -2241,11 +2241,11 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	for (i = 0; i < ARRAY_SIZE(cs42l42->supplies); i++)
 		cs42l42->supplies[i].supply = cs42l42_supply_names[i];
 
-	ret = devm_regulator_bulk_get(&i2c_client->dev,
+	ret = devm_regulator_bulk_get(cs42l42->dev,
 				      ARRAY_SIZE(cs42l42->supplies),
 				      cs42l42->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"Failed to request supplies: %d\n", ret);
 		return ret;
 	}
@@ -2253,13 +2253,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies),
 				    cs42l42->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
 	/* Reset the Device */
-	cs42l42->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+	cs42l42->reset_gpio = devm_gpiod_get_optional(cs42l42->dev,
 		"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs42l42->reset_gpio)) {
 		ret = PTR_ERR(cs42l42->reset_gpio);
@@ -2267,7 +2267,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	}
 
 	if (cs42l42->reset_gpio) {
-		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
+		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
 		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
@@ -2281,7 +2281,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		if (ret == -EPROBE_DEFER) {
 			goto err_disable_noirq;
 		} else if (ret != 0) {
-			dev_err(&i2c_client->dev,
+			dev_err(cs42l42->dev,
 				"Failed to request IRQ: %d\n", ret);
 			goto err_disable_noirq;
 		}
@@ -2291,13 +2291,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	devid = cirrus_read_device_id(cs42l42->regmap, CS42L42_DEVID_AB);
 	if (devid < 0) {
 		ret = devid;
-		dev_err(&i2c_client->dev, "Failed to read device ID: %d\n", ret);
+		dev_err(cs42l42->dev, "Failed to read device ID: %d\n", ret);
 		goto err_disable;
 	}
 
 	if (devid != CS42L42_CHIP_ID) {
 		ret = -ENODEV;
-		dev_err(&i2c_client->dev,
+		dev_err(cs42l42->dev,
 			"CS42L42 Device ID (%X). Expected %X\n",
 			devid, CS42L42_CHIP_ID);
 		goto err_disable;
@@ -2305,11 +2305,11 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 
 	ret = regmap_read(cs42l42->regmap, CS42L42_REVID, &reg);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
+		dev_err(cs42l42->dev, "Get Revision ID failed\n");
 		goto err_shutdown;
 	}
 
-	dev_info(&i2c_client->dev,
+	dev_info(cs42l42->dev,
 		 "Cirrus Logic CS42L42, Revision: %02X\n", reg & 0xFF);
 
 	/* Power up the codec */
@@ -2329,7 +2329,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 			(1 << CS42L42_ADC_PDN_SHIFT) |
 			(0 << CS42L42_PDN_ALL_SHIFT));
 
-	ret = cs42l42_handle_device_data(&i2c_client->dev, cs42l42);
+	ret = cs42l42_handle_device_data(cs42l42->dev, cs42l42);
 	if (ret != 0)
 		goto err_shutdown;
 
@@ -2340,7 +2340,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 	cs42l42_set_interrupt_masks(cs42l42);
 
 	/* Register codec for machine driver */
-	ret = devm_snd_soc_register_component(&i2c_client->dev,
+	ret = devm_snd_soc_register_component(cs42l42->dev,
 			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
 	if (ret < 0)
 		goto err_shutdown;
-- 
2.30.2

