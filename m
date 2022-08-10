Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E658E51E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiHJDFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHJDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:05:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AB80F73
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:05:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u14so8064186oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DJUM0H5nWnlK5sCtI3BuhNWFB7lAw+BQ8FAQo0GkIlc=;
        b=WNcBjkMXdkJi2tobHhlF+PDyLly87zGXFN03liljIrnJAUwXDUnwLDvAfxw7P0xabL
         jIPUeOdesxt927tB2O32I1K2RI/n1lKMC0H+OrMeOZCwG+Jo3tVEJ4tC2DJ6W66Wj13h
         v6CPguQpaZLxMFsmMy/iGbd9gklrUtgb+ej7fW45BE4f4m8ofYmnwjcYozsaCuSCWUIe
         eut+2hHzQ2QtLSdZegzdSpsIf4G0YAU1F4cZllIoAz8PlTO0T1UP6KkPImiJKiCCvOpU
         e2dOUKjwaBm7R9dU3OOQkl5hNCcQ03+CnxVPGdAw34my93vaK3MT4GIAzuuyXAjrRqSU
         UTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DJUM0H5nWnlK5sCtI3BuhNWFB7lAw+BQ8FAQo0GkIlc=;
        b=vSibpG2vC1fxVBL3zoXA+8jCHNvLtbXmEvLu8eK3Zzf9FZcOp4LwYWPNho3L5557iD
         B+qiU3lsoIiQJ2ylX0AqAR5Oz0eCJ+KEtcXVzWV+lEEyfvH+jAkxL1kGKmwv+eZVq4Od
         hDIECEnUWJJAUvPhJpyqtzRqxMvRfiuiSDlx98V9yyfwMH8OopobL39LUDZlxgn96GIK
         SEoWulWb+r0ffG1FSnYdAOFFjsvU+afCmLvV8pIdT9u8OtVPY3gBMvQnXtMmsC1naJox
         PJOphlzA4ojUeGaMDFE1PNqT1VaLqxw1zlnS67Ef+pyYGhRY+8phEp78q1cpqr6a/C0x
         EDqw==
X-Gm-Message-State: ACgBeo3NR72bLsqzdu8CUeLXVNRhvGxMgtxvAUKzCBHw9+VUFBLBdb/R
        HvIlJUBKImPSxk7J+jJJLxtU4g==
X-Google-Smtp-Source: AA6agR44wLF7f5OYt6hc65Qhsx/yEZzxoIHleyboRiHuAiaWW3dnbRSfUbZqa6Uqen4dPY0cd9Avdw==
X-Received: by 2002:aca:3557:0:b0:342:c29e:59c8 with SMTP id c84-20020aca3557000000b00342c29e59c8mr597619oia.78.1660100704523;
        Tue, 09 Aug 2022 20:05:04 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s20-20020a0568080b1400b0032f0fd7e1f8sm409004oij.39.2022.08.09.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:05:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: Add Lenovo Yoga C630 EC driver
Date:   Tue,  9 Aug 2022 22:05:00 -0500
Message-Id: <20220810030500.2793882-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm Snapdragon-based Lenovo Yoga C630 has some sort of EC
providing AC-adapter and battery status, as well as USB Type-C altmode
notifications for Displayport operation.

The Yoga C630 ships with Windows, where these operations primarily are
implemented in ACPI, but due to various issues with the hardware
representation therein it's not possible to run Linux on this
information. As such this is a best-effort re-implementation of these
operations, based on the register map expressed in ACPI and a fair
amount of trial and error.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/power/supply/Kconfig        |  11 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/yoga-c630-ec.c | 547 ++++++++++++++++++++++++++++
 3 files changed, 559 insertions(+)
 create mode 100644 drivers/power/supply/yoga-c630-ec.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1aa8323ad9f6..6e706e948ad2 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -897,4 +897,15 @@ config BATTERY_UG3105
 	  device is off or suspended, the functionality of this driver is
 	  limited to reporting capacity only.
 
+config LENOVO_YOGA_C630_EC
+	tristate "Lenovo Yoga C630 EC battery driver"
+	depends on DRM
+	depends on I2C
+	help
+	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
+	  Lenovo Yoga C630, which provides battery information and USB Type-C
+	  altmode notifications.
+
+	  Say M or Y here to include this support.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 7f02f36aea55..24a4129cc427 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
+obj-$(CONFIG_LENOVO_YOGA_C630_EC)	+= yoga-c630-ec.o
diff --git a/drivers/power/supply/yoga-c630-ec.c b/drivers/power/supply/yoga-c630-ec.c
new file mode 100644
index 000000000000..1fa0b5844e01
--- /dev/null
+++ b/drivers/power/supply/yoga-c630-ec.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Linaro Ltd.
+ */
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/usb/typec_mux.h>
+
+#include <drm/drm_bridge.h>
+
+#define LENOVO_EC_CACHE_TIME		(10 * HZ)
+
+#define LENOVO_EC_RESPONSE_REG		0x1
+#define LENOVO_EC_REQUEST_REG		0x2
+
+#define LENOVO_EC_READ_REG		0xb0
+#define LENOVO_EC_QUERY_USB_EVENT	0x8
+#define LENOVO_EC_USB_EVENT_MUX		GENMASK(1, 0)
+#define LENOVO_EC_USB_EVENT_ORIENTATION	BIT(7)
+#define LENOVO_EC_ADPT_STATUS		0xa3
+#define LENOVO_EC_ADPT_PRESENT		BIT(7)
+#define LENOVO_EC_BAT_STATUS		0xc1
+#define LENOVO_EC_BAT_VOLTAGE		0xc6
+#define LENOVO_EC_BAT_CURRENT		0xd2
+#define LENOVO_EC_BAT_PRESENT		0xda
+#define LENOVO_EC_BAT_ATTRIBUTES	0xc0
+#define LENOVO_EC_BAT_ATTR_UNIT_IS_MA	BIT(1)
+#define LENOVO_EC_BAT_REMAIN_CAPACITY	0xc2
+#define LENOVO_EC_BAT_DESIGN_VOLTAGE	0xc8
+#define LENOVO_EC_BAT_DESIGN_CAPACITY	0xca
+#define LENOVO_EC_BAT_FULL_CAPACITY	0xcc
+#define LENOVO_EC_BAT_FULL_FACTORY	0xd6
+#define LENOVO_EC_BAT_FULL_REGISTER	0xdb
+
+#define LENOVO_EC_REQUEST_NEXT_EVENT	0x84
+#define LENOVO_EC_EVENT_USB		0x20
+#define LENOVO_EC_EVENT_UCSI		0x21
+#define LENOVO_EC_EVENT_HPD		0x22
+#define LENOVO_EC_EVENT_BAT_STATUS	0x24
+#define LENOVO_EC_EVENT_BAT_INFO	0x25
+#define LENOVO_EC_EVENT_BAT_ADPT_STATUS	0x37
+
+struct yoga_c630_ec {
+	struct i2c_client *client;
+	struct mutex lock;
+
+	struct power_supply *adp_psy;
+	struct power_supply *bat_psy;
+
+	struct typec_switch *typec_switch;
+
+	unsigned long last_status_update;
+
+	bool adapter_online;
+
+	bool unit_ma;
+
+	unsigned int scale;
+
+	bool bat_present;
+	unsigned int bat_status;
+
+	unsigned int design_capacity;
+	unsigned int design_voltage;
+	unsigned int full_charge_capacity;
+
+	unsigned int capacity_now;
+	unsigned int voltage_now;
+
+	int rate_now;
+
+	bool bridge_configured;
+	struct drm_bridge bridge;
+};
+
+static int yoga_c630_ec_request(struct yoga_c630_ec *ec, u8 *req, size_t req_len,
+				u8 *resp, size_t resp_len)
+{
+	int ret;
+
+	WARN_ON(!mutex_is_locked(&ec->lock));
+
+	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_REQUEST_REG,
+					     req_len, req);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_RESPONSE_REG,
+					     resp_len, resp);
+}
+
+static int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr)
+{
+	int ret;
+	u8 val;
+
+	ret = yoga_c630_ec_request(ec, (u8[]) { LENOVO_EC_READ_REG, addr }, 2,
+				   &val, 1);
+	if (ret < 0)
+		return ret;
+
+	return val;
+}
+
+static int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr)
+{
+	int ret;
+	u8 msb;
+	u8 lsb;
+
+	ret = yoga_c630_ec_request(ec, (u8[]) { LENOVO_EC_READ_REG, addr }, 2,
+				   &lsb, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = yoga_c630_ec_request(ec, (u8[]) { LENOVO_EC_READ_REG, addr + 1 }, 2,
+				   &msb, 1);
+	if (ret < 0)
+		return ret;
+
+	return msb << 8 | lsb;
+}
+
+static void yoga_c630_ec_update_bat_info(struct yoga_c630_ec *ec)
+{
+	int val;
+
+	mutex_lock(&ec->lock);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
+	if (val < 0)
+		goto out_unlock;
+	ec->bat_present = !!(val & BIT(0));
+	if (!ec->bat_present)
+		goto out_unlock;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
+	if (val < 0)
+		goto out_unlock;
+	ec->unit_ma = val & LENOVO_EC_BAT_ATTR_UNIT_IS_MA;
+	if (!ec->unit_ma)
+		ec->scale = 1000;
+	else
+		ec->scale = 1;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
+	if (val < 0)
+		goto out_unlock;
+	ec->design_capacity = val * ec->scale;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
+	if (val < 0)
+		goto out_unlock;
+	ec->design_voltage = val;
+
+	msleep(50);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
+	if (val < 0)
+		goto out_unlock;
+	if (val & BIT(0))
+		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_FACTORY);
+	else
+		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_CAPACITY);
+	if (val < 0)
+		goto out_unlock;
+	ec->full_charge_capacity = val * ec->scale;
+
+out_unlock:
+	mutex_unlock(&ec->lock);
+}
+
+static void yoga_c630_ec_maybe_update_bat_status(struct yoga_c630_ec *ec)
+{
+	int val = 0;
+
+	mutex_lock(&ec->lock);
+
+	if (time_before(jiffies, ec->last_status_update + LENOVO_EC_CACHE_TIME))
+		goto out_unlock;
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_STATUS);
+	if (val < 0)
+		goto out_unlock;
+	ec->bat_status = val;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_REMAIN_CAPACITY);
+	if (val < 0)
+		goto out_unlock;
+	ec->capacity_now = val * ec->scale;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
+	if (val < 0)
+		goto out_unlock;
+	ec->voltage_now = val;
+
+	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
+	if (val < 0)
+		goto out_unlock;
+	ec->rate_now = sign_extend32(val, 15) * ec->scale;
+
+	if (ec->unit_ma)
+		ec->rate_now = ec->rate_now * ec->voltage_now / 1000;
+
+	ec->last_status_update = jiffies;
+
+out_unlock:
+	mutex_unlock(&ec->lock);
+}
+
+static int yoga_c630_ec_update_adapter_status(struct yoga_c630_ec *ec)
+{
+	int val;
+
+	mutex_lock(&ec->lock);
+
+	val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
+	if (val > 0)
+		ec->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
+
+	mutex_unlock(&ec->lock);
+
+	return val;
+}
+
+static bool yoga_c630_ec_is_charged(struct yoga_c630_ec *ec)
+{
+	if (ec->bat_status != 0)
+		return false;
+
+	if (ec->full_charge_capacity == ec->capacity_now)
+		return true;
+
+	if (ec->design_capacity == ec->capacity_now)
+		return true;
+
+	return false;
+}
+
+static int yoga_c630_ec_bat_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct yoga_c630_ec *ec = power_supply_get_drvdata(psy);
+	int rc = 0;
+
+	if (ec->bat_present)
+		yoga_c630_ec_maybe_update_bat_status(ec);
+	else if (psp != POWER_SUPPLY_PROP_PRESENT)
+		return -ENODEV;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (ec->bat_status & BIT(0))
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (ec->bat_status & BIT(1))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (yoga_c630_ec_is_charged(ec))
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = ec->bat_present;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = ec->design_voltage;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = ec->design_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		val->intval = ec->full_charge_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		val->intval = ec->capacity_now;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = ec->rate_now;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = ec->voltage_now;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "PABAS0241231";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Compal";
+		break;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = "05072018";
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static enum power_supply_property yoga_c630_ec_bat_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct power_supply_desc yoga_c630_ec_bat_psy_desc = {
+	.name = "yoga-c630-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yoga_c630_ec_bat_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_ec_bat_properties),
+	.get_property = yoga_c630_ec_bat_get_property,
+};
+
+static int yoga_c630_ec_adpt_get_property(struct power_supply *psy,
+					  enum power_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct yoga_c630_ec *ec = power_supply_get_drvdata(psy);
+	int rc = 0;
+
+	yoga_c630_ec_update_adapter_status(ec);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ec->adapter_online;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static enum power_supply_property yoga_c630_ec_adpt_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc yoga_c630_ec_adpt_psy_desc = {
+	.name = "yoga-c630-adapter",
+	.type = POWER_SUPPLY_TYPE_USB_TYPE_C,
+	.properties = yoga_c630_ec_adpt_properties,
+	.num_properties = ARRAY_SIZE(yoga_c630_ec_adpt_properties),
+	.get_property = yoga_c630_ec_adpt_get_property,
+};
+
+static int yoga_c630_ec_attach(struct drm_bridge *bridge,
+			       enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs yoga_c630_ec_bridge_funcs = {
+	.attach = yoga_c630_ec_attach,
+};
+
+static int yoga_c630_ec_query_usb_event(struct yoga_c630_ec *ec)
+{
+	struct device *dev = &ec->client->dev;
+	enum typec_orientation orientation;
+	enum drm_connector_status status;
+	int event;
+
+	mutex_lock(&ec->lock);
+	event = yoga_c630_ec_read8(ec, LENOVO_EC_QUERY_USB_EVENT);
+	mutex_unlock(&ec->lock);
+	if (event < 0) {
+		dev_err(dev, "unable to query USB event\n");
+		return event;
+	}
+
+	if (FIELD_GET(LENOVO_EC_USB_EVENT_MUX, event))
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+	if (FIELD_GET(LENOVO_EC_USB_EVENT_ORIENTATION, event))
+		orientation = TYPEC_ORIENTATION_REVERSE;
+	else
+		orientation = TYPEC_ORIENTATION_NORMAL;
+
+	typec_switch_set(ec->typec_switch, orientation);
+	if (ec->bridge_configured)
+		drm_bridge_hpd_notify(&ec->bridge, status);
+
+	return 0;
+}
+
+static irqreturn_t yoga_c630_ec_intr(int irq, void *data)
+{
+	struct yoga_c630_ec *ec = data;
+	u8 event;
+	int ret;
+
+	mutex_lock(&ec->lock);
+	ret = yoga_c630_ec_request(ec, (u8[]){ LENOVO_EC_REQUEST_NEXT_EVENT }, 1,
+				   &event, 1);
+	mutex_unlock(&ec->lock);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	switch (event) {
+	case LENOVO_EC_EVENT_USB:
+	case LENOVO_EC_EVENT_HPD:
+		yoga_c630_ec_query_usb_event(ec);
+		break;
+	case LENOVO_EC_EVENT_BAT_INFO:
+		yoga_c630_ec_update_bat_info(ec);
+		break;
+	case LENOVO_EC_EVENT_BAT_ADPT_STATUS:
+		power_supply_changed(ec->adp_psy);
+		fallthrough;
+	case LENOVO_EC_EVENT_BAT_STATUS:
+		power_supply_changed(ec->bat_psy);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void yoga_c630_ec_put_switch(void *data)
+{
+	typec_switch_put(data);
+}
+
+static int yoga_c630_ec_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
+{
+	struct power_supply_config adp_cfg = {};
+	struct power_supply_config bat_cfg = {};
+	struct fwnode_handle *fwnode;
+	struct yoga_c630_ec *ec;
+	struct device *dev = &client->dev;
+	u32 port;
+	int ret;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	mutex_init(&ec->lock);
+	ec->client = client;
+
+	adp_cfg.drv_data = ec;
+	adp_cfg.of_node = client->dev.of_node;
+	ec->adp_psy = devm_power_supply_register(dev, &yoga_c630_ec_adpt_psy_desc, &adp_cfg);
+	if (IS_ERR(ec->adp_psy)) {
+		dev_err(dev, "failed to register AC adapter supply\n");
+		return PTR_ERR(ec->adp_psy);
+	}
+
+	bat_cfg.drv_data = ec;
+	bat_cfg.of_node = client->dev.of_node;
+	ec->bat_psy = devm_power_supply_register(dev, &yoga_c630_ec_bat_psy_desc, &bat_cfg);
+	if (IS_ERR(ec->bat_psy)) {
+		dev_err(dev, "failed to register battery supply\n");
+		return PTR_ERR(ec->bat_psy);
+	}
+
+	device_for_each_child_node(dev, fwnode) {
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0)
+			continue;
+
+		/* Got multiple ports, but altmode is only possible on port 1 */
+		if (port != 1)
+			continue;
+
+		ec->bridge.funcs = &yoga_c630_ec_bridge_funcs;
+		ec->bridge.of_node = to_of_node(fwnode);
+		ec->bridge.ops = DRM_BRIDGE_OP_HPD;
+		ec->bridge.type = DRM_MODE_CONNECTOR_USB;
+
+		ret = devm_drm_bridge_add(dev, &ec->bridge);
+		if (ret) {
+			dev_err(dev, "failed to register drm bridge\n");
+			fwnode_handle_put(fwnode);
+			return ret;
+		}
+
+		ec->bridge_configured = true;
+
+		ec->typec_switch = fwnode_typec_switch_get(fwnode);
+		if (IS_ERR(ec->typec_switch))
+			return dev_err_probe(dev, PTR_ERR(ec->typec_switch),
+					     "failed to acquire orientation-switch for port 1\n");
+
+		ret = devm_add_action_or_reset(dev, yoga_c630_ec_put_switch,
+					       ec->typec_switch);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_request_threaded_irq(dev, client->irq,
+					NULL, yoga_c630_ec_intr,
+					IRQF_ONESHOT, "yoga_c630_ec", ec);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "unable to request irq\n");
+
+	yoga_c630_ec_update_bat_info(ec);
+
+	return 0;
+}
+
+static const struct of_device_id yoga_c630_ec_of_match[] = {
+	{ .compatible = "lenovo,yoga-c630-ec" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, yoga_c630_ec_of_match);
+
+static const struct i2c_device_id yoga_c630_ec_i2c_id_table[] = {
+	{ "yoga-c630-ec", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, yoga_c630_ec_i2c_id_table);
+
+static struct i2c_driver yoga_c630_ec_i2c_driver = {
+	.driver = {
+		.name = "yoga-c630-ec",
+		.of_match_table = yoga_c630_ec_of_match,
+	},
+	.probe = yoga_c630_ec_probe,
+	.id_table = yoga_c630_ec_i2c_id_table,
+};
+module_i2c_driver(yoga_c630_ec_i2c_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga C630 EC driver");
+MODULE_LICENSE("GPL");
-- 
2.37.1

