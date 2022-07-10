Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239156D166
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGJVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGJVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:24:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871311152
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk26so4740164wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xk6A/pNWCl/Nzs7Qg1vyN7A/ewbkmH3NrwD0SYWTSzQ=;
        b=bY0fExwP3MURnYRBx4omWr6dHDeloNf3GtuXmB5SJTGKaGli9DPxOPVtnSXfYy/IZj
         euH+0zIKdnC7syngU7AO3tFLPLy4YJ7YE3aSQJW879SKowor/hPmNwimCZyTBGh5Fokw
         pN9r62L2aLDdSE5mQlVIK31j3WZHW3y+JADNgy7szDmqsrXMtZDNu9XGKvArcYSW2SHK
         ZHv1RnXiGJEiqlVDqMmrkZgXzjw4/kKAAaHxZEN+0umle7/d+QLJLXzJVYqYnmYmZfa0
         KetYEco7njc8yITUk7gDVNEXgnqAMDxUMyamEjaaT7qUP84VbJM1RZM3jkM/Ssdx3lA0
         VlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk6A/pNWCl/Nzs7Qg1vyN7A/ewbkmH3NrwD0SYWTSzQ=;
        b=OYDeE28S3FXg1ImpozTov0CUseU+XPfgws2OGt/x9vWibgY5097YDmOMn1ncoqB5NZ
         +M32NzMSxjHuwpkNgLYJlVVd7CoWVvMFULo/o3o6YrwFDX/EJSZGy0BTIleAst+1AIBU
         KrEtf6YZUoT1J15R+qedkG7ULA6LdhTm9SMtJAToSq2+v6q2mdtfs1+V1Ozh8pc5/7RJ
         XLi9tGt4HCtwwuC5On7IFxWd6tGVDejsByND3pO8V16fY1jR9I3hg+6AWeR3CmkotE3T
         ahjPJEvQJwBsZ7SXYAuPjWBMJugt0dA6BwQEVRJmAaL3BMAzqbdk4cb7feGSRIBFX9En
         JsWA==
X-Gm-Message-State: AJIora/snw9sNkmOkovoh3znIODBOcIk9iiE98PHk3rPJv/o10sM8kw4
        bD8EA1p9gTP4EnGq0IVg0vo9Vw==
X-Google-Smtp-Source: AGRyM1vKS9doHkKgEmjxJC9SU75lHuuqhQ6vkhBSE+BJuwsds520dkzYONMvXdKg3SpePQIjpLJppQ==
X-Received: by 2002:a05:6000:1446:b0:21d:27ea:5a01 with SMTP id v6-20020a056000144600b0021d27ea5a01mr13953400wrx.314.1657488282307;
        Sun, 10 Jul 2022 14:24:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Talel Shenhar <talel@amazon.com>
Subject: [PATCH v1 06/33] thermal/drivers/mmio: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:56 +0200
Message-Id: <20220710212423.681301-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..fecf537bb470 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -20,11 +20,10 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 	return readb(mmio_base);
 }
 
-static int thermal_mmio_get_temperature(void *private, int *temp)
+static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor =
-		(struct thermal_mmio *)private;
+	struct thermal_mmio *sensor = tz->devdata;
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
@@ -34,7 +33,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static struct thermal_zone_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
@@ -68,10 +67,10 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							    0,
-							    sensor,
-							    &thermal_mmio_ops);
+	thermal_zone = devm_thermal_of_zone_register(&pdev->dev,
+						     0,
+						     sensor,
+						     &thermal_mmio_ops);
 	if (IS_ERR(thermal_zone)) {
 		dev_err(&pdev->dev,
 			"failed to register sensor (%ld)\n",
@@ -79,7 +78,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal_zone);
 	}
 
-	thermal_mmio_get_temperature(sensor, &temperature);
+	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
 		 "thermal mmio sensor %s registered, current temperature: %d\n",
 		 pdev->name, temperature);
-- 
2.25.1

