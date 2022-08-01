Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2605587311
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiHAVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHAVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869529809
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q30so11193937wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=qSeCYtfWEy92FlgyfFaKj3/vFcJQEqh1PA3DCyXK30JW24KWQ9oSHKsYDbv6FKWyMj
         CWPJ+jYV5HlDH6AsTmEIAz3bODYyjNojdqYNIT1tLX0cu8PgNbZ8P2VCjACOa+ChXgZA
         /YvJR5K4t+lie4h9IT9fkPc6Ylt33mUxuoPwJuNEP8JcYSUlVA+AQhbbsmqSJoCTLR/J
         RJuZdFj8cgN+rGLbWPtG5MarKwzQB7LMUikRcUGIRt2ZSeCzU95VXau7upHoYggMiwMN
         qyqxyGUIrXJyBrF8h53ZKT1VE0zz8ykY8Qi9w4kZxyokPwr4XLF3gJ9LyvT9OrpamwM0
         xhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=QyWbG7QVvM4PF3A9JshaozySLa0i7R2MisnduqUD+3cF0B/TfQ9u8ARs6J/wq2AUP6
         GgeDDp3+R92MNxCh50RRBYVdgCd7/wquiFDXaZnIVkqqbBSAzxh5xoeQM5AwRWPhyMy7
         xxiKRP/ll9ohDF9J5KUqGo5wS2Xg1CSVm0h9wSLrWq87n8826lH6U+gtBLxT9Mjjeukp
         LlyTPVU1wE8vbUX2x6n1VyvUfTFNSeCP+TBkFNjiWb6PeZVRQEhtpTf98jxOcYyMuwuL
         VFSZfZeNOpc0U/+rqdS9rfrTXSzfE1DPZpSkYNQ+dbKJ9qJ9IDgmXrSCbxPByZVLecpd
         hA/w==
X-Gm-Message-State: ACgBeo2/Ks9awXhrO7d6qLGs4uCEtotS5GV/1JQzgrOhdjEFYSq6vacZ
        ExXce/Z3iIMlc0Z1Kssj57LRMQ==
X-Google-Smtp-Source: AA6agR5sPKXj4h9igLJCZAH/X+aUkmOQbvR5OnRBTn8aUtmTsGJ7lA1pun5rfvcceQYoQjV+XJlqCA==
X-Received: by 2002:a05:6000:1f0d:b0:21e:927e:d440 with SMTP id bv13-20020a0560001f0d00b0021e927ed440mr11656280wrb.621.1659388990499;
        Mon, 01 Aug 2022 14:23:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:10 -0700 (PDT)
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
Subject: [PATCH v4 05/32] thermal/drivers/generic-adc: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:17 +0200
Message-Id: <20220801212244.1124867-6-daniel.lezcano@linexp.org>
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
 drivers/thermal/thermal-generic-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..323e273e3298 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -52,9 +52,9 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(void *data, int *temp)
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct gadc_thermal_info *gti = data;
+	struct gadc_thermal_info *gti = tz->devdata;
 	int val;
 	int ret;
 
@@ -68,7 +68,7 @@ static int gadc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops gadc_thermal_ops = {
+static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
@@ -143,8 +143,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gti);
 
-	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
-							   &gadc_thermal_ops);
+	gti->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0, gti,
+						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
 		if (ret != -EPROBE_DEFER)
-- 
2.25.1

