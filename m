Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C004580691
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiGYV1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiGYV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0A248E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b26so17729686wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+IbCbjvww7/6MCT8FlO/AyuSJ2MYApVBUJpYGG38Fs=;
        b=fSrO/7vc7YdETGnbNnO4MEoFJhS6dOOpUs+z5Z4Q0CqwrIfzxANf5LlJa+hCQ7v27l
         81lRhs5MjQ0RwMyOU1vngZmBC0e5WlCSypRzTh/imp8F2C1+GGzPkieklV32eFN2eqX9
         2b3oxol1P3daqJxMXwf4AxNNCTUB+WzRIBt9g92q7jF/q5+OucyDzf9mbEvrFMBaGxfz
         CqAZFsBA51J9kXHUQafWLlFPmTmqUcZtH2Cdfe9nYyZJBzW5lG4pms2f0xN0wPiv5EE6
         Ygn629fB7mPhzemvLau3tiqVBuPXCBBLBoh7CbwaV3G6d1ARVwrhfAc0OnXBq+JjYc7r
         uYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+IbCbjvww7/6MCT8FlO/AyuSJ2MYApVBUJpYGG38Fs=;
        b=b7pG2rK8yaA6llug5uKvO0pqiRDcerJ6JvxQz5VDJk3nSOXR0V4rMFL3zmqdRPqd+m
         vjXE9ssCtylUB7JUfTHLpgS+JWQxwkySTP1Sr0fyrLv1f1cgaNsqHGBUedPMSpZTtYoO
         BSALtLBMF83ocjHY801QvhD9IkbYEOMNOK/LbL2+I+Ee6EMWk9e6S2MrLFaBaziDN6JR
         Xz7g3hnssffjFYUs48gfYxyXb5hzejx4d/3E4OWRk7x0tdf8rmNXtAzpg+FTCyI4fHAT
         091fGFXyZ9Bhp7CQzSUdwWV/rg9A6/rj0BhFqiPeccGW/OnsFuFZVPB8adHuYT4YQb/Z
         /25A==
X-Gm-Message-State: AJIora8gMn4h4ZFmUJiqbIzZe9S8z7PCq0WbIhp8aU83Hvwp2sp+vbe+
        kFpRryWfDBjulrjcn0PzBpinjg==
X-Google-Smtp-Source: AGRyM1tPhZQxz2m/hgQzzipXQqvcy35d3jJ4+m1gu6vcvitjtr9rcjLcXjbfXhHboUlBS2gK8XX4ow==
X-Received: by 2002:adf:f245:0:b0:21d:a39a:bed5 with SMTP id b5-20020adff245000000b0021da39abed5mr8265442wrp.508.1658784433206;
        Mon, 25 Jul 2022 14:27:13 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:12 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v2 08/32] thermal/drivers/sun8i: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:13 +0200
Message-Id: <20220725212637.2818207-9-daniel.lezcano@linexp.org>
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
 drivers/thermal/sun8i_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..2a4fa4068950 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -108,9 +108,9 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
-static int sun8i_ths_get_temp(void *data, int *temp)
+static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsensor *s = data;
+	struct tsensor *s = tz->devdata;
 	struct ths_device *tmdev = s->tmdev;
 	int val = 0;
 
@@ -135,7 +135,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ths_ops = {
+static const struct thermal_zone_device_ops ths_ops = {
 	.get_temp = sun8i_ths_get_temp,
 };
 
@@ -468,10 +468,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
 		tmdev->sensor[i].tzd =
-			devm_thermal_zone_of_sensor_register(tmdev->dev,
-							     i,
-							     &tmdev->sensor[i],
-							     &ths_ops);
+			devm_thermal_of_zone_register(tmdev->dev,
+						      i,
+						      &tmdev->sensor[i],
+						      &ths_ops);
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-- 
2.25.1

