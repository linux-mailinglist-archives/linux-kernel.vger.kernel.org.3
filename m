Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834A558069F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiGYV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiGYV2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16125281
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bn9so6832481wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3dKZnAQZ0SIws+k1uhBHAMzUVp1fju47+AzixoTetw=;
        b=xCB8b9yxfHutieAo2I7Va3xYv0mtoYLkiW5s/GVWIh9uwWv3uDEtFciwSTI/u+XqTq
         GYUGN+hXxVN+UTPizFH+ucpPxf+DRrvGfWRXdYDHyx28B2o6v8oiyqrb0bP7J5CGbTD7
         EX0sSXnmWrmA3nB37Umc2GNx4rR8uaxrlUhzn3eqJrC/H6DwLhHhexF99qCTVu3+nvj3
         a9p537layJ1A0CPETRgwg7nMakZ+68pBNjx8HRRV6G/aYHp91U8O+Up/kro1lVgCE/km
         bUbv8O7mI5fX/5GAoVksjoRtXkSYfRTrvp2zQb1XyPQiyin68V64s34AVD6/OzbTDVio
         M+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3dKZnAQZ0SIws+k1uhBHAMzUVp1fju47+AzixoTetw=;
        b=sBBKrBsXIiIHI+tVpJnfDGNSvgVvecDlZ75Y4p8wUOJEA/v4h2tsvDn6psfAHJjscH
         68lSX1c7K16wlCc7NbKPP4iVJMcdQkzKPXDgtH30Uez4jIT0PwFGg54NLsMze4TsPQzt
         oEDoWb8hdQQONrFGQ5tI48VRuyWPcOLss6f2dhz/GTchmOQvJUiaW0kf8MWmEWdS2KUw
         /DQVy8JG32sIpslg6osV2CXPzirJfwHHV2HySxaHbPVlRrJgdZaOCDCKPvtKz5biTi+M
         riU2i+ADM9Ll616ffvSd0cH4E6EVyA/wpxUaznVWWvez/OjKRWP6tcNjsodNUL6I+BHs
         9Cyw==
X-Gm-Message-State: AJIora/JtwKGMeDWkmZgRzFr4Lh9I9j/ZFeQs6yGzZia0by/S9lYrsd0
        hxZVO165QruAn2BIu9FiMdMJSw==
X-Google-Smtp-Source: AGRyM1vdEFmGCxZV6Bkcky9o/pVtDI2YiKOZH0ksVzR74izu9hBmSAcPes1btztsU+d0UM/QyrWRGw==
X-Received: by 2002:adf:f492:0:b0:21d:89d5:9443 with SMTP id l18-20020adff492000000b0021d89d59443mr8483081wro.201.1658784453592;
        Mon, 25 Jul 2022 14:27:33 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:33 -0700 (PDT)
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
Subject: [PATCH v2 15/32] thermal/drivers/db8500: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:20 +0200
Message-Id: <20220725212637.2818207-16-daniel.lezcano@linexp.org>
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
 drivers/thermal/db8500_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 21d4d6e6409a..4d1b31930209 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -59,9 +59,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -74,16 +74,16 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 }
 
 /* Callback to get temperature changing trend */
-static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
+static int db8500_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	*trend = th->trend;
 
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 	.get_trend = db8500_thermal_get_trend,
 };
@@ -202,7 +202,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

