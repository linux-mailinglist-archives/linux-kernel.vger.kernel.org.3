Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3503F597C19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiHRDNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiHRDM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:12:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB7A6C48
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:12:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so438998otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mlyPnb8fBKXPSWVVxdPX65ZayzbPSZfVxyieMRtfdGc=;
        b=JHrnKserPnx8W2EC/ReGpnOykPoAFEyAb9LuYuYHs94xXp3IpUXIi7Ta9KgUhSJYIq
         pHSaapLzz3MD6ZsYl2v84mt4rQ7ap1Z3EESiwt3axCXyrXCZ3wV1nl/LJQQ6YQlPG+nV
         axFaIa5w8gJdGkIyhVXxCSukTZF/JpvIZMscfFjaK+qgz2a2uq+uLGacfmtetJK93qTv
         oseXIKvo1o5OtJOg5fAAeM+zfYQ5GlRG7OfHQg/bqUBKBvsvSv3mQioZm+qG60DUhy1R
         ZTM0awZgSQm+kw1I6TCGaaTNgmcMDWKkdbjrmt6USVZIb9qZ5a2/k2ernlQ5O0i7YR7n
         tnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mlyPnb8fBKXPSWVVxdPX65ZayzbPSZfVxyieMRtfdGc=;
        b=ET5WwBYiI49l6DpUxD7Evt1rh2cDy8A/kFovjchOo1U30hAjmz8Ou6ZYRTsBmDuMCa
         5nGSCEPhweavUNwqe7JxciOpNb59cwrWJYiGg1+QWmDKgJBNwnQvvFwt4lFWuoSc0jsk
         HuTOwqtjjcQvnam7hT/IxzpLz25LlyIQLgbMCiWaHB1s5YLvNjTacX9aJbykd/GnX3QZ
         F2ahaqqwmvodqhCSL1Yg5Otk4QIe54uccTjYILNozsBtU9hPlE6gKLQkJj6PB/HEvbIO
         TxwylOhAikCbIUOv2GhQXb1NpTbYKEbaqqa0pekjvduZr3en6VzU4BULtbp+/wm/nv6x
         hOrA==
X-Gm-Message-State: ACgBeo0B3SgHisQVGV3c6pqONKEzAtlFmWagxhCYsrIzzfl/THJAmhYS
        HhIm0VU4n/My4YngNFw3R8SRLA==
X-Google-Smtp-Source: AA6agR67hH1krvQzSX57HiSrCu+3tnGEx1e0B5qebQPlb4pPa5+85T/gC8VMzOqEO1QFLkn6syTfjw==
X-Received: by 2002:a05:6830:3150:b0:638:afc3:8639 with SMTP id c16-20020a056830315000b00638afc38639mr446800ots.53.1660792369509;
        Wed, 17 Aug 2022 20:12:49 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b0011c25975c1dsm112382oao.25.2022.08.17.20.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:12:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/4] power: supply: Introduce Qualcomm PMIC GLINK power supply
Date:   Wed, 17 Aug 2022 20:15:12 -0700
Message-Id: <20220818031512.319310-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818031512.319310-1-bjorn.andersson@linaro.org>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK service, running on a coprocessor of modern Qualcomm
platforms, deals with battery charging and fuel gauging, as well as
reporting status of AC and wireless power supplies.

As this is just one of the functionalities provided by the PMIC GLINK
service, this power supply driver is implemented as an auxilirary bus
driver, spawned by the main "pmic glink" driver when the PMIC GLINK
service is detected.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/power/supply/Kconfig        |    9 +
 drivers/power/supply/Makefile       |    1 +
 drivers/power/supply/qcom_battmgr.c | 1422 +++++++++++++++++++++++++++
 3 files changed, 1432 insertions(+)
 create mode 100644 drivers/power/supply/qcom_battmgr.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1aa8323ad9f6..490386ae729f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -183,6 +183,15 @@ config BATTERY_PMU
 	  Say Y here to expose battery information on Apple machines
 	  through the generic battery class.
 
+config BATTERY_QCOM_BATTMGR
+	tristate "Qualcomm PMIC GLINK battery manager support"
+	depends on QCOM_PMIC_GLINK
+	select AUXILIARY_BUS
+	help
+	  Say Y here to enable the Qualcomm PMIC GLINK power supply driver,
+	  which is used on modern Qualcomm platforms to provide battery and
+	  power supply information.
+
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
 	depends on OLPC_EC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 7f02f36aea55..f93d777487f6 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
+obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
 obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
new file mode 100644
index 000000000000..935c3beb1d01
--- /dev/null
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -0,0 +1,1422 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/power_supply.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+#include <linux/math.h>
+#include <linux/units.h>
+
+#define BATTMGR_CHEMISTRY_LEN	4
+#define BATTMGR_STRING_LEN	128
+
+enum qcom_battmgr_variant {
+	QCOM_BATTMGR_SM8350,
+	QCOM_BATTMGR_SC8280XP,
+};
+
+#define BATTMGR_BAT_STATUS		0x1
+
+#define BATTMGR_REQUEST_NOTIFICATION	0x4
+
+#define BATTMGR_NOTIFICATION		0x7
+#define NOTIF_BAT_PROPERTY		0x30
+#define NOTIF_USB_PROPERTY		0x32
+#define NOTIF_WLS_PROPERTY		0x34
+#define NOTIF_BAT_INFO			0x80
+
+#define BATTMGR_BAT_INFO		0x9
+
+#define BATTMGR_BAT_DISCHARGE_TIME	0xc
+
+#define BATTMGR_BAT_CHARGE_TIME		0xd
+
+#define BATTMGR_BAT_PROPERTY_GET	0x30
+#define BATTMGR_BAT_PROPERTY_SET	0x31
+#define BATT_STATUS			0
+#define BATT_HEALTH			1
+#define BATT_PRESENT			2
+#define BATT_CHG_TYPE			3
+#define BATT_CAPACITY			4
+#define BATT_SOH			5
+#define BATT_VOLT_OCV			6
+#define BATT_VOLT_NOW			7
+#define BATT_VOLT_MAX			8
+#define BATT_CURR_NOW			9
+#define BATT_CHG_CTRL_LIM		10
+#define BATT_CHG_CTRL_LIM_MAX		11
+#define BATT_TEMP			12
+#define BATT_TECHNOLOGY			13
+#define BATT_CHG_COUNTER		14
+#define BATT_CYCLE_COUNT		15
+#define BATT_CHG_FULL_DESIGN		16
+#define BATT_CHG_FULL			17
+#define BATT_MODEL_NAME			18
+#define BATT_TTF_AVG			19
+#define BATT_TTE_AVG			20
+#define BATT_RESISTANCE			21
+#define BATT_POWER_NOW			22
+#define BATT_POWER_AVG			23
+
+#define BATTMGR_USB_PROPERTY_GET	0x32
+#define BATTMGR_USB_PROPERTY_SET	0x33
+#define USB_ONLINE			0
+#define USB_VOLT_NOW			1
+#define USB_VOLT_MAX			2
+#define USB_CURR_NOW			3
+#define USB_CURR_MAX			4
+#define USB_INPUT_CURR_LIMIT		5
+#define USB_TYPE			6
+#define USB_ADAP_TYPE			7
+#define USB_MOISTURE_DET_EN		8
+#define USB_MOISTURE_DET_STS		9
+
+#define BATTMGR_WLS_PROPERTY_GET	0x34
+#define BATTMGR_WLS_PROPERTY_SET	0x35
+#define WLS_ONLINE			0
+#define WLS_VOLT_NOW			1
+#define WLS_VOLT_MAX			2
+#define WLS_CURR_NOW			3
+#define WLS_CURR_MAX			4
+#define WLS_TYPE			5
+#define WLS_BOOST_EN			6
+
+struct qcom_battmgr_enable_request {
+	struct pmic_glink_hdr hdr;
+	__le32 battery_id;
+	__le32 power_state;
+	__le32 low_capacity;
+	__le32 high_capacity;
+};
+
+struct qcom_battmgr_property_request {
+	struct pmic_glink_hdr hdr;
+	__le32 battery;
+	__le32 property;
+	__le32 value;
+};
+
+struct qcom_battmgr_update_request {
+	struct pmic_glink_hdr hdr;
+	u32 battery_id;
+};
+
+struct qcom_battmgr_charge_time_request {
+	struct pmic_glink_hdr hdr;
+	__le32 battery_id;
+	__le32 percent;
+	__le32 reserved;
+};
+
+struct qcom_battmgr_discharge_time_request {
+	struct pmic_glink_hdr hdr;
+	__le32 battery_id;
+	__le32 rate; /* 0 for current rate */
+	__le32 reserved;
+};
+
+struct qcom_battmgr_message {
+	struct pmic_glink_hdr hdr;
+	union {
+		struct {
+			__le32 property;
+			__le32 value;
+			__le32 result;
+		} intval;
+		struct {
+			__le32 property;
+			char model[BATTMGR_STRING_LEN];
+		} strval;
+		struct {
+			/*
+			 * 0: mWh
+			 * 1: mAh
+			 */
+			__le32 power_unit;
+			__le32 design_capacity;
+			__le32 last_full_capacity;
+			/*
+			 * 0 nonrechargable
+			 * 1 rechargable
+			 */
+			__le32 battery_tech;
+			__le32 design_voltage; /* mV */
+			__le32 capacity_low;
+			__le32 capacity_warning;
+			__le32 cycle_count;
+			/* thousandth of persent */
+			__le32 accuracy;
+			__le32 max_sample_time_ms;
+			__le32 min_sample_time_ms;
+			__le32 max_average_interval_ms;
+			__le32 min_average_interval_ms;
+			/* granularity between low and warning */
+			__le32 capacity_granularity1;
+			/* granularity between warning and full */
+			__le32 capacity_granularity2;
+			/*
+			 * 0: no
+			 * 1: cold
+			 * 2: hot
+			 */
+			__le32 swappable;
+			__le32 capabilities;
+			char model_number[BATTMGR_STRING_LEN];
+			char serial_number[BATTMGR_STRING_LEN];
+			char battery_type[BATTMGR_STRING_LEN];
+			char oem_info[BATTMGR_STRING_LEN];
+			char battery_chemistry[BATTMGR_CHEMISTRY_LEN];
+			char uid[BATTMGR_STRING_LEN];
+			__le32 critical_bias;
+			u8 day;
+			u8 month;
+			__le16 year;
+			__le32 battery_id;
+		} info;
+		struct {
+			/*
+			 * BIT(0) discharging
+			 * BIT(1) charging
+			 * BIT(2) critical low
+			 */
+			__le32 battery_state;
+			/* mWh or mAh, based on info->power_unit */
+			__le32 capacity;
+			__le32 rate;
+			/* mv */
+			__le32 battery_voltage;
+			/*
+			 * BIT(0) power online
+			 * BIT(1) discharging
+			 * BIT(2) charging
+			 * BIT(3) battery critical
+			 */
+			__le32 power_state;
+			/*
+			 * 1: AC
+			 * 2: USB
+			 * 3: Wireless
+			 */
+			__le32 charging_source;
+			__le32 temperature;
+		} status;
+		__le32 time;
+		__le32 notification;
+	};
+};
+
+#define BATTMGR_CHARGING_SOURCE_AC	1
+#define BATTMGR_CHARGING_SOURCE_USB	2
+#define BATTMGR_CHARGING_SOURCE_WIRELESS 3
+
+enum qcom_battmgr_unit {
+	QCOM_BATTMGR_UNIT_mWh = 0,
+	QCOM_BATTMGR_UNIT_mAh = 1
+};
+
+struct qcom_battmgr_info {
+	bool valid;
+
+	bool present;
+	unsigned int charge_type;
+	unsigned int design_capacity;
+	unsigned int last_full_capacity;
+	unsigned int voltage_max_design;
+	unsigned int voltage_max;
+	unsigned int capacity_low;
+	unsigned int capacity_warning;
+	unsigned int cycle_count;
+	unsigned int charge_count;
+	char model_number[BATTMGR_STRING_LEN];
+	char serial_number[BATTMGR_STRING_LEN];
+	char oem_info[BATTMGR_STRING_LEN];
+	unsigned char technology;
+	unsigned char day;
+	unsigned char month;
+	unsigned short year;
+};
+
+struct qcom_battmgr_status {
+	unsigned int status;
+	unsigned int health;
+	unsigned int capacity;
+	unsigned int percent;
+	int current_now;
+	int power_now;
+	unsigned int voltage_now;
+	unsigned int voltage_ocv;
+	unsigned int temperature;
+
+	unsigned int discharge_time;
+	unsigned int charge_time;
+};
+
+struct qcom_battmgr_ac {
+	bool online;
+};
+
+struct qcom_battmgr_usb {
+	bool online;
+	unsigned int voltage_now;
+	unsigned int voltage_max;
+	unsigned int current_now;
+	unsigned int current_max;
+	unsigned int current_limit;
+	unsigned int usb_type;
+};
+
+struct qcom_battmgr_wireless {
+	bool online;
+	unsigned int voltage_now;
+	unsigned int voltage_max;
+	unsigned int current_now;
+	unsigned int current_max;
+};
+
+struct qcom_battmgr {
+	struct device *dev;
+	struct pmic_glink_client *client;
+
+	enum qcom_battmgr_variant variant;
+
+	struct power_supply *ac_psy;
+	struct power_supply *bat_psy;
+	struct power_supply *usb_psy;
+	struct power_supply *wls_psy;
+
+	enum qcom_battmgr_unit unit;
+
+	int error;
+	struct completion ack;
+
+	bool service_up;
+
+	struct qcom_battmgr_info info;
+	struct qcom_battmgr_status status;
+	struct qcom_battmgr_ac ac;
+	struct qcom_battmgr_usb usb;
+	struct qcom_battmgr_wireless wireless;
+
+	struct work_struct enable_work;
+
+	/*
+	 * @lock is used to prevent concurrent power supply requests to the
+	 * firmware, as it then stops responding.
+	 */
+	struct mutex lock;
+};
+
+static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t len)
+{
+	unsigned long left;
+	int ret;
+
+	reinit_completion(&battmgr->ack);
+
+	battmgr->error = 0;
+
+	ret = pmic_glink_send(battmgr->client, data, len);
+	if (ret < 0)
+		return ret;
+
+	left = wait_for_completion_timeout(&battmgr->ack, HZ);
+	if (!left)
+		return -ETIMEDOUT;
+
+	return battmgr->error;
+}
+
+static int qcom_battmgr_request_property(struct qcom_battmgr *battmgr, int opcode,
+					 int property, u32 value)
+{
+	struct qcom_battmgr_property_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(opcode),
+		.battery = cpu_to_le32(0),
+		.property = cpu_to_le32(property),
+		.value = cpu_to_le32(value),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static int qcom_battmgr_update_status(struct qcom_battmgr *battmgr)
+{
+	struct qcom_battmgr_update_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(BATTMGR_BAT_STATUS),
+		.battery_id = cpu_to_le32(0),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static int qcom_battmgr_update_info(struct qcom_battmgr *battmgr)
+{
+	struct qcom_battmgr_update_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(BATTMGR_BAT_INFO),
+		.battery_id = cpu_to_le32(0),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static int qcom_battmgr_update_charge_time(struct qcom_battmgr *battmgr)
+{
+	struct qcom_battmgr_charge_time_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(BATTMGR_BAT_CHARGE_TIME),
+		.battery_id = cpu_to_le32(0),
+		.percent = cpu_to_le32(100),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static int qcom_battmgr_update_discharge_time(struct qcom_battmgr *battmgr)
+{
+	struct qcom_battmgr_discharge_time_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(BATTMGR_BAT_DISCHARGE_TIME),
+		.battery_id = cpu_to_le32(0),
+		.rate = cpu_to_le32(0),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static const u8 sm8350_bat_prop_map[] = {
+	[POWER_SUPPLY_PROP_STATUS] = BATT_STATUS,
+	[POWER_SUPPLY_PROP_HEALTH] = BATT_HEALTH,
+	[POWER_SUPPLY_PROP_PRESENT] = BATT_PRESENT,
+	[POWER_SUPPLY_PROP_CHARGE_TYPE] = BATT_CHG_TYPE,
+	[POWER_SUPPLY_PROP_CAPACITY] = BATT_CAPACITY,
+	[POWER_SUPPLY_PROP_VOLTAGE_OCV] = BATT_VOLT_OCV,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = BATT_VOLT_NOW,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = BATT_VOLT_MAX,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = BATT_CURR_NOW,
+	[POWER_SUPPLY_PROP_TEMP] = BATT_TEMP,
+	[POWER_SUPPLY_PROP_TECHNOLOGY] = BATT_TECHNOLOGY,
+	[POWER_SUPPLY_PROP_CHARGE_COUNTER] =  BATT_CHG_COUNTER,
+	[POWER_SUPPLY_PROP_CYCLE_COUNT] = BATT_CYCLE_COUNT,
+	[POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN] =  BATT_CHG_FULL_DESIGN,
+	[POWER_SUPPLY_PROP_CHARGE_FULL] = BATT_CHG_FULL,
+	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME,
+	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
+	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
+	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
+};
+
+static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
+					  enum power_supply_property psp)
+{
+	unsigned int prop;
+	int ret;
+
+	if (psp >= ARRAY_SIZE(sm8350_bat_prop_map))
+		return -EINVAL;
+
+	prop = sm8350_bat_prop_map[psp];
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET, prop, 0);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
+static int qcom_battmgr_bat_sc8280xp_update(struct qcom_battmgr *battmgr,
+					    enum power_supply_property psp)
+{
+	int ret;
+
+	mutex_lock(&battmgr->lock);
+
+	if (!battmgr->info.valid) {
+		ret = qcom_battmgr_update_info(battmgr);
+		if (ret < 0)
+			goto out_unlock;
+		battmgr->info.valid = true;
+	}
+
+	ret = qcom_battmgr_update_status(battmgr);
+	if (ret < 0)
+		goto out_unlock;
+
+	if (psp == POWER_SUPPLY_PROP_TIME_TO_FULL_AVG) {
+		ret = qcom_battmgr_update_charge_time(battmgr);
+		if (ret < 0) {
+			ret = -ENODATA;
+			goto out_unlock;
+		}
+	}
+
+	if (psp == POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG) {
+		ret = qcom_battmgr_update_discharge_time(battmgr);
+		if (ret < 0) {
+			ret = -ENODATA;
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&battmgr->lock);
+	return ret;
+}
+
+static int qcom_battmgr_bat_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	enum qcom_battmgr_unit unit = battmgr->unit;
+	int ret;
+
+	if (!battmgr->service_up)
+		return -ENODEV;
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
+	else
+		ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = battmgr->status.status;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		val->intval = battmgr->info.charge_type;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = battmgr->status.health;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = battmgr->info.present;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = battmgr->info.technology;
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		val->intval = battmgr->info.cycle_count;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = battmgr->info.voltage_max_design;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = battmgr->info.voltage_max;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battmgr->status.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = battmgr->status.voltage_ocv;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battmgr->status.current_now;
+		break;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		val->intval = battmgr->status.power_now;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		if (unit != QCOM_BATTMGR_UNIT_mAh)
+			return -ENODATA;
+		val->intval = battmgr->info.design_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		if (unit != QCOM_BATTMGR_UNIT_mAh)
+			return -ENODATA;
+		val->intval = battmgr->info.last_full_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
+		if (unit != QCOM_BATTMGR_UNIT_mAh)
+			return -ENODATA;
+		val->intval = battmgr->info.capacity_low;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		if (unit != QCOM_BATTMGR_UNIT_mAh)
+			return -ENODATA;
+		val->intval = battmgr->status.capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		val->intval = battmgr->info.charge_count;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		if (unit != QCOM_BATTMGR_UNIT_mWh)
+			return -ENODATA;
+		val->intval = battmgr->info.design_capacity;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+		if (unit != QCOM_BATTMGR_UNIT_mWh)
+			return -ENODATA;
+		val->intval = battmgr->info.last_full_capacity;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_EMPTY:
+		if (unit != QCOM_BATTMGR_UNIT_mWh)
+			return -ENODATA;
+		val->intval = battmgr->info.capacity_low;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		if (unit != QCOM_BATTMGR_UNIT_mWh)
+			return -ENODATA;
+		val->intval = battmgr->status.capacity;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = battmgr->status.percent;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = battmgr->status.temperature;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+		val->intval = battmgr->status.discharge_time;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		val->intval = battmgr->status.charge_time;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = battmgr->info.year;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
+		val->intval = battmgr->info.month;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
+		val->intval = battmgr->info.day;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = battmgr->info.model_number;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = battmgr->info.oem_info;
+		break;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = battmgr->info.serial_number;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property sc8280xp_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_EMPTY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_EMPTY,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
+	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc sc8280xp_bat_psy_desc = {
+	.name = "qcom-battmgr-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sc8280xp_bat_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_bat_props),
+	.get_property = qcom_battmgr_bat_get_property,
+};
+
+static const enum power_supply_property sm8350_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+};
+
+static const struct power_supply_desc sm8350_bat_psy_desc = {
+	.name = "qcom-battmgr-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sm8350_bat_props,
+	.num_properties = ARRAY_SIZE(sm8350_bat_props),
+	.get_property = qcom_battmgr_bat_get_property,
+};
+
+static int qcom_battmgr_ac_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -ENODEV;
+
+	ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = battmgr->ac.online;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property sc8280xp_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc sc8280xp_ac_psy_desc = {
+	.name = "qcom-battmgr-ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = sc8280xp_ac_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_ac_props),
+	.get_property = qcom_battmgr_ac_get_property,
+};
+
+static const u8 sm8350_usb_prop_map[] = {
+	[POWER_SUPPLY_PROP_ONLINE] = USB_ONLINE,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = USB_VOLT_NOW,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = USB_VOLT_MAX,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = USB_CURR_NOW,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = USB_CURR_MAX,
+	[POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT] = USB_INPUT_CURR_LIMIT,
+	[POWER_SUPPLY_PROP_USB_TYPE] = USB_TYPE,
+};
+
+static int qcom_battmgr_usb_sm8350_update(struct qcom_battmgr *battmgr,
+					  enum power_supply_property psp)
+{
+	unsigned int prop;
+	int ret;
+
+	if (psp >= ARRAY_SIZE(sm8350_usb_prop_map))
+		return -EINVAL;
+
+	prop = sm8350_usb_prop_map[psp];
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_GET, prop, 0);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
+static int qcom_battmgr_usb_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -ENODEV;
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
+	else
+		ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = battmgr->usb.online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battmgr->usb.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = battmgr->usb.voltage_max;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battmgr->usb.current_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = battmgr->usb.current_max;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = battmgr->usb.current_limit;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = battmgr->usb.usb_type;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_usb_type usb_psy_supported_types[] = {
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_ACA,
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+	POWER_SUPPLY_USB_TYPE_PD_DRP,
+	POWER_SUPPLY_USB_TYPE_PD_PPS,
+	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,
+};
+
+static const enum power_supply_property sc8280xp_usb_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc sc8280xp_usb_psy_desc = {
+	.name = "qcom-battmgr-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = sc8280xp_usb_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_usb_props),
+	.get_property = qcom_battmgr_usb_get_property,
+	.usb_types = usb_psy_supported_types,
+	.num_usb_types = ARRAY_SIZE(usb_psy_supported_types),
+};
+
+static const enum power_supply_property sm8350_usb_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static const struct power_supply_desc sm8350_usb_psy_desc = {
+	.name = "qcom-battmgr-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = sm8350_usb_props,
+	.num_properties = ARRAY_SIZE(sm8350_usb_props),
+	.get_property = qcom_battmgr_usb_get_property,
+	.usb_types = usb_psy_supported_types,
+	.num_usb_types = ARRAY_SIZE(usb_psy_supported_types),
+};
+
+static const u8 sm8350_wls_prop_map[] = {
+	[POWER_SUPPLY_PROP_ONLINE] = WLS_ONLINE,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = WLS_VOLT_NOW,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = WLS_VOLT_MAX,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = WLS_CURR_NOW,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = WLS_CURR_MAX,
+};
+
+static int qcom_battmgr_wls_sm8350_update(struct qcom_battmgr *battmgr,
+					  enum power_supply_property psp)
+{
+	unsigned int prop;
+	int ret;
+
+	if (psp >= ARRAY_SIZE(sm8350_wls_prop_map))
+		return -EINVAL;
+
+	prop = sm8350_wls_prop_map[psp];
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_WLS_PROPERTY_GET, prop, 0);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
+static int qcom_battmgr_wls_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (!battmgr->service_up)
+		return -ENODEV;
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
+	else
+		ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
+	if (ret < 0)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = battmgr->wireless.online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = battmgr->wireless.voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = battmgr->wireless.voltage_max;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = battmgr->wireless.current_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = battmgr->wireless.current_max;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property sc8280xp_wls_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc sc8280xp_wls_psy_desc = {
+	.name = "qcom-battmgr-wls",
+	.type = POWER_SUPPLY_TYPE_WIRELESS,
+	.properties = sc8280xp_wls_props,
+	.num_properties = ARRAY_SIZE(sc8280xp_wls_props),
+	.get_property = qcom_battmgr_wls_get_property,
+};
+
+static const enum power_supply_property sm8350_wls_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+};
+
+static const struct power_supply_desc sm8350_wls_psy_desc = {
+	.name = "qcom-battmgr-wls",
+	.type = POWER_SUPPLY_TYPE_WIRELESS,
+	.properties = sm8350_wls_props,
+	.num_properties = ARRAY_SIZE(sm8350_wls_props),
+	.get_property = qcom_battmgr_wls_get_property,
+};
+
+static void qcom_battmgr_notification(struct qcom_battmgr *battmgr,
+				      const struct qcom_battmgr_message *msg,
+				      int len)
+{
+	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
+	unsigned int notification;
+
+	if (payload_len != sizeof(msg->notification)) {
+		dev_warn(battmgr->dev, "ignoring notification with invalid length\n");
+		return;
+	}
+
+	notification = le32_to_cpu(msg->notification);
+	switch (notification) {
+	case NOTIF_BAT_INFO:
+		battmgr->info.valid = false;
+		fallthrough;
+	case NOTIF_BAT_PROPERTY:
+		power_supply_changed(battmgr->bat_psy);
+		break;
+	case NOTIF_USB_PROPERTY:
+		power_supply_changed(battmgr->usb_psy);
+		break;
+	case NOTIF_WLS_PROPERTY:
+		power_supply_changed(battmgr->wls_psy);
+		break;
+	default:
+		dev_err(battmgr->dev, "unknown notification: %#x\n", notification);
+		break;
+	}
+}
+
+static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
+{
+	size_t len = src[0];
+
+	/* Some firmware versions return Pascal-style strings */
+	if (len < BATTMGR_STRING_LEN && len == strnlen(src + 1, BATTMGR_STRING_LEN - 1)) {
+		memcpy(dest, src + 1, len);
+		dest[len] = '\0';
+	} else {
+		memcpy(dest, src, BATTMGR_STRING_LEN);
+	}
+}
+
+static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
+{
+	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
+		return POWER_SUPPLY_TECHNOLOGY_LION;
+
+	pr_err("Unknown battery technology '%s'\n", chemistry);
+	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+}
+
+static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
+{
+	return DIV_ROUND_CLOSEST(temperature, 10);
+}
+
+static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
+					   const struct qcom_battmgr_message *resp,
+					   size_t len)
+{
+	unsigned int opcode = le32_to_cpu(resp->hdr.opcode);
+	unsigned int source;
+	unsigned int state;
+	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
+
+	if (payload_len < sizeof(__le32)) {
+		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
+			 opcode, len);
+		return;
+	}
+
+	switch (opcode) {
+	case BATTMGR_REQUEST_NOTIFICATION:
+		battmgr->error = 0;
+		break;
+	case BATTMGR_BAT_INFO:
+		if (payload_len != sizeof(resp->info)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for battery information request: %zd\n",
+				 payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		battmgr->unit = le32_to_cpu(resp->info.power_unit);
+
+		battmgr->info.design_capacity = le32_to_cpu(resp->info.design_capacity) * 1000;
+		battmgr->info.last_full_capacity = le32_to_cpu(resp->info.last_full_capacity) * 1000;
+		battmgr->info.voltage_max_design = le32_to_cpu(resp->info.design_voltage) * 1000;
+		battmgr->info.capacity_low = le32_to_cpu(resp->info.capacity_low) * 1000;
+		battmgr->info.cycle_count = le32_to_cpu(resp->info.cycle_count);
+		qcom_battmgr_sc8280xp_strcpy(battmgr->info.model_number, resp->info.model_number);
+		qcom_battmgr_sc8280xp_strcpy(battmgr->info.serial_number, resp->info.serial_number);
+		battmgr->info.technology = qcom_battmgr_sc8280xp_parse_technology(resp->info.battery_chemistry);
+		qcom_battmgr_sc8280xp_strcpy(battmgr->info.oem_info, resp->info.oem_info);
+		battmgr->info.day = resp->info.day;
+		battmgr->info.month = resp->info.month;
+		battmgr->info.year = le16_to_cpu(resp->info.year);
+		break;
+	case BATTMGR_BAT_STATUS:
+		if (payload_len != sizeof(resp->status)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for battery status request: %zd\n",
+				 payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		state = le32_to_cpu(resp->status.battery_state);
+		if (state & BIT(0))
+			battmgr->status.status = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (state & BIT(1))
+			battmgr->status.status = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			battmgr->status.status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		battmgr->status.capacity = le32_to_cpu(resp->status.capacity) * 1000;
+		battmgr->status.power_now = le32_to_cpu(resp->status.rate) * 1000;
+		battmgr->status.voltage_now = le32_to_cpu(resp->status.battery_voltage) * 1000;
+		battmgr->status.temperature = qcom_battmgr_sc8280xp_convert_temp(le32_to_cpu(resp->status.temperature));
+
+		source = le32_to_cpu(resp->status.charging_source);
+		battmgr->ac.online = source == BATTMGR_CHARGING_SOURCE_AC;
+		battmgr->usb.online = source == BATTMGR_CHARGING_SOURCE_USB;
+		battmgr->wireless.online = source == BATTMGR_CHARGING_SOURCE_WIRELESS;
+		break;
+	case BATTMGR_BAT_DISCHARGE_TIME:
+		battmgr->status.discharge_time = le32_to_cpu(resp->time);
+		break;
+	case BATTMGR_BAT_CHARGE_TIME:
+		battmgr->status.charge_time = le32_to_cpu(resp->time);
+		break;
+	default:
+		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
+		break;
+	}
+
+	complete(&battmgr->ack);
+}
+
+static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
+					 const struct qcom_battmgr_message *resp,
+					 size_t len)
+{
+	unsigned int property;
+	unsigned int opcode = le32_to_cpu(resp->hdr.opcode);
+	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
+	unsigned int val;
+
+	if (payload_len < sizeof(__le32)) {
+		dev_warn(battmgr->dev, "invalid payload length for %#x: %zd\n",
+			 opcode, len);
+		return;
+	}
+
+	switch (opcode) {
+	case BATTMGR_BAT_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (property == BATT_MODEL_NAME) {
+			if (payload_len != sizeof(resp->strval)) {
+				dev_warn(battmgr->dev,
+					 "invalid payload length for BATT_MODEL_NAME request: %zd\n",
+					 payload_len);
+				battmgr->error = -ENODATA;
+				return;
+			}
+		} else {
+			if (payload_len != sizeof(resp->intval)) {
+				dev_warn(battmgr->dev,
+					 "invalid payload length for %#x request: %zd\n",
+					 property, payload_len);
+				battmgr->error = -ENODATA;
+				return;
+			}
+
+			battmgr->error = le32_to_cpu(resp->intval.result);
+			if (battmgr->error)
+				goto out_complete;
+		}
+
+		switch (property) {
+		case BATT_STATUS:
+			battmgr->status.status = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_HEALTH:
+			battmgr->status.health = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_PRESENT:
+			battmgr->info.present = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_TYPE:
+			battmgr->info.charge_type = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CAPACITY:
+			battmgr->status.percent = le32_to_cpu(resp->intval.value);
+			do_div(battmgr->status.percent, 100);
+			break;
+		case BATT_VOLT_OCV:
+			battmgr->status.voltage_ocv = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_VOLT_NOW:
+			battmgr->status.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_VOLT_MAX:
+			battmgr->info.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CURR_NOW:
+			battmgr->status.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_TEMP:
+			val = le32_to_cpu(resp->intval.value);
+			battmgr->status.temperature = DIV_ROUND_CLOSEST(val, 10);
+			break;
+		case BATT_TECHNOLOGY:
+			battmgr->info.technology = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_COUNTER:
+			battmgr->info.charge_count = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CYCLE_COUNT:
+			battmgr->info.cycle_count = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_FULL_DESIGN:
+			battmgr->info.design_capacity = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_FULL:
+			battmgr->info.last_full_capacity = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_MODEL_NAME:
+			strscpy(battmgr->info.model_number, resp->strval.model, BATTMGR_STRING_LEN);
+			break;
+		case BATT_TTF_AVG:
+			battmgr->status.charge_time = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_TTE_AVG:
+			battmgr->status.discharge_time = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_POWER_NOW:
+			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
+	case BATTMGR_USB_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		battmgr->error = le32_to_cpu(resp->intval.result);
+		if (battmgr->error)
+			goto out_complete;
+
+		switch (property) {
+		case USB_ONLINE:
+			battmgr->usb.online = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_NOW:
+			battmgr->usb.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_VOLT_MAX:
+			battmgr->usb.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_NOW:
+			battmgr->usb.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_CURR_MAX:
+			battmgr->usb.current_max = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_INPUT_CURR_LIMIT:
+			battmgr->usb.current_limit = le32_to_cpu(resp->intval.value);
+			break;
+		case USB_TYPE:
+			battmgr->usb.usb_type = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
+	case BATTMGR_WLS_PROPERTY_GET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		battmgr->error = le32_to_cpu(resp->intval.result);
+		if (battmgr->error)
+			goto out_complete;
+
+		switch (property) {
+		case WLS_ONLINE:
+			battmgr->wireless.online = le32_to_cpu(resp->intval.value);
+			break;
+		case WLS_VOLT_NOW:
+			battmgr->wireless.voltage_now = le32_to_cpu(resp->intval.value);
+			break;
+		case WLS_VOLT_MAX:
+			battmgr->wireless.voltage_max = le32_to_cpu(resp->intval.value);
+			break;
+		case WLS_CURR_NOW:
+			battmgr->wireless.current_now = le32_to_cpu(resp->intval.value);
+			break;
+		case WLS_CURR_MAX:
+			battmgr->wireless.current_max = le32_to_cpu(resp->intval.value);
+			break;
+		default:
+			dev_warn(battmgr->dev, "unknown property %#x\n", property);
+			break;
+		}
+		break;
+	case BATTMGR_REQUEST_NOTIFICATION:
+		battmgr->error = 0;
+		break;
+	default:
+		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
+		break;
+	}
+
+out_complete:
+	complete(&battmgr->ack);
+}
+
+static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
+{
+	const struct pmic_glink_hdr *hdr = data;
+	struct qcom_battmgr *battmgr = priv;
+	unsigned int opcode = le32_to_cpu(hdr->opcode);
+
+	if (opcode == BATTMGR_NOTIFICATION)
+		qcom_battmgr_notification(battmgr, data, len);
+	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
+	else
+		qcom_battmgr_sm8350_callback(battmgr, data, len);
+}
+
+static void qcom_battmgr_enable_worker(struct work_struct *work)
+{
+	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
+	struct qcom_battmgr_enable_request req = {
+		.hdr.owner = PMIC_GLINK_OWNER_BATTMGR,
+		.hdr.type = PMIC_GLINK_NOTIFY,
+		.hdr.opcode = BATTMGR_REQUEST_NOTIFICATION,
+	};
+	int ret;
+
+	ret = qcom_battmgr_request(battmgr, &req, sizeof(req));
+	if (ret)
+		dev_err(battmgr->dev, "failed to request power notifications\n");
+}
+
+static void qcom_battmgr_pdr_notify(void *priv, int state)
+{
+	struct qcom_battmgr *battmgr = priv;
+
+	if (state == SERVREG_SERVICE_STATE_UP) {
+		battmgr->service_up = true;
+		schedule_work(&battmgr->enable_work);
+	} else {
+		battmgr->service_up = false;
+	}
+}
+
+static const struct of_device_id qcom_battmgr_of_variants[] = {
+	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
+	{}
+};
+
+static char *qcom_battmgr_battery[] = { "battery" };
+
+static int qcom_battmgr_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct power_supply_config psy_cfg_supply = {};
+	struct power_supply_config psy_cfg = {};
+	const struct of_device_id *match;
+	struct qcom_battmgr *battmgr;
+	struct device *dev = &adev->dev;
+
+	battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
+	if (!battmgr)
+		return -ENOMEM;
+
+	battmgr->dev = dev;
+
+	psy_cfg.drv_data = battmgr;
+	psy_cfg.of_node = adev->dev.of_node;
+
+	psy_cfg_supply.drv_data = battmgr;
+	psy_cfg_supply.of_node = adev->dev.of_node;
+	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
+	psy_cfg_supply.num_supplicants = 1;
+
+	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
+	mutex_init(&battmgr->lock);
+	init_completion(&battmgr->ack);
+
+	match = of_match_device(qcom_battmgr_of_variants, dev->parent);
+	if (match)
+		battmgr->variant = (unsigned long)match->data;
+	else
+		battmgr->variant = QCOM_BATTMGR_SM8350;
+
+	battmgr->client = devm_pmic_glink_register_client(dev,
+							  PMIC_GLINK_OWNER_BATTMGR,
+							  qcom_battmgr_callback,
+							  qcom_battmgr_pdr_notify,
+							  battmgr);
+	if (IS_ERR(battmgr->client))
+		return PTR_ERR(battmgr->client);
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
+					     "failed to register battery power supply\n");
+
+		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->ac_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
+					     "failed to register AC power supply\n");
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
+					     "failed to register USB power supply\n");
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
+					     "failed to register wireless charing power supply\n");
+	} else {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
+					     "failed to register battery power supply\n");
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
+					     "failed to register USB power supply\n");
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
+					     "failed to register wireless charing power supply\n");
+	}
+
+	dev_set_drvdata(dev, battmgr);
+
+	return 0;
+}
+
+static const struct auxiliary_device_id qcom_battmgr_id_table[] = {
+	{ .name = "pmic_glink.power-supply", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, qcom_battmgr_id_table);
+
+static struct auxiliary_driver qcom_battmgr_driver = {
+	.name = "pmic_glink_power_supply",
+	.probe = qcom_battmgr_probe,
+	.id_table = qcom_battmgr_id_table,
+};
+
+static int __init qcom_battmgr_init(void)
+{
+	return auxiliary_driver_register(&qcom_battmgr_driver);
+}
+module_init(qcom_battmgr_init);
+
+static void __exit qcom_battmgr_exit(void)
+{
+	auxiliary_driver_unregister(&qcom_battmgr_driver);
+}
+module_exit(qcom_battmgr_exit);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK battery manager driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

