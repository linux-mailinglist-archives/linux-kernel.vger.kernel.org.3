Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7558A387
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiHDWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiHDWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4197391D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a11so604227wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=OCD0y3QgfAQloSgUF+zgv7CA7DEWyXGFNLika9s+rO/f5K5SEp2+xcNUfT+hikmJ0L
         7B4oEOoZe5kERppsB3aHyT2fi0ZQ9sCR9V2CgML5jAGXOhkTQeJxT3g8NuKtAGrxbuRo
         wNHiGGyEimXMiDuCs/IRSFxwqtFD6GoF1CF0J5zpGwwJxoiihbeJKN18owk4DXpb3tDO
         wcHgOat2GagF0ZezvxMGV4gHfMr9y9NBDi/fKjRUN/NzwEJZcG1TSPzEE7TyQ899tD5/
         UgmVYOftMlK8jKb7rs5/LDpsvLUv21bl/75BuDlDuEvuRSSXcyGWNJHbXNfEcyZvKo2J
         0scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=wzEM5wBYDdcs/mZFlVP2ygQdgG/sIaeeFRiuytrW5hKjbuSi9WkZ3PYyllb496C62h
         5FjVepnknLkE4G68ZL5S35S/nH6NpgcAeG/3EwgZUSWocVUQ+NrxegSERtQtKrL49W0x
         IRcH65pbxsGCl6GyRjJQtgBPCRfqJ/yricr2dFZ380x+P1hrA5AAFpJmmn9seM1PegWq
         dBJAs6R2DoPwZViGab0v7zzbQK6JE/GK3spJf78ao7JrfJrffflf8mEt+qrGtmGUH+al
         kmPWvHgeMcBRAdAD/RI56usfjmLpXRX6H8DKrNOZqBBdOiErRnUM33PJDZeuvl4i994d
         tP+w==
X-Gm-Message-State: ACgBeo1QhuCgULjyaHw46/0sdPlZeQNvHLjcjK4Pxz3UFMhFz7CSG9ZU
        5I302TzSs6309bCUYPVolMouqw==
X-Google-Smtp-Source: AA6agR4Q/pp5eAxAatZvxQ81jOJXnhc9G7oQn37iUavXl9RM8lOiCKFSkD0sbxFc0a8hBci25BgozA==
X-Received: by 2002:a05:600c:3b15:b0:3a5:49e:81a6 with SMTP id m21-20020a05600c3b1500b003a5049e81a6mr4331582wms.49.1659653553087;
        Thu, 04 Aug 2022 15:52:33 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:32 -0700 (PDT)
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
Subject: [PATCH v5 15/33] thermal/drivers/db8500: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:31 +0200
Message-Id: <20220804224349.1926752-16-daniel.lezcano@linexp.org>
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
 drivers/thermal/db8500_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 121cf853e545..cb10e280681f 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -58,9 +58,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -72,7 +72,7 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 };
 
@@ -182,7 +182,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

