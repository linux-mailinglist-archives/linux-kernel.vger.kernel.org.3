Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94C58346E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiG0VDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiG0VD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BAF5724F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i8so3128133wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoCo3jVOreA60M5B2h+gu+yJSl6IxRYoUlnzq7WRBI0=;
        b=FGGLVzfx4BZq6tb0SPQJeiGIls9Y9otMd0oDQ8KKBCrCOid6Um1zjDXdapW9zopV3O
         gNsZWoglPbSDWFPOyr9yJdyGtgE3IaYP3VsjNwEoHVOcs6zgY78tgAt++783huFC8N25
         bC2KsnGaPbvpqtwIGI/j4O9EQLi608OQLkJI2RGqRVysceitXpr/OiH5AAvn9aq0Q8cr
         fOXbpIXzmgMltKUJWGu4HM1dWlIJKjouOnZdJR1ZI3SLJOHbUMeKDVcy1vy/7R1Xo7K5
         mZDvdKMUVTSP5EO8wSd1HMJnPqk2O4aRBPZZccissOcB+IjnYWKQ59QMPpFUllEh0Xw8
         oo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoCo3jVOreA60M5B2h+gu+yJSl6IxRYoUlnzq7WRBI0=;
        b=qqnAz65Pv5ryEtSRaIGQEKPwP0HGFpHsnAZaPz/3EtgVTgx7i7jbqU/wcvZSHHJL45
         U0KSFMaBmmJYd7M3nD+v9MjBSd+3Pf3InixVoA0B/p1fZP9rtuacZQqhCblXGeMmP6y1
         YEUjHmZXy7HG1ufKZVIMgpeFPtsD24HTL0GMOrwR4sebIW9ZySYXHZMZOsa6EY0e2CMs
         VxJjcTMhO9/n18qYw9IziODLnhjo8fsLue9QYVGe1rLr0xAf4apzMvD7SS6LNTDiz95j
         E6VBb7fyt0XR7TDGlyTP8v12dGTiMEMMDm7hhMJEdMwjSSDZdLWonYv1Ezqigp8P0i+f
         H8GA==
X-Gm-Message-State: AJIora/3ec0yf2sB3io4rBqqI7u+WdvIzbYp3eF2nw+hso73DCBaa9xc
        Wjr83Npdh827287Jbu0aCm+IUA==
X-Google-Smtp-Source: AGRyM1tXz/i+RQouBdI72BasLcWFpSsgokti/kC2BxvW6NBwQNGEzXEydiPc+macGX4K1FVqLUI8AQ==
X-Received: by 2002:a05:6000:1a8b:b0:21d:9ae8:f8d9 with SMTP id f11-20020a0560001a8b00b0021d9ae8f8d9mr14493418wry.686.1658955806595;
        Wed, 27 Jul 2022 14:03:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:26 -0700 (PDT)
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
Subject: [PATCH v3 08/32] thermal/drivers/sun8i: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:29 +0200
Message-Id: <20220727210253.3794069-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/sun8i_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 212c87e63a66..e64d06d1328c 100644
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

