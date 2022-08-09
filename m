Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3858E2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiHIWHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiHIWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E9ADFC6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so15780486wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=jCNREL2wvW5Mt/Jx47kkKqrkQYSxrNhtbo/YUXfdyuGbaMqFonANOTppRgCHOvVlRh
         nAO8aL/UEwwb2MXaPozfGKUhb+nB7ztAqZ3MZ4ChLnkrU0PQaTCEl8UljO6HAtCLBQ8g
         bNkqOH56RW1+trgVV3mCHeYSlX++/c2y6xvjKqd2QYlLF+1h2CRcjwASR0Z5SyxFh9wK
         XvqFQjWkPUB9tg74PqHmQetBYqaTNulmjnE+VYSCWeRgxh1vn/IhfSYT49ff1i9QmFy5
         0kj88VosKBabAVvaUEMiS1Q5n+mMr5OPPCApaTPbgTzMbEy2TD3llXndJKN7LuwKWuXE
         FL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=b4GlFmx0NJubXOgJjGLN4NClAt9t+ZPVmJAcTxxlgmfp+TBKdc1V7gBz860yiwkEfo
         W3b8zk+8oHaRgfmPZAag8kf1CHK5tnpyHcueK9loblONL3/7L6YBECq65MdcU60Zj+Vo
         UlL/OJMKQmwm0I89L97ALNIYN2lJieUPa/m+kZQpn4ncxRM9lM/tlempyFr2j2YrzdHb
         WDkEHLRrYpQYznadaJ2NM8vDrk+wi7DbWE/PfrYIyr8aSzR+Np3DNBCNb4ey64/2AX52
         Ut49cW5kT75BlFIZGP4KlSUBjCo5/kpemh3J9H5kUeDM6s4keQtY4xuTxRgqMY/pXNUA
         hSDQ==
X-Gm-Message-State: ACgBeo2gV85MSi1KTLc4MUMWSj7rnWGdzh93sTSUSPT+ksDOPcuwcmnX
        IsBTa4/MZjf9MWqcmFCXqpLnFg==
X-Google-Smtp-Source: AA6agR5NGbThSbhVZ+tZO3ogBhTmCAhnaSQPK4NshdFqQqNV6OfuTIurkNF/5/N9B6xXxOhrZOKwEQ==
X-Received: by 2002:adf:d4c2:0:b0:21e:ddf3:8b14 with SMTP id w2-20020adfd4c2000000b0021eddf38b14mr15888310wrk.355.1660082723860;
        Tue, 09 Aug 2022 15:05:23 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 20/26] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:30 +0200
Message-Id: <20220809220436.711020-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

