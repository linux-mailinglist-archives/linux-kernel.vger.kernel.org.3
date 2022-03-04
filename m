Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD24CDBAC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiCDSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbiCDSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:03:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC06C2E;
        Fri,  4 Mar 2022 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646416966; x=1677952966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9IAPkX30lPRt7xjn2zVoUeFmeKtRddFjq7cWnqBlTdA=;
  b=A+5ZXEbNek4Tg+whN8V49Vj7rlFqwJVVtJ/z5O+h/WzqXJwQxcpIhTwe
   U0Ka9OY4XwzfhzzStQH24zh0FUnTkFaYoSeaNVyeVKCPt27rm/EWCI3zU
   O/q1BfJmSDI0aGkNsau1ujLTVatZTy4mIvsiVAIbTZt5NGlx/6fo3jQ1Q
   UgCrpP6G4MVIp3d81UynQEkMHfQ613wlpw0DpFGhT2HGjF+/10Jzo4R59
   gAoFFZ4B6+HgdfC0zbcj9AA7uLjsxEJWEIkQrvuTlrdWEAvbHX0gWPGZN
   o/YzrMxla46raRGMklkZrYXuZ9W3JidbGqJWiP+ethiP5BdhfyaO1bmIm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="317259212"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="317259212"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="610017253"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2022 10:02:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63FEC14A; Fri,  4 Mar 2022 20:03:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device properties
Date:   Fri,  4 Mar 2022 20:02:57 +0200
Message-Id: <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

The conversion slightly changes the logic behind property reading for
the configuration values. Original code allocates just as much memory
as needed. Then for each separate 32- or 64-bit value it reads it from
the property and converts to a raw one which will be fed to the sensor.
In the new code we allocate the amount of memory needed to retrieve all
values at once from the property and then convert them as required.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Nuno Sá <nuno.sa@analog.com>
---
v4: added checks for error pointer (Nuno), added Tb tag (Nuno)
v3: no changes

 drivers/iio/temperature/ltc2983.c | 209 +++++++++++++++---------------
 1 file changed, 106 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 636bbc9011b9..6971e8828d44 100644
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
@@ -423,21 +427,33 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
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
+	/*
+	 * Steinhart sensors are configured with raw values in the firmware
+	 * node. For the other sensors we must convert the value to raw.
+	 * The odd index's correspond to temperatures and always have 1/1024
+	 * of resolution. Temperatures also come in Kelvin, so signed values
+	 * are not possible.
+	 */
+	if (is_steinhart) {
+		ret = fwnode_property_read_u32_array(fn, propname, new_custom->table, n_entries);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		cpu_to_be32_array(new_custom->table, new_custom->table, n_entries);
+	} else {
+		ret = fwnode_property_read_u64_array(fn, propname, new_custom->table, n_entries);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		for (index = 0; index < n_entries; index++) {
+			u64 temp = ((u64 *)new_custom->table)[index];
 
 			if ((index % 2) != 0)
 				temp = __convert_to_raw(temp, 1024);
@@ -445,16 +461,9 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
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
@@ -597,13 +606,12 @@ static int ltc2983_adc_assign_chan(struct ltc2983_data *st,
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
 
@@ -611,11 +619,10 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
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
@@ -651,10 +658,11 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 		return ERR_PTR(-EINVAL);
 	}
 
-	phandle = of_parse_phandle(child, "adi,cold-junction-handle", 0);
-	if (phandle) {
-		ret = of_property_read_u32(phandle, "reg",
-					   &thermo->cold_junction_chan);
+	ref = fwnode_find_reference(child, "adi,cold-junction-handle", 0);
+	if (IS_ERR_OR_NULL(ref)) {
+		ref = NULL;
+	} else {
+		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
 		if (ret) {
 			/*
 			 * This would be catched later but we can just return
@@ -682,41 +690,41 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 	thermo->sensor.fault_handler = ltc2983_thermocouple_fault_handler;
 	thermo->sensor.assign_chan = ltc2983_thermocouple_assign_chan;
 
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return &thermo->sensor;
 
 fail:
-	of_node_put(phandle);
+	fwnode_handle_put(ref);
 	return ERR_PTR(ret);
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
+	if (IS_ERR_OR_NULL(ref)) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_PTR(-EINVAL);
+		return ref ? ERR_CAST(ref) : ERR_PTR(-EINVAL);
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
@@ -739,9 +747,9 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
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
@@ -813,8 +821,8 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 	rtd->sensor.fault_handler = ltc2983_common_fault_handler;
 	rtd->sensor.assign_chan = ltc2983_rtd_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+				       &excitation_current);
 	if (ret) {
 		/* default to 5uA */
 		rtd->excitation_current = 1;
@@ -853,23 +861,22 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
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
 
@@ -877,23 +884,23 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 	if (!thermistor)
 		return ERR_PTR(-ENOMEM);
 
-	phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
-	if (!phandle) {
+	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
+	if (IS_ERR_OR_NULL(ref)) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_PTR(-EINVAL);
+		return ref ? ERR_CAST(ref) : ERR_PTR(-EINVAL);
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
@@ -935,8 +942,8 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
 	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-nanoamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
+				       &excitation_current);
 	if (ret) {
 		/* Auto range is not allowed for custom sensors */
 		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
@@ -1000,17 +1007,16 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
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
@@ -1020,13 +1026,13 @@ static struct ltc2983_sensor *ltc2983_diode_new(
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
@@ -1041,8 +1047,8 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
 
-	ret = of_property_read_u32(child, "adi,excitation-current-microamp",
-				   &excitation_current);
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+				       &excitation_current);
 	if (!ret) {
 		switch (excitation_current) {
 		case 10:
@@ -1065,7 +1071,7 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 		}
 	}
 
-	of_property_read_u32(child, "adi,ideal-factor-value", &temp);
+	fwnode_property_read_u32(child, "adi,ideal-factor-value", &temp);
 
 	/* 2^20 resolution */
 	diode->ideal_factor_value = __convert_to_raw(temp, 1048576);
@@ -1073,7 +1079,7 @@ static struct ltc2983_sensor *ltc2983_diode_new(
 	return &diode->sensor;
 }
 
-static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
+static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
@@ -1092,7 +1098,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
+	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
 	if (ret) {
 		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
 		return ERR_PTR(-EINVAL);
@@ -1111,7 +1117,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct device_node *child,
 	return &rsense->sensor;
 }
 
-static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
+static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
@@ -1121,7 +1127,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct device_node *child,
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_bool(child, "adi,single-ended"))
+	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
 	if (!adc->single_ended &&
@@ -1265,17 +1271,15 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
 
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
@@ -1287,10 +1291,10 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
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
@@ -1309,8 +1313,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			goto put_child;
 		}
 
-		ret = of_property_read_u32(child, "adi,sensor-type",
-					       &sensor.type);
+		ret = fwnode_property_read_u32(child, "adi,sensor-type", &sensor.type);
 		if (ret) {
 			dev_err(dev,
 				"adi,sensor-type property must given for child nodes\n");
@@ -1364,7 +1367,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 
 	return 0;
 put_child:
-	of_node_put(child);
+	fwnode_handle_put(child);
 	return ret;
 }
 
-- 
2.34.1

