Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF858A385
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiHDWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiHDWwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F856FA1C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l22so1348415wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=Qr+Mq0euvweA+TndSV4WEFl5Wuf4P1I4vcd5dZzxhGtogWzjuXQfIw1uPMLTgp6G0/
         B73QBMlb1qFacraxUFeUVtmsajPi+Edam36i6HuFTCiGaK/c5LRypwd1om1DX7STEGoG
         qMk11tBHm/6+ao6WjV/gDDufCiak4N6sKWYw2gCCVS6zLcmzf8QqxViYuV+seFzcFcx+
         944WMdHa6mYMyxkQUEoFFzPeGjpNOkakqCLRDUkPv8dkmr0dmjDIXgZW3QOBsEPQYQl7
         +E7xX875es5+/dViYVFXlEMF7A5vmDv2NVbg4KRXq2skW9yCSifMxXp6Odyt7UUU5M4g
         DtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=WMg0452OZ32givUwGXYY+rIyCJ9AEYhASQLxdl28JsrDlOrjDesh2H1NKrXYinPG0J
         1iZf6uM+t71t5pwlAIGs29dOdZaEvfLgrYT0xQwt2vcLqq2jK5g1XMBB+EWLIqVcyd8c
         Xr+4roQBnuvUjjJK+rnzx7tICqg4+FniVczVyfQcFkF24zD3jsjjbMWVvSHU4LYaTlqr
         yXcdwQdKznO52Pf/I14Z2htu+zOrR5ukcCrzKCxIoeD1T8uOP1o7zLU4hkv/udjppCS7
         xKHcIeuEaOIkhSEIIREWi5PL+T7gTsyErsRsXiK/ZrYEM/FBDKcCYxyO04IIsc9MbH/s
         lXHw==
X-Gm-Message-State: ACgBeo1H4TB5e/7g5JIfS9CXKr7UDQrCMAFVatQeRXWrvz6CehkABb4L
        U9V9pYIVQf1Jd0xie0sAEZSqJw==
X-Google-Smtp-Source: AA6agR4xnRrnN7fHMJPWjS3C+aziwCwTm6AHBR+56Dsqq+d72y2sjpoGuNSgwo1mGcz+0/3LDOrLsA==
X-Received: by 2002:a5d:4dc4:0:b0:21f:abb:fcef with SMTP id f4-20020a5d4dc4000000b0021f0abbfcefmr2569270wru.486.1659653534997;
        Thu, 04 Aug 2022 15:52:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:14 -0700 (PDT)
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
Subject: [PATCH v5 09/33] thermal/drivers/sprd: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:25 +0200
Message-Id: <20220804224349.1926752-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

