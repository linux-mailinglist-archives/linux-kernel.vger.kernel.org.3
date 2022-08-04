Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6B58A3B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiHDWyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiHDWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302436FA01
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l22so1349199wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=eoyzE7ogFywED2/EUtpLvsOwJZPBVONDzJsiY6NeAaLB8x5JI4mbNdWjh/F3Fzqv8W
         fz7yFNHgJjb4VGgZ8tfrCyWGHeR0h3RWAmwKAFk0qVXSdOBiPSpv2a2+5TtHrv9gLYy7
         wqDAyJTocy52jndl7jRbdRYR9I1Ef7MsnSheSqxKwu927wQmH3joTxnrJ7X/QC2b9dHb
         9Wz2pFrdD+VFzT49HaofwCIU69bJjAvX13+HZsQYrUftqNYxeUXMKehYslHfjHnIMN1w
         zV5ZwXBfqchJq/pfLNloqVp87612VVsMGDd4syPqXhnlC7c6BDCHlassJjortxwUXQNz
         cMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=Jh5QiIs/IAwdPAQ+mzs8pkZsORdS2fQr1pkEusTWyZ9hFofgFM3S4/jqTp13/xDkzI
         CcxHTpkqyLIzpfIWDNi44nYX2UgyKspMAxjoBLsP800X48Uk1lLhvsYnvzsgY3ZI5tQg
         UX4jjpuv5bziJICF29iALbaS/C9tolifBvwdFMDvSO8tuvBMHcIuJZ7EMBuOAV1NgwYz
         0ebxZeGUN/MGGyFCzwXNw0qJAxI0RszvJdLHZH3CxuH1zkDdcsotFrJo67ze1sBG0VHb
         k2ruxJ392zr+Hj2vpDR2154aCcSgccozoTEBlRXmA7U8NwJvgoo7yuGmyih+RBlqcacK
         LiLQ==
X-Gm-Message-State: ACgBeo0I3RJGoBOAZmC9CfWCiAyuYPJFeXQ4Tv0hqe23M2Ko/1OgXdVg
        oJ1mkFVZdtxPUznH6IVuy8OJxQ==
X-Google-Smtp-Source: AA6agR6dY6X4w6WCQa4LgXn/5/Zwevkpd2oU/ZegzE4zaMHCf136q7tOMGKjDAvCkAV0/gVz6ccU7A==
X-Received: by 2002:a05:6000:1682:b0:221:599b:a41e with SMTP id y2-20020a056000168200b00221599ba41emr1299592wrd.522.1659653559829;
        Thu, 04 Aug 2022 15:52:39 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:39 -0700 (PDT)
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
Subject: [PATCH v5 18/33] thermal/drivers/rzg2l: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:34 +0200
Message-Id: <20220804224349.1926752-19-daniel.lezcano@linexp.org>
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

