Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC29510BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbiDZWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355738AbiDZWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28604348D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so1340834wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVhezk9B87ybbOk33dem3lxM0Kx2b5w34TWWJpET4nU=;
        b=c6/yMNhqpjRNkxbWUr6888LfBel4XBBaMHYXksJ6Q1/aI6GjRvcHd2b935fsZnRSr0
         uKn00lK62rUjVMIyW5RgBdREupNxpcj1ZL5W/kib8bj639w+7jMVk5PtomunTHyLx82j
         rP//7MIeluu7nXebw8txykShT06kmAIME2oqw54yGN38jUbvTlGprc3ZgLHxtjo4sPb7
         5z8o1QvNri3EW3qP6xgqWRz1ME5yV40trlzXC3ZTgXj8CtaHYALyJpPZt3EmawBZf3jR
         MnMwzunzBcowBw0ylWEA1PnEb7zawhw8JHJZ+FieEKV33gSX4Cq6o/X2sWc2IpvIa2JY
         zy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVhezk9B87ybbOk33dem3lxM0Kx2b5w34TWWJpET4nU=;
        b=SZHD9/nqMQzWyATWcvsri7Ndtm4tIpPhPA5F1+/zI7RVLZwfVnnX0WQcMV64FF6vn4
         5bQCHtEaIOBInfbVyMDEmp6/IMsgwaQop/s3G0AH0so+sbsr01EpS0NIIkSjCEUKKVsy
         kPTFIxKLp/geAr57DWBryE0hegddQM57KDgYPjwOvD97d1btPMYW9XtHskHEYcDvPTNj
         iCAbOJs78aPULfiVWhQag87UEQ+lgHZvzsBSdDF2O7Zp7v8sEaBHOF3d2H18DHHlQ0fw
         eDraUil+QEGK6ezP++6HRU0wibUr/iotdc2Q3FrrjhwtTOalEwMKTc+AaiFe31gAfxQo
         VD1A==
X-Gm-Message-State: AOAM530ONmaomDaL7931PQ3Xs0jr81aCQCeECiXKpPR82UQiiyY6F8iL
        /aahK+nhuU4RNKUqiS/Mtac4Dw==
X-Google-Smtp-Source: ABdhPJwZCA1ixD3ixVK6T21Tn2CRBMAMUf/1DHBPhC2n8kWXxsd+B/9yx5FalBWFMzVO5L5B0YDrQQ==
X-Received: by 2002:a05:600c:1910:b0:392:9143:27d3 with SMTP id j16-20020a05600c191000b00392914327d3mr23231890wmq.206.1651011346517;
        Tue, 26 Apr 2022 15:15:46 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] thermal/of: Initialize trip points separately
Date:   Wed, 27 Apr 2022 00:15:23 +0200
Message-Id: <20220426221523.3056696-16-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
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

Self contain the trip initialization from the device tree in a single
function for the sake of making the code flow more clear.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 79 ++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a356a7b2d73d..ef9c2e7f1af4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -681,7 +681,8 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
  *
  * Return: 0 on success, proper error code otherwise
  */
-static int thermal_of_populate_bind_params(struct device_node *np,
+static int thermal_of_populate_bind_params(struct device_node *tz_np,
+					   struct device_node *np,
 					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
@@ -703,7 +704,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	trip_id = of_find_trip_id(np, trip);
+	trip_id = of_find_trip_id(tz_np, trip);
 	if (trip_id < 0) {
 		ret = trip_id;
 		goto end;
@@ -837,6 +838,53 @@ static int thermal_of_populate_trip(struct device_node *np,
 	return 0;
 }
 
+static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
+{
+	struct thermal_trip *tt;
+	struct device_node *trips, *trip;
+	int ret, count;
+
+	trips = of_get_child_by_name(np, "trips");
+	if (!trips) {
+		pr_err("Failed to find 'trips' node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	count = of_get_child_count(trips);
+	if (!count) {
+		pr_err("No trip point defined\n");
+		ret = -EINVAL;
+		goto out_of_node_put;
+	}
+
+	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
+	if (!tt) {
+		ret = -ENOMEM;
+		goto out_of_node_put;
+	}
+
+	*ntrips = count;
+
+	count = 0;
+	for_each_child_of_node(trips, trip) {
+		ret = thermal_of_populate_trip(trip, &tt[count++]);
+		if (ret)
+			goto out_kfree;
+	}
+
+	of_node_put(trips);
+	
+	return tt;
+	
+out_kfree:
+	kfree(tt);
+	*ntrips = 0;
+out_of_node_put:
+	of_node_put(trips);
+
+	return ERR_PTR(ret);
+}
+
 /**
  * thermal_of_build_thermal_zone - parse and fill one thermal zone data
  * @np: DT node containing a thermal zone node
@@ -855,7 +903,6 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
-	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -897,28 +944,10 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 		tz->offset = 0;
 	}
 
-	/* trips */
-	trips = of_get_child_by_name(np, "trips");
-
-	/* No trips provided */
-	if (!trips)
+	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
+	if (IS_ERR(tz->trips)) {
+		ret = PTR_ERR(tz->trips);
 		goto finish;
-
-	tz->ntrips = of_get_child_count(trips);
-	if (tz->ntrips == 0) /* must have at least one child */
-		goto finish;
-
-	tz->trips = kcalloc(tz->ntrips, sizeof(*tz->trips), GFP_KERNEL);
-	if (!tz->trips) {
-		ret = -ENOMEM;
-		goto free_tz;
-	}
-
-	i = 0;
-	for_each_child_of_node(trips, gchild) {
-		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
-		if (ret)
-			goto free_trips;
 	}
 
 	/* cooling-maps */
@@ -940,7 +969,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
+		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
 		if (ret)
 			goto free_tbps;
 	}
-- 
2.25.1

