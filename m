Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370758ACD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiHEO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiHEO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AC6BD5F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q30so3503352wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aqMaHXWxSF1AlY1fJjS12uTHlTBPz1oDnaX+N99K3gQ=;
        b=mqQrqmu+YhBQKIHfpM02TKn8UWOFfqRsUFuFQbbJhvSQ1LoPwTt3dwHLaiqSpzdN9E
         PDpn+KG6MZAitd5QWudINdRdVFMHC7KHDPtJAaAyFwGBpaCu+pnqgRQ+c+hxkSPqaNnI
         xuknQtd0BI0OZPGvyBNOG7x4KlSHpLzhNqqXbupqSM0iyzaxoAFl9fdcgGB8CbqG6amo
         YCVbnf5NLwOjibh0MIqn1QgFTo48NZYHi9Ny5K8znbP8gQfuFsPlJHCiZjFkbVS1o/4K
         kCB+tJwwyjdYmFGKsTxwBcH7jWy1vH2kc0HqgTLKmYSJ9g4F0GwMNwAX0CjWGJdtniBs
         ZFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aqMaHXWxSF1AlY1fJjS12uTHlTBPz1oDnaX+N99K3gQ=;
        b=MJoREEAqU7ap0QFno9mBxcEADwiLm4Whuo5lGtWWNJQ+nLGfTGQuMVGPC81TTweibi
         uGyamD8xGPdreXhrGGYkq9XY0tc896gU3RZiUrKTGRhRd+om47qTDhnsQh70lg4BdW/h
         KMe/UTi80nViCjtnEMOGbHYjqrRIJOr//2HoMNhyu5iIOVKpi5+CiVDKvLrOr5O742sk
         8s3AMDadPW6P6AeLp2ZHy5GPhW1H0Uh4B1KkRI9DWMwvqtXYdADHUV6sd6dQr/rWG4kj
         5E2afwHGcAoYDSwBvwiYkbjVjPjdNvnZYlwEX6C0ghfRP/KRDt9/drrSFxblSVDOyPUa
         sPnw==
X-Gm-Message-State: ACgBeo0SDNkD83LM2/pKs+PtV+6gSD7S1tntctOz4+Yc7t4CgwSLyc9I
        MhFQfRKuhRAl5mzDj3UHMTk/hw==
X-Google-Smtp-Source: AA6agR4JSLzRCO8BJrj8mF8xZLtYg+aL9xK+By9lyb4B7Jxec+U/RjWtTI1b7bJsL6XswKljIgLBLQ==
X-Received: by 2002:a5d:590f:0:b0:21f:c78:4693 with SMTP id v15-20020a5d590f000000b0021f0c784693mr4489792wrd.544.1659711492875;
        Fri, 05 Aug 2022 07:58:12 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v1 20/26] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:23 +0200
Message-Id: <20220805145729.2491611-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
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
2.25.1

