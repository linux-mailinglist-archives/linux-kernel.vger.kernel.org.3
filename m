Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD49533499
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiEYBH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbiEYBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:07:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5706EC7B;
        Tue, 24 May 2022 18:07:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i66so23411478oia.11;
        Tue, 24 May 2022 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akyJ3eMCAM3VOmRdshXQ/0n8kw50DGr5XbOrDQl6ss4=;
        b=JVTSo8shoRUGLP+njlNZ0/EcvVOb/hJ/S/tl8AZNMShjpwy+gYzjzxIkXzgmDBv+ao
         JYQxGq00n3V3J6O4lKUGaMxic7QPJ6tY3qzlkza0oF9LBsquK1ddCQPfYTz3UNZ9xW3n
         G8y2SCfTys2c39WV4h5h7H1/yujJnWVnLg4YhgW/0f8crOE9Mi60PFoRDiFqAKDjKrOI
         arVkKw1P1BOIj4ScxticVXb47UCJitj17j4WlAo0R04eIqK93T0cHINd8ywhHS1q0j5l
         22qkQonu2FLvng/cfrv+v1PEBr3vXL5vE/Mt/ny6UKDjdsX05DByhbiQwM85qMjCcnuQ
         ZiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=akyJ3eMCAM3VOmRdshXQ/0n8kw50DGr5XbOrDQl6ss4=;
        b=H00WpXd1miQyqlUeRoZPmUfvgYXOKmEH75McUh5AkGD1tHj01J0qMh5XpOJuLp1Ok5
         Ub0RVQRdBHqdZDgt47/g4ftGv+6pK1D2AWToIBuIrcsqXQwZeqNWK+irbFf7Ng3SbWSB
         rzpiDeDDwIB5fX741e2fan/ZECfVKxuQjbejGE+vwTqIi2bv10cpH+rmx+M7QUDoRId8
         6PmFNeSxMiPU2CPekXwsxuNn+fAZdJSZQj2ed4GEqi9Kr1i+NYxM1fQGCdKtUrAuM/RT
         pKpygpV1TJIZghxo/evVlvSozaWiWjHRLDGfC8LA+IQO30Ci3aJrsksAyL+3VYp8+rMA
         PhwA==
X-Gm-Message-State: AOAM5334nv7vj0nYc/6v1HCklgnGxjJ52+u0MgZ8kVLgSV8FipTe69k4
        tz7oIsO+ndCa1fy85UH4OPdvFzZqQxm/wA==
X-Google-Smtp-Source: ABdhPJzfI4edgskSY0YWZEB9GYX2e8QW3zPtN40pwAUC/qJh9p+hMaZV000flkkbD38TCwAiJP8VCA==
X-Received: by 2002:a05:6808:344:b0:32a:f6d8:82cc with SMTP id j4-20020a056808034400b0032af6d882ccmr4008457oie.200.1653440842804;
        Tue, 24 May 2022 18:07:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb6-20020a056820160600b0040e8c09f99dsm3096134oob.23.2022.05.24.18.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:07:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/3] hwmon: (pmbus) Add IEEE 754 half precision support to PMBus core
Date:   Tue, 24 May 2022 18:07:15 -0700
Message-Id: <20220525010717.4000736-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IEEE 754 half precision data format as specified
in PMBus v1.3.1.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to v5.18+

 drivers/hwmon/pmbus/pmbus.h      |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 142 ++++++++++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index c031a9700ace..c708b60c1b48 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -406,7 +406,7 @@ enum pmbus_sensor_classes {
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
 
-enum pmbus_data_format { linear = 0, direct, vid };
+enum pmbus_data_format { linear = 0, ieee754, direct, vid };
 enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
 
 struct pmbus_driver_info {
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index e670b868e74b..bb21f1e79289 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -611,6 +611,66 @@ static void pmbus_update_sensor_data(struct i2c_client *client, struct pmbus_sen
 						     sensor->phase, sensor->reg);
 }
 
+/*
+ * Convert ieee754 sensor values to milli- or micro-units
+ * depending on sensor type.
+ *
+ * ieee754 data format:
+ *	bit 15:		sign
+ *	bit 10..14:	exponent
+ *	bit 0..9:	mantissa
+ * exponent=0:
+ *	v=(−1)^signbit * 2^(−14) * 0.significantbits
+ * exponent=1..30:
+ *	v=(−1)^signbit * 2^(exponent - 15) * 1.significantbits
+ * exponent=31:
+ *	v=NaN
+ *
+ * Add the number mantissa bits into the calculations for simplicity.
+ * To do that, add '10' to the exponent. By doing that, we can just add
+ * 0x400 to normal values and get the expected result.
+ */
+static long pmbus_reg2data_ieee754(struct pmbus_data *data,
+				   struct pmbus_sensor *sensor)
+{
+	int exponent;
+	bool sign;
+	long val;
+
+	/* only support half precision for now */
+	sign = sensor->data & 0x8000;
+	exponent = (sensor->data >> 10) & 0x1f;
+	val = sensor->data & 0x3ff;
+
+	if (exponent == 0) {			/* subnormal */
+		exponent = -(14 + 10);
+	} else if (exponent ==  0x1f) {		/* NaN, convert to min/max */
+		exponent = 0;
+		val = 65504;
+	} else {
+		exponent -= (15 + 10);		/* normal */
+		val |= 0x400;
+	}
+
+	/* scale result to milli-units for all sensors except fans */
+	if (sensor->class != PSC_FAN)
+		val = val * 1000L;
+
+	/* scale result to micro-units for power sensors */
+	if (sensor->class == PSC_POWER)
+		val = val * 1000L;
+
+	if (exponent >= 0)
+		val <<= exponent;
+	else
+		val >>= -exponent;
+
+	if (sign)
+		val = -val;
+
+	return val;
+}
+
 /*
  * Convert linear sensor values to milli- or micro-units
  * depending on sensor type.
@@ -741,6 +801,9 @@ static s64 pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 	case vid:
 		val = pmbus_reg2data_vid(data, sensor);
 		break;
+	case ieee754:
+		val = pmbus_reg2data_ieee754(data, sensor);
+		break;
 	case linear:
 	default:
 		val = pmbus_reg2data_linear(data, sensor);
@@ -749,8 +812,72 @@ static s64 pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 	return val;
 }
 
-#define MAX_MANTISSA	(1023 * 1000)
-#define MIN_MANTISSA	(511 * 1000)
+#define MAX_IEEE_MANTISSA	(0x7ff * 1000)
+#define MIN_IEEE_MANTISSA	(0x400 * 1000)
+
+static u16 pmbus_data2reg_ieee754(struct pmbus_data *data,
+				  struct pmbus_sensor *sensor, long val)
+{
+	u16 exponent = (15 + 10);
+	long mantissa;
+	u16 sign = 0;
+
+	/* simple case */
+	if (val == 0)
+		return 0;
+
+	if (val < 0) {
+		sign = 0x8000;
+		val = -val;
+	}
+
+	/* Power is in uW. Convert to mW before converting. */
+	if (sensor->class == PSC_POWER)
+		val = DIV_ROUND_CLOSEST(val, 1000L);
+
+	/*
+	 * For simplicity, convert fan data to milli-units
+	 * before calculating the exponent.
+	 */
+	if (sensor->class == PSC_FAN)
+		val = val * 1000;
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val > MAX_IEEE_MANTISSA && exponent < 30) {
+		exponent++;
+		val >>= 1;
+	}
+	/*
+	 * Increase small mantissa to generate valid 'normal'
+	 * number
+	 */
+	while (val < MIN_IEEE_MANTISSA && exponent > 1) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = DIV_ROUND_CLOSEST(val, 1000);
+
+	/*
+	 * Ensure that the resulting number is within range.
+	 * Valid range is 0x400..0x7ff, where bit 10 reflects
+	 * the implied high bit in normalized ieee754 numbers.
+	 * Set the range to 0x400..0x7ff to reflect this.
+	 * The upper bit is then removed by the mask against
+	 * 0x3ff in the final assignment.
+	 */
+	if (mantissa > 0x7ff)
+		mantissa = 0x7ff;
+	else if (mantissa < 0x400)
+		mantissa = 0x400;
+
+	/* Convert to sign, 5 bit exponent, 10 bit mantissa */
+	return sign | (mantissa & 0x3ff) | ((exponent << 10) & 0x7c00);
+}
+
+#define MAX_LIN_MANTISSA	(1023 * 1000)
+#define MIN_LIN_MANTISSA	(511 * 1000)
 
 static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 				 struct pmbus_sensor *sensor, s64 val)
@@ -796,12 +923,12 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *data,
 		val = val * 1000LL;
 
 	/* Reduce large mantissa until it fits into 10 bit */
-	while (val >= MAX_MANTISSA && exponent < 15) {
+	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
 		exponent++;
 		val >>= 1;
 	}
 	/* Increase small mantissa to improve precision */
-	while (val < MIN_MANTISSA && exponent > -15) {
+	while (val < MIN_LIN_MANTISSA && exponent > -15) {
 		exponent--;
 		val <<= 1;
 	}
@@ -875,6 +1002,9 @@ static u16 pmbus_data2reg(struct pmbus_data *data,
 	case vid:
 		regval = pmbus_data2reg_vid(data, sensor, val);
 		break;
+	case ieee754:
+		regval = pmbus_data2reg_ieee754(data, sensor, val);
+		break;
 	case linear:
 	default:
 		regval = pmbus_data2reg_linear(data, sensor, val);
@@ -2369,6 +2499,10 @@ static int pmbus_identify_common(struct i2c_client *client,
 			if (data->info->format[PSC_VOLTAGE_OUT] != direct)
 				return -ENODEV;
 			break;
+		case 3:	/* ieee 754 half precision */
+			if (data->info->format[PSC_VOLTAGE_OUT] != ieee754)
+				return -ENODEV;
+			break;
 		default:
 			return -ENODEV;
 		}
-- 
2.35.1

