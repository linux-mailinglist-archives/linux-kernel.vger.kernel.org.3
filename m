Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035F58068B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiGYV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiGYV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C44240B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso101444wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=moWO8jivNU1cjTx+jhycpwp4j1NSrFXiBxnZLzWxkWOhd71+VNeuW0LevHrqNx+Y96
         Xj6/35UpT0H8o2zYirADYTOclDWf3z9Dk5imPZNxkcVgB+NgGvhLIk7/cawOeh/rUTkr
         aDWM5oFzGzIQT7In16e0/Wst5qm/cmsrDeIWVqkXCBBd6hP/iXmwby5nnQxGcyt8rlIF
         YJIPGZg9AgWB3LHF6DKHFvNxPB1EwyzWRDnQ90gavwFHwqVVuqiYbpmulEYgmMD4Xryg
         XWvLDvcYCcW7JodGSsr5kFKGcqqde4xKh9nayjG3ro6hmdV0QwF1oRGIDmk3uLGDRjEl
         b0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=rt2X6et1e3xDNxIFbINgJ2r/Tv6e2snVGSzcSK0bFYduj2LiERohsIZ2spZ6TYQLxg
         Xv2OBHKKNu7C5oYJnJaGDHY8P6vHa+E+Lr1Wcid3yNklWhymCCA2y2SVnpDyEkz93VEO
         PEcjw7IjKipVFKN7COP7ur4feZ1fTsrvTZAnuaIv1qME2dZ3CAICiF2HSSWvRa36dAzW
         kmup/a48dpsUqBmB3c06QvNeQrt6DHmTGQUIsjsJsE3pxhpFOqDz0XVp0fqHx/xMjbOG
         It/kC2kiUgmo8GetUnh4XtHl9BwqqQhJmVjt/ou9lc5DWUcaZortHb+jzEHgOCPmZFq+
         w7fw==
X-Gm-Message-State: AJIora91fKPnAdLBf6AUshmSaZ9sm/u4cJ2ruYDpUZXOsQ4ew8ZHiRfJ
        4mJsdoVT+5K99UXW/WgJqsWPxw==
X-Google-Smtp-Source: AGRyM1vyKjPCEv+fbOJKMq+h7EeTbR0qwq3V9QbvaCMzbQZMAZEvkVpoRiQ0jzTYzF1x+kvB6/Inuw==
X-Received: by 2002:a1c:2584:0:b0:3a1:9de1:f2cd with SMTP id l126-20020a1c2584000000b003a19de1f2cdmr9329750wml.182.1658784421392;
        Mon, 25 Jul 2022 14:27:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:01 -0700 (PDT)
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
Subject: [PATCH v2 05/32] thermal/drivers/generic-adc: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:10 +0200
Message-Id: <20220725212637.2818207-6-daniel.lezcano@linexp.org>
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

