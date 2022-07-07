Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFD56A8E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiGGQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiGGQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CD621E24;
        Thu,  7 Jul 2022 09:59:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e132so19593871pgc.5;
        Thu, 07 Jul 2022 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+8QxwaoZmvV6a812dsSCQ4nzYcbcePbk0+AOkHgL50=;
        b=I0Lsgc1j6ugLUKZde4KMSUmK4VTEABFQPD9JOztolKl/EUJJZ7FzwYlT5zVNlCtHtf
         o8jWmndwYqdgmL18zN8WolFkSiMJsNb+l1C15lGmy57N5vaTqdQvL3QritdVcD0Gj079
         kPkwf3Ul2GDhZfm2He/29CBTwXj/EPy4+ZZJD4C3BEqekewFDehZhCDDAowDk7wV0kjm
         BZX4PlQwVn47BeJkRAM6gZPrcjmmDpufgoKhfUk95wwiimY3eUqXzp+Oz5o1MIUuBG96
         2+y58zw3VQ2cPK7ZbjSoq+ThKwJiiAuswtqDPx/lNwW1N+12d/PYDlKP4kEbXqev1FLq
         3dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+8QxwaoZmvV6a812dsSCQ4nzYcbcePbk0+AOkHgL50=;
        b=2cAeyA70I0r8GoisjrSgl9jWt3dIwqoXOcVKsk0OowfAmdtg5jnNYMVACte5YduqJO
         iu9X0TpkZ+7JTfWCDPRLrOGHAG039xICmrxmQmXGxJ5MWPSb+KYlIPNyNqEZfn6bLbt7
         PRIvbi4C626fKUU08v5KPB7QtRB0jDU0eej7er4u8XTfACKXBZYsNohdTrPcveMRAK6N
         BaUIEdjJ2+Rp3lC34aXGfReY7SrAqjYXZVnhHq5QP7vuBoW+hQ7AY3LuHFVsmGBT2wNA
         AUNgUcRt4E/1Z8enwjii4Ap9sZ6tStBaf/VlqKeJAbyuSYLT84rFV25M+Yun7t2N6KOp
         75+Q==
X-Gm-Message-State: AJIora+tHROiPwwwHHs+099WZwXDHFTwMsU4EnjZPoPYT1KjgY4V/wOt
        PrRh+xRHMMUjj0tuHoitW9Y=
X-Google-Smtp-Source: AGRyM1skrJJjRv3NAxOGwER+8WIywWocaROXk7uYC083V9Fd757IQ+oIW2CIXbads9YsjkITvsNyEw==
X-Received: by 2002:a05:6a00:1592:b0:525:52ca:bee6 with SMTP id u18-20020a056a00159200b0052552cabee6mr53234154pfk.38.1657213168268;
        Thu, 07 Jul 2022 09:59:28 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:27 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 5/6] HID: add spi-hid, transport driver for HID over SPI bus
Date:   Thu,  7 Jul 2022 09:59:01 -0700
Message-Id: <20220707165902.3184-6-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707165902.3184-1-jaschultzMS@gmail.com>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

This driver follows HID Over SPI Protocol Specification 1.0 available at
https://www.microsoft.com/en-us/download/details.aspx?id=103325. The
initial version of the driver does not support: 1) multi-fragment input
reports, 2) sending GET_INPUT and COMMAND output report types and
processing their respective acknowledge input reports, and 3) device
sleep power state.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 drivers/hid/Kconfig                 |    2 +
 drivers/hid/Makefile                |    1 +
 drivers/hid/spi-hid/Kconfig         |   25 +
 drivers/hid/spi-hid/Makefile        |   12 +
 drivers/hid/spi-hid/spi-hid-core.c  | 1326 +++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h  |  188 ++++
 drivers/hid/spi-hid/spi-hid-of.c    |  141 +++
 drivers/hid/spi-hid/spi-hid-of.h    |   30 +
 drivers/hid/spi-hid/spi-hid_trace.h |  194 ++++
 drivers/hid/spi-hid/trace.c         |    9 +
 10 files changed, 1928 insertions(+)
 create mode 100644 drivers/hid/spi-hid/Kconfig
 create mode 100644 drivers/hid/spi-hid/Makefile
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-core.h
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.c
 create mode 100644 drivers/hid/spi-hid/spi-hid-of.h
 create mode 100644 drivers/hid/spi-hid/spi-hid_trace.h
 create mode 100644 drivers/hid/spi-hid/trace.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 70da5931082f..a396829c4c0b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1314,6 +1314,8 @@ source "drivers/hid/usbhid/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
 
+source "drivers/hid/spi-hid/Kconfig"
+
 source "drivers/hid/intel-ish-hid/Kconfig"
 
 source "drivers/hid/amd-sfh-hid/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cac2cbe26d11..1699863e4021 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_USB_MOUSE)		+= usbhid/
 obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID_CORE)	+= i2c-hid/
+obj-$(CONFIG_SPI_HID)		+= spi-hid/
 
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
new file mode 100644
index 000000000000..37302d658162
--- /dev/null
+++ b/drivers/hid/spi-hid/Kconfig
@@ -0,0 +1,25 @@
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 as published by
+# the Free Software Foundation.
+#
+menu "SPI HID support"
+	depends on SPI
+
+config SPI_HID
+	tristate "HID over SPI transport layer"
+	default n
+	depends on SPI && INPUT && OF
+	select HID
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which is connected to your computer via SPI.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid.
+
+endmenu
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
new file mode 100644
index 000000000000..b9f73982b956
--- /dev/null
+++ b/drivers/hid/spi-hid/Makefile
@@ -0,0 +1,12 @@
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License version 2 as published by
+# the Free Software Foundation.
+#
+# Makefile for the HID over SPI transport driver
+#
+CFLAGS_trace.o = -I$(src)
+obj-$(CONFIG_SPI_HID)	+= spi-hid.o
+spi-hid-objs := spi-hid-core.o spi-hid-of.o trace.o
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
new file mode 100644
index 000000000000..8a29bfe40590
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -0,0 +1,1326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol implementation
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ *
+ * This code is partly based on "HID over I2C protocol implementation:
+ *
+ *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ *  Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ *  Copyright (c) 2012 Red Hat, Inc
+ *
+ *  which in turn is partly based on "USB HID support for Linux":
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2007-2008 Oliver Neukum
+ *  Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "spi-hid-core.h"
+#include "spi-hid_trace.h"
+#include "spi-hid-of.h"
+#include "../hid-ids.h"
+
+#define SPI_HID_MAX_RESET_ATTEMPTS 3
+
+static struct hid_ll_driver spi_hid_ll_driver;
+
+static void spi_hid_populate_read_approvals(struct spi_hid_of_config *conf,
+	u8 *header_buf, u8 *body_buf)
+{
+	header_buf[0] = conf->read_opcode;
+	header_buf[1] = (conf->input_report_header_address >> 16) & 0xff;
+	header_buf[2] =	(conf->input_report_header_address >> 8) & 0xff;
+	header_buf[3] =	(conf->input_report_header_address >> 0) & 0xff;
+	header_buf[4] = SPI_HID_READ_APPROVAL_CONSTANT;
+
+	body_buf[0] = conf->read_opcode;
+	body_buf[1] = (conf->input_report_body_address >> 16) & 0xff;
+	body_buf[2] = (conf->input_report_body_address >> 8) & 0xff;
+	body_buf[3] = (conf->input_report_body_address >> 0) & 0xff;
+	body_buf[4] = SPI_HID_READ_APPROVAL_CONSTANT;
+}
+
+static void spi_hid_parse_dev_desc(struct spi_hid_device_desc_raw *raw,
+					struct spi_hid_device_descriptor *desc)
+{
+	desc->hid_version = le16_to_cpu(raw->bcdVersion);
+	desc->report_descriptor_length = le16_to_cpu(raw->wReportDescLength);
+	desc->max_input_length = le16_to_cpu(raw->wMaxInputLength);
+	desc->max_output_length = le16_to_cpu(raw->wMaxOutputLength);
+
+	/* FIXME: multi-fragment not supported, field below not used */
+	desc->max_fragment_length = le16_to_cpu(raw->wMaxFragmentLength);
+
+	desc->vendor_id = le16_to_cpu(raw->wVendorID);
+	desc->product_id = le16_to_cpu(raw->wProductID);
+	desc->version_id = le16_to_cpu(raw->wVersionID);
+	desc->no_output_report_ack = le16_to_cpu(raw->wFlags) & BIT(0);
+}
+
+static void spi_hid_populate_input_header(u8 *buf,
+		struct spi_hid_input_header *header)
+{
+	header->version            = buf[0] & 0xf;
+	header->report_length      = le16_to_cpu((buf[1] | ((buf[2] & 0x3f) << 8)) * 4);
+	header->last_fragment_flag = (buf[2] & 0x40) >> 6;
+	header->sync_const         = buf[3];
+}
+
+static void spi_hid_populate_input_body(u8 *buf,
+		struct spi_hid_input_body *body)
+{
+	body->report_type = buf[0];
+	body->content_length = le16_to_cpu(buf[1] | (buf[2] << 8));
+	body->content_id = buf[3];
+}
+
+static void spi_hid_input_report_prepare(struct spi_hid_input_buf *buf,
+		struct spi_hid_input_report *report)
+{
+	struct spi_hid_input_header header;
+	struct spi_hid_input_body body;
+
+	spi_hid_populate_input_header(buf->header, &header);
+	spi_hid_populate_input_body(buf->body, &body);
+	report->report_type = body.report_type;
+	report->content_length = body.content_length;
+	report->content_id = body.content_id;
+	report->content = buf->content;
+}
+
+static void spi_hid_populate_output_header(u8 *buf,
+		struct spi_hid_of_config *conf,
+		struct spi_hid_output_report *report)
+{
+	buf[0] = conf->write_opcode;
+	buf[1] = (conf->output_report_address >> 16) & 0xff;
+	buf[2] = (conf->output_report_address >> 8) & 0xff;
+	buf[3] = (conf->output_report_address >> 0) & 0xff;
+	buf[4] = report->report_type;
+	buf[5] = report->content_length & 0xff;
+	buf[6] = (report->content_length >> 8) & 0xff;
+	buf[7] = report->content_id;
+}
+
+static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
+				bool is_header)
+{
+	int ret;
+	struct device *dev = &shid->spi->dev;
+
+	shid->input_transfer[0].tx_buf = is_header ? shid->read_approval_header :
+						shid->read_approval_body;
+	shid->input_transfer[0].len = SPI_HID_READ_APPROVAL_LEN;
+
+	shid->input_transfer[1].rx_buf = buf;
+	shid->input_transfer[1].len = length;
+
+	spi_message_init_with_transfers(&shid->input_message,
+			shid->input_transfer, 2);
+
+	trace_spi_hid_input_sync(shid,
+			shid->input_transfer[0].tx_buf,
+			shid->input_transfer[0].len,
+			shid->input_transfer[1].rx_buf,
+			shid->input_transfer[1].len, 0);
+
+	ret = spi_sync(shid->spi, &shid->input_message);
+	if (ret) {
+		dev_err(dev, "Error starting async transfer: %d, resetting\n",
+									ret);
+		shid->bus_error_count++;
+		shid->bus_last_error = ret;
+		schedule_work(&shid->error_work);
+	}
+
+	return ret;
+}
+
+static int spi_hid_output(struct spi_hid *shid, void *buf, u16 length)
+{
+	struct spi_transfer transfer;
+	struct spi_message message;
+	int ret;
+
+	memset(&transfer, 0, sizeof(transfer));
+
+	transfer.tx_buf = buf;
+	transfer.len = length;
+
+	spi_message_init_with_transfers(&message, &transfer, 1);
+
+	trace_spi_hid_output_begin(shid, transfer.tx_buf,
+			transfer.len, NULL, 0, 0);
+
+	ret = spi_sync(shid->spi, &message);
+
+	trace_spi_hid_output_end(shid, transfer.tx_buf,
+			transfer.len, NULL, 0, ret);
+
+	if (ret) {
+		shid->bus_error_count++;
+		shid->bus_last_error = ret;
+	}
+
+	return ret;
+}
+
+static const char *const spi_hid_power_mode_string(u8 power_state)
+{
+	switch (power_state) {
+	case SPI_HID_POWER_MODE_ON:
+		return "d0";
+	case SPI_HID_POWER_MODE_SLEEP:
+		return "d2";
+	case SPI_HID_POWER_MODE_OFF:
+		return "d3";
+	case SPI_HID_POWER_MODE_WAKING_SLEEP:
+		return "d3*";
+	default:
+		return "unknown";
+	}
+}
+
+static void spi_hid_suspend(struct spi_hid *shid)
+{
+	int ret;
+	struct device *dev = &shid->spi->dev;
+
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF)
+		return;
+
+	if (shid->irq_enabled) {
+		disable_irq(shid->spi->irq);
+		shid->irq_enabled = false;
+	} else {
+		dev_err(dev, "%s called with interrupt already disabled\n",
+								__func__);
+	}
+
+	shid->ready = false;
+
+	spi_hid_of_assert_reset(&shid->conf);
+
+	ret = spi_hid_of_power_down(&shid->conf);
+	if (ret) {
+		dev_err(dev, "%s: could not power down\n", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = ret;
+		return;
+	}
+
+	shid->power_state = SPI_HID_POWER_MODE_OFF;
+}
+
+static void spi_hid_resume(struct spi_hid *shid)
+{
+	int ret;
+	struct device *dev = &shid->spi->dev;
+
+	if (shid->power_state == SPI_HID_POWER_MODE_ON)
+		return;
+
+	if (!shid->irq_enabled) {
+		enable_irq(shid->spi->irq);
+		shid->irq_enabled = true;
+	} else {
+		dev_err(dev, "%s called with interrupt already enabled\n",
+								__func__);
+	}
+
+	ret = spi_hid_of_power_up(&shid->conf);
+	if (ret) {
+		dev_err(dev, "%s: could not power up\n", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = ret;
+		return;
+	}
+	shid->power_state = SPI_HID_POWER_MODE_ON;
+
+	spi_hid_of_deassert_reset(&shid->conf);
+}
+
+static struct hid_device *spi_hid_disconnect_hid(struct spi_hid *shid)
+{
+	struct hid_device *hid = shid->hid;
+
+	shid->hid = NULL;
+
+	return hid;
+}
+
+static void spi_hid_stop_hid(struct spi_hid *shid)
+{
+	struct hid_device *hid;
+
+	hid = spi_hid_disconnect_hid(shid);
+	if (hid) {
+		cancel_work_sync(&shid->create_device_work);
+		cancel_work_sync(&shid->refresh_device_work);
+		hid_destroy_device(hid);
+	}
+}
+
+static void spi_hid_error_work(struct work_struct *work)
+{
+	struct spi_hid *shid = container_of(work, struct spi_hid, error_work);
+	struct device *dev = &shid->spi->dev;
+	int ret;
+
+	mutex_lock(&shid->power_lock);
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF)
+		goto out;
+
+	if (shid->attempts++ >= SPI_HID_MAX_RESET_ATTEMPTS) {
+		dev_err(dev, "unresponsive device, aborting.\n");
+		spi_hid_stop_hid(shid);
+		spi_hid_of_assert_reset(&shid->conf);
+		ret = spi_hid_of_power_down(&shid->conf);
+		if (ret) {
+			dev_err(dev, "failed to disable regulator\n");
+			shid->regulator_error_count++;
+			shid->regulator_last_error = ret;
+		}
+		goto out;
+	}
+
+	trace_spi_hid_error_work(shid);
+
+	shid->ready = false;
+
+	spi_hid_of_assert_reset(&shid->conf);
+
+	shid->power_state = SPI_HID_POWER_MODE_OFF;
+	cancel_work_sync(&shid->reset_response_work);
+
+	spi_hid_of_sleep_minimal_reset_delay(&shid->conf);
+
+	shid->power_state = SPI_HID_POWER_MODE_ON;
+
+	spi_hid_of_deassert_reset(&shid->conf);
+out:
+	mutex_unlock(&shid->power_lock);
+}
+
+static int spi_hid_send_output_report(struct spi_hid *shid,
+		struct spi_hid_output_report *report)
+{
+	struct spi_hid_output_buf *buf = &shid->output;
+	struct device *dev = &shid->spi->dev;
+	u16 report_length;
+	u16 padded_length;
+	u8 padding;
+	int ret;
+
+	if (report->content_length > shid->desc.max_output_length) {
+		dev_err(dev, "Output report too big, content_length 0x%x\n",
+						report->content_length);
+		ret = -E2BIG;
+		goto out;
+	}
+
+	spi_hid_populate_output_header(buf->header, &shid->conf, report);
+
+	if (report->content_length)
+		memcpy(&buf->content, report->content, report->content_length);
+
+	report_length = sizeof(buf->header) + report->content_length;
+	padded_length = round_up(report_length,	4);
+	padding = padded_length - report_length;
+	memset(&buf->content[report->content_length], 0, padding);
+
+	ret = spi_hid_output(shid, buf, padded_length);
+	if (ret) {
+		dev_err(dev, "Failed output transfer\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	return ret;
+}
+
+static int spi_hid_sync_request(struct spi_hid *shid,
+		struct spi_hid_output_report *report)
+{
+	struct device *dev = &shid->spi->dev;
+	int ret = 0;
+
+	ret = spi_hid_send_output_report(shid, report);
+	if (ret) {
+		dev_err(dev, "Failed to transfer output report\n");
+		return ret;
+	}
+
+	mutex_unlock(&shid->output_lock);
+	ret = wait_for_completion_interruptible_timeout(&shid->output_done,
+			msecs_to_jiffies(1000));
+	mutex_lock(&shid->output_lock);
+	if (ret == 0) {
+		dev_err(dev, "Response timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * Handle the reset response from the FW by sending a request for the device
+ * descriptor.
+ */
+static void spi_hid_reset_response_work(struct work_struct *work)
+{
+	struct spi_hid *shid =
+		container_of(work, struct spi_hid, reset_response_work);
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = SPI_HID_OUTPUT_REPORT_TYPE_DEVICE_DESC_REQUEST,
+		.content_length = 0x0,
+		.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
+		.content = NULL,
+	};
+	int ret;
+
+	trace_spi_hid_reset_response_work(shid);
+
+	if (shid->ready) {
+		dev_err(dev, "Spontaneous FW reset!");
+		shid->ready = false;
+		shid->dir_count++;
+	}
+
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF)
+		return;
+
+	if (flush_work(&shid->create_device_work))
+		dev_err(dev, "Reset handler waited for create_device_work");
+
+	if (flush_work(&shid->refresh_device_work))
+		dev_err(dev, "Reset handler waited for refresh_device_work");
+
+	mutex_lock(&shid->output_lock);
+	ret = spi_hid_sync_request(shid, &report);
+	mutex_unlock(&shid->output_lock);
+	if (ret) {
+		dev_WARN_ONCE(dev, true,
+				"Failed to send device descriptor request\n");
+		schedule_work(&shid->error_work);
+	}
+}
+
+static int spi_hid_input_report_handler(struct spi_hid *shid,
+		struct spi_hid_input_buf *buf)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_input_report r;
+	int ret;
+
+	trace_spi_hid_input_report_handler(shid);
+
+	if (!shid->ready || shid->refresh_in_progress || !shid->hid)
+		return 0;
+
+	spi_hid_input_report_prepare(buf, &r);
+
+	ret = hid_input_report(shid->hid, HID_INPUT_REPORT,
+			r.content - 1,
+			r.content_length + 1, 1);
+
+	if (ret == -ENODEV || ret == -EBUSY) {
+		dev_err(dev, "ignoring report --> %d\n", ret);
+		return 0;
+	} else if (ret) {
+		dev_err(dev, "Bad input report, error %d\n", ret);
+	}
+
+	return ret;
+}
+
+static void spi_hid_response_handler(struct spi_hid *shid,
+		struct spi_hid_input_buf *buf)
+{
+	trace_spi_hid_response_handler(shid);
+
+	/* completion_done returns 0 if there are waiters, otherwise 1 */
+	if (completion_done(&shid->output_done)) {
+		dev_err(&shid->spi->dev, "Unexpected response report\n");
+	} else {
+		if (shid->input.body[0] ==
+				SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC ||
+			shid->input.body[0] ==
+				SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP) {
+			size_t response_length = (shid->input.body[1] |
+					(shid->input.body[2] << 8)) +
+					sizeof(shid->input.body);
+			memcpy(shid->response.body, shid->input.body,
+							response_length);
+		}
+		complete(&shid->output_done);
+	}
+}
+
+/*
+ * This function returns the length of the report descriptor, or a negative
+ * error code if something went wrong.
+ */
+static int spi_hid_report_descriptor_request(struct spi_hid *shid)
+{
+	int ret;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = SPI_HID_OUTPUT_REPORT_TYPE_REPORT_DESC_REQUEST,
+		.content_length = 0,
+		.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
+		.content = NULL,
+	};
+
+	ret =  spi_hid_sync_request(shid, &report);
+	if (ret) {
+		dev_err(dev,
+			"Expected report descriptor not received! Error %d\n",
+			ret);
+		schedule_work(&shid->error_work);
+		goto out;
+	}
+
+	ret = (shid->response.body[1] | (shid->response.body[2] << 8));
+	if (ret != shid->desc.report_descriptor_length) {
+		ret = min_t(unsigned int, ret,
+			shid->desc.report_descriptor_length);
+		dev_err(dev,
+			"Received report descriptor length doesn't match device descriptor field, using min of the two: %d\n",
+			ret);
+	}
+out:
+	return ret;
+}
+
+static void spi_hid_process_input_report(struct spi_hid *shid,
+		struct spi_hid_input_buf *buf)
+{
+	struct spi_hid_input_header header;
+	struct spi_hid_input_body body;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_device_desc_raw *raw;
+	int ret;
+
+	trace_spi_hid_process_input_report(shid);
+
+	spi_hid_populate_input_header(buf->header, &header);
+	spi_hid_populate_input_body(buf->body, &body);
+
+	if (body.content_length > header.report_length) {
+		dev_err(dev, "Bad body length %d > %d\n", body.content_length,
+							header.report_length);
+		schedule_work(&shid->error_work);
+		return;
+	}
+
+	switch (body.report_type) {
+	case SPI_HID_INPUT_REPORT_TYPE_DATA:
+		ret = spi_hid_input_report_handler(shid, buf);
+		if (ret)
+			schedule_work(&shid->error_work);
+		break;
+	case SPI_HID_INPUT_REPORT_TYPE_RESET_RESP:
+		schedule_work(&shid->reset_response_work);
+		break;
+	case SPI_HID_INPUT_REPORT_TYPE_DEVICE_DESC:
+		/* Mark the completion done to avoid timeout */
+		spi_hid_response_handler(shid, buf);
+
+		/* Reset attempts at every device descriptor fetch */
+		shid->attempts = 0;
+
+		raw = (struct spi_hid_device_desc_raw *)buf->content;
+
+		/* Validate device descriptor length before parsing */
+		if (body.content_length != SPI_HID_DEVICE_DESCRIPTOR_LENGTH) {
+			dev_err(dev,
+				"Invalid content length %d, expected %d\n",
+				body.content_length,
+				SPI_HID_DEVICE_DESCRIPTOR_LENGTH);
+			schedule_work(&shid->error_work);
+			break;
+		}
+
+		if (le16_to_cpu(raw->wDeviceDescLength) !=
+					SPI_HID_DEVICE_DESCRIPTOR_LENGTH) {
+			dev_err(dev,
+				"Invalid wDeviceDescLength %d, expected %d\n",
+				raw->wDeviceDescLength,
+				SPI_HID_DEVICE_DESCRIPTOR_LENGTH);
+			schedule_work(&shid->error_work);
+			break;
+		}
+
+		spi_hid_parse_dev_desc(raw, &shid->desc);
+
+		if (shid->desc.hid_version != SPI_HID_SUPPORTED_VERSION) {
+			dev_err(dev,
+				"Unsupported device descriptor version %4x\n",
+				shid->desc.hid_version);
+			schedule_work(&shid->error_work);
+			break;
+		}
+
+		if (!shid->hid)
+			schedule_work(&shid->create_device_work);
+		else
+			schedule_work(&shid->refresh_device_work);
+
+		break;
+	case SPI_HID_INPUT_REPORT_TYPE_SET_OUTPUT_REPORT_RESP:
+		if (shid->desc.no_output_report_ack) {
+			dev_err(dev, "Unexpected output report response\n");
+			break;
+		}
+		fallthrough;
+	case SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP:
+	case SPI_HID_INPUT_REPORT_TYPE_SET_FEATURE_RESP:
+		if (!shid->ready) {
+			dev_err(dev,
+				"Unexpected response report while not ready: 0x%x\n",
+				body.report_type);
+			break;
+		}
+		fallthrough;
+	case SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC:
+		spi_hid_response_handler(shid, buf);
+		break;
+	/*
+	 * FIXME: sending GET_INPUT and COMMAND reports not supported, thus
+	 * throw away responses to those, they should never come.
+	 */
+	case SPI_HID_INPUT_REPORT_TYPE_GET_INPUT_REPORT_RESP:
+	case SPI_HID_INPUT_REPORT_TYPE_COMMAND_RESP:
+		dev_err(dev, "Not a supported report type: 0x%x\n",
+							body.report_type);
+		break;
+	default:
+		dev_err(dev, "Unknown input report: 0x%x\n",
+							body.report_type);
+		schedule_work(&shid->error_work);
+		break;
+	}
+}
+
+static int spi_hid_bus_validate_header(struct spi_hid *shid,
+					struct spi_hid_input_header *header)
+{
+	struct device *dev = &shid->spi->dev;
+
+	if (header->version != SPI_HID_INPUT_HEADER_VERSION) {
+		dev_err(dev, "Unknown input report version (v 0x%x)\n",
+				header->version);
+		return -EINVAL;
+	}
+
+	if (shid->desc.max_input_length != 0 &&
+			header->report_length > shid->desc.max_input_length) {
+		dev_err(dev, "Input report body size %u > max expected of %u\n",
+				header->report_length,
+				shid->desc.max_input_length);
+		return -EMSGSIZE;
+	}
+
+	if (header->last_fragment_flag != 1) {
+		dev_err(dev, "Multi-fragment reports not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (header->sync_const != SPI_HID_INPUT_HEADER_SYNC_BYTE) {
+		dev_err(dev, "Invalid input report sync constant (0x%x)\n",
+				header->sync_const);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spi_hid_create_device(struct spi_hid *shid)
+{
+	struct hid_device *hid;
+	struct device *dev = &shid->spi->dev;
+	int ret;
+
+	hid = hid_allocate_device();
+
+	if (IS_ERR(hid)) {
+		dev_err(dev, "Failed to allocate hid device: %ld\n",
+				PTR_ERR(hid));
+		ret = PTR_ERR(hid);
+		return ret;
+	}
+
+	hid->driver_data = shid->spi;
+	hid->ll_driver = &spi_hid_ll_driver;
+	hid->dev.parent = &shid->spi->dev;
+	hid->bus = BUS_SPI;
+	hid->version = shid->desc.hid_version;
+	hid->vendor = shid->desc.vendor_id;
+	hid->product = shid->desc.product_id;
+
+	snprintf(hid->name, sizeof(hid->name), "spi %04hX:%04hX",
+			hid->vendor, hid->product);
+	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
+
+	shid->hid = hid;
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		dev_err(dev, "Failed to add hid device: %d\n", ret);
+		/*
+		 * We likely got here because report descriptor request timed
+		 * out. Let's disconnect and destroy the hid_device structure.
+		 */
+		hid = spi_hid_disconnect_hid(shid);
+		if (hid)
+			hid_destroy_device(hid);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void spi_hid_create_device_work(struct work_struct *work)
+{
+	struct spi_hid *shid =
+		container_of(work, struct spi_hid, create_device_work);
+	struct device *dev = &shid->spi->dev;
+	u8 prev_state = shid->power_state;
+	int ret;
+
+	trace_spi_hid_create_device_work(shid);
+
+	mutex_lock(&shid->power_lock);
+	if (prev_state == SPI_HID_POWER_MODE_OFF) {
+		dev_err(dev, "%s: Powered off, returning", __func__);
+		goto out;
+	}
+
+	ret = spi_hid_create_device(shid);
+	if (ret) {
+		dev_err(dev, "%s: Failed to create hid device\n", __func__);
+		goto out;
+	}
+
+	spi_hid_suspend(shid);
+
+out:
+	mutex_unlock(&shid->power_lock);
+
+	dev_dbg(dev, "%s: %s -> %s\n", __func__,
+			spi_hid_power_mode_string(prev_state),
+			spi_hid_power_mode_string(shid->power_state));
+}
+
+static void spi_hid_refresh_device_work(struct work_struct *work)
+{
+	struct spi_hid *shid =
+		container_of(work, struct spi_hid, refresh_device_work);
+	struct device *dev = &shid->spi->dev;
+	struct hid_device *hid;
+	int ret;
+	u32 new_crc32;
+
+	trace_spi_hid_refresh_device_work(shid);
+
+	mutex_lock(&shid->power_lock);
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF) {
+		dev_err(dev, "%s: Powered off, returning", __func__);
+		goto out2;
+	}
+
+	mutex_lock(&shid->output_lock);
+	ret = spi_hid_report_descriptor_request(shid);
+	mutex_unlock(&shid->output_lock);
+	if (ret < 0) {
+		dev_err(dev,
+			"Refresh: failed report descriptor request, error %d",
+			ret);
+		goto out2;
+	}
+
+	new_crc32 = crc32_le(0, (unsigned char const *)shid->response.content,
+								(size_t)ret);
+	if (new_crc32 == shid->report_descriptor_crc32)
+		goto out1;
+
+	shid->report_descriptor_crc32 = new_crc32;
+	shid->refresh_in_progress = true;
+
+	hid = spi_hid_disconnect_hid(shid);
+	if (hid)
+		hid_destroy_device(hid);
+
+	ret = spi_hid_create_device(shid);
+	if (ret) {
+		dev_err(dev, "%s: Failed to create hid device\n", __func__);
+		goto out2;
+	}
+
+	shid->refresh_in_progress = false;
+
+out1:
+	if (completion_done(&shid->ready_done))
+		dev_err(&shid->spi->dev, "Nobody waiting for ready_done\n");
+	else
+		complete(&shid->ready_done);
+out2:
+	mutex_unlock(&shid->power_lock);
+}
+
+static int spi_hid_get_request(struct spi_hid *shid, u8 content_id)
+{
+	int ret;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = SPI_HID_OUTPUT_REPORT_TYPE_HID_GET_FEATURE,
+		.content_length = 0,
+		.content_id = content_id,
+		.content = NULL,
+	};
+
+	ret = spi_hid_sync_request(shid, &report);
+	if (ret) {
+		dev_err(dev,
+			"Expected get request response not received! Error %d\n",
+			ret);
+		schedule_work(&shid->error_work);
+	}
+
+	return ret;
+}
+
+static int spi_hid_set_request(struct spi_hid *shid,
+		u8 *arg_buf, u16 arg_len, u8 content_id)
+{
+	struct spi_hid_output_report report = {
+		.report_type = SPI_HID_OUTPUT_REPORT_TYPE_HID_SET_FEATURE,
+		.content_length = arg_len,
+		.content_id = content_id,
+		.content = arg_buf,
+	};
+
+	return spi_hid_sync_request(shid, &report);
+}
+
+static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
+{
+	struct spi_hid *shid = _shid;
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_input_header header;
+	int ret = 0;
+
+	trace_spi_hid_dev_irq(shid, irq);
+	trace_spi_hid_header_transfer(shid);
+
+	ret = spi_hid_input_sync(shid, shid->input.header,
+			sizeof(shid->input.header), true);
+	if (ret) {
+		dev_err(dev, "Failed to transfer header: %d\n", ret);
+		goto out;
+	}
+
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF) {
+		dev_warn(dev, "Device is off after header was received\n");
+		goto out;
+	}
+
+	trace_spi_hid_input_header_complete(shid,
+				shid->input_transfer[0].tx_buf,
+				shid->input_transfer[0].len,
+				shid->input_transfer[1].rx_buf,
+				shid->input_transfer[1].len,
+				shid->input_message.status);
+
+	if (shid->input_message.status < 0) {
+		dev_warn(dev, "Error reading header: %d\n",
+				shid->input_message.status);
+		shid->bus_error_count++;
+		shid->bus_last_error = shid->input_message.status;
+		schedule_work(&shid->error_work);
+		goto out;
+	}
+
+	spi_hid_populate_input_header(shid->input.header, &header);
+
+	ret = spi_hid_bus_validate_header(shid, &header);
+	if (ret) {
+		dev_err(dev, "Failed to validate header: %d\n", ret);
+		print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
+						DUMP_PREFIX_NONE, 16, 1,
+						shid->input.header,
+						sizeof(shid->input.header),
+						false);
+		shid->bus_error_count++;
+		shid->bus_last_error = ret;
+		goto out;
+	}
+
+	ret = spi_hid_input_sync(shid, shid->input.body, header.report_length,
+				false);
+	if (ret)
+		dev_err(dev, "Failed to transfer body: %d\n", ret);
+
+	if (shid->power_state == SPI_HID_POWER_MODE_OFF) {
+		dev_warn(dev, "Device is off after body was received\n");
+		goto out;
+	}
+
+	trace_spi_hid_input_body_complete(shid, shid->input_transfer[0].tx_buf,
+						shid->input_transfer[0].len,
+						shid->input_transfer[1].rx_buf,
+						shid->input_transfer[1].len,
+						shid->input_message.status);
+
+	if (shid->input_message.status < 0) {
+		dev_warn(dev, "Error reading body: %d\n",
+				shid->input_message.status);
+		shid->bus_error_count++;
+		shid->bus_last_error = shid->input_message.status;
+		schedule_work(&shid->error_work);
+		goto out;
+	}
+
+	spi_hid_process_input_report(shid, &shid->input);
+
+out:
+	return IRQ_HANDLED;
+}
+
+/* hid_ll_driver interface functions */
+
+static int spi_hid_ll_start(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	if (shid->desc.max_input_length < HID_MIN_BUFFER_SIZE) {
+		dev_err(&shid->spi->dev,
+			"HID_MIN_BUFFER_SIZE > max_input_length (%d)\n",
+			shid->desc.max_input_length);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void spi_hid_ll_stop(struct hid_device *hid)
+{
+	hid->claimed = 0;
+}
+
+static int spi_hid_ll_open(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	u8 prev_state = shid->power_state;
+	int ret;
+
+	if (shid->refresh_in_progress)
+		return 0;
+
+	spi_hid_resume(shid);
+
+	dev_dbg(dev, "%s: %s -> %s\n", __func__,
+			spi_hid_power_mode_string(prev_state),
+			spi_hid_power_mode_string(shid->power_state));
+
+	reinit_completion(&shid->ready_done);
+	ret = wait_for_completion_interruptible_timeout(&shid->ready_done,
+			msecs_to_jiffies(1000));
+	if (ret == 0) {
+		dev_err(dev, "Handshake timed out\n");
+		return -EAGAIN;
+	} else {
+		dev_dbg(dev, "%s: ready\n", __func__);
+		shid->ready = true;
+		return 0;
+	}
+}
+
+static void spi_hid_ll_close(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	u8 prev_state = shid->power_state;
+
+	if (shid->refresh_in_progress)
+		return;
+
+	mutex_lock(&shid->power_lock);
+	spi_hid_suspend(shid);
+	mutex_unlock(&shid->power_lock);
+
+	shid->attempts = 0;
+
+	dev_dbg(dev, "%s: %s -> %s\n", __func__,
+			spi_hid_power_mode_string(prev_state),
+			spi_hid_power_mode_string(shid->power_state));
+}
+
+static int spi_hid_ll_power(struct hid_device *hid, int level)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	int ret = 0;
+
+	mutex_lock(&shid->output_lock);
+	if (!shid->hid)
+		ret = -ENODEV;
+	mutex_unlock(&shid->output_lock);
+
+	return ret;
+}
+
+static int spi_hid_ll_parse(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int ret, len;
+
+	mutex_lock(&shid->output_lock);
+
+	len = spi_hid_report_descriptor_request(shid);
+	if (len < 0) {
+		dev_err(dev, "Report descriptor request failed, %d\n", len);
+		ret = len;
+		goto out;
+	}
+
+	/*
+	 * FIXME: below call returning 0 doesn't mean that the report descriptor
+	 * is good. We might be caching a crc32 of a corrupted r. d. or who
+	 * knows what the FW sent. Need to have a feedback loop about r. d.
+	 * being ok and only then cache it.
+	 */
+	ret = hid_parse_report(hid, (u8 *)shid->response.content, len);
+	if (ret)
+		dev_err(dev, "failed parsing report: %d\n", ret);
+	else
+		shid->report_descriptor_crc32 = crc32_le(0,
+				(unsigned char const *)shid->response.content,
+				len);
+
+out:
+	mutex_unlock(&shid->output_lock);
+
+	return ret;
+}
+
+static int spi_hid_ll_raw_request(struct hid_device *hid,
+		unsigned char reportnum, u8 *buf, size_t len,
+		unsigned char rtype, int reqtype)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	if (!shid->ready) {
+		dev_err(&shid->spi->dev, "%s called in unready state\n",
+								__func__);
+		return -ENODEV;
+	}
+
+	mutex_lock(&shid->output_lock);
+
+	switch (reqtype) {
+	case HID_REQ_SET_REPORT:
+		if (buf[0] != reportnum) {
+			dev_err(dev, "report id mismatch\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = spi_hid_set_request(shid, &buf[1], len - 1,
+				reportnum);
+		if (ret) {
+			dev_err(dev, "failed to set report\n");
+			break;
+		}
+
+		ret = len;
+		break;
+	case HID_REQ_GET_REPORT:
+		ret = spi_hid_get_request(shid, reportnum);
+		if (ret) {
+			dev_err(dev, "failed to get report\n");
+			break;
+		}
+
+		ret = min_t(size_t, len,
+			shid->response.body[1] | (shid->response.body[2] << 8));
+		memcpy(buf, &shid->response.content, ret);
+		break;
+	default:
+		dev_err(dev, "invalid request type\n");
+		ret = -EIO;
+	}
+
+	mutex_unlock(&shid->output_lock);
+
+	return ret;
+}
+
+static int spi_hid_ll_output_report(struct hid_device *hid,
+		u8 *buf, size_t len)
+{
+	int ret;
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = SPI_HID_OUTPUT_REPORT_TYPE_HID_OUTPUT_REPORT,
+		.content_length = len - 1,
+		.content_id = buf[0],
+		.content = &buf[1],
+	};
+
+	mutex_lock(&shid->output_lock);
+	if (!shid->ready) {
+		dev_err(dev, "%s called in unready state\n", __func__);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (shid->desc.no_output_report_ack)
+		ret = spi_hid_send_output_report(shid, &report);
+	else
+		ret = spi_hid_sync_request(shid, &report);
+
+	if (ret)
+		dev_err(dev, "failed to send output report\n");
+
+out:
+	mutex_unlock(&shid->output_lock);
+
+	if (ret > 0)
+		return -ret;
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static struct hid_ll_driver spi_hid_ll_driver = {
+	.start = spi_hid_ll_start,
+	.stop = spi_hid_ll_stop,
+	.open = spi_hid_ll_open,
+	.close = spi_hid_ll_close,
+	.power = spi_hid_ll_power,
+	.parse = spi_hid_ll_parse,
+	.output_report = spi_hid_ll_output_report,
+	.raw_request = spi_hid_ll_raw_request,
+};
+
+const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "hid-over-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static ssize_t bus_error_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d (%d)\n",
+			shid->bus_error_count, shid->bus_last_error);
+}
+static DEVICE_ATTR_RO(bus_error_count);
+
+static ssize_t regulator_error_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d (%d)\n",
+			shid->regulator_error_count,
+			shid->regulator_last_error);
+}
+static DEVICE_ATTR_RO(regulator_error_count);
+
+static ssize_t device_initiated_reset_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", shid->dir_count);
+}
+static DEVICE_ATTR_RO(device_initiated_reset_count);
+
+static const struct attribute *const spi_hid_attributes[] = {
+	&dev_attr_bus_error_count.attr,
+	&dev_attr_regulator_error_count.attr,
+	&dev_attr_device_initiated_reset_count.attr,
+	NULL	/* Terminator */
+};
+
+static int spi_hid_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid *shid;
+	unsigned long irqflags;
+	int ret;
+
+	if (spi->irq <= 0) {
+		dev_err(dev, "Missing IRQ\n");
+		ret = spi->irq ?: -EINVAL;
+		goto err0;
+	}
+
+	shid = devm_kzalloc(dev, sizeof(struct spi_hid), GFP_KERNEL);
+	if (!shid) {
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	shid->spi = spi;
+	shid->power_state = SPI_HID_POWER_MODE_ON;
+	spi_set_drvdata(spi, shid);
+
+	ret = sysfs_create_files(&dev->kobj, spi_hid_attributes);
+	if (ret) {
+		dev_err(dev, "Unable to create sysfs attributes\n");
+		goto err0;
+	}
+
+	ret = spi_hid_of_populate_config(&shid->conf, dev);
+	if (ret) {
+		dev_err(dev, "%s: unable to populate config data\n", __func__);
+		goto err1;
+	}
+
+	/* Using now populated conf let's pre-calculate the read approvals */
+	spi_hid_populate_read_approvals(&shid->conf, shid->read_approval_header,
+						shid->read_approval_body);
+
+	mutex_init(&shid->output_lock);
+	mutex_init(&shid->power_lock);
+	init_completion(&shid->output_done);
+	init_completion(&shid->ready_done);
+
+	INIT_WORK(&shid->reset_response_work, spi_hid_reset_response_work);
+	INIT_WORK(&shid->create_device_work, spi_hid_create_device_work);
+	INIT_WORK(&shid->refresh_device_work, spi_hid_refresh_device_work);
+	INIT_WORK(&shid->error_work, spi_hid_error_work);
+
+	/*
+	 * At the end of probe we initialize the device:
+	 *   0) Default pinctrl in DT: assert reset, bias the interrupt line
+	 *   1) sleep minimal reset delay
+	 *   2) request IRQ
+	 *   3) power up the device
+	 *   4) deassert reset (high)
+	 * After this we expect an IRQ with a reset response.
+	 */
+
+	spi_hid_of_sleep_minimal_reset_delay(&shid->conf);
+
+	irqflags = irq_get_trigger_type(spi->irq) | IRQF_ONESHOT;
+	ret = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+			irqflags, dev_name(&spi->dev), shid);
+	if (ret) {
+		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
+		goto err1;
+	}
+	shid->irq_enabled = true;
+
+	ret = spi_hid_of_power_up(&shid->conf);
+	if (ret) {
+		dev_err(dev, "%s: could not power up\n", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = ret;
+		goto err1;
+	}
+
+	spi_hid_of_deassert_reset(&shid->conf);
+
+	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
+			spi_hid_power_mode_string(shid->power_state));
+
+	return 0;
+
+err1:
+	sysfs_remove_files(&dev->kobj, spi_hid_attributes);
+
+err0:
+	return ret;
+}
+
+static int spi_hid_remove(struct spi_device *spi)
+{
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	spi_hid_of_assert_reset(&shid->conf);
+	ret = spi_hid_of_power_down(&shid->conf);
+	if (ret) {
+		dev_err(dev, "failed to disable regulator\n");
+		shid->regulator_error_count++;
+		shid->regulator_last_error = ret;
+	}
+	sysfs_remove_files(&dev->kobj, spi_hid_attributes);
+	spi_hid_stop_hid(shid);
+
+	return 0;
+}
+
+static const struct spi_device_id spi_hid_id_table[] = {
+	{ "hid", 0 },
+	{ "hid-over-spi", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_id_table);
+
+static struct spi_driver spi_hid_driver = {
+	.driver = {
+		.name	= "spi_hid",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spi_hid_of_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe		= spi_hid_probe,
+	.remove		= spi_hid_remove,
+	.id_table	= spi_hid_id_table,
+};
+
+module_spi_driver(spi_hid_driver);
+
+MODULE_DESCRIPTION("HID over SPI transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
new file mode 100644
index 000000000000..45cf3fd2b369
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ */
+
+#ifndef SPI_HID_CORE_H
+#define SPI_HID_CORE_H
+
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "spi-hid-of.h"
+
+/* Protocol constants */
+#define SPI_HID_READ_APPROVAL_CONSTANT		0xff
+#define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
+#define SPI_HID_INPUT_HEADER_VERSION		0x03
+#define SPI_HID_SUPPORTED_VERSION		0x0300
+
+/* Protocol message size constants */
+#define SPI_HID_READ_APPROVAL_LEN		5
+#define SPI_HID_INPUT_HEADER_LEN		4
+#define SPI_HID_INPUT_BODY_LEN			4
+#define SPI_HID_OUTPUT_HEADER_LEN		8
+#define SPI_HID_DEVICE_DESCRIPTOR_LENGTH	24
+
+/* Protocol message type constants */
+#define SPI_HID_INPUT_REPORT_TYPE_DATA				0x01
+#define SPI_HID_INPUT_REPORT_TYPE_RESET_RESP			0x03
+#define SPI_HID_INPUT_REPORT_TYPE_COMMAND_RESP			0x04
+#define SPI_HID_INPUT_REPORT_TYPE_GET_FEATURE_RESP		0x05
+#define SPI_HID_INPUT_REPORT_TYPE_DEVICE_DESC			0x07
+#define SPI_HID_INPUT_REPORT_TYPE_REPORT_DESC			0x08
+#define SPI_HID_INPUT_REPORT_TYPE_SET_FEATURE_RESP		0x09
+#define SPI_HID_INPUT_REPORT_TYPE_SET_OUTPUT_REPORT_RESP	0x0a
+#define SPI_HID_INPUT_REPORT_TYPE_GET_INPUT_REPORT_RESP		0x0b
+
+#define SPI_HID_OUTPUT_REPORT_TYPE_DEVICE_DESC_REQUEST	0x01
+#define SPI_HID_OUTPUT_REPORT_TYPE_REPORT_DESC_REQUEST	0x02
+#define SPI_HID_OUTPUT_REPORT_TYPE_HID_SET_FEATURE	0x03
+#define SPI_HID_OUTPUT_REPORT_TYPE_HID_GET_FEATURE	0x04
+#define SPI_HID_OUTPUT_REPORT_TYPE_HID_OUTPUT_REPORT	0x05
+#define SPI_HID_OUTPUT_REPORT_TYPE_INPUT_REPORT_REQUEST	0x06
+#define SPI_HID_OUTPUT_REPORT_TYPE_COMMAND		0x07
+
+#define SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST	0x00
+
+/* Power mode constants */
+#define SPI_HID_POWER_MODE_ON			0x01
+#define SPI_HID_POWER_MODE_SLEEP		0x02
+#define SPI_HID_POWER_MODE_OFF			0x03
+#define SPI_HID_POWER_MODE_WAKING_SLEEP		0x04
+
+/* Raw input buffer with data from the bus */
+struct spi_hid_input_buf {
+	u8 header[SPI_HID_INPUT_HEADER_LEN];
+	u8 body[SPI_HID_INPUT_BODY_LEN];
+	u8 content[SZ_8K];
+};
+
+/* Processed data from  input report header */
+struct spi_hid_input_header {
+	u8 version;
+	u16 report_length;
+	u8 last_fragment_flag;
+	u8 sync_const;
+};
+
+/* Processed data from input report body, excluding the content */
+struct spi_hid_input_body {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+};
+
+/* Processed data from an input report */
+struct spi_hid_input_report {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+	u8 *content;
+};
+
+/* Raw output report buffer to be put on the bus */
+struct spi_hid_output_buf {
+	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
+	u8 content[SZ_8K];
+};
+
+/* Data necessary to send an output report */
+struct spi_hid_output_report {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+	u8 *content;
+};
+
+/* Raw content in device descriptor */
+struct spi_hid_device_desc_raw {
+	__le16 wDeviceDescLength;
+	__le16 bcdVersion;
+	__le16 wReportDescLength;
+	__le16 wMaxInputLength;
+	__le16 wMaxOutputLength;
+	__le16 wMaxFragmentLength;
+	__le16 wVendorID;
+	__le16 wProductID;
+	__le16 wVersionID;
+	__le16 wFlags;
+	u8 reserved[4];
+} __packed;
+
+/* Processed data from a device descriptor */
+struct spi_hid_device_descriptor {
+	u16 hid_version;
+	u16 report_descriptor_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u8 no_output_report_ack;
+};
+
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;
+	struct hid_device	*hid;
+
+	struct spi_transfer	input_transfer[2];
+	struct spi_transfer	output_transfer;
+	struct spi_message	input_message;
+	struct spi_message	output_message;
+
+	struct spi_hid_of_config conf;
+	struct spi_hid_device_descriptor desc;
+	struct spi_hid_output_buf output;
+	struct spi_hid_input_buf input;
+	struct spi_hid_input_buf response;
+
+	u32 input_transfer_pending;
+
+	u8 power_state;
+
+	u8 attempts;
+
+	/*
+	 * ready flag indicates that the FW is ready to accept commands and
+	 * requests. The FW becomes ready after sending the report descriptor.
+	 */
+	bool ready;
+	/*
+	 * refresh_in_progress is set to true while the refresh_device worker
+	 * thread is destroying and recreating the hidraw device. When this flag
+	 * is set to true, the ll_close and ll_open functions will not cause
+	 * power state changes.
+	 */
+	bool refresh_in_progress;
+
+	bool irq_enabled;
+
+	struct work_struct reset_response_work;
+	struct work_struct create_device_work;
+	struct work_struct refresh_device_work;
+	struct work_struct error_work;
+
+	struct mutex output_lock;
+	struct mutex power_lock;
+	struct completion output_done;
+	struct completion ready_done;
+
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+
+	u32 report_descriptor_crc32;
+
+	u32 regulator_error_count;
+	int regulator_last_error;
+	u32 bus_error_count;
+	int bus_last_error;
+	u32 dir_count;
+};
+
+#endif
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
new file mode 100644
index 000000000000..d8d1d134cf29
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, Open Firmware related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ *
+ * This code was forked out of the HID over SPI core code, which is partially
+ * based on "HID over I2C protocol implementation:
+ *
+ * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ * Copyright (c) 2012 Red Hat, Inc
+ *
+ * which in turn is partially based on "USB HID support for Linux":
+ *
+ * Copyright (c) 1999 Andreas Gal
+ * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ * Copyright (c) 2007-2008 Oliver Neukum
+ * Copyright (c) 2006-2010 Jiri Kosina
+ */
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+
+#include "spi-hid-core.h"
+
+int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				struct device *dev)
+{
+	int ret;
+	u32 val;
+
+	ret = device_property_read_u32(dev, "input-report-header-address",
+									&val);
+	if (ret) {
+		dev_err(dev, "Input report header address not provided\n");
+		return -ENODEV;
+	}
+	conf->input_report_header_address = val;
+
+	ret = device_property_read_u32(dev, "input-report-body-address", &val);
+	if (ret) {
+		dev_err(dev, "Input report body address not provided\n");
+		return -ENODEV;
+	}
+	conf->input_report_body_address = val;
+
+	ret = device_property_read_u32(dev, "output-report-address", &val);
+	if (ret) {
+		dev_err(dev, "Output report address not provided\n");
+		return -ENODEV;
+	}
+	conf->output_report_address = val;
+
+	ret = device_property_read_u32(dev, "read-opcode", &val);
+	if (ret) {
+		dev_err(dev, "Read opcode not provided\n");
+		return -ENODEV;
+	}
+	conf->read_opcode = val;
+
+	ret = device_property_read_u32(dev, "write-opcode", &val);
+	if (ret) {
+		dev_err(dev, "Write opcode not provided\n");
+		return -ENODEV;
+	}
+	conf->write_opcode = val;
+
+	ret = device_property_read_u32(dev, "post-power-on-delay-ms", &val);
+	if (ret) {
+		dev_err(dev, "post-power-on-delay-ms not provided, using 10\n");
+		val = 10;
+	}
+	conf->post_power_on_delay_ms = val;
+
+	ret = device_property_read_u32(dev, "minimal-reset-delay-ms", &val);
+	if (ret) {
+		dev_err(dev, "minimal-reset-delay-ms not provided, using 100\n");
+		val = 100;
+	}
+	conf->minimal_reset_delay_ms = val;
+
+	/* FIXME: not reading hid-over-spi-flags, multi-SPI not supported */
+
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply)) {
+		if (PTR_ERR(conf->supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get regulator: %ld\n",
+					PTR_ERR(conf->supply));
+		return PTR_ERR(conf->supply);
+	}
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(conf->reset_gpio)) {
+		dev_err(dev, "%s: error getting reset GPIO\n", __func__);
+		return PTR_ERR(conf->reset_gpio);
+	}
+
+	return 0;
+}
+
+int spi_hid_of_power_down(struct spi_hid_of_config *conf)
+{
+	if (regulator_is_enabled(conf->supply) == 0)
+		return 0;
+
+	return regulator_disable(conf->supply);
+}
+
+int spi_hid_of_power_up(struct spi_hid_of_config *conf)
+{
+	int ret;
+
+	if (regulator_is_enabled(conf->supply) > 0)
+		return 0;
+
+	ret = regulator_enable(conf->supply);
+
+	usleep_range(1000 * conf->post_power_on_delay_ms,
+			1000 * (conf->post_power_on_delay_ms + 1));
+
+	return ret;
+}
+
+void spi_hid_of_assert_reset(struct spi_hid_of_config *conf)
+{
+	gpiod_set_value(conf->reset_gpio, 1);
+}
+
+void spi_hid_of_deassert_reset(struct spi_hid_of_config *conf)
+{
+	gpiod_set_value(conf->reset_gpio, 0);
+}
+
+void spi_hid_of_sleep_minimal_reset_delay(struct spi_hid_of_config *conf)
+{
+	usleep_range(1000 * conf->minimal_reset_delay_ms,
+			1000 * (conf->minimal_reset_delay_ms + 1));
+}
diff --git a/drivers/hid/spi-hid/spi-hid-of.h b/drivers/hid/spi-hid/spi-hid-of.h
new file mode 100644
index 000000000000..48d9dfe44e95
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ */
+
+#ifndef SPI_HID_OF_H
+#define SPI_HID_OF_H
+
+/* Config structure is filled with data from Device Tree */
+struct spi_hid_of_config {
+	u32 input_report_header_address;
+	u32 input_report_body_address;
+	u32 output_report_address;
+	u8 read_opcode;
+	u8 write_opcode;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+};
+
+int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				struct device *dev);
+int spi_hid_of_power_down(struct spi_hid_of_config *conf);
+int spi_hid_of_power_up(struct spi_hid_of_config *conf);
+void spi_hid_of_assert_reset(struct spi_hid_of_config *conf);
+void spi_hid_of_deassert_reset(struct spi_hid_of_config *conf);
+void spi_hid_of_sleep_minimal_reset_delay(struct spi_hid_of_config *conf);
+
+#endif
diff --git a/drivers/hid/spi-hid/spi-hid_trace.h b/drivers/hid/spi-hid/spi-hid_trace.h
new file mode 100644
index 000000000000..23732ba493a0
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid_trace.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_hid
+
+#if !defined(_SPI_HID_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SPI_HID_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include "spi-hid-core.h"
+
+DECLARE_EVENT_CLASS(spi_hid_transfer,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, len)
+		__field(int, ret)
+		__dynamic_array(u8, rx_buf, rx_len)
+		__dynamic_array(u8, tx_buf, tx_len)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->len = rx_len + tx_len;
+		__entry->ret = ret;
+
+		memcpy(__get_dynamic_array(tx_buf), tx_buf, tx_len);
+		memcpy(__get_dynamic_array(rx_buf), rx_buf, rx_len);
+	),
+
+	TP_printk("spi%d.%d: len=%d tx=[%*phD] rx=[%*phD] --> %d",
+		__entry->bus_num, __entry->chip_select, __entry->len,
+		__get_dynamic_array_len(tx_buf), __get_dynamic_array(tx_buf),
+		__get_dynamic_array_len(rx_buf), __get_dynamic_array(rx_buf),
+		__entry->ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_sync,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_header_complete,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_body_complete,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_output_begin,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_output_end,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+			const void *rx_buf, u16 rx_len, int ret),
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret)
+);
+
+DECLARE_EVENT_CLASS(spi_hid_irq,
+	TP_PROTO(struct spi_hid *shid, int irq),
+
+	TP_ARGS(shid, irq),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, irq)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->irq = irq;
+	),
+
+	TP_printk("spi%d.%d: IRQ %d",
+		__entry->bus_num, __entry->chip_select, __entry->irq)
+);
+
+DEFINE_EVENT(spi_hid_irq, spi_hid_dev_irq,
+	TP_PROTO(struct spi_hid *shid, int irq),
+	TP_ARGS(shid, irq)
+);
+
+DECLARE_EVENT_CLASS(spi_hid,
+	TP_PROTO(struct spi_hid *shid),
+
+	TP_ARGS(shid),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, power_state)
+		__field(bool, ready)
+
+		__field(int, vendor_id)
+		__field(int, product_id)
+		__field(int, max_input_length)
+		__field(int, max_output_length)
+		__field(u16, hid_version)
+		__field(u16, report_descriptor_length)
+		__field(u16, version_id)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->power_state = shid->power_state;
+		__entry->ready = shid->ready;
+
+		__entry->vendor_id = shid->desc.vendor_id;
+		__entry->product_id = shid->desc.product_id;
+		__entry->max_input_length = shid->desc.max_input_length;
+		__entry->max_output_length = shid->desc.max_output_length;
+		__entry->hid_version = shid->desc.hid_version;
+		__entry->report_descriptor_length =
+					shid->desc.report_descriptor_length;
+		__entry->version_id = shid->desc.version_id;
+	),
+
+	TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d len i:%d o:%d r:%d flags %c",
+		__entry->bus_num, __entry->chip_select, __entry->vendor_id,
+		__entry->product_id, __entry->version_id,
+		__entry->hid_version >> 8, __entry->hid_version & 0xff,
+		__entry->power_state,	__entry->max_input_length,
+		__entry->max_output_length, __entry->report_descriptor_length,
+		__entry->ready ? 'R' : 'r')
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_header_transfer,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_process_input_report,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_input_report_handler,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_reset_response_work,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_create_device_work,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_refresh_device_work,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_response_handler,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_error_work,
+	TP_PROTO(struct spi_hid *shid),
+	TP_ARGS(shid)
+);
+
+#endif /* _SPI_HID_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE spi-hid_trace
+#include <trace/define_trace.h>
diff --git a/drivers/hid/spi-hid/trace.c b/drivers/hid/spi-hid/trace.c
new file mode 100644
index 000000000000..6cd686c9493e
--- /dev/null
+++ b/drivers/hid/spi-hid/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ *
+ * Author: Felipe Balbi <felipe.balbi@microsoft.com>
+ */
+
+#define CREATE_TRACE_POINTS
+#include "spi-hid_trace.h"
-- 
2.25.1

