Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DC5AF193
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiIFRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiIFRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:01:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E205AC65
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:48:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so11326119wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=MXGgRNozmSiTJDrSQGhOqLAYkNyQdEf+MvlRK6wDRULEIyGehPAVkS2pWBu+v4KVI3
         r2M7fKLCgA/0xSUzN5utm3rPHu5wwsD9VFO7d9ohljX8r1o/U6zdh+tYT+SR7qJ6TDm8
         zp0ACWwSlMW3Fc3pW3a5J24CTo+HA931m30KwrcblwOorqVJEIOKr8xRB+A7go5R541Q
         fKEWSZMwfEzKoRvfx97BbXgfC6Q0yJi07gQ68/cDhBRVSAZBq+rTbN0A7traz+VSWHDo
         qDOs7p4UwIHAMmExnVHZ1TgMnBm0WFF7u6hC0SEfI4GlvsDfLqhzMu1iON8FHYHzdJZm
         smDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=y1wwojF7m5gWcYR8GDtuyWFcCYsOr93u56lgo9bU+PVmhQLpKm4skLrBXeOYq8Aqwk
         5aMVesupR82Xe09arAzJ8sXeJgTI+8S9xh2YuYhia8NYtSAZdSKww5xyOnlreh5kNKWI
         3HUpNUv5dBO2U2mS9Dl0wWtw5DGWw+AAzPHGe9MhmeoVOVRHJDqgQLEGgOLUrFey34Z+
         CzdZRVTDmiKHO6Mtx1fsiMQ6ud7TRlzhcl4Bdfxbbq8faFTE4SOQQHO6EzszR7SAtwlW
         K6yHjiCtP3GsLyhf2/Tqd4wsqMu+DIgIXIr/W2aunQh+IgP0whO8oThuC/rYYxsbcBEB
         f7NQ==
X-Gm-Message-State: ACgBeo12R6TMj+BtM5xk5IguZS8rxP5EsbLwEErpVBngOPXNLPob+MBR
        Wm+YRN1OZoYr0yP7VFEfGIX9xQ==
X-Google-Smtp-Source: AA6agR6XIRcEoeyLaSxHMBLKwQF0QhLuHuR3B1cYfC3PJXE0abDpIDYcpQwEP9X88VuDatj0oVwNxg==
X-Received: by 2002:a5d:5887:0:b0:220:81c9:8ab7 with SMTP id n7-20020a5d5887000000b0022081c98ab7mr27763590wrf.702.1662482887974;
        Tue, 06 Sep 2022 09:48:07 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:48:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v3 24/30] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:14 +0200
Message-Id: <20220906164720.330701-25-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/thermal/broadcom/bcm2835_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 2c67841a1115..5485e59d03a9 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
+#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 #define BCM2835_TS_TSENSCTL			0x00
@@ -224,7 +225,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	val = readl(data->regs + BCM2835_TS_TSENSCTL);
 	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
-		int trip_temp, offset, slope;
+		struct thermal_trip trip;
+		int offset, slope;
 
 		slope = thermal_zone_get_slope(tz);
 		offset = thermal_zone_get_offset(tz);
@@ -232,7 +234,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		 * For now we deal only with critical, otherwise
 		 * would need to iterate
 		 */
-		err = tz->ops->get_trip_temp(tz, 0, &trip_temp);
+		err = thermal_zone_get_trip(tz, 0, &trip);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
@@ -249,7 +251,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		val |= (0xFE << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
 
 		/*  trip_adc value from info */
-		val |= bcm2835_thermal_temp2adc(trip_temp,
+		val |= bcm2835_thermal_temp2adc(trip.temperature,
 						offset,
 						slope)
 			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;
-- 
2.34.1

