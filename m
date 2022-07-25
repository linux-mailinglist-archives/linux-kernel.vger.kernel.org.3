Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D05806CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiGYVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiGYV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4B25286
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b6so7613860wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=b2VZ8Ju8IwtY6a6J6GJwWN+9At19kwozRPe13f2CTVnLgb2W4A989u3Y0aiRzpqCeF
         1J0NpYYL7WbpTE0kPHlR1AELCW/7ceZKgc7wyI5T6s/3pmekxppjBcqa8SdH4V9A8Yr0
         DWNNEM8c1OTx+dCyNJBHhk6uWGwbS8p1ApOslg3Pand4UdhH18E1sQMHy7wO1L27Em8L
         ndaCXDKohkiM2dwvJtx369LeryzzZKJ9E5ee1pYKZM7N62r+g6GaJAI+tZLe93ERpB5J
         OTWGCj47lzDyNfimDx+AEN0VSLghbaJsbdWVWo2dKQM39c5o0XYWZKCTLHe0xaEv7hmP
         zk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=fOsgdPg6wImODH+cja/kKrNGDbQsAooDF2oO0x0doKtajptNaK3DbpvIZY6PFgHi+b
         TnMwS9/EikwvIWKAepo38HQzlr1yTZ26MUO7VmW6Uwj8ydb2YlzjW3INmsbqVwj1MLLS
         0VGSCXuYu6VK0ONyLD7sQlS4aMpFVxqbRhgnKNL4YCd3codcWGhLt68nup/NHu3KobL2
         ZaLP9oDE3Z4n+rnA9XqmFa5E5X0DU1aAP1FaZ6FbDA7ycydCGg4TRsE2WUmq2wo57yq1
         wgkwql4rR2HNOd9n9l0foS5g7Ek4hF4soq0gj6RLfZftx6XZzw5BhM3o780/+Ks+SRmR
         plag==
X-Gm-Message-State: AJIora/SajhZcsW0GTsxHkAvlCe6/3najG0caYFaNnyjCoou2Y2ZsDQg
        QbnuMKcDZEIHUeM2/OZy8tpNMg==
X-Google-Smtp-Source: AGRyM1tBn+lVCslS7l3C/D2sAss3SonsfMDvDGzZGhRSizto3CJv3y8B58GZuJKhGdD8qSOwrYh+IQ==
X-Received: by 2002:a1c:4c0f:0:b0:3a3:1401:7660 with SMTP id z15-20020a1c4c0f000000b003a314017660mr22597468wmf.8.1658784468598;
        Mon, 25 Jul 2022 14:27:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:48 -0700 (PDT)
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
Subject: [PATCH v2 22/32] thermal/drivers/maxim: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:27 +0200
Message-Id: <20220725212637.2818207-23-daniel.lezcano@linexp.org>
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
 drivers/thermal/max77620_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 82d06c7411eb..6451a55eb582 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -44,9 +44,9 @@ struct max77620_therm_info {
  * Return 0 on success otherwise error number to show reason of failure.
  */
 
-static int max77620_thermal_read_temp(void *data, int *temp)
+static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max77620_therm_info *mtherm = data;
+	struct max77620_therm_info *mtherm = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -66,7 +66,7 @@ static int max77620_thermal_read_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops max77620_thermal_ops = {
+static const struct thermal_zone_device_ops max77620_thermal_ops = {
 	.get_temp = max77620_thermal_read_temp,
 };
 
@@ -114,7 +114,7 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	 */
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+	mtherm->tz_device = devm_thermal_of_zone_register(&pdev->dev, 0,
 				mtherm, &max77620_thermal_ops);
 	if (IS_ERR(mtherm->tz_device)) {
 		ret = PTR_ERR(mtherm->tz_device);
-- 
2.25.1

