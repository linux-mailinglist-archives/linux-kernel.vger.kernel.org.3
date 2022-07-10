Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4256CF18
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiGJMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGJMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106E1115B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p4so1669395wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=7FZC1XlwUeCjZH8ZSvIznIq5ec/4ZvJN7n3SWjDc+mViL4KDlcjnIgSL5NworU/YCS
         6+zFq1odwL3lW3NA013zSGPEgqj33JKyMSSSF1doHNmeqTiXCy482kR5uFxqqLShC5bE
         GuHvCdAH8dfDEX3tA5WRb7K6L+zrhI6O4krhUc1+zafZg9YrHPLzK+BVkRvBjeAox+SI
         IrOX6p92xYyDEye2WlQyCPkESExe21CHv17CXpvlTHWwtyzOirCVezhrP7i2lo7zvCvV
         QYk2skX+WGcFrDdR5YbgCgeqjLNSks9UqQemtj7Sm/x3JYHagq4p9lrXcp+rAWNUMl73
         OZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=pV7CigYIfECDvvQ3xORIlZsGUWkznbD6srcPdUTadVIlrmtkaKxAV4iHKqaqMAl6IS
         yEnRECErPthFUd8ly01fcPtAFnIJkbqhGbHizLrfqKpRV9AciC1bFaravPBYXa7Xf9nJ
         KEOdSQPBkmalQNg59ojbiqoQ8oiW5VDAMlaZgE0X8hi+CpUwofqfv5Anm9QzCThqzR3/
         GnbJhIDWS2lg+iLyelIX70u8ftuUOft1azNtZMRkP7+wQ2tPDDLEfp47ALxia2fGIyyJ
         J4sE0ZFBSU9hg7Te08G3cB29nnfHdrwmHxBqa8pA4vRe/AtB3HZDnpM55ddHCpL68C1w
         sp3w==
X-Gm-Message-State: AJIora88jYm8BjZ+Tu6y7mw5JIIe48obqYVOTtvwDj7w9lUkb9NEqr3e
        ZxlVN1GHQas6SSSCRqv18mVm/A==
X-Google-Smtp-Source: AGRyM1tpONmqIRY5diePpBSQza27Ip45mxPB+Syk8AvH+Sa8dpOESdi0d3FCZKpamr1oEnU7vJXICw==
X-Received: by 2002:a05:600c:1e20:b0:3a2:e540:17ad with SMTP id ay32-20020a05600c1e2000b003a2e54017admr2751595wmb.205.1657456519575;
        Sun, 10 Jul 2022 05:35:19 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 03/12] thermal/of: Remove the device node pointer for thermal_trip
Date:   Sun, 10 Jul 2022 14:35:02 +0200
Message-Id: <20220710123512.1714714-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

The device node pointer is no longer needed in the thermal trip
structure, remove it.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h | 2 --
 drivers/thermal/thermal_of.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..ff10cdda056c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -70,13 +70,11 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
  */
 struct thermal_trip {
-	struct device_node *np;
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 7d96494ef94d..19243c57b3f4 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -867,10 +867,6 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
-	/* Required for cooling map matching */
-	trip->np = np;
-	of_node_get(np);
-
 	return 0;
 }
 
@@ -1001,8 +997,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(trips);
 	of_node_put(gchild);
@@ -1028,8 +1022,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

