Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88B54A834C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbiBCLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:45:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:22405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350231AbiBCLo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643888697; x=1675424697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibPTErh0wG+RM8WWLKLF3IU/awfNnF0p1Wlu65q0gKA=;
  b=gXAUHPWdXoCtCj18gtGFxq274oPkEUVp8thSniSAu/XBc3TFIeyJD6XR
   t5LpPwA2A0AYDl5dCWUM6MsKEz6u/wHiDAuaHic2/nznRGor22Q62KFCS
   3kf49GsfhIq4eXUMqKwOegCZZepsG1Dx9mazWJnCsjZ277J8oei92pqTJ
   z6ri2baQAM+nVO5X35zGGZtoYcxQGbimVykKE92x964+zpNtPnsdcFpEj
   fRcvObOC+/HYJ5Vj37eBKZEYhejiJPev4cAyQg++NOpJo9whc7iliZ5uq
   RJTC/mvUFWty9o5Wj8to+QYHpW4RZaIu/XJ4ra2Fizc0t9yKEaUVdI1Rs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308853693"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="308853693"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:44:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="483214812"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2022 03:44:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ECD50204; Thu,  3 Feb 2022 13:45:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device properties
Date:   Thu,  3 Feb 2022 13:45:06 +0200
Message-Id: <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/temperature/ltc2983.c | 211 +++++++++++++++---------------
 1 file changed, 105 insertions(+), 106 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index d272c303c1b0..a2fcea7d9d90 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -12,11 +12,15 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+
 /* register map */
 #define LTC2983_STATUS_REG			0x0000
 #define LTC2983_TEMP_RES_START_REG		0x0010
@@ -219,7 +223,7 @@ struct ltc2983_sensor {
 
 struct ltc2983_custom_sensor {
 	/* raw table sensor data */
-	u8 *table;
+	void *table;
 	size_t size;
 	/* address offset */
 	s8 offset;
@@ -377,25 +381,25 @@ static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
 	return regmap_bulk_write(st->regmap, reg, custom->table, custom->size);
 }
 
-static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
-						struct ltc2983_data *st,
-						const struct device_node *np,
-						const char *propname,
-						const bool is_steinhart,
-						const u32 resolution,
-						const bool has_signed)
+static struct ltc2983_custom_sensor *
+__ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
+			    const char *propname, const bool is_steinhart,
+			    const u32 resolution, const bool has_signed)
 {
 	struct ltc2983_custom_sensor *new_custom;
-	u8 index, n_entries, tbl = 0;
 	struct device *dev = &st->spi->dev;
 	/*
 	 * For custom steinhart, the full u32 is taken. For all the others
 	 * the MSB is discarded.
 	 */
 	const u8 n_size = is_steinhart ? 4 : 3;
-	const u8 e_size = is_steinhart ? sizeof(u32) : sizeof(u64);
+	u8 index, n_entries;
+	int ret;
 
-	n_entries = of_property_count_elems_of_size(np, propname, e_size);
+	if (is_steinhart)
+		n_entries = fwnode_property_count_u32(fn, propname);
+	else
+		n_entries = fwnode_property_count_u64(fn, propname);
 	/* n_entries must be an even number */
 	if (!n_entries || (n_entries % 2) != 0) {
 		dev_err(dev, "Number of entries either 0 or not even\n");
@@ -415,29 +419,39 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 	}
 	/* Check space on the table. */
 	if (st->custom_table_size + new_custom->size >
-	    (LTC2983_CUST_SENS_TBL_END_REG -
-	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
+	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1) {
 		dev_err(dev, "No space left(%d) for new custom sensor(%zu)",
 				st->custom_table_size, new_custom->size);
 		return ERR_PTR(-EINVAL);
 	}
 
 	/* allocate the table */
-	new_custom->table = devm_kzalloc(dev, new_custom->size, GFP_KERNEL);
+	if (is_steinhart)
+		new_custom->table = devm_kcalloc(dev, n_entries, sizeof(u32), GFP_KERNEL);
+	else
+		new_custom->table = devm_kcalloc(dev, n_entries, sizeof(u64), GFP_KERNEL);
 	if (!new_custom->table)
 		return ERR_PTR(-ENOMEM);
 
-	for (index = 0; index < n_entries; index++) {
-		u64 temp = 0, j;
-		/*
-		 * Steinhart sensors are configured with raw values in the
-		 * devicetree. For the other sensors we must convert the
-		 * value to raw. The odd index's correspond to temperarures
-		 * and always have 1/1024 of resolution. Temperatures also
-		 * come in kelvin, so signed values is not possible
-		 */
-		if (!is_steinhart) {
-			of_property_read_u64_index(np, propname, index, &temp);
+	if (is_steinhart)
+		ret = fwnode_property_read_u32_array(fn, propname, new_custom->table, n_entries);
+	else
+		ret = fwnode_property_read_u64_array(fn, propname, new_custom->table, n_entries);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	/*
+	 * Steinhart sensors are configured with raw values in the device tree.
+	 * For the other sensors we must convert the value to raw. The odd
+	 * index's correspond to temperatures and always have 1/1024 of
+	 * resolution. Temperatures also come in Kelvin, so signed values is
+	 * not possible.
+	 */
+	if (is_steinhart) {
+		cpu_to_be32_array(new_custom->table, new_custom->table, n_entries);
+	} else {
+		for (index = 0; index < n_entries; index++) {
+			u64 temp = ((u64 *)new_custom->table)[index];
 
 			if ((index % 2) != 0)
 				temp = __convert_to_raw(temp, 1024);
@@ -445,16 +459,9 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 				temp = __convert_to_raw_sign(temp, resolution);
 			else
 				temp = __convert_to_raw(temp, resolution);
-		} else {
-			u32 t32;
 
-			of_property_read_u32_index(np, propname, index, &t32);
-			temp = t32;
+			put_unaligned_be24(temp, new_custom->table + index * 3);
 		}
-
-		for (j = 0; j < n_size; j++)
-			new_custom->table[tbl++] =
-				temp >> (8 * (n_size - j - 1));
 	}
 
 	new_custom->is_steinhart = is_steinhart;
@@ -597,13 +604,12 @@ static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
-static struct ltc2983_sensor *ltc2983_thermocouple_new(
-					const struct device_node *child,
-					struct ltc2983_data *st,
-					const struct ltc2983_sensor *sensor)
+static struct ltc2983_sensor *
+ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data *st,
+			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
-	struct device_node *phandle;
+	struct fwnode_handle *ref;
 	u32 oc_current;
 	int ret;
 
@@ -611,11 +617,10 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_bool(child, "adi,single-ended"))
+	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		thermo->sensor_config = LTC2983_THERMOCOUPLE_SGL(1);
 
-	ret = of_property_read_u32(child, "adi,sensor-oc-current-microamp",
-				   &oc_current);
+	ret = fwnode_property_read_u32(child, "adi,sensor-oc-current-microamp", &oc_current);
 	if (!ret) {
 		switch (oc_current) {
 		case 10:
@@ -651,19 +656,18 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 		return ERR_PTR(-EINVAL);
 	}
 
-	phandle = of_parse_phandle(child, "adi,cold-junction-handle", 0);
-	if (phandle) {
+	ref = fwnode_find_reference(child, "adi,cold-junction-handle", 0);
+	if (ref) {
 		int ret;
 
-		ret = of_property_read_u32(phandle, "reg",
-					   &thermo->cold_junction_chan);
+		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
 		if (ret) {
 			/*
 			 * This would be catched later but we can just return
 			 * the error right away.
 			 */
 			dev_err(&st->spi->dev, "Property reg must be given\n");
-			of_node_put(phandle);
+			fwnode_handle_put(ref);
 			return ERR_PTR(-EINVAL);
 		}
 	}
@@ -676,7 +680,7 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 							     propname, false,
 							     16384, true);
 		if (IS_ERR(thermo->custom)) {
-			of_node_put(phandle);
+			fwnode_handle_put(ref);
 			return ERR_CAST(thermo->custom);
 		}
 	}
@@ -685,37 +689,37 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 	thermo->sensor.fault_handler = ltc2983_thermocouple_fault_handler;
 	thermo->sensor.assign_chan = ltc2983_thermocouple_assign_chan;
 
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return &thermo->sensor;
 }
 
-static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
-					  struct ltc2983_data *st,
-					  const struct ltc2983_sensor *sensor)
+static struct ltc2983_sensor *
+ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
+		const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	struct device_node *phandle;
+	struct fwnode_handle *ref;
 	u32 excitation_current = 0, n_wires = 0;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
 		return ERR_PTR(-ENOMEM);
 
-	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
-	if (!phandle) {
+	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
+	if (!ref) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_property_read_u32(phandle, "reg", &rtd->r_sense_chan);
+	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
 	if (ret) {
 		dev_err(dev, "Property reg must be given\n");
 		goto fail;
 	}
 
-	ret = of_property_read_u32(child, "adi,number-of-wires", &n_wires);
+	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
 	if (!ret) {
 		switch (n_wires) {
 		case 2:
@@ -738,9 +742,9 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 		}
 	}
 
-	if (of_property_read_bool(child, "adi,rsense-share")) {
+	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
 		/* Current rotation is only available with rsense sharing */
-		if (of_property_read_bool(child, "adi,current-rotate")) {
+		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
 			if (n_wires == 2 || n_wires == 3) {
 				dev_err(dev,
 					"Rotation not allowed for 2/3 Wire RTDs");
@@ -803,7 +807,7 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 							  "adi,custom-rtd",
 							  false, 2048, false);
 		if (IS_ERR(rtd->custom)) {
-			of_node_put(phandle);
+			fwnode_handle_put(ref);
 			return ERR_CAST(rtd->custom);
 		}
 	}
@@ -812,8 +816,8 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 	rtd->sensor.fault_handler = ltc2983_common_fault_handler;
 	rtd->sensor.assign_chan = ltc2983_rtd_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+				       &excitation_current);
 	if (ret) {
 		/* default to 5uA */
 		rtd->excitation_current = 1;
@@ -852,23 +856,22 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 		}
 	}
 
-	of_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
+	fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
 
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return &rtd->sensor;
 fail:
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return ERR_PTR(ret);
 }
 
-static struct ltc2983_sensor *ltc2983_thermistor_new(
-					const struct device_node *child,
-					struct ltc2983_data *st,
-					const struct ltc2983_sensor *sensor)
+static struct ltc2983_sensor *
+ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *st,
+		       const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermistor *thermistor;
 	struct device *dev = &st->spi->dev;
-	struct device_node *phandle;
+	struct fwnode_handle *ref;
 	u32 excitation_current = 0;
 	int ret = 0;
 
@@ -876,23 +879,23 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 	if (!thermistor)
 		return ERR_PTR(-ENOMEM);
 
-	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
-	if (!phandle) {
+	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
+	if (!ref) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_property_read_u32(phandle, "reg", &thermistor->r_sense_chan);
+	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
 	if (ret) {
 		dev_err(dev, "rsense channel must be configured...\n");
 		goto fail;
 	}
 
-	if (of_property_read_bool(child, "adi,single-ended")) {
+	if (fwnode_property_read_bool(child, "adi,single-ended")) {
 		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
-	} else if (of_property_read_bool(child, "adi,rsense-share")) {
+	} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
 		/* rotation is only possible if sharing rsense */
-		if (of_property_read_bool(child, "adi,current-rotate"))
+		if (fwnode_property_read_bool(child, "adi,current-rotate"))
 			thermistor->sensor_config =
 						LTC2983_THERMISTOR_C_ROTATE(1);
 		else
@@ -926,7 +929,7 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 								 steinhart,
 								 64, false);
 		if (IS_ERR(thermistor->custom)) {
-			of_node_put(phandle);
+			fwnode_handle_put(ref);
 			return ERR_CAST(thermistor->custom);
 		}
 	}
@@ -934,8 +937,8 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
 	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-nanoamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
+				       &excitation_current);
 	if (ret) {
 		/* Auto range is not allowed for custom sensors */
 		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
@@ -999,17 +1002,16 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 		}
 	}
 
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return &thermistor->sensor;
 fail:
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return ERR_PTR(ret);
 }
 
-static struct ltc2983_sensor *ltc2983_diode_new(
-					const struct device_node *child,
-					const struct ltc2983_data *st,
-					const struct ltc2983_sensor *sensor)
+static struct ltc2983_sensor *
+ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
+		  const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_diode *diode;
 	u32 temp = 0, excitation_current = 0;
@@ -1019,13 +1021,13 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 	if (!diode)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_bool(child, "adi,single-ended"))
+	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		diode->sensor_config = LTC2983_DIODE_SGL(1);
 
-	if (of_property_read_bool(child, "adi,three-conversion-cycles"))
+	if (fwnode_property_read_bool(child, "adi,three-conversion-cycles"))
 		diode->sensor_config |= LTC2983_DIODE_3_CONV_CYCLE(1);
 
-	if (of_property_read_bool(child, "adi,average-on"))
+	if (fwnode_property_read_bool(child, "adi,average-on"))
 		diode->sensor_config |= LTC2983_DIODE_AVERAGE_ON(1);
 
 	/* validate channel index */
@@ -1040,8 +1042,8 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+				       &excitation_current);
 	if (!ret) {
 		switch (excitation_current) {
 		case 10:
@@ -1064,7 +1066,7 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 		}
 	}
 
-	of_property_read_u32(child, "adi,ideal-factor-value", &temp);
+	fwnode_property_read_u32(child, "adi,ideal-factor-value", &temp);
 
 	/* 2^20 resolution */
 	diode->ideal_factor_value = __convert_to_raw(temp, 1048576);
@@ -1072,7 +1074,7 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 	return &diode->sensor;
 }
 
-static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
+static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
@@ -1091,7 +1093,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
+	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
 	if (ret) {
 		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
 		return ERR_PTR(-EINVAL);
@@ -1110,7 +1112,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
 	return &rsense->sensor;
 }
 
-static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
+static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
@@ -1120,7 +1122,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_bool(child, "adi,single-ended"))
+	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
 	if (!adc->single_ended &&
@@ -1264,17 +1266,15 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
 
 static int ltc2983_parse_dt(struct ltc2983_data *st)
 {
-	struct device_node *child;
 	struct device *dev = &st->spi->dev;
+	struct fwnode_handle *child;
 	int ret = 0, chan = 0, channel_avail_mask = 0;
 
-	of_property_read_u32(dev->of_node, "adi,mux-delay-config-us",
-			     &st->mux_delay_config);
+	device_property_read_u32(dev, "adi,mux-delay-config-us", &st->mux_delay_config);
 
-	of_property_read_u32(dev->of_node, "adi,filter-notch-freq",
-			     &st->filter_notch_freq);
+	device_property_read_u32(dev, "adi,filter-notch-freq", &st->filter_notch_freq);
 
-	st->num_channels = of_get_available_child_count(dev->of_node);
+	st->num_channels = device_get_child_node_count(dev);
 	if (!st->num_channels) {
 		dev_err(&st->spi->dev, "At least one channel must be given!");
 		return -EINVAL;
@@ -1286,10 +1286,10 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		return -ENOMEM;
 
 	st->iio_channels = st->num_channels;
-	for_each_available_child_of_node(dev->of_node, child) {
+	device_for_each_child_node(dev, child) {
 		struct ltc2983_sensor sensor;
 
-		ret = of_property_read_u32(child, "reg", &sensor.chan);
+		ret = fwnode_property_read_u32(child, "reg", &sensor.chan);
 		if (ret) {
 			dev_err(dev, "reg property must given for child nodes\n");
 			goto put_child;
@@ -1308,8 +1308,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			goto put_child;
 		}
 
-		ret = of_property_read_u32(child, "adi,sensor-type",
-					       &sensor.type);
+		ret = fwnode_property_read_u32(child, "adi,sensor-type", &sensor.type);
 		if (ret) {
 			dev_err(dev,
 				"adi,sensor-type property must given for child nodes\n");
@@ -1363,7 +1362,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 
 	return 0;
 put_child:
-	of_node_put(child);
+	fwnode_handle_put(child);
 	return ret;
 }
 
-- 
2.34.1

