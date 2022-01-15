Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCC48F396
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiAOA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiAOA4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:56:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B641CC06161C;
        Fri, 14 Jan 2022 16:56:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id x20so4094406pgk.1;
        Fri, 14 Jan 2022 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGymlSCYveV70zOkRTbwcXx6QvMg0Oa2VIc2SYulpn0=;
        b=kSQ3HChjhGI4BxvSuwU6326QN+zB5G3sANUH8knY0omHjh4hojm0XEBOGW5mHzdTSK
         6qTs1WpjwxHLXTDxui5ob5OU1GwfhJDwT0Y4D5JdKXpxXQ/UeOobrUUQ2hZtrX3BJaw/
         5OzrgG+xf6MlHig5SoEMVroRoThTA1WwWzFvCe8tF7D/aoxqTMPnupYMriKEEspYGmSs
         kLFEoZILf4QycF/yclXbMdLA0YO3OgzaroRfG21A1H8jXAhYT32rc2eztHZ0dE8EqfUQ
         c+9bLkA0FkkoXnye0GQCrT7i0ksYV4z7D4T9FPcaF1IpUH2+ufKxb10fPtyHjYYEVb24
         s+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGymlSCYveV70zOkRTbwcXx6QvMg0Oa2VIc2SYulpn0=;
        b=qzojkBK1jBfHZN1WbgdkGxUI//eklIeX1KAqJdE5hdEnNISCuqxc3LPtQPBVzXlJS8
         ci2005X/AqSRBXgnCeYDkWXpu/3SeXdcWXevgOpakhSZOoozAD/Li2hND9OPP30H6mbW
         a6xm+19YvV/sPYd7vhZApc8/1aUJOJi+lOBfCqfjf66MWsZlSilcYNR26DEiWO2R33Dm
         VeD+wqZdAgG087e6IX9w0e1xmiuH1aZuBTVmPkl6KGQn+cBrkfo68vtrXjP2ZgevdxBm
         sTBFks8x8w/qe2Rqd7jwlTddYrBQFsZh6FwPwBaDc5Xrdom9B/UTHPjJks5oRoScubfI
         O+/Q==
X-Gm-Message-State: AOAM530GvwH78BnLu6ptfThtOdXQvG8wXbS/IKCcUAk0BC8bIK/mzXGB
        SKek2wud7FkBk9KMcFUiTDY0U+7hn0M=
X-Google-Smtp-Source: ABdhPJyHBDI0QToqJxah8e3gGvfHR8WbR+GlhIAQdqw4cEnebAGQ5V6yo3gcs7PRzwMM9n3W0xsRew==
X-Received: by 2002:a05:6a00:10d5:b0:4be:d3f9:c329 with SMTP id d21-20020a056a0010d500b004bed3f9c329mr3954085pfu.2.1642208205966;
        Fri, 14 Jan 2022 16:56:45 -0800 (PST)
Received: from localhost.localdomain (1-171-7-64.dynamic-ip.hinet.net. [1.171.7.64])
        by smtp.gmail.com with ESMTPSA id j18sm5335570pgb.27.2022.01.14.16.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:56:45 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH v2 2/2] usb: typec: rt1719: Add support for Richtek RT1719
Date:   Sat, 15 Jan 2022 08:56:31 +0800
Message-Id: <1642208191-7254-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
References: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Richtek RT1719 is a sink-only Type-C PD controller it complies with
latest USB Type-C and PD standards. It integrates the physical layer of
USB power delivery protocol to allow up to 100W of power.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/usb/typec/Kconfig  |  12 +
 drivers/usb/typec/Makefile |   1 +
 drivers/usb/typec/rt1719.c | 976 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 989 insertions(+)
 create mode 100644 drivers/usb/typec/rt1719.c

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index ab480f3..bc918ca 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -52,6 +52,18 @@ source "drivers/usb/typec/ucsi/Kconfig"
 
 source "drivers/usb/typec/tipd/Kconfig"
 
+config TYPEC_RT1719
+	tristate "Richtek RT1719 Sink Only Type-C controller driver"
+	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y or M here if your system has Richtek RT1719 sink only
+	  Type-C port controller driver.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called rt1719.ko
+
 config TYPEC_HD3SS3220
 	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
 	depends on I2C
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 57870a2..441dd6c 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
 obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
 obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
 obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
+obj-$(CONFIG_TYPEC_RT1719)	+= rt1719.o
 obj-$(CONFIG_TYPEC)		+= mux/
diff --git a/drivers/usb/typec/rt1719.c b/drivers/usb/typec/rt1719.c
new file mode 100644
index 00000000..9da65ee
--- /dev/null
+++ b/drivers/usb/typec/rt1719.c
@@ -0,0 +1,976 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/usb/pd.h>
+#include <linux/usb/role.h>
+#include <linux/usb/typec.h>
+
+#define RT1719_REG_TXCTRL1	0x03
+#define RT1719_REG_TXCTRL2	0x04
+#define RT1719_REG_POLICYINFO	0x0E
+#define RT1719_REG_SRCPDO1	0x11
+#define RT1719_REG_MASKS	0x2D
+#define RT1719_REG_EVENTS	0x33
+#define RT1719_REG_STATS	0x37
+#define RT1719_REG_PSELINFO	0x3C
+#define RT1719_REG_USBSETINFO	0x3E
+#define RT1719_REG_VENID	0x82
+
+#define RT1719_UNIQUE_PID	0x1719
+#define RT1719_REQDRSWAP_MASK	BIT(7)
+#define RT1719_EVALMODE_MASK	BIT(4)
+#define RT1719_REQSRCPDO_MASK	GENMASK(2, 0)
+#define RT1719_TXSPDOREQ_MASK	BIT(7)
+#define RT1719_INT_DRSW_ACCEPT	BIT(23)
+#define RT1719_INT_RX_SRCCAP	BIT(21)
+#define RT1719_INT_VBUS_DCT	BIT(6)
+#define RT1719_INT_VBUS_PRESENT	BIT(5)
+#define RT1719_INT_PE_SNK_RDY	BIT(2)
+#define RT1719_CC1_STAT		GENMASK(9, 8)
+#define RT1719_CC2_STAT		GENMASK(11, 10)
+#define RT1719_POLARITY_MASK	BIT(23)
+#define RT1719_DATAROLE_MASK	BIT(22)
+#define RT1719_PDSPECREV_MASK	GENMASK(21, 20)
+#define RT1719_SPDOSEL_MASK	GENMASK(18, 16)
+#define RT1719_SPDONUM_MASK	GENMASK(15, 13)
+#define RT1719_ATTACH_VBUS	BIT(12)
+#define RT1719_ATTACH_DBG	BIT(10)
+#define RT1719_ATTACH_SNK	BIT(9)
+#define RT1719_ATTACHDEV_MASK	(RT1719_ATTACH_VBUS | RT1719_ATTACH_DBG | \
+				 RT1719_ATTACH_SNK)
+#define RT1719_PE_EXP_CONTRACT	BIT(2)
+#define RT1719_PSEL_SUPPORT	BIT(15)
+#define RT1719_TBLSEL_MASK	BIT(6)
+#define RT1719_LATPSEL_MASK	GENMASK(5, 0)
+#define RT1719_USBINFO_MASK	GENMASK(1, 0)
+#define RT1719_USB_DFPUFP	3
+#define RT1719_MAX_SRCPDO	7
+
+enum {
+	SNK_PWR_OPEN = 0,
+	SNK_PWR_DEF,
+	SNK_PWR_1P5A,
+	SNK_PWR_3A
+};
+
+enum {
+	USBPD_SPECREV_1_0 = 0,
+	USBPD_SPECREV_2_0,
+	USBPD_SPECREV_3_0
+};
+
+enum rt1719_snkcap {
+	RT1719_SNKCAP_5V = 0,
+	RT1719_SNKCAP_9V,
+	RT1719_SNKCAP_12V,
+	RT1719_SNKCAP_15V,
+	RT1719_SNKCAP_20V,
+	RT1719_MAX_SNKCAP
+};
+
+struct rt1719_psel_cap {
+	u8 lomask;
+	u8 himask;
+	u32 milliwatt;
+	u32 milliamp;
+};
+
+struct rt1719_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct typec_port *port;
+	struct usb_role_switch *role_sw;
+	struct power_supply *psy;
+	struct typec_partner *partner;
+	struct power_supply_desc psy_desc;
+	struct usb_pd_identity partner_ident;
+	struct typec_partner_desc partner_desc;
+	struct completion req_completion;
+	enum power_supply_usb_type usb_type;
+	bool attached;
+	bool pd_capable;
+	bool drswap_support;
+	u32 voltage;
+	u32 req_voltage;
+	u32 max_current;
+	u32 op_current;
+	u32 spdos[RT1719_MAX_SRCPDO];
+	u16 snkcaps[RT1719_MAX_SNKCAP];
+	int spdo_num;
+	int spdo_sel;
+	u32 conn_info;
+	u16 conn_stat;
+};
+
+static const enum power_supply_usb_type rt1719_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+	POWER_SUPPLY_USB_TYPE_PD_PPS
+};
+
+static const enum power_supply_property rt1719_psy_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW
+};
+
+static int rt1719_read16(struct rt1719_data *data, unsigned int reg, u16 *val)
+{
+	__le16 regval;
+	int ret;
+
+	ret = regmap_raw_read(data->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(regval);
+	return 0;
+}
+
+static int rt1719_read32(struct rt1719_data *data, unsigned int reg, u32 *val)
+{
+	__le32 regval;
+	int ret;
+
+	ret = regmap_raw_read(data->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpu(regval);
+	return 0;
+}
+
+static int rt1719_write32(struct rt1719_data *data, unsigned int reg, u32 val)
+{
+	__le32 regval = cpu_to_le32(val);
+
+	return regmap_raw_write(data->regmap, reg, &regval, sizeof(regval));
+}
+
+static enum typec_pwr_opmode rt1719_get_pwr_opmode(u32 conn, u16 stat)
+{
+	u16 cc1, cc2, cc_stat;
+
+	cc1 = FIELD_GET(RT1719_CC1_STAT, stat);
+	cc2 = FIELD_GET(RT1719_CC2_STAT, stat);
+
+	if (conn & RT1719_ATTACH_SNK) {
+		if (conn & RT1719_POLARITY_MASK)
+			cc_stat = cc2;
+		else
+			cc_stat = cc1;
+
+		switch (cc_stat) {
+		case SNK_PWR_3A:
+			return TYPEC_PWR_MODE_3_0A;
+		case SNK_PWR_1P5A:
+			return TYPEC_PWR_MODE_1_5A;
+		}
+	} else if (conn & RT1719_ATTACH_DBG) {
+		if ((cc1 == SNK_PWR_1P5A && cc2 == SNK_PWR_DEF) ||
+		    (cc1 == SNK_PWR_DEF && cc2 == SNK_PWR_1P5A))
+			return TYPEC_PWR_MODE_1_5A;
+		else if ((cc1 == SNK_PWR_3A && cc2 == SNK_PWR_DEF) ||
+			 (cc1 == SNK_PWR_DEF && cc2 == SNK_PWR_3A))
+			return TYPEC_PWR_MODE_3_0A;
+	}
+
+	return TYPEC_PWR_MODE_USB;
+}
+
+static enum typec_data_role rt1719_get_data_role(u32 conn)
+{
+	if (conn & RT1719_DATAROLE_MASK)
+		return TYPEC_HOST;
+	return TYPEC_DEVICE;
+}
+
+static void rt1719_set_data_role(struct rt1719_data *data,
+				 enum typec_data_role data_role,
+				 bool attached)
+{
+	enum usb_role usb_role = USB_ROLE_NONE;
+
+	if (attached) {
+		if (data_role == TYPEC_HOST)
+			usb_role = USB_ROLE_HOST;
+		else
+			usb_role = USB_ROLE_DEVICE;
+	}
+
+	usb_role_switch_set_role(data->role_sw, usb_role);
+	typec_set_data_role(data->port, data_role);
+}
+
+static void rt1719_update_data_role(struct rt1719_data *data)
+{
+	if (!data->attached)
+		return;
+
+	rt1719_set_data_role(data, rt1719_get_data_role(data->conn_info), true);
+}
+
+static void rt1719_register_partner(struct rt1719_data *data)
+{
+	u16 spec_rev = 0;
+
+	if (data->pd_capable) {
+		u32 rev;
+
+		rev = FIELD_GET(RT1719_PDSPECREV_MASK, data->conn_info);
+		switch (rev) {
+		case USBPD_SPECREV_3_0:
+			spec_rev = 0x0300;
+			break;
+		case USBPD_SPECREV_2_0:
+			spec_rev = 0x0200;
+			break;
+		default:
+			spec_rev = 0x0100;
+			break;
+		}
+	}
+
+	/* Just to prevent multiple times attach */
+	if (data->partner)
+		typec_unregister_partner(data->partner);
+
+	memset(&data->partner_ident, 0, sizeof(data->partner_ident));
+	data->partner_desc.usb_pd = data->pd_capable;
+	data->partner_desc.pd_revision = spec_rev;
+
+	if (data->conn_info & RT1719_ATTACH_DBG)
+		data->partner_desc.accessory = TYPEC_ACCESSORY_DEBUG;
+	else
+		data->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
+
+	data->partner = typec_register_partner(data->port, &data->partner_desc);
+}
+
+static void rt1719_attach(struct rt1719_data *data)
+{
+	enum typec_pwr_opmode pwr_opmode;
+	enum typec_data_role data_role;
+	u32 volt = 5000, curr = 500;
+
+	if (!(data->conn_info & RT1719_ATTACHDEV_MASK))
+		return;
+
+	pwr_opmode = rt1719_get_pwr_opmode(data->conn_info, data->conn_stat);
+	data_role = rt1719_get_data_role(data->conn_info);
+
+	typec_set_pwr_opmode(data->port, pwr_opmode);
+	rt1719_set_data_role(data, data_role, true);
+
+	if (data->conn_info & RT1719_ATTACH_SNK)
+		rt1719_register_partner(data);
+
+	if (pwr_opmode == TYPEC_PWR_MODE_3_0A)
+		curr = 3000;
+	else if (pwr_opmode == TYPEC_PWR_MODE_1_5A)
+		curr = 1500;
+
+	data->voltage = volt * 1000;
+	data->max_current = data->op_current = curr * 1000;
+	data->attached = true;
+
+	power_supply_changed(data->psy);
+}
+
+static void rt1719_detach(struct rt1719_data *data)
+{
+	if (!data->attached || (data->conn_info & RT1719_ATTACHDEV_MASK))
+		return;
+
+	typec_unregister_partner(data->partner);
+	data->partner = NULL;
+
+	typec_set_pwr_opmode(data->port, TYPEC_PWR_MODE_USB);
+	rt1719_set_data_role(data, TYPEC_DEVICE, false);
+
+	memset32(data->spdos, 0, RT1719_MAX_SRCPDO);
+	data->spdo_num = 0;
+	data->voltage = data->max_current = data->op_current = 0;
+	data->attached = data->pd_capable = false;
+
+	data->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	power_supply_changed(data->psy);
+}
+
+static void rt1719_update_operating_status(struct rt1719_data *data)
+{
+	enum power_supply_usb_type usb_type = POWER_SUPPLY_USB_TYPE_PD;
+	u32 voltage, max_current, op_current;
+	int i, snk_sel;
+
+	for (i = 0; i < data->spdo_num; i++) {
+		u32 pdo = data->spdos[i];
+		enum pd_pdo_type type = pdo_type(pdo);
+
+		if (type == PDO_TYPE_APDO) {
+			usb_type = POWER_SUPPLY_USB_TYPE_PD_PPS;
+			break;
+		}
+	}
+
+	data->spdo_sel = FIELD_GET(RT1719_SPDOSEL_MASK, data->conn_info);
+	if (data->spdo_sel <= 0)
+		return;
+
+	data->usb_type = usb_type;
+
+	voltage = pdo_fixed_voltage(data->spdos[data->spdo_sel -1]);
+	max_current = pdo_max_current(data->spdos[data->spdo_sel - 1]);
+
+	switch (voltage) {
+	case 5000:
+		snk_sel = RT1719_SNKCAP_5V;
+		break;
+	case 9000:
+		snk_sel = RT1719_SNKCAP_9V;
+		break;
+	case 12000:
+		snk_sel = RT1719_SNKCAP_12V;
+		break;
+	case 15000:
+		snk_sel = RT1719_SNKCAP_15V;
+		break;
+	case 20000:
+		snk_sel = RT1719_SNKCAP_20V;
+		break;
+	default:
+		return;
+	}
+
+	op_current = min(max_current, pdo_max_current(data->snkcaps[snk_sel]));
+
+	/* covert mV/mA to uV/uA */
+	data->voltage = voltage * 1000;
+	data->max_current = max_current * 1000;
+	data->op_current = op_current * 1000;
+
+	power_supply_changed(data->psy);
+}
+
+static void rt1719_update_pwr_opmode(struct rt1719_data *data)
+{
+	if (!data->attached)
+		return;
+
+	if (!data->pd_capable) {
+		data->pd_capable = true;
+
+		typec_set_pwr_opmode(data->port, TYPEC_PWR_MODE_PD);
+		rt1719_register_partner(data);
+	}
+
+	rt1719_update_operating_status(data);
+}
+
+static void rt1719_update_source_pdos(struct rt1719_data *data)
+{
+	int spdo_num = FIELD_GET(RT1719_SPDONUM_MASK, data->conn_info);
+	__le32 src_pdos[RT1719_MAX_SRCPDO] = { };
+	int i, ret;
+
+	if (!data->attached)
+		return;
+
+	ret = regmap_raw_read(data->regmap, RT1719_REG_SRCPDO1, src_pdos,
+			      sizeof(__le32) * spdo_num);
+	if (ret)
+		return;
+
+	data->spdo_num = spdo_num;
+	for (i = 0; i < spdo_num; i++)
+		data->spdos[i] = le32_to_cpu(src_pdos[i]);
+}
+
+static int rt1719_dr_set(struct typec_port *port, enum typec_data_role role)
+{
+	struct rt1719_data *data = typec_get_drvdata(port);
+	enum typec_data_role cur_role;
+	int ret;
+
+	if (!data->attached || !data->pd_capable || !data->drswap_support)
+		return -EINVAL;
+
+	if (data->spdo_num > 0 && !(data->spdos[0] & PDO_FIXED_DATA_SWAP))
+		return -EINVAL;
+
+	cur_role = rt1719_get_data_role(data->conn_info);
+	if (cur_role == role)
+		return 0;
+
+	ret = regmap_update_bits(data->regmap, RT1719_REG_TXCTRL1,
+				 RT1719_REQDRSWAP_MASK, RT1719_REQDRSWAP_MASK);
+	if (ret)
+		return ret;
+
+	reinit_completion(&data->req_completion);
+	ret = wait_for_completion_timeout(&data->req_completion,
+					  msecs_to_jiffies(400));
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	cur_role = rt1719_get_data_role(data->conn_info);
+	if (cur_role != role)
+		return -ENOTSUPP;
+
+	rt1719_set_data_role(data, role, true);
+	return 0;
+}
+
+static const struct typec_operations rt1719_port_ops = {
+	.dr_set = rt1719_dr_set,
+};
+
+static int rt1719_usbpd_request_voltage(struct rt1719_data *data)
+{
+	u32 src_voltage;
+	int snk_sel, src_sel = -1;
+	int i, ret;
+
+	if (!data->attached || !data->pd_capable || data->spdo_sel <= 0)
+		return -EINVAL;
+
+	src_voltage = pdo_fixed_voltage(data->spdos[data->spdo_sel - 1]);
+	if (src_voltage == data->req_voltage)
+		return 0;
+
+	switch (data->req_voltage) {
+	case 5000:
+		snk_sel = RT1719_SNKCAP_5V;
+		break;
+	case 9000:
+		snk_sel = RT1719_SNKCAP_9V;
+		break;
+	case 12000:
+		snk_sel = RT1719_SNKCAP_12V;
+		break;
+	case 15000:
+		snk_sel = RT1719_SNKCAP_15V;
+		break;
+	case 20000:
+		snk_sel = RT1719_SNKCAP_20V;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!(data->snkcaps[snk_sel] & RT1719_PSEL_SUPPORT))
+		return -EINVAL;
+
+	for (i = 0; i < data->spdo_num; i++) {
+		enum pd_pdo_type type = pdo_type(data->spdos[i]);
+
+		if (type != PDO_TYPE_FIXED)
+			continue;
+
+		src_voltage = pdo_fixed_voltage(data->spdos[i]);
+		if (src_voltage == data->req_voltage) {
+			src_sel = i;
+			break;
+		}
+	}
+
+	if (src_sel == -1)
+		return -ENOTSUPP;
+
+	ret = regmap_update_bits(data->regmap, RT1719_REG_TXCTRL1,
+				 RT1719_EVALMODE_MASK | RT1719_REQSRCPDO_MASK,
+				 RT1719_EVALMODE_MASK | (src_sel + 1));
+	ret |= regmap_update_bits(data->regmap, RT1719_REG_TXCTRL2,
+				  RT1719_TXSPDOREQ_MASK, RT1719_TXSPDOREQ_MASK);
+	if (ret)
+		return ret;
+
+	reinit_completion(&data->req_completion);
+	ret = wait_for_completion_timeout(&data->req_completion,
+					  msecs_to_jiffies(400));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int rt1719_psy_set_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct rt1719_data *data = power_supply_get_drvdata(psy);
+	int ret = -ENOTSUPP;
+
+	if (psp == POWER_SUPPLY_PROP_VOLTAGE_NOW) {
+		data->req_voltage = val->intval / 1000;
+		ret = rt1719_usbpd_request_voltage(data);
+	}
+
+	return ret;
+}
+
+static int rt1719_psy_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct rt1719_data *data = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = data->attached ? 1 : 0;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = data->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = data->max_current;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->op_current;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int rt1719_psy_property_is_writeable(struct power_supply *psy,
+					    enum power_supply_property psp)
+{
+	if (psp == POWER_SUPPLY_PROP_VOLTAGE_NOW)
+		return 1;
+	return 0;
+}
+
+static int devm_rt1719_psy_register(struct rt1719_data *data)
+{
+	static const char *rt1719_psy_name_prefix = "rt1719-source-psy-";
+	const char *port_dev_name = dev_name(data->dev);
+	struct power_supply_config psy_cfg = { };
+	size_t psy_name_len = strlen(rt1719_psy_name_prefix) +
+				       strlen(port_dev_name) + 1;
+	char *psy_name;
+
+	psy_cfg.fwnode = dev_fwnode(data->dev);
+	psy_cfg.drv_data = data;
+
+	psy_name = devm_kzalloc(data->dev, psy_name_len, GFP_KERNEL);
+	if (!psy_name)
+		return -ENOMEM;
+
+	snprintf(psy_name, psy_name_len, "%s%s", rt1719_psy_name_prefix,
+		 port_dev_name);
+	data->psy_desc.name = psy_name;
+	data->psy_desc.type = POWER_SUPPLY_TYPE_USB;
+	data->psy_desc.usb_types = rt1719_psy_usb_types;
+	data->psy_desc.num_usb_types = ARRAY_SIZE(rt1719_psy_usb_types);
+	data->psy_desc.properties = rt1719_psy_properties;
+	data->psy_desc.num_properties = ARRAY_SIZE(rt1719_psy_properties);
+	data->psy_desc.get_property = rt1719_psy_get_property;
+	data->psy_desc.set_property = rt1719_psy_set_property;
+	data->psy_desc.property_is_writeable = rt1719_psy_property_is_writeable;
+
+	data->usb_type = POWER_SUPPLY_USB_TYPE_C;
+
+	data->psy = devm_power_supply_register(data->dev, &data->psy_desc,
+					       &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(data->psy);
+}
+
+static irqreturn_t rt1719_irq_handler(int irq, void *priv)
+{
+	struct rt1719_data *data = priv;
+	u32 events, conn_info;
+	u16 conn_stat;
+	int ret;
+
+	ret = rt1719_read32(data, RT1719_REG_EVENTS, &events);
+	ret |= rt1719_read32(data, RT1719_REG_POLICYINFO, &conn_info);
+	ret |= rt1719_read16(data, RT1719_REG_STATS, &conn_stat);
+	if (ret)
+		return IRQ_NONE;
+
+	data->conn_info = conn_info;
+	data->conn_stat = conn_stat;
+
+	events &= (RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP |
+		   RT1719_INT_VBUS_PRESENT | RT1719_INT_VBUS_DCT |
+		   RT1719_INT_PE_SNK_RDY);
+
+	if (events & RT1719_INT_DRSW_ACCEPT)
+		rt1719_update_data_role(data);
+
+	if (events & RT1719_INT_VBUS_PRESENT)
+		rt1719_attach(data);
+
+	if (events & RT1719_INT_VBUS_DCT)
+		rt1719_detach(data);
+
+	if (events & RT1719_INT_RX_SRCCAP)
+		rt1719_update_source_pdos(data);
+
+	if (events & RT1719_INT_PE_SNK_RDY) {
+		complete(&data->req_completion);
+		rt1719_update_pwr_opmode(data);
+	}
+
+	/* Write 1 to clear already handled events */
+	rt1719_write32(data, RT1719_REG_EVENTS, events);
+
+	return IRQ_HANDLED;
+}
+
+static int rt1719_irq_init(struct rt1719_data *data)
+{
+	struct i2c_client *i2c = to_i2c_client(data->dev);
+	u32 irq_enable;
+	int ret;
+
+	irq_enable = RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP |
+		     RT1719_INT_VBUS_DCT | RT1719_INT_VBUS_PRESENT |
+		     RT1719_INT_PE_SNK_RDY;
+
+	ret = rt1719_write32(data, RT1719_REG_MASKS, irq_enable);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to config irq enable\n");
+		return ret;
+	}
+
+	return devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+					 rt1719_irq_handler, IRQF_ONESHOT,
+					 dev_name(&i2c->dev), data);
+}
+
+static int rt1719_init_attach_state(struct rt1719_data *data)
+{
+	u32 conn_info, irq_clear;
+	u16 conn_stat;
+	int ret;
+
+	irq_clear = RT1719_INT_DRSW_ACCEPT | RT1719_INT_RX_SRCCAP |
+		    RT1719_INT_VBUS_DCT | RT1719_INT_VBUS_PRESENT |
+		    RT1719_INT_PE_SNK_RDY;
+
+	ret = rt1719_read32(data, RT1719_REG_POLICYINFO, &conn_info);
+	ret |= rt1719_read16(data, RT1719_REG_STATS, &conn_stat);
+	ret |= rt1719_write32(data, RT1719_REG_EVENTS, irq_clear);
+	if (ret)
+		return ret;
+
+	data->conn_info = conn_info;
+	data->conn_stat = conn_stat;
+
+	if (conn_info & RT1719_ATTACHDEV_MASK)
+		rt1719_attach(data);
+
+	if (conn_info & RT1719_PE_EXP_CONTRACT) {
+		rt1719_update_source_pdos(data);
+		rt1719_update_pwr_opmode(data);
+	}
+
+	return 0;
+}
+
+#define RT1719_PSEL_CAPINFO(_lomask, _milliwatt, _himask, _milliamp) { \
+	.lomask		= _lomask, \
+	.milliwatt	= _milliwatt, \
+	.himask		= _himask, \
+	.milliamp	= _milliamp, \
+}
+
+static const struct rt1719_psel_cap rt1719_psel_caps[] = {
+	RT1719_PSEL_CAPINFO(0x18, 75000, 0x10, 5000),
+	RT1719_PSEL_CAPINFO(0x18, 60000, 0x10, 4500),
+	RT1719_PSEL_CAPINFO(0x18, 45000, 0x10, 4000),
+	RT1719_PSEL_CAPINFO(0x18, 30000, 0x10, 3500),
+	RT1719_PSEL_CAPINFO(0x18, 25000, 0x10, 3000),
+	RT1719_PSEL_CAPINFO(0x18, 20000, 0x10, 2500),
+	RT1719_PSEL_CAPINFO(0x18, 15000, 0x10, 2000),
+	RT1719_PSEL_CAPINFO(0x18, 10000, 0x10, 1000),
+	RT1719_PSEL_CAPINFO(0x1C, 60000, 0x1F, 5000),
+	RT1719_PSEL_CAPINFO(0x1C, 45000, 0x1F, 4500),
+	RT1719_PSEL_CAPINFO(0x1C, 30000, 0x1F, 4000),
+	RT1719_PSEL_CAPINFO(0x1C, 24000, 0x1F, 3500),
+	RT1719_PSEL_CAPINFO(0x1C, 15000, 0x1F, 3000),
+	RT1719_PSEL_CAPINFO(0x1C, 10000, 0x1F, 2500),
+	RT1719_PSEL_CAPINFO(0x0C, 60000, 0x1F, 2000),
+	RT1719_PSEL_CAPINFO(0x0C, 45000, 0x1F, 1000),
+	RT1719_PSEL_CAPINFO(0x0C, 36000, 0x08, 5000),
+	RT1719_PSEL_CAPINFO(0x0C, 30000, 0x08, 4500),
+	RT1719_PSEL_CAPINFO(0x0C, 24000, 0x08, 4000),
+	RT1719_PSEL_CAPINFO(0x0C, 15000, 0x08, 3500),
+	RT1719_PSEL_CAPINFO(0x0C, 10000, 0x08, 3000),
+	RT1719_PSEL_CAPINFO(0x1E, 45000, 0x08, 2500),
+	RT1719_PSEL_CAPINFO(0x1E, 36000, 0x08, 2000),
+	RT1719_PSEL_CAPINFO(0x1E, 27000, 0x08, 1500),
+	RT1719_PSEL_CAPINFO(0x1E, 20000, 0x08, 1000),
+	RT1719_PSEL_CAPINFO(0x1E, 15000, 0x0F, 5000),
+	RT1719_PSEL_CAPINFO(0x1E, 9000, 0x0F, 4500),
+	RT1719_PSEL_CAPINFO(0x0E, 45000, 0x0F, 4000),
+	RT1719_PSEL_CAPINFO(0x0E, 36000, 0x0F, 3500),
+	RT1719_PSEL_CAPINFO(0x0E, 27000, 0x0F, 3000),
+	RT1719_PSEL_CAPINFO(0x0E, 20000, 0x0F, 2500),
+	RT1719_PSEL_CAPINFO(0x0E, 15000, 0x0F, 2000),
+	RT1719_PSEL_CAPINFO(0x0E, 9000, 0x0F, 1500),
+	RT1719_PSEL_CAPINFO(0x06, 45000, 0x0F, 1000),
+	RT1719_PSEL_CAPINFO(0x06, 36000, 0x0F, 500),
+	RT1719_PSEL_CAPINFO(0x06, 27000, 0x04, 5000),
+	RT1719_PSEL_CAPINFO(0x06, 24000, 0x04, 4500),
+	RT1719_PSEL_CAPINFO(0x06, 18000, 0x04, 4000),
+	RT1719_PSEL_CAPINFO(0x06, 12000, 0x04, 3500),
+	RT1719_PSEL_CAPINFO(0x06, 9000, 0x04, 3000),
+	RT1719_PSEL_CAPINFO(0x1F, 25000, 0x04, 2500),
+	RT1719_PSEL_CAPINFO(0x1F, 20000, 0x04, 2000),
+	RT1719_PSEL_CAPINFO(0x1F, 15000, 0x04, 1500),
+	RT1719_PSEL_CAPINFO(0x1F, 10000, 0x04, 1000),
+	RT1719_PSEL_CAPINFO(0x1F, 7500, 0x07, 5000),
+	RT1719_PSEL_CAPINFO(0x0F, 25000, 0x07, 4500),
+	RT1719_PSEL_CAPINFO(0x0F, 20000, 0x07, 4000),
+	RT1719_PSEL_CAPINFO(0x0F, 15000, 0x07, 3500),
+	RT1719_PSEL_CAPINFO(0x0F, 10000, 0x07, 3000),
+	RT1719_PSEL_CAPINFO(0x0F, 7500, 0x07, 2500),
+	RT1719_PSEL_CAPINFO(0x07, 25000, 0x07, 2000),
+	RT1719_PSEL_CAPINFO(0x07, 20000, 0x07, 1500),
+	RT1719_PSEL_CAPINFO(0x07, 15000, 0x07, 1000),
+	RT1719_PSEL_CAPINFO(0x07, 10000, 0x07, 500),
+	RT1719_PSEL_CAPINFO(0x07, 7500, 0x03, 5000),
+	RT1719_PSEL_CAPINFO(0x03, 25000, 0x03, 4500),
+	RT1719_PSEL_CAPINFO(0x03, 20000, 0x03, 4000),
+	RT1719_PSEL_CAPINFO(0x03, 15000, 0x03, 3500),
+	RT1719_PSEL_CAPINFO(0x03, 10000, 0x03, 3000),
+	RT1719_PSEL_CAPINFO(0x03, 7500, 0x03, 2500),
+	RT1719_PSEL_CAPINFO(0x01, 15000, 0x03, 2000),
+	RT1719_PSEL_CAPINFO(0x01, 10000, 0x03, 1500),
+	RT1719_PSEL_CAPINFO(0x01, 7500, 0x03, 1000),
+	RT1719_PSEL_CAPINFO(0x01, 2500, 0x03, 500)
+};
+
+static u16 rt1719_gen_snkcap_by_current(const struct rt1719_psel_cap *psel_cap,
+					enum rt1719_snkcap capsel)
+{
+	u16 cap = RT1719_PSEL_SUPPORT;
+
+	if (!(psel_cap->himask & BIT(capsel)))
+		return 0;
+
+	cap |= psel_cap->milliamp / 10;
+	return cap;
+}
+
+static u16 rt1719_gen_snkcap_by_watt(const struct rt1719_psel_cap *psel_cap,
+				     enum rt1719_snkcap capsel)
+{
+	u32 volt_div[RT1719_MAX_SNKCAP] = { 5, 9, 12, 15, 20 };
+	u16 cap = RT1719_PSEL_SUPPORT;
+
+	if (!(psel_cap->lomask & BIT(capsel)))
+		return 0;
+
+	cap |= min(psel_cap->milliwatt / volt_div[capsel], (u32)5000) / 10;
+	return cap;
+}
+
+static u16 rt1719_gen_snkcap(unsigned int pselinfo, enum rt1719_snkcap capsel)
+{
+	int psel = FIELD_GET(RT1719_LATPSEL_MASK, pselinfo);
+	const struct rt1719_psel_cap *psel_cap;
+	bool by_current = false;
+
+	if (pselinfo & RT1719_TBLSEL_MASK)
+		by_current = true;
+
+	psel_cap = rt1719_psel_caps + psel;
+	if (by_current)
+		return rt1719_gen_snkcap_by_current(psel_cap, capsel);
+
+	return rt1719_gen_snkcap_by_watt(psel_cap, capsel);
+}
+
+static int rt1719_get_caps(struct rt1719_data *data)
+{
+	unsigned int pselinfo, usbinfo;
+	int i, ret;
+
+	ret = regmap_read(data->regmap, RT1719_REG_PSELINFO, &pselinfo);
+	ret |= regmap_read(data->regmap, RT1719_REG_USBSETINFO, &usbinfo);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < RT1719_MAX_SNKCAP; i++)
+		data->snkcaps[i] = rt1719_gen_snkcap(pselinfo, i);
+
+	usbinfo = FIELD_GET(RT1719_USBINFO_MASK, usbinfo);
+	if (usbinfo == RT1719_USB_DFPUFP)
+		data->drswap_support = true;
+
+	return 0;
+}
+
+static int rt1719_check_exist(struct rt1719_data *data)
+{
+	u16 pid;
+	int ret;
+
+	ret = rt1719_read16(data, RT1719_REG_VENID, &pid);
+	if (ret)
+		return ret;
+
+	if (pid != RT1719_UNIQUE_PID) {
+		dev_err(data->dev, "Incorrect PID 0x%04x\n", pid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config rt1719_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+};
+
+static int rt1719_probe(struct i2c_client *i2c)
+{
+	struct rt1719_data *data;
+	struct fwnode_handle *fwnode;
+	struct typec_capability typec_cap = { };
+	int ret;
+
+	data = devm_kzalloc(&i2c->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = &i2c->dev;
+	init_completion(&data->req_completion);
+
+	data->regmap = devm_regmap_init_i2c(i2c, &rt1719_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
+	}
+
+	ret = rt1719_check_exist(data);
+	if (ret)
+		return ret;
+
+	ret = rt1719_get_caps(data);
+	if (ret)
+		return ret;
+
+	/*
+	 * This fwnode has a "compatible" property, but is never populated as a
+	 * struct device. Instead we simply parse it to read the properties.
+	 * This it breaks fw_devlink=on. To maintain backward compatibility
+	 * with existing DT files, we work around this by deleting any
+	 * fwnode_links to/from this fwnode.
+	 */
+	fwnode = device_get_named_child_node(&i2c->dev, "connector");
+	if (!fwnode)
+		return -ENODEV;
+
+	fw_devlink_purge_absent_suppliers(fwnode);
+
+	data->role_sw = fwnode_usb_role_switch_get(fwnode);
+	if (IS_ERR(data->role_sw)) {
+		ret = PTR_ERR(data->role_sw);
+		dev_err(&i2c->dev, "Failed to get usb role switch (%d)\n", ret);
+		goto err_fwnode_put;
+	}
+
+	ret = devm_rt1719_psy_register(data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to register psy (%d)\n", ret);
+		goto err_role_put;
+	}
+
+	typec_cap.revision = USB_TYPEC_REV_1_2;
+	typec_cap.pd_revision = 0x300;	/* USB-PD spec release 3.0 */
+	typec_cap.type = TYPEC_PORT_SNK;
+	typec_cap.data = TYPEC_PORT_DRD;
+	typec_cap.ops = &rt1719_port_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.driver_data = data;
+	typec_cap.accessory[0] = TYPEC_ACCESSORY_DEBUG;
+
+	data->partner_desc.identity = &data->partner_ident;
+
+	data->port = typec_register_port(&i2c->dev, &typec_cap);
+	if (IS_ERR(data->port)) {
+		ret = PTR_ERR(data->port);
+		dev_err(&i2c->dev, "Failed to register typec port (%d)\n", ret);
+		goto err_role_put;
+	}
+
+	ret = rt1719_init_attach_state(data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to init attach state (%d)\n", ret);
+		goto err_role_put;
+	}
+
+	ret = rt1719_irq_init(data);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to init irq\n");
+		goto err_role_put;
+	}
+
+	fwnode_handle_put(fwnode);
+
+	i2c_set_clientdata(i2c, data);
+
+	return 0;
+
+err_role_put:
+	usb_role_switch_put(data->role_sw);
+err_fwnode_put:
+	fwnode_handle_put(fwnode);
+
+	return ret;
+}
+
+static int rt1719_remove(struct i2c_client *i2c)
+{
+	struct rt1719_data *data = i2c_get_clientdata(i2c);
+
+	typec_unregister_port(data->port);
+	usb_role_switch_put(data->role_sw);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused rt1719_device_table[] = {
+	{ .compatible = "richtek,rt1719", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt1719_device_table);
+
+static struct i2c_driver rt1719_driver = {
+	.driver = {
+		.name = "rt1719",
+		.of_match_table = rt1719_device_table,
+	},
+	.probe_new = rt1719_probe,
+	.remove = rt1719_remove,
+};
+module_i2c_driver(rt1719_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT1719 Sink Only USBPD Controller Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

