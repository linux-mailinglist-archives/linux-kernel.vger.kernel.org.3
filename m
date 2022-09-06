Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2225AF19A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiIFRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiIFRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:01:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F47391C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:48:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bz13so12941920wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=ETMe3sp/Q+As/P6Y8jJMD+gUZU7ML+tORbT3cbliZHs2yWfCYz+fqU9Y8ZlkQTfI4w
         FJS0oI/NxqtMbKYQ0hbW5h569iSjJ0CfnUi5HeCs208eRNhsn+vjap4db4WljtpdE+Qc
         lKNH7L0jkL9kPvvfVNCZF6eThkfMMi0+C65WAqfnhqJnNPk/Wa+RVJtP51uff9YZobgQ
         aRqPjw/PkCs51d6TBs5dZ9NGFm0/7YfClW5bAageevbuDRuMGmhbuJ7fqiMMrsI90CMr
         PCBbBqQlw22lb+h0zVOiNsNKMkZ0jt9iYhpbGokl1xS1MGpgmPEqkz2y66FmySNSzdTv
         8l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=g08Rz7rFt+7hAJhG8PRgMoXauNwgVUR1POjKZ/r7Pvm5qLqZOBIPdDjAHHQWFqCF4Y
         yVfDaOZLrSbCDa4a1X5fWeY8T34CQhQld+a1Q1kZbn0DJJsttEWtR8jW/e4SEflJYFZn
         rhAiP9fpD1w3onA3IzPgVE9NNrFXuPTHvF/wtVq5AvePMmdm0VyMgu0u97qaSxNmE/z8
         q3CRXP744UmINVJPx/JoPJ8pLnYA85l/3T/1agFdtoBjTxgVomlxi/P60/6UJ8UonfV7
         HGdZ67s0ZeWcvqmw/gpBMROCjbRqBDxa3cs/XdGej9Qnr+mbp8kC8QhjbrWz4jq9CzBJ
         20Kw==
X-Gm-Message-State: ACgBeo3esQ4UnliSVrd2GRgS6UE4LAuaGCG5JT0YEusD8kfnLI9+o/Sv
        NLK3yK/J6Uav1mYVXmbtlj2rgA==
X-Google-Smtp-Source: AA6agR7Bfv2PPU+Ow16wDD+XaQzj7m39/KlnCs4wBa0domDpH+LAomiPy0yyMEiLt8ehOAi2SU9ZBQ==
X-Received: by 2002:a5d:69c6:0:b0:228:c119:987f with SMTP id s6-20020a5d69c6000000b00228c119987fmr4967593wrw.268.1662482886151;
        Tue, 06 Sep 2022 09:48:06 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v3 23/30] thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:13 +0200
Message-Id: <20220906164720.330701-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 49 +++++-----------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4df42d70d867..003457810072 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,16 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
-				      int trip, enum thermal_trip_type *type)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int *temp)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*temp = MCELSIUS(90);
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
-	.get_trip_type	= rcar_thermal_get_trip_type,
-	.get_trip_temp	= rcar_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
 };
 
 /*
@@ -531,9 +495,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-			priv->zone = thermal_zone_device_register(
-						"rcar_thermal",
-						1, 0, priv,
+			priv->zone = thermal_zone_device_register_with_trips(
+				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
-- 
2.34.1

