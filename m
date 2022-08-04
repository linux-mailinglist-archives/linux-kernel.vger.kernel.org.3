Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD658A383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiHDWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiHDWw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085573905
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso2691525wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YLbrdXUnmrQegHQ4ArILFVac507m4xUt/E4MiWL2p00=;
        b=aFhzj5S7cwF1iOCecWm82eQU6McBfgSTPX45J0fnRoQZNIevy+1bRoUm1Ey/y3bEm9
         mIfKVl6+oUu46UHACCXtykLrlntdDaaea3/EohI7qi/jKdlZhI0siirJJAhl9YUSaiIH
         MUJ/2OSN806EZjmC8cTVPZ7R66ddAcD2v3cywdgmuYq6ZtUww5bmgnxnAcePM34VVhxN
         JVDNDuUKmjs3fqNJ0f5GrCUz0+fA+hAWtEjNV5HTVyyPq5TGey6MrR4bRNEpoqC4Xozk
         p8ZR6igzNcjkYbtLB8BcKH3626bQAvcpUqnSq0PWZfH1mBUaWiKLw1nv1KwxX35Rdy9N
         4gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YLbrdXUnmrQegHQ4ArILFVac507m4xUt/E4MiWL2p00=;
        b=zRkGKG1IUNktHdKJRiMWS5kwwyIBNmSqiL4+prclsvJLFlCS4hp5t7j76tkUQsURhp
         GVXrMHwaupxxrp/wwaCrSwreSp53tMaj0Tg/TFuZ6Sposj3Ti69Bth+YG2EBBTxI8YDA
         lhHoxEneyHQm2zQY0a7xigrbYFjKEtbs+UjiMOq+WjXqjoxqh7Bh1I3nUI/zkV7equBi
         R9pBhuxq2aJP+WQoD+rZOry7zMQ5TNSrr+KRRCGoQ0GHm6wxYn76YDWk9aomcNu8O4If
         FFJ9I8asuc6HzudPdE5CbbfJ3EAZiVtu8HZUHpCLrUm5krmTSQ1iEpB7tJoVBtk6a0xk
         oxtg==
X-Gm-Message-State: ACgBeo3HiO2Rl8rFlixdLhE82oRmIQHAYhQlXh9aAPEgfzhOR02IYfFm
        oYcKF6BLddHUZz7xYF3FzcXXhA==
X-Google-Smtp-Source: AA6agR4ULFOekFqR1S23ofy2jgc1fgTjsC4bmHGRK9CQ5SrpNqwQUdtYwfFJ6ZBkTrRq8vCZMKDn6A==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr2664666wmq.33.1659653548997;
        Thu, 04 Aug 2022 15:52:28 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:28 -0700 (PDT)
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
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS)
Subject: [PATCH v5 13/33] thermal/drivers/amlogic: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:29 +0200
Message-Id: <20220804224349.1926752-14-daniel.lezcano@linexp.org>
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
 drivers/thermal/amlogic_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index e61b91d14ad1..d30cb791e63c 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -179,12 +179,12 @@ static int amlogic_thermal_disable(struct amlogic_thermal *data)
 	return 0;
 }
 
-static int amlogic_thermal_get_temp(void *data, int *temp)
+static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	unsigned int tval;
-	struct amlogic_thermal *pdata = data;
+	struct amlogic_thermal *pdata = tz->devdata;
 
-	if (!data)
+	if (!pdata)
 		return -EINVAL;
 
 	regmap_read(pdata->regmap, TSENSOR_STAT0, &tval);
@@ -195,7 +195,7 @@ static int amlogic_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops amlogic_thermal_ops = {
+static const struct thermal_zone_device_ops amlogic_thermal_ops = {
 	.get_temp	= amlogic_thermal_get_temp,
 };
 
@@ -276,10 +276,10 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->sec_ao_map);
 	}
 
-	pdata->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  0,
-							  pdata,
-							  &amlogic_thermal_ops);
+	pdata->tzd = devm_thermal_of_zone_register(&pdev->dev,
+						   0,
+						   pdata,
+						   &amlogic_thermal_ops);
 	if (IS_ERR(pdata->tzd)) {
 		ret = PTR_ERR(pdata->tzd);
 		dev_err(dev, "Failed to register tsensor: %d\n", ret);
-- 
2.25.1

