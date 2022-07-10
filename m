Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEC56CF15
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiGJMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGJMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C9011156
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so3892392wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJpp/3sovrJilbrJccW08MiNpRgjzFnvxf+q+uGsrtg=;
        b=fdOU0j/PkCW1L5PFaEZiU2JGHBNKlxN+fzzi9T/M0rCMEj4wee+7IBaum4CywN8L91
         UFuWh2c9YQb3pwAkW0DrNNb+RD0x/Uh9ImHuKzaAkwsyASduhb8XaLOkdg2OGNJGyA2H
         dY5MzdDl2rUsK/fY3XOrk2aVckzSn+x0sz1+V+Vqcd52KN23j7x/fiPFB2RgJKuinQ1X
         6mL3ijG48R7A/b3Wb1YQAVaQ67XQk6NHrp4DIial9YxdUYhCI6lJA1/VsdiUrBttPT/5
         YxeGLx5hGNGATI9su6/XRSJfhrF5x1k9h5hT2Nms1VlBFmHayo9EA+C0TMBH+mLmELeh
         3OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJpp/3sovrJilbrJccW08MiNpRgjzFnvxf+q+uGsrtg=;
        b=2T5NilRML15oyHn+hoNDJ+TqJbc2tjtOa1DWMgo6Gj8aBVqOq0LzIi/e44SxAy2vGT
         TpqJsheTx9b2uG91S+38SnEAudba2RcRWjGb1h21PPVVtv194ZAI4KJW7cbY0S/5F3eZ
         bVxX0c3yI2lCZas5DcqRYY1fij4dEdnnJgWV0Yt44JgkwRguvWFiaQsteoaSZiIUy5sT
         MunEmV22a1WmdeH1xAhCqzOLmIKrrEWivdIuG7l0DrgDDHhqsDJtZacvzJM9AFhasrLA
         xth+9VB8E6zvroHOagW35nCp2aPWFpem82XDyMu7u1PuYqMWwYLUC2ZhIa+kNMuM6hU0
         d0/Q==
X-Gm-Message-State: AJIora+f6kzUDhT8e3vvw3MKoxgCLyGY9w/kV8NbiHqSNfx2uQnkD4z1
        tXwAvbiA0jTuTNpe0M4tro8wXC9GWKsgfQ==
X-Google-Smtp-Source: AGRyM1uav6+HaNd6GpsrfJAcqzoVS+TYxgiPl0vSM4JhuNgl8trKCXrlepwNlq9027f4agbjqnQCeA==
X-Received: by 2002:adf:e187:0:b0:21d:64c6:74f0 with SMTP id az7-20020adfe187000000b0021d64c674f0mr12099785wrb.221.1657456518495;
        Sun, 10 Jul 2022 05:35:18 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 02/12] thermal/of: Replace device node match with device node search
Date:   Sun, 10 Jul 2022 14:35:01 +0200
Message-Id: <20220710123512.1714714-3-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

The thermal_of code builds a trip array associated with the node
pointer in order to compare the trip point phandle with the list.

The thermal trip is a thermal zone property and should be moved
there. If some sensors have hardcoded trip points, they should use the
exported structure instead of redefining again and again their own
structure and data to describe exactly the same things.

In order to move this to the thermal.h header and allow more cleanup,
we need to remove the node pointer from the structure.

Instead of building storing the device node, we search directly in the
device tree the corresponding node. That results in a simplification
of the code and allows to move the structure to thermal.h

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 64 +++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b65d435cb92f..7d96494ef94d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -671,6 +671,35 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
 
 /***   functions parsing device tree nodes   ***/
 
+static int of_find_trip_id(struct device_node *np, struct device_node *trip)
+{
+	struct device_node *trips;
+	struct device_node *t;
+	int i = 0;
+
+	trips = of_get_child_by_name(np, "trips");
+	if (!trips) {
+		pr_err("Failed to find 'trips' node\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Find the trip id point associated with the cooling device map
+	 */
+	for_each_child_of_node(trips, t) {
+
+		if (t == trip)
+			goto out;
+		i++;
+	}
+
+	i = -ENXIO;
+out:	
+	of_node_put(trips);
+
+	return i;
+}
+
 /**
  * thermal_of_populate_bind_params - parse and fill cooling map data
  * @np: DT node containing a cooling-map node
@@ -686,14 +715,13 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
  * Return: 0 on success, proper error code otherwise
  */
 static int thermal_of_populate_bind_params(struct device_node *np,
-					   struct __thermal_bind_params *__tbp,
-					   struct thermal_trip *trips,
-					   int ntrips)
+					   struct __thermal_bind_params *__tbp)
 {
 	struct of_phandle_args cooling_spec;
 	struct __thermal_cooling_bind_param *__tcbp;
 	struct device_node *trip;
 	int ret, i, count;
+	int trip_id;
 	u32 prop;
 
 	/* Default weight. Usage is optional */
@@ -708,18 +736,14 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 		return -ENODEV;
 	}
 
-	/* match using device_node */
-	for (i = 0; i < ntrips; i++)
-		if (trip == trips[i].np) {
-			__tbp->trip_id = i;
-			break;
-		}
-
-	if (i == ntrips) {
-		ret = -ENODEV;
+	trip_id = of_find_trip_id(np, trip);
+	if (trip_id < 0) {
+		ret = trip_id;
 		goto end;
 	}
 
+	__tbp->trip_id = trip_id;
+	
 	count = of_count_phandle_with_args(np, "cooling-device",
 					   "#cooling-cells");
 	if (count <= 0) {
@@ -868,6 +892,7 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
+	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -910,13 +935,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	}
 
 	/* trips */
-	child = of_get_child_by_name(np, "trips");
+	trips = of_get_child_by_name(np, "trips");
 
 	/* No trips provided */
-	if (!child)
+	if (!trips)
 		goto finish;
 
-	tz->ntrips = of_get_child_count(child);
+	tz->ntrips = of_get_child_count(trips);
 	if (tz->ntrips == 0) /* must have at least one child */
 		goto finish;
 
@@ -927,14 +952,12 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	}
 
 	i = 0;
-	for_each_child_of_node(child, gchild) {
+	for_each_child_of_node(trips, gchild) {
 		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
 		if (ret)
 			goto free_trips;
 	}
 
-	of_node_put(child);
-
 	/* cooling-maps */
 	child = of_get_child_by_name(np, "cooling-maps");
 
@@ -954,13 +977,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
-						      tz->trips, tz->ntrips);
+		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
 		if (ret)
 			goto free_tbps;
 	}
 
 finish:
+	of_node_put(trips);
 	of_node_put(child);
 
 	return tz;
@@ -981,6 +1004,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	for (i = 0; i < tz->ntrips; i++)
 		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
+	of_node_put(trips);
 	of_node_put(gchild);
 free_tz:
 	kfree(tz);
-- 
2.25.1

