Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE07951E725
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446384AbiEGM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385013AbiEGM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D945053
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5874339wmn.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJTpdtZ3Dvv2pgbB16rUZnzGfgzRayyB+EehmrYmI4I=;
        b=r8DEyWCaOn3aWY2lI6UgyxsgndLqA3OA747yuYprq1WCUe1gMkuX4+0zwPRLI0T+9r
         okytRUZk6Nu0/FQp6nM+0jBMjrZpzOfmAuxYKkpQ3+p/n5OnfKoIf95+p+nNwBo1uvRU
         vFBMdPEWEyJobBUPndajOygUtvmwQlZHrRwVga3C0/yHaoHSoOBv5JEhxk+YLPQHSuve
         am8qEsc+gava0AE6j98gwvKHhXD8YFRoEBOUtnrgc9FO0iSuf/DD/H0bedUcqIMEAZjj
         OT0ipqij64Faxxan8nl54xm3N8a6Sj51Lz1ufbqBxDPV3IaP0uMcewe0eQVi2RG1MWi+
         fvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJTpdtZ3Dvv2pgbB16rUZnzGfgzRayyB+EehmrYmI4I=;
        b=NONUikgOZ6NlE124T/t2OqKkT2JaSSBMZCdc2Jx+q3OavpbF8CZ7LZUvpP8tOgUomr
         Z6EpCRzb+xsDZY+tO0baVNgm7psq8n9Q7nSiAxhsPdKiXzsqMRAdLayTfdHn2N3kN80O
         vFiuP3WB6XJDb9HoCxtT/XxgcwCfomZh5gbpCs2V1Q4AR8UjwHEVaVl/I255G/g9GqY2
         8WDiJJuwDpz+kdj6v8JIPLD8wrcNi1IZehafMjY0lMX8DrCGK5g2peaSmW/POIpDGfmQ
         UEUgKEfMeukAnkt7ZbOL9/lWe3Qk+jarzYb6pwIQS5zpe8QA3v7GY81VgtxyqBIyflH6
         luHg==
X-Gm-Message-State: AOAM531EQP3JEa5rrNfP0h1f1RfzC8VYE+h0+Jvyvq/h++W6/BtXHwoE
        mJgGnhN6QxY/3WykuSvUFTfzwg==
X-Google-Smtp-Source: ABdhPJwVzX01+jP/THCWZgaTNGuZUeO5WZLo7PjVFPBEODAUucRQdLdpDOc0XorIz8nqdXE/AoSclg==
X-Received: by 2002:a1c:7512:0:b0:394:16ee:ab9b with SMTP id o18-20020a1c7512000000b0039416eeab9bmr7921228wmc.176.1651928110390;
        Sat, 07 May 2022 05:55:10 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 04/14] thermal/of: Replace device node match with device node search
Date:   Sat,  7 May 2022 14:54:32 +0200
Message-Id: <20220507125443.2766939-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 62 ++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d6917f1bc486..d8b4a0ad2d5f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -659,6 +659,35 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
 
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
@@ -674,14 +703,13 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
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
@@ -696,18 +724,14 @@ static int thermal_of_populate_bind_params(struct device_node *np,
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
@@ -856,6 +880,7 @@ static struct __thermal_zone
 __init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
+	struct device_node *trips;
 	struct __thermal_zone *tz;
 	int ret, i;
 	u32 prop, coef[2];
@@ -898,13 +923,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
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
 
@@ -915,14 +940,12 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
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
 
@@ -942,8 +965,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	i = 0;
 	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
-						      tz->trips, tz->ntrips);
+		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
 		if (ret)
 			goto free_tbps;
 	}
-- 
2.25.1

