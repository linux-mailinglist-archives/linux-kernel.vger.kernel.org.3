Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161CE587341
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiHAV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF86481E6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:24:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so7540277wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=7p+CjkFGKSQi35uasn1I3nC8Ivn3QGuamMVh8OMTFvATCqAwxvcKhJ4fWBUs0X37rg
         1x49X71uxJ+JIWRFnXCkWQoWVTge4O+YhBXNP6qLWujn6XgGu7UjbpG2P7tI+infzAaP
         NEx6kvhlLJg0YQGgevzh2S02rHQQem7JjI9S2DHPRecvo06U6A1dzOQp7lgOruWddOwV
         bznRgIbJpqcSeoyFwtGL/gn8DGToZy60EX78L8l/obXwB3UfkCBw4MrdWLIH9ejDxMzA
         SHtdstwoNAg3g/E1qxfPmKd1MRd+XxcG6x/QewBcNRDgBPLKdsY+UmEmK0NKpF8dGRgm
         3ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=o5ZJm15JSoO2IUtIgxbXEGN1oQJX6MoFcwKHBQug4efaB5ibIdpGOjQRSoqTH8UcVq
         7oi/ZuprRd/UhqKXqAcCV4OyK3hQtHXs7Ha8bMOAMDIFi/HukY+sqn4SqJa9z54fXBmS
         PMmH51mxPh0nx23x2DZneUugZlTOPJ0Iwy6zKhYnJHolFzcn3Rtm5sKpB8cUHqyrVsMF
         AnVZ+kPDqc+1bNzQ4azpvbYhjaCL3ezzJRXI/CKs9MA3jR/S2olfJOcpc7XgKgvB9XgX
         +HJ0gTHjRuzs1QCy26zqqrixnoNzCMKz2Oz0pLuS3y1LN5LbXSSFOFuW3APYWpVsWnmI
         MNng==
X-Gm-Message-State: ACgBeo1VFYO50320D2XJmHYh77JyZgT1sWppFtjglTI5CzcfX8ECUWMn
        ZrGv454x9B4E9w5DY/Sg1WUuxg==
X-Google-Smtp-Source: AA6agR5gxjnhIhcm2aWRQ7S0rlS9V5GLVEtm+FGT8nMQNHuNVnBHScn86jTXsRtYkJ8hm0husOpLKA==
X-Received: by 2002:adf:ee4b:0:b0:21e:8e1a:8f3c with SMTP id w11-20020adfee4b000000b0021e8e1a8f3cmr10979273wro.346.1659389041182;
        Mon, 01 Aug 2022 14:24:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:24:00 -0700 (PDT)
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
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v4 24/32] thermal/drivers/ti-soc: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:36 +0200
Message-Id: <20220801212244.1124867-25-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
 .../thermal/ti-soc-thermal/ti-thermal-common.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d8b937..8a9055bd376e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -65,10 +65,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone */
-static inline int __ti_thermal_get_temp(void *devdata, int *temp)
+static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = devdata;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -85,8 +85,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = thermal_zone_get_slope(data->ti_thermal);
-	constant = thermal_zone_get_offset(data->ti_thermal);
+	slope = thermal_zone_get_slope(tz);
+	constant = thermal_zone_get_offset(tz);
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
@@ -107,9 +107,9 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct ti_thermal_data *data = p;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	int id, tr, ret = 0;
 
@@ -130,7 +130,7 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
+static const struct thermal_zone_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
 };
@@ -170,7 +170,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return -EINVAL;
 
 	/* in case this is specified by DT */
-	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
+	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
 	if (IS_ERR(data->ti_thermal)) {
 		dev_err(bgp->dev, "thermal zone device is NULL\n");
-- 
2.25.1

