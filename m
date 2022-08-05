Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00FC58ACC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiHEO6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiHEO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9ACDFE2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z17so3551185wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/c47mmgHTTMvyLf/83EJ/1pMb9iuqt//FlEV+R3Bkds=;
        b=V/v37E7UL3/DfXbI6eCjm6rKFqCtEuU+q82C/T1MX0lgOf6sXm0T6ZVGmVe2scud7S
         mok6un4hASnbp1mJoAaOemcwvOtqs+yQGp3oBsjzkS2zQIMGnS5ga5a2KzZ0/lR+36ZT
         p7Pl3+aPpc6/EIQEzXtHNeRv6GQ2W1nYXeJS3yuP9ss4Z22iTsNlj/lijyPEeKK5ujhu
         B972SuiJV3TUHalWDEp+a9p3u3ppmRUjqjAVgtaE/tDKElJY6OOXXsvkenxBljf8zEvX
         YAd87UDEUTMTzkk5oq5y1xTmTMtd2AGtTOMYkRbghJoVyC28veSdZyztNOlAo7vUtF2F
         wJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/c47mmgHTTMvyLf/83EJ/1pMb9iuqt//FlEV+R3Bkds=;
        b=zicXIU6d7ZSzZVj0LtIlAwSGMYxZPhl0ntPlOlaThWG+hr+UhYmSKxtkIkoABY0m12
         FTlJTE8SR3Ud0ycKgCi2GRO0bv0FJ+o76s5VaDOb7CGc2Fa4Lwgd7zgyAmTdSKkH38yl
         r7xZF9BKCmxnOul5wwIfnYNKAy248VgWNEbTfTsaJGh8sg/zSWLQF8AJiqTBw5jSWZjS
         nn+KsB+8TNrW90LTVMnYcXYpaitkRZX5+/ekYjlg3nMUIopxRSXm3Y/lMhuWUqKl6E2v
         CR6hWj5cYi4plPFjqhep+k/gtuFF6wgXHlLmIQtMI8PQ+h+Rf09UJ7atHGTxG7Z8//hc
         LE7Q==
X-Gm-Message-State: ACgBeo1la4OuQhsBgWLO+yJ28qQEWGkQU61YHt+nM16Nznk+iMvjkhwp
        AySdIjby1lAau3XN9uXN2OLb9w==
X-Google-Smtp-Source: AA6agR4GeV2y+hOJd8mp2Fh31Net3NqxYHbyGc5gyzCl9XMZS74RTAtCTF7iVE7ekwvFpGaSjXAgyw==
X-Received: by 2002:a5d:6e89:0:b0:21e:ad87:ab24 with SMTP id k9-20020a5d6e89000000b0021ead87ab24mr4655923wrz.259.1659711482963;
        Fri, 05 Aug 2022 07:58:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 13/26] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:16 +0200
Message-Id: <20220805145729.2491611-14-daniel.lezcano@linaro.org>
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
 drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 52d63b3997fe..9444e5a22ca0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct thermal_trip trip;
 	int ret;
 	int i;
 
-	if (!trips)
-		return -EINVAL;
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			break;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	if (i == of_thermal_get_ntrips(tz))
-		return -EINVAL;
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		if (trip.type != THERMAL_TRIP_CRITICAL) 
+			continue;
 
-	ret = armada_select_channel(priv, sensor_id);
-	if (ret)
-		return ret;
+		ret = armada_select_channel(priv, sensor_id);
+		if (ret)
+			return ret;
+		
+		armada_set_overheat_thresholds(priv, trip.temperature,
+					       trip.hysteresis);
+		priv->overheat_sensor = tz;
+		priv->interrupt_source = sensor_id;
 
-	armada_set_overheat_thresholds(priv,
-				       trips[i].temperature,
-				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
+		armada_enable_overheat_interrupt(priv);
 
-	armada_enable_overheat_interrupt(priv);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.25.1

