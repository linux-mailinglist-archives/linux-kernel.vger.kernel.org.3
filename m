Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139894EFC40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352895AbiDAVmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351805AbiDAVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:42:33 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE097265E81;
        Fri,  1 Apr 2022 14:40:42 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F31D522249;
        Fri,  1 Apr 2022 23:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648849241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92Ipf+SNVjQC2sLd1I2KRQ1qqFCuUwW6leZy97zvTaY=;
        b=rVAGIzLH/7STp6XR5VYD+bR0HlEX7L7+TBFGJmefPLDRu3lMZ53Q49Cwm7FxAIWrWOuQTM
        OcU1VIvZh3emeHNQngE8wgUcEPtDu7JJt2NtcVZCD3QjtWp4Jw+UZFpvtvoBXbtOYfrVA2
        6QtRi6DnXZjON1AuG3xfO4Qq+SUICbQ=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 2/4] hwmon: (bt1-pvt) use generic polynomial functions
Date:   Fri,  1 Apr 2022 23:40:30 +0200
Message-Id: <20220401214032.3738095-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220401214032.3738095-1-michael@walle.cc>
References: <20220401214032.3738095-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The polynomial calculation function was moved into lib/ to be able to
reuse it. Move over to this one.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig   |  1 +
 drivers/hwmon/bt1-pvt.c | 50 +++++++++++------------------------------
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..be9773270e53 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -415,6 +415,7 @@ config SENSORS_ATXP1
 config SENSORS_BT1_PVT
 	tristate "Baikal-T1 Process, Voltage, Temperature sensor driver"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	select POLYNOMIAL
 	help
 	  If you say yes here you get support for Baikal-T1 PVT sensor
 	  embedded into the SoC.
diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
index 74ce5211eb75..21ab172774ec 100644
--- a/drivers/hwmon/bt1-pvt.c
+++ b/drivers/hwmon/bt1-pvt.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/polynomial.h>
 #include <linux/seqlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -65,7 +66,7 @@ static const struct pvt_sensor_info pvt_info[] = {
  *     48380,
  * where T = [-48380, 147438] mC and N = [0, 1023].
  */
-static const struct pvt_poly __maybe_unused poly_temp_to_N = {
+static const struct polynomial __maybe_unused poly_temp_to_N = {
 	.total_divider = 10000,
 	.terms = {
 		{4, 18322, 10000, 10000},
@@ -76,7 +77,7 @@ static const struct pvt_poly __maybe_unused poly_temp_to_N = {
 	}
 };
 
-static const struct pvt_poly poly_N_to_temp = {
+static const struct polynomial poly_N_to_temp = {
 	.total_divider = 1,
 	.terms = {
 		{4, -16743, 1000, 1},
@@ -97,7 +98,7 @@ static const struct pvt_poly poly_N_to_temp = {
  * N = (18658e-3*V - 11572) / 10,
  * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
  */
-static const struct pvt_poly __maybe_unused poly_volt_to_N = {
+static const struct polynomial __maybe_unused poly_volt_to_N = {
 	.total_divider = 10,
 	.terms = {
 		{1, 18658, 1000, 1},
@@ -105,7 +106,7 @@ static const struct pvt_poly __maybe_unused poly_volt_to_N = {
 	}
 };
 
-static const struct pvt_poly poly_N_to_volt = {
+static const struct polynomial poly_N_to_volt = {
 	.total_divider = 10,
 	.terms = {
 		{1, 100000, 18658, 1},
@@ -113,31 +114,6 @@ static const struct pvt_poly poly_N_to_volt = {
 	}
 };
 
-/*
- * Here is the polynomial calculation function, which performs the
- * redistributed terms calculations. It's pretty straightforward. We walk
- * over each degree term up to the free one, and perform the redistributed
- * multiplication of the term coefficient, its divider (as for the rationale
- * fraction representation), data power and the rational fraction divider
- * leftover. Then all of this is collected in a total sum variable, which
- * value is normalized by the total divider before being returned.
- */
-static long pvt_calc_poly(const struct pvt_poly *poly, long data)
-{
-	const struct pvt_poly_term *term = poly->terms;
-	long tmp, ret = 0;
-	int deg;
-
-	do {
-		tmp = term->coef;
-		for (deg = 0; deg < term->deg; ++deg)
-			tmp = mult_frac(tmp, data, term->divider);
-		ret += tmp / term->divider_leftover;
-	} while ((term++)->deg);
-
-	return ret / poly->total_divider;
-}
-
 static inline u32 pvt_update(void __iomem *reg, u32 mask, u32 data)
 {
 	u32 old;
@@ -324,9 +300,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 	} while (read_seqretry(&cache->data_seqlock, seq));
 
 	if (type == PVT_TEMP)
-		*val = pvt_calc_poly(&poly_N_to_temp, data);
+		*val = polynomial_calc(&poly_N_to_temp, data);
 	else
-		*val = pvt_calc_poly(&poly_N_to_volt, data);
+		*val = polynomial_calc(&poly_N_to_volt, data);
 
 	return 0;
 }
@@ -345,9 +321,9 @@ static int pvt_read_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 		data = FIELD_GET(PVT_THRES_HI_MASK, data);
 
 	if (type == PVT_TEMP)
-		*val = pvt_calc_poly(&poly_N_to_temp, data);
+		*val = polynomial_calc(&poly_N_to_temp, data);
 	else
-		*val = pvt_calc_poly(&poly_N_to_volt, data);
+		*val = polynomial_calc(&poly_N_to_volt, data);
 
 	return 0;
 }
@@ -360,10 +336,10 @@ static int pvt_write_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 
 	if (type == PVT_TEMP) {
 		val = clamp(val, PVT_TEMP_MIN, PVT_TEMP_MAX);
-		data = pvt_calc_poly(&poly_temp_to_N, val);
+		data = polynomial_calc(&poly_temp_to_N, val);
 	} else {
 		val = clamp(val, PVT_VOLT_MIN, PVT_VOLT_MAX);
-		data = pvt_calc_poly(&poly_volt_to_N, val);
+		data = polynomial_calc(&poly_volt_to_N, val);
 	}
 
 	/* Serialize limit update, since a part of the register is changed. */
@@ -522,9 +498,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 		return -ETIMEDOUT;
 
 	if (type == PVT_TEMP)
-		*val = pvt_calc_poly(&poly_N_to_temp, data);
+		*val = polynomial_calc(&poly_N_to_temp, data);
 	else
-		*val = pvt_calc_poly(&poly_N_to_volt, data);
+		*val = polynomial_calc(&poly_N_to_volt, data);
 
 	return 0;
 }
-- 
2.30.2

