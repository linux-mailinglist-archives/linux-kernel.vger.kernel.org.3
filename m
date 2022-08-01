Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0215587332
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiHAVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiHAVYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E04507D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z12so5504337wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=XcUUc8qM7G/FN2/Ik/kib5qvYaTWhY4VkL3Ucgb+axybGRqozKiyz1rgesWhhIpkeq
         lQ8tpT/HWfVVAeH3JYRrbG69gqYzBo6nmtC4X1UBo0G3CJ2lKtHOLl76vKsyEly3hh7l
         acKaJA1lCeIl2xoNDBp9QAocfbNHrJeSTEYTpqmk99Bla0dF5GNxGvOs7g+w/quZuVUX
         dgR+b1QqpX5eszpv2N9X8TWM/072fatVPY0+CQMfW/RgItWp6VlB1LcGDHbQErc8wkMy
         35IlpRcmrEytZZOjpC7Ci2XEM3zQlwaZoIVyVk7y7sFDLHc9lK7a6nEOIh4djuO/Dwlg
         nR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=qvUorUBaFcyCuTrrhsUWM7szwqQMu2IwrCmY0/YV7L+zVEQAQ6gkiNEeu7FfuXOFs2
         oyBonOPzGLmQ9b5RDgyzmIzxguHAAgBtd4ssKrI0CdVTw/F52y7FMMvAknGU7mfN035L
         Sowg21DaDi9nUmmogd1Vat0jvv3PbXBq/09VhGhJ9Kr5A9llhlqkJrOqMK69Tjl2ur3G
         kh4+Ch68zuqp95Dfl6SYBu2mqCgAecLRfpppZRP3tcrpi4Ly2mKR4Pruik9Hcje9r7/4
         r1uY/qOqvFyKeUaFoaLDJVsI3WrbFxDSU5ROSGSZLm0wY/cAMAcBCQ6MJlNt0Zx7GrKM
         vwrw==
X-Gm-Message-State: ACgBeo3r8z6YpiYgUqFTBm+olzlY4YF9f2gF8sNwFy0BZvy/56nQKwN5
        wS3lIE2GFDmkrBkt4vQy5fKSkg==
X-Google-Smtp-Source: AA6agR5fCSFR6cUl+FDkIV7UYUh2UvRZUkNSegDFhR3u0nNfhk8UjgIhz+yn5ElpkhR4MqnPFD5Nmw==
X-Received: by 2002:a5d:6e8e:0:b0:220:5fa1:d508 with SMTP id k14-20020a5d6e8e000000b002205fa1d508mr5977038wrz.337.1659389028792;
        Mon, 01 Aug 2022 14:23:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:48 -0700 (PDT)
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
Subject: [PATCH v4 18/32] thermal/drivers/rzg2l: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:30 +0200
Message-Id: <20220801212244.1124867-19-daniel.lezcano@linexp.org>
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
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 51ae80eda6af..2e0649f38506 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -114,7 +114,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static const struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -207,8 +207,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
-- 
2.25.1

