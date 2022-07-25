Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5855806A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiGYV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiGYV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A124F3F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m17so17425551wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=TrmbTyY+Jm2q3X/X6q1QtexNHvpBiAtomY5PyCgxik2uwmeaOGsOEuZemKSuqC97io
         Sk5axPQjpfDHpUFPl4ipa5f4cqQs9MVFPBDsO5t3w3MzZ39hrFXWdlt2VXIrcIASvktu
         TZISCuAMjEKCDjKiV2pWa1SkEreQbNQOu8mWIpovWrCB8o9zXvfjmfMekKdDhSGmlt/V
         tviRbaSiOAiiOy7W0YREjxbLjNFVkV4IefXYr6J+6/IAjMGPR6yb3r6ILhaXkCz/L2kp
         1Vw76tVpM8nPiiUODJ9GLAFiE2TW1SQrC/T2WtCc9qg66L6byOzbALRM5EWxFyORY0Vp
         h58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=0A38iUnu5L2aA/273LYr2EvbxiPMZNXczcseVHbwaNbIAB+7nrg0CNpX96MobxGqjT
         bThKKZIh25r70ocEx8Cx7bTJS2cOW7JedonQiCBOJF8bGKcEYlcTQfteSRUvd2ZofvgT
         9tAjxmbZHK2kAICWp2TGGrsJqKMHVk5y0sVgCaavLU8UrEOg5Bws8GTr/T0ceGUnS/Xa
         4giXQLFgbRYHWQ88nKSwMysY9FxV2eTStVwikAVEotqXqxflHmgEQlsNlH/bmRtYOA3d
         WPhAVNZo21yW2XjQrH4E8zWDNgoYl/FHyYDZILdEfaRq3f7Xh9JiguyLtlQfq2LSzpGI
         FbKw==
X-Gm-Message-State: AJIora8RapDaZ+j0UTsEx2omYYJcyd3TP/OZiRWFF+4xrS+Llut/nZYH
        Y5w0LGh+CR0pmS2IqmkDLGuRBg==
X-Google-Smtp-Source: AGRyM1umqWm+lULt+EkMxEKGIKTa0FZKFgM3T61QU8a0rBwxpmni/9bWC4Jmj8OwNZ9DmLN1TN8HMA==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id a3-20020adffb83000000b0021d649a72d9mr8412084wrr.688.1658784451499;
        Mon, 25 Jul 2022 14:27:31 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:31 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 14/32] thermal/drivers/armada: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:19 +0200
Message-Id: <20220725212637.2818207-15-daniel.lezcano@linexp.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/armada_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..52d63b3997fe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -420,9 +420,9 @@ static struct thermal_zone_device_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
-static int armada_get_temp(void *_sensor, int *temp)
+static int armada_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct armada_thermal_sensor *sensor = _sensor;
+	struct armada_thermal_sensor *sensor = tz->devdata;
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
@@ -450,7 +450,7 @@ static int armada_get_temp(void *_sensor, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops of_ops = {
+static const struct thermal_zone_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
@@ -928,9 +928,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Register the sensor */
 		sensor->priv = priv;
 		sensor->id = sensor_id;
-		tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  sensor->id, sensor,
-							  &of_ops);
+		tz = devm_thermal_of_zone_register(&pdev->dev,
+						   sensor->id, sensor,
+						   &of_ops);
 		if (IS_ERR(tz)) {
 			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
 				 sensor_id);
-- 
2.25.1

