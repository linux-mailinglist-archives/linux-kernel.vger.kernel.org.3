Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF59751E721
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446415AbiEGNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445470AbiEGM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E09C1E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so13459983wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uK+avJ+Fc4U1Ga3etjhF2701RA/xhtvy4kO7NRlkCh0=;
        b=5dt7w3FElgfiClR0goQtIOCz/YFEmg8Ot6QNGa8xFXFXKH339rh3U3/mE4mv59hKlU
         fTzwgMbKxg/F0yJNBTlGhALMebzD52DxaPkdyiPSnz7aFiJWbWvX22Nq6DwoEdGO6Tb7
         7d5jZW24QKV5T9aoKg80BmhEjQ35IeJsYWse4vS0Tm55wh477gD1gvrLvoSC5lq0SqKx
         ki38fjdzcp+kzZoyr4akDmx48k40aY40suAAANSlDf6k3p2Au62T9KDHH/g5ZMD4goLj
         B1U6EqIkymANSEDirKOKyhYGRiX7xyk4v548Stu5R7EzANpIplYgOqn5fFN/IvwgRdGC
         Wn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK+avJ+Fc4U1Ga3etjhF2701RA/xhtvy4kO7NRlkCh0=;
        b=k8nlrZVU2CliUt5w7d7oH4AExmWrXgQ5HfqjcwBZiWDqdL5fxMi+uEA+EUOYh5E0NR
         SGAPJFRKqOzjKwwYT3hh+qCG/HoqVZaGjA1utyY3E0+0QDfVaAH4hjd8YoCsxY23axQ0
         oPcyqxAhs7+zm0nfo6wiay+fu7c4kBhet6N+e8giXQ8Px2y/0qS64W3HVwGCtJhpfSbh
         bGcGAF5hZWHnD/hEHSt6RO0u5iHMiWIdawZ0/czvUf8WaB+SjG0WWwW89p+dStaZPDfn
         elFDsOerDa4TlGHY+zrFCYl86qoslJIDlmkiAIybrSCSBVUq5OJpCvYQOr8kSxOdUd0H
         +ZCw==
X-Gm-Message-State: AOAM533fO7YJbWXBmT2LrMmQzQaaDGfBK0VLiQuDd18FsNa67ZgDzCkJ
        92tBSPEDjLn5sGqGWchAIkSM5A==
X-Google-Smtp-Source: ABdhPJwCr2c+Ca883anoBDmg/lSekW6ek8XmHs2hS+jmDoKUfMI7FpDBjxE0NfPgAWuS57k4xJtfrg==
X-Received: by 2002:a5d:5887:0:b0:20c:83c9:b72 with SMTP id n7-20020a5d5887000000b0020c83c90b72mr6558172wrf.588.1651928122387;
        Sat, 07 May 2022 05:55:22 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 14/14] thermal/of: Initialize trip points separately
Date:   Sat,  7 May 2022 14:54:42 +0200
Message-Id: <20220507125443.2766939-15-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/thermal_of.c | 84 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 64e5b9e92cb1..fd55e895258c 100644
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
-		goto finish;
-
-	tz->ntrips = of_get_child_count(trips);
-	if (tz->ntrips == 0) /* must have at least one child */
+	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
+	if (IS_ERR(tz->trips)) {
+		ret = PTR_ERR(tz->trips);
 		goto finish;
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
@@ -940,9 +969,11 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
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
@@ -964,7 +995,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	kfree(tz->tbps);
 free_trips:
 	kfree(tz->trips);
-	of_node_put(gchild);
 free_tz:
 	kfree(tz);
 	of_node_put(child);
-- 
2.25.1

