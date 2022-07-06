Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C35685E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiGFKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiGFKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:40:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62C275EC;
        Wed,  6 Jul 2022 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657104049; x=1688640049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+iBIedqH39T480rY7C6PPOxJpyMq3EdQ4Vl899KKv8=;
  b=JSn3jCHoRMg14lKpCJDKvnf6FFWPHQ1AALD6hG2qG2n/PlY6wj/HpUr7
   qXc9UBKiHEDuOvtqsM+JQbyAFxb2Ov7CYmRBDmIY6RGZBoRosliPu26lg
   bKr/C+xR6+9S6Dr1Rshu9JAuGu+G/ey1ps3XpxT9ztyJD93zHcXJPVLrj
   HdIDS/x0eW8ELOIEBGt7WkYNXUQIfG+e6dShrIvU14LloBWm9O38LIoyu
   TVOLO1LSI3p5dxxv5JBuY0rNLiS9VQ9GU4ffWzRVxUzm1s/15Hay9FrLC
   7+Bt/fzfdXjhoxSNWw/DJbuoj/ZgitOYqCpv21M7Ltuo/YRdsasThA7Uc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263495534"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="263495534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="597621229"
Received: from gklab-106a-125.igk.intel.com (HELO localhost) ([10.211.106.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 03:40:47 -0700
From:   "Kallas, Pawel" <pawel.kallas@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     iwona.winiarska@intel.com, pawel.kallas@intel.com
Subject: [PATCH 3/3] hwmon: (pmbus) add EIN and EOUT readings
Date:   Wed,  6 Jul 2022 12:40:24 +0200
Message-Id: <20220706104024.3118590-4-pawel.kallas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706104024.3118590-1-pawel.kallas@intel.com>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new sensor type to pmbus hwmon driver. The sensor reads EIN and
EOUT registers and calculates power based on energy reads. New hwmon
file names are power1_average for power from EIN and power2_average for
power from EOUT.
Perform automatic detection of support for EIN and EOUT in generic
pmbus device driver. Use QUERY pmbus command to check if EIN or
EOUT commands are supported and what format of data they use. Support
only direct format with coefficient m equal to 1. Other formats not
tested due to lack of devices supporting them.

Signed-off-by: Kallas, Pawel <pawel.kallas@intel.com>
---
 drivers/hwmon/pmbus/pmbus.c      |  20 +++
 drivers/hwmon/pmbus/pmbus.h      |   5 +
 drivers/hwmon/pmbus/pmbus_core.c | 203 ++++++++++++++++++++++++++++++-
 3 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index ce2f020f09d74..81292541969a7 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -30,6 +30,7 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 {
 	int page;
 	int fan_mode;
+	int rv;
 
 	/* Sensors detected on page 0 only */
 	if (pmbus_check_word_register(client, 0, PMBUS_READ_VIN))
@@ -74,6 +75,25 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 					 PMBUS_STATUS_TEMPERATURE))
 			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
 
+	rv = pmbus_query_register(client, PMBUS_READ_EIN);
+	/* only direct format for EIN and EOUT supported */
+	if (rv > 0 && (rv & PB_QUERY_COMMAND_SUPPORTED) &&
+	    (rv & PB_QUERY_COMMAND_SUPPORTED_FOR_READ) &&
+		((rv & PB_QUERY_COMMAND_MODE_MASK) == PB_QUERY_COMMAND_MODE_DIRECT)) {
+		info->func[0] |= PMBUS_HAVE_EIN;
+		info->format[PSC_POWER_AVERAGE] = direct;
+		info->m[PSC_POWER_AVERAGE] = 1;
+	}
+
+	rv = pmbus_query_register(client, PMBUS_READ_EOUT);
+	if (rv > 0 && (rv & PB_QUERY_COMMAND_SUPPORTED) &&
+	    (rv & PB_QUERY_COMMAND_SUPPORTED_FOR_READ) &&
+		((rv & PB_QUERY_COMMAND_MODE_MASK) == PB_QUERY_COMMAND_MODE_DIRECT)) {
+		info->func[0] |= PMBUS_HAVE_EOUT;
+		info->format[PSC_POWER_AVERAGE] = direct;
+		info->m[PSC_POWER_AVERAGE] = 1;
+	}
+
 	/* Sensors detected on all pages */
 	for (page = 0; page < info->pages; page++) {
 		if (pmbus_check_word_register(client, page, PMBUS_READ_VOUT)) {
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 971554f40dba6..eaf0478d6ec15 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -94,6 +94,8 @@ enum pmbus_regs {
 	PMBUS_STATUS_FAN_12		= 0x81,
 	PMBUS_STATUS_FAN_34		= 0x82,
 
+	PMBUS_READ_EIN			= 0x86,
+	PMBUS_READ_EOUT			= 0x87,
 	PMBUS_READ_VIN			= 0x88,
 	PMBUS_READ_IIN			= 0x89,
 	PMBUS_READ_VCAP			= 0x8A,
@@ -383,6 +385,7 @@ enum pmbus_sensor_classes {
 	PSC_CURRENT_IN,
 	PSC_CURRENT_OUT,
 	PSC_POWER,
+	PSC_POWER_AVERAGE,
 	PSC_TEMPERATURE,
 	PSC_FAN,
 	PSC_PWM,
@@ -416,6 +419,8 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_PWM12	BIT(20)
 #define PMBUS_HAVE_PWM34	BIT(21)
 #define PMBUS_HAVE_SAMPLES	BIT(22)
+#define PMBUS_HAVE_EIN		BIT(23)
+#define PMBUS_HAVE_EOUT		BIT(24)
 
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 6e3ec6a223b92..d6a6640a1779e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -44,6 +44,15 @@ struct pmbus_sensor {
 #define to_pmbus_sensor(_attr) \
 	container_of(_attr, struct pmbus_sensor, attribute)
 
+struct pmbus_power_average_sensor {
+	struct pmbus_sensor sensor;
+	u64 energy_count;
+	u32 sample_count;
+};
+
+#define to_pmbus_power_average_sensor(_attr) \
+	container_of(to_pmbus_sensor(_attr), struct pmbus_power_average_sensor, sensor)
+
 struct pmbus_boolean {
 	char name[PMBUS_NAME_SIZE];	/* sysfs boolean name */
 	struct sensor_device_attribute attribute;
@@ -702,7 +711,7 @@ static s64 pmbus_reg2data_linear(struct pmbus_data *data,
 		val = val * 1000LL;
 
 	/* scale result to micro-units for power sensors */
-	if (sensor->class == PSC_POWER)
+	if (sensor->class == PSC_POWER || sensor->class == PSC_POWER_AVERAGE)
 		val = val * 1000LL;
 
 	if (exponent >= 0)
@@ -739,7 +748,7 @@ static s64 pmbus_reg2data_direct(struct pmbus_data *data,
 	}
 
 	/* scale result to micro-units for power sensors */
-	if (sensor->class == PSC_POWER) {
+	if (sensor->class == PSC_POWER || sensor->class == PSC_POWER_AVERAGE) {
 		R += 3;
 		b *= 1000;
 	}
@@ -814,6 +823,21 @@ static s64 pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
 	return val;
 }
 
+static u64 pmbus_energy_count(struct pmbus_data *data,
+			      struct pmbus_power_average_sensor *sensor,
+			      u32 accumulator_current,
+			      u8 rollover)
+{
+	s64 val;
+	u64 accumulator_max;
+
+	sensor->sensor.data = accumulator_current;
+	val = pmbus_reg2data(data, &sensor->sensor);
+	sensor->sensor.data = 0x7FFF;
+	accumulator_max = (u64)pmbus_reg2data(data, &sensor->sensor);
+	return rollover * accumulator_max + val;
+}
+
 #define MAX_MANTISSA	(1023 * 1000)
 #define MIN_MANTISSA	(511 * 1000)
 
@@ -1056,6 +1080,54 @@ static ssize_t pmbus_show_sensor(struct device *dev,
 	return ret;
 }
 
+static ssize_t pmbus_show_power_average_sensor(struct device *dev,
+					       struct device_attribute *devattr, char *buf)
+{
+	struct pmbus_power_average_sensor *sensor = to_pmbus_power_average_sensor(devattr);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u64 last_energy_count = sensor->energy_count;
+	u32 last_sample_count = sensor->sample_count;
+	u8 buffer[I2C_SMBUS_BLOCK_MAX];
+	s16 accumulator_current;
+	u64 energy_count_diff;
+	u32 sample_count_diff;
+	ssize_t ret;
+
+	mutex_lock(&data->update_lock);
+	ret = pmbus_set_page(client, sensor->sensor.page, sensor->sensor.phase);
+	if (ret < 0)
+		goto unlock;
+
+	ret = i2c_smbus_read_i2c_block_data(client, sensor->sensor.reg, 8, buffer);
+	if (ret < 0)
+		goto unlock;
+
+	accumulator_current = buffer[1] + (buffer[2] << 8);
+	sensor->sample_count = buffer[4] + (buffer[5] << 8) + (buffer[6] << 16);
+	sensor->energy_count = pmbus_energy_count(data, sensor, accumulator_current, buffer[3]);
+
+	if (sensor->sample_count == last_sample_count) {
+		ret = -ENODATA;
+		goto unlock;
+	}
+	if (sensor->energy_count < last_energy_count)
+		energy_count_diff = sensor->energy_count +
+			(pmbus_energy_count(data, sensor, 0xFFFF, 0xFF) + 1) - last_energy_count;
+	else
+		energy_count_diff = sensor->energy_count - last_energy_count;
+
+	if (sensor->sample_count < last_sample_count)
+		sample_count_diff = sensor->sample_count + (0xFFFFFF + 1) - last_sample_count;
+	else
+		sample_count_diff = sensor->sample_count - last_sample_count;
+
+	ret = sysfs_emit(buf, "%llu\n", div_u64(energy_count_diff, sample_count_diff));
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
 static ssize_t pmbus_set_sensor(struct device *dev,
 				struct device_attribute *devattr,
 				const char *buf, size_t count)
@@ -1223,6 +1295,40 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 	return sensor;
 }
 
+static struct pmbus_power_average_sensor
+*pmbus_add_power_average_sensor(struct pmbus_data *data, const char *name, const char *type,
+				int seq, int page, int phase, int reg,
+				enum pmbus_sensor_classes class, bool update, bool readonly,
+				bool convert)
+{
+	struct pmbus_power_average_sensor *sensor;
+	struct device_attribute *a;
+
+	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return NULL;
+
+	pmbus_sensor_init(&sensor->sensor, name, type, seq, page, phase, reg, class, update,
+			  convert);
+
+	if (data->flags & PMBUS_WRITE_PROTECTED)
+		readonly = true;
+
+	a = &sensor->sensor.attribute;
+
+	pmbus_dev_attr_init(a, sensor->sensor.name,
+			    readonly ? 0444 : 0644,
+			    pmbus_show_power_average_sensor, NULL);
+
+	if (pmbus_add_attribute(data, &a->attr))
+		return NULL;
+
+	sensor->sensor.next = data->sensors;
+	data->sensors = &sensor->sensor;
+
+	return sensor;
+}
+
 static int pmbus_add_label(struct pmbus_data *data,
 			   const char *name, int seq,
 			   const char *lstring, int index, int phase)
@@ -1415,6 +1521,23 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 	return 0;
 }
 
+static int pmbus_add_power_average_sensor_attrs_one(struct i2c_client *client,
+						    struct pmbus_data *data,
+						    const struct pmbus_driver_info *info,
+						    const char *name, int index, int page,
+						    int phase,
+						    const struct pmbus_sensor_attr *attr,
+						    bool paged)
+{
+	struct pmbus_power_average_sensor *base;
+
+	base = pmbus_add_power_average_sensor(data, name, "average", index, page, phase,
+					      attr->reg, attr->class, true, true, true);
+	if (!base)
+		return -ENOMEM;
+	return 0;
+}
+
 static bool pmbus_sensor_is_paged(const struct pmbus_driver_info *info,
 				  const struct pmbus_sensor_attr *attr)
 {
@@ -1826,6 +1949,26 @@ static const struct pmbus_sensor_attr power_attributes[] = {
 	}
 };
 
+static const struct pmbus_sensor_attr power_average_attributes[] = {
+	{
+		.reg = PMBUS_READ_EIN,
+		.class = PSC_POWER_AVERAGE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.label = "ein",
+		.func = PMBUS_HAVE_EIN,
+	}, {
+		.reg = PMBUS_READ_EOUT,
+		.class = PSC_POWER_AVERAGE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.label = "eout",
+		.func = PMBUS_HAVE_EOUT,
+	}
+};
+
 /* Temperature atributes */
 
 static const struct pmbus_limit_attr temp_limit_attrs[] = {
@@ -2120,6 +2263,53 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 	return 0;
 }
 
+static int pmbus_add_power_average_sensor_attrs(struct i2c_client *client,
+						struct pmbus_data *data)
+{
+	const struct pmbus_sensor_attr *attrs = power_average_attributes;
+	const struct pmbus_driver_info *info = data->info;
+	int index = 1;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(power_average_attributes); i++) {
+		int page, pages;
+		bool paged = pmbus_sensor_is_paged(info, attrs);
+
+		pages = paged ? info->pages : 1;
+		for (page = 0; page < pages; page++) {
+			if (info->func[page] & attrs->func) {
+				ret = pmbus_add_power_average_sensor_attrs_one(client, data, info,
+									       "power", index,
+									       page, 0xff, attrs,
+									       paged);
+				if (ret)
+					return ret;
+				index++;
+			}
+			if (info->phases[page]) {
+				int phase;
+
+				for (phase = 0; phase < info->phases[page]; phase++) {
+					if (!(info->pfunc[phase] & attrs->func))
+						continue;
+					ret = pmbus_add_power_average_sensor_attrs_one(client,
+										       data, info,
+										       "power",
+										       index,
+										       page, phase,
+										       attrs,
+										       paged);
+					if (ret)
+						return ret;
+					index++;
+				}
+			}
+		}
+		attrs++;
+	}
+	return 0;
+}
+
 struct pmbus_samples_attr {
 	int reg;
 	char *name;
@@ -2266,6 +2456,11 @@ static int pmbus_find_attributes(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	/* Power average */
+	ret = pmbus_add_power_average_sensor_attrs(client, data);
+	if (ret)
+		return ret;
+
 	ret = pmbus_add_samples_attributes(client, data);
 	return ret;
 }
@@ -2305,6 +2500,10 @@ static const struct pmbus_class_attr_map class_attr_map[] = {
 		.class = PSC_TEMPERATURE,
 		.attr = temp_attributes,
 		.nattr = ARRAY_SIZE(temp_attributes),
+	}, {
+		.class = PSC_POWER_AVERAGE,
+		.attr = power_average_attributes,
+		.nattr = ARRAY_SIZE(power_average_attributes),
 	}
 };
 
