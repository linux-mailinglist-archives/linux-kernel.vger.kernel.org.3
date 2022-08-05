Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCC58ACBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiHEO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiHEO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD5165836
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:57:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so3576066wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kIpvuE+bW+eT/SFr+C12ZH/LKEUovzkS1DdxP7wVWjE=;
        b=wKk9VfbxvHMAVc7uI99CGYA3+IhnPdZriOODpeqDxwKDYCf2PmRwoo8vm8JoW/y3OO
         +oQStB1GJ5blh48C420xBWXMLzUIOvlFL88PFk2TTn/7yu5kUsbrvihZjxUjSumcKiJ3
         6F/QGxHScm6ZWFx7QGUkiGF1EPXZpp7Yg5B1qmvd1D3Qe92JY/9+1NBJFSrxzz5xbIPm
         aBY33429clL/3IveC/oVcEE4h4gPfFgoyAtC7wBAcn3CxNpuOiG+PcjMIjikFt7d/hSb
         oW6hwxJXnP0TvlOGZQ2Ufz5HiB4R9f4ygJo8ZQQXTxTvyqhl4X1qL0LpRiEBRrCibxR1
         aFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kIpvuE+bW+eT/SFr+C12ZH/LKEUovzkS1DdxP7wVWjE=;
        b=vvmiOy/bOmFCngKkLmA/aM0iYKlKbj9tGmkMo+TRL8lJVVz7vpz8kPlSrCbBwCQSeV
         W+2YUXYIRKI1clj27gesnLhDkiZtoYfefsRFstdC0CorOZDLGFEX5rPF1uZiXKJDkyTv
         TgXKGyJfHaFg+qb8NId5DOaVyRtKNhD/dX0Kau1pvgpBDSp7U0MCu15Jq9XRATmFk6cG
         Z1P1/7b4b+ue5JWJcnSrcd1/sHr/dsRXrZMVaWh0227ZGd+ZwGmoXuaKfO38UpBEJ83l
         LlCNYKBlwGyWOv87Z9emNUQ3ScTb7w/kQWLPxxqz8lurF0J1Zvyce/EEmbxA78BrrnPx
         5iNw==
X-Gm-Message-State: ACgBeo1jJNXvjHk/w016USXasg9sKfjsnC7XSto8cA8Sn90UxqFpUQdI
        /ayrFuaPrCfXLTFELcZmboSQ+A==
X-Google-Smtp-Source: AA6agR45hdupSZOJcF2lOhYvVvylrAuSS8NnlhDTf1hMsh5B1lwK5QBrPzFlpZzjDYONDbDSWIxHBw==
X-Received: by 2002:a5d:504b:0:b0:220:7ae9:d7df with SMTP id h11-20020a5d504b000000b002207ae9d7dfmr4481205wrt.465.1659711478058;
        Fri, 05 Aug 2022 07:57:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:57:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v1 09/26] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:12 +0200
Message-Id: <20220805145729.2491611-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
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
2.25.1

