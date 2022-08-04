Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043A58A38D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiHDWyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbiHDWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6536FA13
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso2691740wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=ALcEQOT4UjCCUh1CGJZLBpDmxr47aIzLLlFqmAsK1poo9ss/PJkxR9pWxpzF0SGzMb
         BA9eQjJ1TwUAz/3fK4FG3Qy2VzxAzbKlB3VpV6hPzfQ0dbM0i6VNJ1coqjl5eHgd3GX4
         bvdwhMiPAtWCbNCBeHV6JwRpq17dFtkuCJ3FGZBydPfzjbVXkK8ylJ15Kx5ihd1/Imzj
         y12B8kJnZREDhjnf79o8tXFWxg+kuir3lLh7wu7fOw1wozPANA+xJxmoidqUK6i0BaV8
         hpwHIQjqgdxT/rexH2wak5aUZWh/hD1898V7t53LGmOXl60vYM3kHsbtAj68ZEgCr59z
         2zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=V9IiI8dM5L7H5aeT2oY6axA8PPzj/dmjda20e333wf2Ll+NQBktC16m8ELh00jGMKf
         jsNmlBJOKoRVSaI94dIhOAS7BkLEwFvJNj7exvCRjRx+19diLFPRAPggB8luXynk5w8x
         0y+be2eSda3m7PtoWwRXxqkNyQtNPsMHYCYmYS+obguZWRN6JFImXN1HQfaGYVVl43KQ
         7ZrwkWDGUCXJ8p3ZEgkUVRTg2uyuNE3AU+2Dr1FRCi/6V7djMS/XgHgJ2igelMPpvu2T
         EMIwpBAbNtZVdVK+rFOSmDdHJ6n9JXdvA7cqLxrkJdEL7vKtajwldewb4QPOKnHNDPlm
         T6bw==
X-Gm-Message-State: ACgBeo1U/0qvdIEE1aqnpwBAV2DIbTJEFw2M4tOO5O/NUpfDMyAW+Mwl
        SKMPf60rmrPTIH5FLxn5Ar5qzg==
X-Google-Smtp-Source: AA6agR6EfPaJIYJTfKnXdv1KX0HQkB/Up4VuVWbI6QAKwVwSlti+IGk5hm53ZI7uBim9Ljqc50OygQ==
X-Received: by 2002:a05:600c:224d:b0:3a5:17db:de75 with SMTP id a13-20020a05600c224d00b003a517dbde75mr738542wmm.80.1659653561814;
        Thu, 04 Aug 2022 15:52:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:41 -0700 (PDT)
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
Subject: [PATCH v5 19/33] thermal/drivers/qoriq: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:35 +0200
Message-Id: <20220804224349.1926752-20-daniel.lezcano@linexp.org>
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
 drivers/thermal/qoriq_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..d111e218f362 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,9 +82,9 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qoriq_sensor *qsensor = p;
+	struct qoriq_sensor *qsensor = tz->devdata;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 	/*
@@ -122,7 +122,7 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -146,9 +146,9 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(dev, id,
-							   sensor,
-							   &tmu_tz_ops);
+		tzd = devm_thermal_of_zone_register(dev, id,
+						    sensor,
+						    &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
 		if (ret) {
 			if (ret == -ENODEV)
-- 
2.25.1

