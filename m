Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAFF589F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiHDQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiHDQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:06:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C081144C;
        Thu,  4 Aug 2022 09:06:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so31513461lfr.2;
        Thu, 04 Aug 2022 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av5XyveaXOq4lfomx4NUPXmNERnCNgpBk1zL7MxIgKM=;
        b=KdDxlVX9eeujoZBA/QigecGC24OzEXH5SX+b21lS2em+5kL/Ha5I6KrPrF6JnXfmg/
         JqLVDILml+PhxVU+gW7jvA8gX+rLVSsmgFY5kiK8M+VTvUuKe15x/2+yk2eUuMb465FB
         QjOrvYc7OPpSslGjLa95tSrzbrw0sCb9e0lbMTmXmdo58UTSJjl5zInoIN0cNdj8d+ZF
         IQct6LFmMOmwiKF7OZhd7v2NJSN6I71OTBdC5IwdA32CDmDQ5dLBtbpctiTNg9lbE6lY
         wkS/SOxOposJpLkXgb8a+XWFYHkGxIMiDjsY7FkP+CsBa2YfDjXiibeskcLFVmS2B5LX
         //Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av5XyveaXOq4lfomx4NUPXmNERnCNgpBk1zL7MxIgKM=;
        b=joRAVpZHXvhvkfOM0/ovSV3g2XZZDkqt/jw6KkRqEHDP0Cwj+Ifbje57P/CI621RS5
         vDVRaECJh/+9JrVPSHXeCpII45JIaRAuWreh4fEUyqf3wJkIS2JF0r8w8w0xx6oEnZqJ
         e9NhP1eqxHf3anpxfGii/2qhBctKHaoiiuopNZnMqmLiIwP1W4fBO8g6AF/MkiP7zL59
         kEvkBw5GA1CvW5DJqFtJ3RL4nmo3GeK5S1cNcY8VOjmBjajZgq0YibH+iCNvEvgt86Z0
         HA68jDg5vH2KKbGXiShaE7Vm0g91drZsY5TvgsHPuJTY6KYBvk7T0nv2iUU6sjua3Vrw
         6VFg==
X-Gm-Message-State: ACgBeo1QJyHS14vaspqZk3fxK35CqseOTOB/tliDsI2sE8LaLucVWxze
        a8DEhhp2Gxc90l0CqvPh5AN9lgOYm0E=
X-Google-Smtp-Source: AA6agR5uXiYr9kll8tPdI85wq1Y9lyDG85wQn/SozQL1ZxlpylEa7x0zWS9JTQMpG6HbxCU+mORgSA==
X-Received: by 2002:ac2:51af:0:b0:48a:f341:21a1 with SMTP id f15-20020ac251af000000b0048af34121a1mr864311lfk.625.1659629201496;
        Thu, 04 Aug 2022 09:06:41 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id h4-20020a2eb0e4000000b0025e2b567434sm169804ljl.9.2022.08.04.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:06:40 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 1/2] HID: Add driver for RC Simulator Controllers
Date:   Thu,  4 Aug 2022 18:10:40 +0200
Message-Id: <20220804161041.4147310-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several RC Simulator Controllers are HID compliant with similar
interface.

Add support for these controllers:
 - Phoenix RC (HID variant)
 - Car VRC2.0
 - Real Flight G5/G6/G7
 - Aero Fly, FMS
 - OrangeRX FrSky

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/hid/index.rst |   1 +
 Documentation/hid/rcsim.rst | 142 ++++++++++++++++
 drivers/hid/Kconfig         |  11 ++
 drivers/hid/Makefile        |   1 +
 drivers/hid/hid-ids.h       |   5 +
 drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++++++++++
 6 files changed, 475 insertions(+)
 create mode 100644 Documentation/hid/rcsim.rst
 create mode 100644 drivers/hid/hid-rcsim.c

diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
index e50f513c579c..e5813d264f37 100644
--- a/Documentation/hid/index.rst
+++ b/Documentation/hid/index.rst
@@ -17,3 +17,4 @@ Human Interface Devices (HID)
    hid-alps
    intel-ish-hid
    amd-sfh-hid
+   rcsim
diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rcsim.rst
new file mode 100644
index 000000000000..1a031f7189cb
--- /dev/null
+++ b/Documentation/hid/rcsim.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+rcsim - RC Simulator Controllers
+=================================
+
+:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
+
+This driver let you use your own RC controller plugged
+into your computer using an HID compatible USB dongle.
+
+There are several HID compatible USB dongles from different
+vendors. The driver currently supports:
+
+- Phoenix RC (HID variant) (8ch)
+- Car VRC2.0 (2ch)
+- Real Flight G5/G6/G7 (6ch)
+- Aero Fly, FMS (8ch)
+- OrangeRX FrSky (6ch)
+
+Many RC controllers is able to configure which stick goes to which channel.
+This is also configurable in most simulators, so a matching is not necessary.
+
+Supported dongles
+==================
+
+PhoenixRC
+----------
+
+The PhoenixRC has one HID compatible variant which is supported by this driver.
+The controller has support for 8 analog channels.
+
+The driver is generating the following input event for on channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_Y         |
++---------+----------------+
+|     2   |  ABS_X         |
++---------+----------------+
+|     3   |  ABS_RY        |
++---------+----------------+
+|     4   |  ABS_RX        |
++---------+----------------+
+|     5   |  ABS_RUDDER    |
++---------+----------------+
+|     6   |  ABS_THROTTLE  |
++---------+----------------+
+|     7   |  ABS_Z         |
++---------+----------------+
+|     8   |  ABS_RZ        |
++---------+----------------+
+
+VRC2.0
+----------
+VRC2.0 is a controller for RC Cars.
+The controller has support for 2 analog channels.
+
+The driver is generating the following input event for on channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_GAS       |
++---------+----------------+
+|     2   |  ABS_WHEEL     |
++---------+----------------+
+
+RealFlight
+----------
+
+This driver supports Realflight G4-G7 and above
+The controller has support for 4 analog channels and two buttons.
+
+The driver is generating the following input event for on channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_Y         |
++---------+----------------+
+|     2   |  ABS_X         |
++---------+----------------+
+|     3   |  ABS_RY        |
++---------+----------------+
+|     4   |  ABS_RX        |
++---------+----------------+
+|     5   |  BTN_A         |
++---------+----------------+
+|     6   |  BTN_B         |
++---------+----------------+
+
+XTR+G2+FMS Controllers
+--------------------------------
+
+The controllers has support for 8 analog channels.
+
+The driver is generating the following input event for on channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_Y         |
++---------+----------------+
+|     2   |  ABS_X         |
++---------+----------------+
+|     3   |  ABS_RY        |
++---------+----------------+
+|     4   |  ABS_RX        |
++---------+----------------+
+|     5   |  ABS_RUDDER    |
++---------+----------------+
+|     6   |  ABS_THROTTLE  |
++---------+----------------+
+|     7   |  ABS_Z         |
++---------+----------------+
+|     8   |  ABS_RZ        |
++---------+----------------+
+
+OrangeRX
+----------
+
+The controllers has support for 6 analog channels.
+
+The driver is generating the following input event for on channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_Y         |
++---------+----------------+
+|     2   |  ABS_X         |
++---------+----------------+
+|     3   |  ABS_RY        |
++---------+----------------+
+|     4   |  ABS_RX        |
++---------+----------------+
+|     5   |  ABS_RUDDER    |
++---------+----------------+
+|     6   |  ABS_THROTTLE  |
++---------+----------------+
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 70da5931082f..d8313d36086c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -957,6 +957,17 @@ config HID_RAZER
 	Support for Razer devices that are not fully compliant with the
 	HID standard.
 
+config HID_RCSIM
+	tristate "RC Simulator Controllers"
+	depends on HID
+	help
+	Support for several HID compatible RC Simulator Controllers including
+         - Phoenix RC
+         - Car VRC2.0
+         - Real Flight
+         - Aero Fly, FMS
+         - OrangeRX FrSky
+
 config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cac2cbe26d11..85d50ab352ee 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PLAYSTATION)	+= hid-playstation.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
 obj-$(CONFIG_HID_RAZER)	+= hid-razer.o
+obj-$(CONFIG_HID_RCSIM)	+= hid-rcsim.o
 obj-$(CONFIG_HID_REDRAGON)	+= hid-redragon.o
 obj-$(CONFIG_HID_RETRODE)	+= hid-retrode.o
 obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d9eb676abe96..baf5f74d5bed 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1381,6 +1381,11 @@
 
 #define USB_VENDOR_ID_MULTIPLE_1781	0x1781
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD	0x0a9d
+#define USB_DEVICE_ID_PHOENIXRC	0x0898
+#define USB_DEVICE_ID_REALFLIGHT	0x0e56
+
+#define USB_VENDOR_ID_DIPLING	0x0B9B
+#define USB_DEVICE_ID_DIPLING_RCCONTROLLER	0x4012
 
 #define USB_VENDOR_ID_DRACAL_RAPHNET	0x289b
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
new file mode 100644
index 000000000000..0f214cb5816a
--- /dev/null
+++ b/drivers/hid/hid-rcsim.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for several HID compatible RC Simulator Controllers.
+ * Currently supported controllers are:
+ *
+ * - Phoenix RC (HID variant) (8ch)
+ * - Car VRC2.0 (2ch)
+ * - Real Flight G5/G6/G7 (6ch)
+ * - Aero Fly, FMS (8ch)
+ * - OrangeRX FrSky (6ch)
+ *
+ * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+/*
+ * Some of these VID/PID are probably "borrowed", so keep them locally and
+ * do not populate hid-ids.h with those.
+ */
+
+/* PHOENIXRC Controlloer (HID variant) */
+#define PHOENIXRC_VID	(USB_VENDOR_ID_MULTIPLE_1781)
+#define PHOENIXRC_PID	(USB_DEVICE_ID_PHOENIXRC)
+#define PHOENIXRC_DSIZE	(8)
+
+/* VRC2 Controlloer */
+#define VRC2_VID	(0x07c0)
+#define VRC2_PID	(0x1125)
+#define VRC2_DSIZE	(7)
+
+/* Realflight G4-&7 and Above Controller */
+#define REALFLIGHT_VID	(USB_VENDOR_ID_MULTIPLE_1781)
+#define REALFLIGHT_PID	(USB_DEVICE_ID_REALFLIGHT)
+#define REALFLIGHT_DSIZE	(8)
+
+#define REALFLIGHT_BTN_A	BIT(0)
+#define REALFLIGHT_BTN_B	BIT(1)
+
+/* XTR+G2+FMS Controller */
+#define XTRG2FMS_VID	(USB_VENDOR_ID_DIPLING)
+#define XTRG2FMS_PID	(USB_DEVICE_ID_DIPLING_RCCONTROLLER)
+#define XTRG2FMS_DSIZE	(8)
+
+#define XTRG2FMS_X_HI	GENMASK(3, 2)
+#define XTRG2FMS_Y_HI	GENMASK(1, 0)
+#define XTRG2FMS_RX_HI	GENMASK(7, 6)
+#define XTRG2FMS_RY_HI	GENMASK(5, 4)
+#define XTRG2FMS_ALT1_HI	GENMASK(3, 2)
+#define XTRG2FMS_ALT2_HI	GENMASK(1, 0)
+
+/* OrangeRX FrSky */
+#define ORANGERX_VID	(0x0451)
+#define ORANGERX_PID	(0x16a5)
+#define ORANGERX_DSIZE	(8)
+
+enum rcsim_controller {
+	PHOENIXRC,
+	VRC2,
+	REALFLIGHT,
+	XTRG2FMS,
+	ORANGERX
+};
+
+struct rcsim_priv {
+	struct hid_device *hdev;
+	struct input_dev *input;
+	enum rcsim_controller controller;
+	u8 alt;
+};
+
+static int rcsim_open(struct input_dev *dev)
+{
+	struct rcsim_priv *priv = input_get_drvdata(dev);
+
+	return hid_hw_open(priv->hdev);
+}
+
+static void rcsim_close(struct input_dev *dev)
+{
+	struct rcsim_priv *priv = input_get_drvdata(dev);
+
+	hid_hw_close(priv->hdev);
+}
+
+static int rcsim_setup_input(struct rcsim_priv *priv)
+{
+	struct input_dev *input;
+
+	input = devm_input_allocate_device(&priv->hdev->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->id.bustype = priv->hdev->bus;
+	input->id.vendor  = priv->hdev->vendor;
+	input->id.product = priv->hdev->product;
+	input->id.version = priv->hdev->bus;
+	input->phys = priv->hdev->phys;
+	input->uniq = priv->hdev->uniq;
+	input->open = rcsim_open;
+	input->close = rcsim_close;
+
+	input_set_drvdata(input, priv);
+
+	switch (priv->controller) {
+	case PHOENIXRC:
+		input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
+		input->name = "RC Simuator Controller PhoenixRC";
+		break;
+	case VRC2:
+		input_set_abs_params(input, ABS_GAS, 0, 2048, 0, 0);
+		input_set_abs_params(input, ABS_WHEEL, 0, 2048, 0, 0);
+		input->name = "RC Simuator Controller VRC2.0";
+		break;
+	case REALFLIGHT:
+		input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
+		input_set_capability(input, EV_KEY, BTN_A);
+		input_set_capability(input, EV_KEY, BTN_B);
+		input->name = "RC Simuator Controller Realflight";
+		break;
+	case XTRG2FMS:
+		input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_Z, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RZ, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_RUDDER, 0, 1024, 0, 0);
+		input_set_abs_params(input, ABS_THROTTLE, 0, 1024, 0, 0);
+		input->name = "RC Simuator Controller AeroFly, FMS";
+		priv->alt = 0;
+		break;
+	case ORANGERX:
+		input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
+		input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
+		input->name = "RC Simuator Controller OrangeRX FrSky";
+		break;
+	};
+
+	priv->input = input;
+	return input_register_device(priv->input);
+}
+
+static int rcsim_raw_event(struct hid_device *hdev,
+			       struct hid_report *report,
+			       u8 *raw_data, int size)
+{
+	struct rcsim_priv *priv = hid_get_drvdata(hdev);
+	u16 value;
+
+	switch (priv->controller) {
+	case PHOENIXRC:
+		if (size != PHOENIXRC_DSIZE)
+			break;
+
+		/* X, RX, Y and RY, RUDDER and THROTTLE are sent every time */
+		input_report_abs(priv->input, ABS_X, raw_data[2]);
+		input_report_abs(priv->input, ABS_Y, raw_data[0]);
+		input_report_abs(priv->input, ABS_RX, raw_data[4]);
+		input_report_abs(priv->input, ABS_RY, raw_data[3]);
+		input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
+		input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
+
+		/* Z and RZ are sent every other time */
+		if (priv->alt)
+			input_report_abs(priv->input, ABS_Z, raw_data[7]);
+		else
+			input_report_abs(priv->input, ABS_RZ, raw_data[7]);
+
+		priv->alt ^= 1;
+		break;
+	case VRC2:
+		if (size != VRC2_DSIZE)
+			break;
+		value = (raw_data[1] << 8 | raw_data[0]) & GENMASK(10, 0);
+		input_report_abs(priv->input, ABS_GAS, value);
+		value = (raw_data[3] << 8 | raw_data[2]) & GENMASK(10, 0);
+		input_report_abs(priv->input, ABS_WHEEL, value);
+		break;
+	case REALFLIGHT:
+		if (size != REALFLIGHT_DSIZE)
+			break;
+		input_report_abs(priv->input, ABS_X, raw_data[2]);
+		input_report_abs(priv->input, ABS_Y, raw_data[1]);
+		input_report_abs(priv->input, ABS_RX, raw_data[5]);
+		input_report_abs(priv->input, ABS_RY, raw_data[3]);
+		input_report_abs(priv->input, ABS_MISC, raw_data[4]);
+		input_report_key(priv->input, BTN_A,
+				raw_data[7] & REALFLIGHT_BTN_A);
+		input_report_key(priv->input, BTN_B,
+				raw_data[7] & REALFLIGHT_BTN_B);
+		break;
+	case XTRG2FMS:
+		if (size != XTRG2FMS_DSIZE)
+			break;
+
+		/* X, RX, Y and RY are sent every time */
+		value = FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
+		value = (value << 8) | raw_data[1];
+		input_report_abs(priv->input, ABS_X, value);
+
+		value = FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
+		value = (value << 8) | raw_data[2];
+		input_report_abs(priv->input, ABS_Y, value);
+
+		value = FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
+		value = (value << 8) | raw_data[0];
+		input_report_abs(priv->input, ABS_RX, value);
+
+		value = FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
+		value = (value << 8) | raw_data[4];
+		input_report_abs(priv->input, ABS_RY, value);
+
+		/* Z, RZ, RUDDER and THROTTLE are sent every other time */
+		value = FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
+		value = (value << 8) | raw_data[6];
+		if (priv->alt)
+			input_report_abs(priv->input, ABS_Z, value);
+		else
+			input_report_abs(priv->input, ABS_RUDDER, value);
+
+		value = FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
+		value = (value << 8) | raw_data[5];
+		if (priv->alt)
+			input_report_abs(priv->input, ABS_RZ, value);
+		else
+			input_report_abs(priv->input, ABS_THROTTLE, value);
+
+		priv->alt ^= 1;
+		break;
+	case ORANGERX:
+		if (size != ORANGERX_DSIZE)
+			break;
+		input_report_abs(priv->input, ABS_X, raw_data[0]);
+		input_report_abs(priv->input, ABS_Y, raw_data[2]);
+		input_report_abs(priv->input, ABS_RX, raw_data[3]);
+		input_report_abs(priv->input, ABS_RY, raw_data[1]);
+		input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
+		input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
+		break;
+	};
+
+	input_sync(priv->input);
+	return 0;
+}
+
+static int rcsim_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct device *dev = &hdev->dev;
+	struct rcsim_priv *priv;
+	int ret;
+
+	if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
+		return -ENODEV;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->hdev = hdev;
+	priv->controller = id->driver_data;
+	hid_set_drvdata(hdev, priv);
+
+	ret = rcsim_setup_input(priv);
+	if (ret)
+		return ret;
+
+	return hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+}
+
+static const struct hid_device_id rcsim_devices[] = {
+	{ HID_USB_DEVICE(PHOENIXRC_VID, PHOENIXRC_PID), .driver_data = PHOENIXRC },
+	{ HID_USB_DEVICE(VRC2_VID, VRC2_PID), .driver_data = VRC2 },
+	{ HID_USB_DEVICE(REALFLIGHT_VID, REALFLIGHT_PID), .driver_data = REALFLIGHT },
+	{ HID_USB_DEVICE(XTRG2FMS_VID, XTRG2FMS_PID), .driver_data = XTRG2FMS },
+	{ HID_USB_DEVICE(ORANGERX_VID, ORANGERX_PID), .driver_data = ORANGERX },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(hid, rcsim_devices);
+
+static struct hid_driver rcsim_driver = {
+	.name = "rcsim",
+	.id_table = rcsim_devices,
+	.probe = rcsim_probe,
+	.raw_event = rcsim_raw_event,
+};
+module_hid_driver(rcsim_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.37.1

