Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2157E7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiGVUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiGVUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA8AF731
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l15so3824860wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVtxa+vuykpc9jPpe/gzYZEspPiDTyEIGx5jh5o8tcM=;
        b=4+janghD8Dw6whSA55KQShCIG1hZCMxlZM8n3+d/7DyuGeEXbFzq9kO106S8vbPv0+
         Rgb0Chkf9UnhCrktg7tnuJ8YPcyuOuy5Wdf2OVrqtFfOAFiYEzWaJ4RJ59SdW2oUTHki
         VzGLtrgcdcwNNFjXPCH4f64jjS2RI5PtEf+JjwHeQ2Rd0QDaRUvNMjsen2h8QAp5f1Db
         9POiG7MQRrFZWZwI8bL69nhoDPP9mDpsukBcfkO4doPLV77OCnBiRvx/IEmmWZ4ip+4/
         fBskA+67+Po0owOmuknbOboqvxzSrYl2HGjn7iJebU1koBjkMfFKsAnPaqCbsfqP1oz0
         XSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVtxa+vuykpc9jPpe/gzYZEspPiDTyEIGx5jh5o8tcM=;
        b=OhzRLaIUWeI638cbR05EwaveK3kqCl25o2OKquUA0/PIVh1+wWVdVd2KBEjHYkPtVy
         07YULt4lJRG1pEN5QVmBerSUC+DXQT6uICOOGhrBQ46QKmf81UCtLuwVo/66Dzh6wYci
         c1vP1jPYgYNhrbgmtlJP6RXILDqvdzca6fyhjE/EEOMQ+elIpps6QZflOZfhinucrslN
         fY73USZKW46/qGtTLtckpCBN9EUSIOemQ6Jq4QwExTRHH306+YE7d+eL87lzDr4yFICS
         qSUNm5PHcHRYKRwu1uysDcNd8IEqyJEAAZoZPoBbPU3NTO7uTWvqv63PIgD2As2fQ3uX
         K82w==
X-Gm-Message-State: AJIora9hoWu/mYIvlmF9xV1PCbgh6hTN8LHZIZFcL3mce65vj/DJ9wQ5
        2uBufukAwpIE2rJV1q9DtQF27A==
X-Google-Smtp-Source: AGRyM1vYAZglTmENhkJtrAMPgyidh7bkVjeuKlt0YW+4lqn+1k/roXGT0kDvWuZy7s2DD6CN9VB5zw==
X-Received: by 2002:a5d:460e:0:b0:21e:6d12:d308 with SMTP id t14-20020a5d460e000000b0021e6d12d308mr795545wrq.419.1658520045826;
        Fri, 22 Jul 2022 13:00:45 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 10/10] thermal/of: Initialize trip points separately
Date:   Fri, 22 Jul 2022 22:00:07 +0200
Message-Id: <20220722200007.1839356-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
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

Self contain the trip initialization from the device tree in a single
function for the sake of making the code flow more clear.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 86 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b59eec4af0eb..0693edc00f60 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -693,7 +693,8 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
  *
  * Return: 0 on success, proper error code otherwise
  */
-static int thermal_of_populate_bind_params(struct device_node *np,
+static int thermal_of_populate_bind_params(struct device_node *tz_np,
+					   struct device_node *np,
 					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
@@ -715,7 +716,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	trip_id = of_find_trip_id(np, trip);
+	trip_id = of_find_trip_id(tz_np, trip);
 	if (trip_id < 0) {
 		ret = trip_id;
 		goto end;
@@ -849,6 +850,53 @@ static int thermal_of_populate_trip(struct device_node *np,
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
@@ -867,7 +915,6 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
-	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -909,28 +956,10 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
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
@@ -952,13 +981,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
-		if (ret)
+		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
+		if (ret) {
+			of_node_put(gchild);
 			goto free_tbps;
+		}
 	}
 
 finish:
-	of_node_put(trips);
 	of_node_put(child);
 
 	return tz;
@@ -977,8 +1007,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(trips);
-	of_node_put(gchild);
 free_tz:
 	kfree(tz);
 	of_node_put(child);
-- 
2.25.1

