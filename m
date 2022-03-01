Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB444C8C79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiCANVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiCANVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:21:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4199BB83
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:20:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so20456769wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5QdSkZobRcNw0sMBE5JQ8DioZepLNwTSt32gkTtTW8=;
        b=LSG1kPXdKa0PM1JDG02Ko7nl5UrO0y5WKjksOzwPwpV88b5CVGkgGVPC6qlnNi7tlf
         EfvhwsxfmZVCq+NqAp09nooPX3lYWczG2AqFmuLaPIMMC85prkky079pxPbMnk5YKQNV
         eAn//RXyws1lbLyTh45Xm+lpHY5/HYI56fuIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5QdSkZobRcNw0sMBE5JQ8DioZepLNwTSt32gkTtTW8=;
        b=WfrSnXCb2T5OxikJSYthmbnqJfavIHiQlEC2NI5kdfw2Ekp/LhHywvju/O5ivdOnl0
         daSrmnAFutLNgBFXgEB652QNU3EddcN3SP16Fx7l+ybEAbyXEb1hgWOPXtj6OZ11NPM6
         nCGuKxQPyu27V5uKt0sOAR/nti04d9BF+u6i0L5Nd4wvKSkSV12Y0XSuNcTWKJCbqWRo
         XkGa9H/Vq8makI3VcnJQLfj2KESJYPsUuz6W7XSMiVuuVHlolfsbCK9y/qzoXPHpLKVf
         0tnGU6YyRccvRMTDGgrbcIXG3e5r0EL/8iAtRaE+cWhc+A/IZPXs14uXoSVIr2gogjvD
         +p8A==
X-Gm-Message-State: AOAM530xAxAtNIkUkMFv9zDWreazNOIIuUg6d1BIjrrklSfhItd8Kgj+
        WOxq6F2uRsg8ncBKNvJKQlQuRLN1qeBHh5wy
X-Google-Smtp-Source: ABdhPJw9/jFZBqJ1KR0CRgunqf8sGSgmR+KdvVcqFMPgFa/hAebORW/5RIpHeisPFDZAdZUTZswKRQ==
X-Received: by 2002:a05:6000:1284:b0:1f0:16e0:2058 with SMTP id f4-20020a056000128400b001f016e02058mr2047242wrx.379.1646140852501;
        Tue, 01 Mar 2022 05:20:52 -0800 (PST)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i12-20020adfe48c000000b001ef6eab4c81sm13258492wrm.96.2022.03.01.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 05:20:52 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] usb: typec: add TUSB320xA driver
Date:   Tue,  1 Mar 2022 14:20:07 +0100
Message-Id: <20220301132010.115258-4-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301132010.115258-1-alvin@pqrs.dk>
References: <20220301132010.115258-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The TUSB320LA and TUSB320HA (or LAI, HAI) chips are I2C controlled
non-PD Type-C port controllers. They support detection of cable
orientation, port attachment state, and role, including Audio Accessory
and Debug Accessory modes. Add a typec class driver for this family.

Note that there already exists an extcon driver for the TUSB320 (a
slightly older revision that does not support setting role preference or
disabling the CC state machine). This driver is loosely based on that
one.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/usb/typec/Kconfig     |  12 +
 drivers/usb/typec/Makefile    |   1 +
 drivers/usb/typec/tusb320xa.c | 517 ++++++++++++++++++++++++++++++++++
 3 files changed, 530 insertions(+)
 create mode 100644 drivers/usb/typec/tusb320xa.c

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 8f921213b17d..fd752524814d 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -75,6 +75,18 @@ config TYPEC_HD3SS3220
 	  If you choose to build this driver as a dynamically linked module, the
 	  module will be called hd3ss3220.ko.
 
+config TYPEC_TUSB320XA
+	tristate "TI TUSB320xA Type-C DRP Port controller driver"
+	depends on USB_ROLE_SWITCH
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y or M here if your system has a TUSB320xA Type-C DRP port
+	  controller.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called tusb320xa.ko.
+
 config TYPEC_STUSB160X
 	tristate "STMicroelectronics STUSB160x Type-C controller driver"
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 43626acc0aaf..493e4796ca65 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
 obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
 obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
+obj-$(CONFIG_TYPEC_TUSB320XA)	+= tusb320xa.o
 obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
 obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
 obj-$(CONFIG_TYPEC_RT1719)	+= rt1719.o
diff --git a/drivers/usb/typec/tusb320xa.c b/drivers/usb/typec/tusb320xa.c
new file mode 100644
index 000000000000..b955143e24fc
--- /dev/null
+++ b/drivers/usb/typec/tusb320xa.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI TUSB320LA/TUSB320HA Type-C DRP Port controller driver
+ *
+ * Based on the drivers/extcon/extcon-tusb320.c driver by Michael Auchter.
+ *
+ * Copyright (c) 2021 Alvin Šipraga <alsi@bang-olufsen.dk>
+ * Copyright (c) 2020 Michael Auchter <michael.auchter@ni.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/usb/role.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
+
+#define TUSB320XA_REG8				0x08
+#define TUSB320XA_REG8_ACCESSORY_CONNECTED	GENMASK(3, 1)
+
+#define TUSB320XA_REG9				0x09
+#define TUSB320XA_REG9_ATTACHED_STATE		GENMASK(7, 6)
+#define TUSB320XA_REG9_CABLE_DIR		BIT(5)
+#define TUSB320XA_REG9_INTERRUPT_STATUS		BIT(4)
+
+#define TUSB320XA_REGA				0x0A
+#define TUSB320XA_REGA_MODE_SELECT		GENMASK(5, 4)
+#define TUSB320XA_REGA_I2C_SOFT_RESET		BIT(3)
+#define TUSB320XA_REGA_SOURCE_PREF		GENMASK(2, 1)
+#define TUSB320XA_REGA_DISABLE_TERM		BIT(0)
+
+enum tusb320xa_accessory {
+	TUSB320XA_ACCESSORY_NONE = 0,
+	/* 0b001 ~ 0b011 are reserved */
+	TUSB320XA_ACCESSORY_AUDIO = 4,
+	TUSB320XA_ACCESSORY_AUDIO_CHARGETHRU = 5,
+	TUSB320XA_ACCESSORY_DEBUG_DFP = 6,
+	TUSB320XA_ACCESSORY_DEBUG_UFP = 7,
+};
+
+static const char *const tusb320xa_accessories[] = {
+	[TUSB320XA_ACCESSORY_NONE]             = "none",
+	[TUSB320XA_ACCESSORY_AUDIO]            = "audio",
+	[TUSB320XA_ACCESSORY_AUDIO_CHARGETHRU] = "audio with charge thru",
+	[TUSB320XA_ACCESSORY_DEBUG_DFP]        = "debug while DFP",
+	[TUSB320XA_ACCESSORY_DEBUG_UFP]        = "debug while UFP",
+};
+
+enum tusb320xa_attached_state {
+	TUSB320XA_ATTACHED_STATE_NONE = 0,
+	TUSB320XA_ATTACHED_STATE_DFP = 1,
+	TUSB320XA_ATTACHED_STATE_UFP = 2,
+	TUSB320XA_ATTACHED_STATE_ACC = 3,
+};
+
+static const char *const tusb320xa_attached_states[] = {
+	[TUSB320XA_ATTACHED_STATE_NONE] = "not attached",
+	[TUSB320XA_ATTACHED_STATE_DFP]  = "downstream facing port",
+	[TUSB320XA_ATTACHED_STATE_UFP]  = "upstream facing port",
+	[TUSB320XA_ATTACHED_STATE_ACC]  = "accessory",
+};
+
+enum tusb320xa_cable_dir {
+	TUSB320XA_CABLE_DIR_CC1 = 0,
+	TUSB320XA_CABLE_DIR_CC2 = 1,
+};
+
+static const char *const tusb320xa_cable_directions[] = {
+	[TUSB320XA_CABLE_DIR_CC1] = "CC1",
+	[TUSB320XA_CABLE_DIR_CC2] = "CC2",
+};
+
+enum tusb320xa_mode {
+	TUSB320XA_MODE_PORT = 0,
+	TUSB320XA_MODE_UFP = 1,
+	TUSB320XA_MODE_DFP = 2,
+	TUSB320XA_MODE_DRP = 3,
+};
+
+enum tusb320xa_source_pref {
+	TUSB320XA_SOURCE_PREF_DRP = 0,
+	TUSB320XA_SOURCE_PREF_TRY_SNK = 1,
+	/* 0b10 is reserved */
+	TUSB320XA_SOURCE_PREF_TRY_SRC = 3,
+};
+
+struct tusb320xa {
+	struct device *dev;
+	struct regmap *regmap;
+	struct typec_port *port;
+	struct usb_role_switch *role_sw;
+	struct mutex lock;
+	int irq;
+};
+
+static int tusb320xa_check_signature(struct tusb320xa *tusb)
+{
+	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
+	unsigned int val;
+	int i, ret;
+
+	mutex_lock(&tusb->lock);
+
+	for (i = 0; i < sizeof(sig); i++) {
+		ret = regmap_read(tusb->regmap, sizeof(sig) - 1 - i, &val);
+		if (ret)
+			goto done;
+
+		if (val != sig[i]) {
+			dev_err(tusb->dev, "signature mismatch!\n");
+			ret = -ENODEV;
+			goto done;
+		}
+	}
+
+done:
+	mutex_unlock(&tusb->lock);
+
+	return ret;
+}
+
+static int tusb320xa_reset(struct tusb320xa *tusb)
+{
+	int ret;
+
+	mutex_lock(&tusb->lock);
+
+	/* Disable CC state machine */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_DISABLE_TERM,
+				FIELD_PREP(TUSB320XA_REGA_DISABLE_TERM, 1));
+	if (ret)
+		goto done;
+
+	/* Set to DRP by default, overriding any hardwired PORT setting */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_MODE_SELECT,
+				FIELD_PREP(TUSB320XA_REGA_MODE_SELECT,
+					   TUSB320XA_MODE_DRP));
+	if (ret)
+		goto done;
+
+	/* Wait 5 ms per datasheet specification */
+	usleep_range(5000, 10000);
+
+	/* Perform soft reset */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_I2C_SOFT_RESET,
+				FIELD_PREP(TUSB320XA_REGA_I2C_SOFT_RESET, 1));
+	if (ret)
+		goto done;
+
+	/* Wait 95 ms for chip to reset per datasheet specification */
+	msleep(95);
+
+	/* Clear any old interrupt status bit */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REG9,
+				TUSB320XA_REG9_INTERRUPT_STATUS,
+				FIELD_PREP(TUSB320XA_REG9_INTERRUPT_STATUS, 1));
+	if (ret)
+		goto done;
+
+	/* Re-enable CC state machine */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_DISABLE_TERM,
+				FIELD_PREP(TUSB320XA_REGA_DISABLE_TERM, 0));
+	if (ret)
+		goto done;
+
+done:
+	mutex_unlock(&tusb->lock);
+
+	return ret;
+}
+
+static int tusb320xa_sync_state(struct tusb320xa *tusb)
+{
+	enum tusb320xa_attached_state attached_state;
+	enum tusb320xa_cable_dir cable_dir;
+	enum tusb320xa_accessory accessory;
+	enum typec_orientation typec_orientation;
+	enum typec_data_role typec_data_role;
+	int typec_mode;
+	enum usb_role usb_role;
+	unsigned int reg8;
+	unsigned int reg9;
+	int ret;
+
+	ret = regmap_read(tusb->regmap, TUSB320XA_REG8, &reg8);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(tusb->regmap, TUSB320XA_REG9, &reg9);
+	if (ret)
+		return ret;
+
+	attached_state = FIELD_GET(TUSB320XA_REG9_ATTACHED_STATE, reg9);
+	cable_dir = FIELD_GET(TUSB320XA_REG9_CABLE_DIR, reg9);
+	accessory = FIELD_GET(TUSB320XA_REG8_ACCESSORY_CONNECTED, reg8);
+
+	dev_dbg(tusb->dev,
+		"attached state: %s, cable direction: %s, accessory: %s\n",
+		tusb320xa_attached_states[attached_state],
+		tusb320xa_cable_directions[cable_dir],
+		tusb320xa_accessories[accessory]);
+
+	if (cable_dir == TUSB320XA_CABLE_DIR_CC1)
+		typec_orientation = TYPEC_ORIENTATION_NORMAL;
+	else
+		typec_orientation = TYPEC_ORIENTATION_REVERSE;
+
+	switch (attached_state) {
+	case TUSB320XA_ATTACHED_STATE_NONE:
+		typec_orientation = TYPEC_ORIENTATION_NONE;
+		typec_data_role = TYPEC_HOST;
+		typec_mode = TYPEC_STATE_USB;
+		usb_role = USB_ROLE_NONE;
+		break;
+	case TUSB320XA_ATTACHED_STATE_DFP:
+		typec_data_role = TYPEC_HOST;
+		typec_mode = TYPEC_STATE_USB;
+		usb_role = USB_ROLE_HOST;
+		break;
+	case TUSB320XA_ATTACHED_STATE_UFP:
+		typec_data_role = TYPEC_DEVICE;
+		typec_mode = TYPEC_STATE_USB;
+		usb_role = USB_ROLE_DEVICE;
+		break;
+	case TUSB320XA_ATTACHED_STATE_ACC:
+		typec_data_role = TYPEC_HOST;
+		usb_role = USB_ROLE_HOST;
+
+		if (accessory == TUSB320XA_ACCESSORY_AUDIO ||
+		    accessory == TUSB320XA_ACCESSORY_AUDIO_CHARGETHRU) {
+			typec_mode = TYPEC_MODE_AUDIO;
+		} else if (accessory == TUSB320XA_ACCESSORY_DEBUG_DFP ||
+			   accessory == TUSB320XA_ACCESSORY_DEBUG_UFP) {
+			typec_mode = TYPEC_MODE_DEBUG;
+		} else {
+			dev_warn(tusb->dev, "unknown accessory type: %d\n",
+				 accessory);
+			typec_mode = TYPEC_STATE_USB;
+		}
+
+		break;
+	}
+
+	typec_set_orientation(tusb->port, typec_orientation);
+	typec_set_data_role(tusb->port, typec_data_role);
+	typec_set_mode(tusb->port, typec_mode);
+	usb_role_switch_set_role(tusb->role_sw, usb_role);
+
+	return ret;
+}
+
+static int tusb320xa_set_source_pref(struct tusb320xa *tusb,
+				     enum tusb320xa_source_pref pref)
+{
+	int ret;
+
+	mutex_lock(&tusb->lock);
+
+	ret = regmap_update_bits(tusb->regmap, TUSB320XA_REGA,
+				 TUSB320XA_REGA_SOURCE_PREF,
+				 FIELD_PREP(TUSB320XA_REGA_SOURCE_PREF, pref));
+
+	mutex_unlock(&tusb->lock);
+
+	return ret;
+}
+
+static int tusb320xa_set_mode(struct tusb320xa *tusb, enum tusb320xa_mode mode)
+{
+	int ret;
+
+	mutex_lock(&tusb->lock);
+
+	/* Disable CC state machine */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_DISABLE_TERM,
+				FIELD_PREP(TUSB320XA_REGA_DISABLE_TERM, 1));
+	if (ret)
+		goto done;
+
+	/* Set the desired port mode */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_MODE_SELECT,
+				FIELD_PREP(TUSB320XA_REGA_MODE_SELECT, mode));
+	if (ret)
+		goto done;
+
+	/* Wait 5 ms per datasheet specification */
+	usleep_range(5000, 10000);
+
+	/* Re-enable CC state machine */
+	ret = regmap_write_bits(tusb->regmap, TUSB320XA_REGA,
+				TUSB320XA_REGA_DISABLE_TERM,
+				FIELD_PREP(TUSB320XA_REGA_DISABLE_TERM, 0));
+	if (ret)
+		goto done;
+
+done:
+	mutex_unlock(&tusb->lock);
+
+	return ret;
+}
+
+static int tusb320xa_try_role(struct typec_port *port, int role)
+{
+	struct tusb320xa *tusb = typec_get_drvdata(port);
+	enum tusb320xa_source_pref pref;
+
+	switch (role) {
+	case TYPEC_NO_PREFERRED_ROLE:
+		pref = TUSB320XA_SOURCE_PREF_DRP;
+		break;
+	case TYPEC_SINK:
+		pref = TUSB320XA_SOURCE_PREF_TRY_SNK;
+		break;
+	case TYPEC_SOURCE:
+		pref = TUSB320XA_SOURCE_PREF_TRY_SRC;
+		break;
+	default:
+		dev_warn(tusb->dev, "unknown port role %d\n", role);
+		return -EINVAL;
+	}
+
+	return tusb320xa_set_source_pref(tusb, pref);
+}
+
+static int tusb320xa_port_type_set(struct typec_port *port,
+				   enum typec_port_type type)
+{
+	struct tusb320xa *tusb = typec_get_drvdata(port);
+	enum tusb320xa_mode mode;
+
+	switch (type) {
+	case TYPEC_PORT_SRC:
+		mode = TUSB320XA_MODE_DFP;
+		break;
+	case TYPEC_PORT_SNK:
+		mode = TUSB320XA_MODE_UFP;
+		break;
+	case TYPEC_PORT_DRP:
+		mode = TUSB320XA_MODE_DRP;
+		break;
+	default:
+		dev_warn(tusb->dev, "unknown port type %d\n", type);
+		return -EINVAL;
+	}
+
+	return tusb320xa_set_mode(tusb, mode);
+}
+
+static const struct typec_operations tusb320xa_ops = {
+	.try_role = tusb320xa_try_role,
+	.port_type_set = tusb320xa_port_type_set,
+};
+
+static irqreturn_t tusb320xa_irq_handler_thread(int irq, void *dev_id)
+{
+	struct tusb320xa *tusb = dev_id;
+	unsigned int reg;
+	int ret;
+
+	mutex_lock(&tusb->lock);
+
+	/* Check interrupt status bit */
+	ret = regmap_read(tusb->regmap, TUSB320XA_REG9, &reg);
+	if (ret)
+		goto unhandled;
+
+	if (!(reg & TUSB320XA_REG9_INTERRUPT_STATUS))
+		goto unhandled;
+
+	/* Clear interrupt status bit */
+	ret = regmap_write(tusb->regmap, TUSB320XA_REG9, reg);
+	if (ret)
+		goto unhandled;
+
+	ret = tusb320xa_sync_state(tusb);
+	if (ret)
+		dev_err_ratelimited(tusb->dev,
+				    "failed to sync state in irq: %d\n", ret);
+
+	mutex_unlock(&tusb->lock);
+
+	return IRQ_HANDLED;
+
+unhandled:
+	mutex_unlock(&tusb->lock);
+
+	return IRQ_NONE;
+}
+
+static const struct regmap_config tusb320xa_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.disable_locking = true,
+};
+
+void tusb320xa_action_role_sw_put(void *data)
+{
+	struct usb_role_switch *role_sw = data;
+
+	usb_role_switch_put(role_sw);
+}
+
+void tusb320xa_action_unregister_port(void *data)
+{
+	struct typec_port *port = data;
+
+	typec_unregister_port(port);
+}
+
+static int tusb320xa_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct tusb320xa *tusb;
+	struct typec_capability typec_cap = {};
+	int ret;
+
+	tusb = devm_kzalloc(&client->dev, sizeof(*tusb), GFP_KERNEL);
+	if (!tusb)
+		return -ENOMEM;
+
+	tusb->dev = &client->dev;
+	mutex_init(&tusb->lock);
+
+	tusb->irq = client->irq;
+	if (!tusb->irq)
+		return -EINVAL;
+
+	tusb->regmap = devm_regmap_init_i2c(client, &tusb320xa_regmap_config);
+	if (IS_ERR(tusb->regmap))
+		return PTR_ERR(tusb->regmap);
+
+	tusb->role_sw = usb_role_switch_get(tusb->dev);
+	if (IS_ERR(tusb->role_sw))
+		return PTR_ERR(tusb->role_sw);
+
+	ret = devm_add_action_or_reset(tusb->dev, tusb320xa_action_role_sw_put,
+				       tusb->role_sw);
+	if (ret)
+		return ret;
+
+	ret = tusb320xa_check_signature(tusb);
+	if (ret)
+		return ret;
+
+	ret = tusb320xa_reset(tusb);
+	if (ret)
+		return ret;
+
+	typec_cap.type = TYPEC_PORT_DRP;
+	typec_cap.data = TYPEC_PORT_DRD;
+	typec_cap.revision = USB_TYPEC_REV_1_1;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	typec_cap.accessory[TYPEC_ACCESSORY_NONE] = 1;
+	typec_cap.accessory[TYPEC_ACCESSORY_AUDIO] = 1;
+	typec_cap.accessory[TYPEC_ACCESSORY_DEBUG] = 1;
+	typec_cap.orientation_aware = 1;
+	typec_cap.fwnode = dev_fwnode(tusb->dev);
+	typec_cap.driver_data = tusb;
+	typec_cap.ops = &tusb320xa_ops;
+
+	tusb->port = typec_register_port(tusb->dev, &typec_cap);
+	if (IS_ERR(tusb->port))
+		return PTR_ERR(tusb->port);
+
+	ret = devm_add_action_or_reset(tusb->dev,
+				       tusb320xa_action_unregister_port,
+				       tusb->port);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(tusb->dev, tusb->irq, NULL,
+					tusb320xa_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					"tusb320xa", tusb);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, tusb);
+
+	return 0;
+}
+
+static const struct of_device_id tusb320xa_dt_match[] = {
+	{
+		.compatible = "ti,tusb320la",
+	},
+	{
+		.compatible = "ti,tusb320ha",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tusb320xa_dt_match);
+
+static struct i2c_driver tusb320xa_driver = {
+	.driver	= {
+		.name = "tusb320xa",
+		.of_match_table = tusb320xa_dt_match,
+	},
+	.probe  = tusb320xa_probe,
+};
+
+module_i2c_driver(tusb320xa_driver);
+
+MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
+MODULE_DESCRIPTION("TI TUSB320xA USB Type-C controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

