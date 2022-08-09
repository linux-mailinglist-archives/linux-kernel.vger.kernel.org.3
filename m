Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6767558E278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiHIWGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHIWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA51BC33
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so129248wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a0tkxQ3BVQ7QDdW+F+13SmYlJx7XIUccYaqSyISXxKQ=;
        b=oNwW+r7s9GvOV/yExM5fCvQD3Qs3rvwgPpSoZbu3tJEGRoP338HKirtKIGVQfSKFSy
         0/3XS5JLayFWC4qBIG0LEi4IuyTQ9TL4uXIR8GcPvflaz4C98Q8ZfdNaI7FBmOsOueef
         nibzX3Juw8ZvhokQ5mKL1xSjwDexH4ORUGAe0nnw8dbR5WJfS0e54iKy6PhRgIrujt33
         8CG6QH6mvSTXUXxFBXKqfrF12GHdmuFDvH62aNlP/AhsP301TMAAhahaUIShxWprVqcQ
         NYdkMycJ0wVvWEOzH+g2T3abi8WqSLy7wg4EnRs5SAgonX7NTU9qRqQRhr0jIIWVSprN
         GFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a0tkxQ3BVQ7QDdW+F+13SmYlJx7XIUccYaqSyISXxKQ=;
        b=CvE/B09stYu+Nj4WV+afDcLFnG3jaOCamVgTo7S+W2CNI/7YxyWeo54KphQOeb9nZB
         EkjtGFme+zYX9MeFTY7cd72ZECptmM1RPMvwzGMEFVA5RS5PTt5dNOQ8LmM3SiRLgksz
         zX7BtUgHz7d90bgLyU/p13RxygOWBuRz7F29yeEOfga1vkHdpXSkMnV2j63Xx4+reVqf
         Ui8BGWCvEs7V/v74KCIJ7XzRZk6DpEMySybr57tvnT4tpVOTdAQnZE3jrhDaUxLGLW7C
         oUgx4bcIH9gwzCNGz5Uno8AkaLqmMsh0gLW+/GEP/xHw+RC1b05J8Qvp/tlir7MNX33s
         EG5g==
X-Gm-Message-State: ACgBeo3nw4VBRSYkoSKMH/Miy4lhRc2Shg1ZjJ5DeMt4bx6FKR7mAyh0
        jfCWGobNmO29ARIK5Y/EpCJe3A==
X-Google-Smtp-Source: AA6agR604SuevAmE7qWjfqroYSOrm0a6UHax8u7NRuopKV2cKJFjhLpw437CPILQSdnsIluXDJfPqA==
X-Received: by 2002:a1c:44d5:0:b0:3a5:4fa3:b260 with SMTP id r204-20020a1c44d5000000b003a54fa3b260mr260348wma.165.1660082708949;
        Tue, 09 Aug 2022 15:05:08 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v2 09/26] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:19 +0200
Message-Id: <20220809220436.711020-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
---
 drivers/thermal/uniphier_thermal.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4111d99ef50e..1675174480aa 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	const struct thermal_trip *trips;
-	int i, ret, irq, ntrips, crit_temp = INT_MAX;
+	int i, ret, irq, crit_temp = INT_MAX;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -296,20 +295,17 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	/* get trip points */
-	trips = of_thermal_get_trip_points(tdev->tz_dev);
-	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
-	if (ntrips > ALERT_CH_NUM) {
-		dev_err(dev, "thermal zone has too many trips\n");
-		return -E2BIG;
-	}
-
 	/* set alert temperatures */
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
-		    trips[i].temperature < crit_temp)
-			crit_temp = trips[i].temperature;
-		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
+	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
+
+		struct thermal_trip trip;
+
+		thermal_zone_get_trip(tdev->tz_dev, i, &trip);
+		
+		if (trip.type == THERMAL_TRIP_CRITICAL &&
+		    trip.temperature < crit_temp)
+			crit_temp = trip.temperature;
+		uniphier_tm_set_alert(tdev, i, trip.temperature);
 		tdev->alert_en[i] = true;
 	}
 	if (crit_temp > CRITICAL_TEMP_LIMIT) {
-- 
2.34.1

