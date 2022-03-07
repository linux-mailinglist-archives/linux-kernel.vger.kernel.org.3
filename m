Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B584CF077
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiCGDkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiCGDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:39:54 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D94DF5A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:39:01 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w127so3489350oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=49L7WLNCDMugCqX6fsdECZs0GVJID2sbYVWyG32rCpw=;
        b=Tx6KfbiJuFYkqkl/CBjrqJFb7VDjM4fGn5H8eUrcLSVrmbTKPX5aQ/BbdiItNh4Tcg
         VT3gFp3QPX9XEIesM1Le8LEflQITkEkS1ok7D805kIWtS5FW7EEFqhTv+ITH1XGWgvk9
         8yuy64GDDIhUaqwpxz7DkdEGOAppZ7w6rBVvTrIzvsiacOZrYuV5qdX887U0Wd0/4omZ
         nCBlw1sUhs6W3qU+8ZroPS+cDLCQ82V+azMrIeirUZvIqIE64Cn0LdbjSrP1lactiY0C
         qcOCeMozci+AGvRIqr73XxGoVdETpWz/3336A4evyzAdr8MnU8EsBwLbP8TXSztwxVYs
         0LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=49L7WLNCDMugCqX6fsdECZs0GVJID2sbYVWyG32rCpw=;
        b=HKqM29TKCCBbaO6MOmtnOoRySHvlarvsAcTWsKnZIPG+mHzq30IFCdGTNZcYh0RH4M
         gp+XrFi5+lchr0Uodz4mwv977Uq3wdVmGbsfW9pioeKatEh7AzKsOuSYiCdRA9NN49G2
         yExBJcVUKyaK6CPnX8IPsLIxdzsXTo2fDpZ2QYuoMn5yC1BEh4puKWG0/fDd0lh6J6yq
         eBngRK43P+zgdTxhZk6uExhaKdCRTNJS52UyuZyep8KF/uKgOVMvIHkINANd2xlH1w5X
         XzYw4m2tp4xHPk2nTGuB/peeJkA3YWT9eVt9WGm5xsgPax0S9kSm/FA8OMPig1srHZz8
         dF7g==
X-Gm-Message-State: AOAM531U5WYwboth5SR/gNhWs0KQJhB2f6N1Mvi6GwWVI3Ige8VfctVf
        +8OMmn+i9WJe0I0fWIgVUpD57w==
X-Google-Smtp-Source: ABdhPJyX2BXF3WJ65qS0nhgl/lTvKjLYe+ljR3L17V/GVwnZXMDGrtI5cuhIRDfC5MxwA0yIA+9Cmg==
X-Received: by 2002:a05:6808:2022:b0:2d4:752b:dfb5 with SMTP id q34-20020a056808202200b002d4752bdfb5mr5841086oiw.174.1646624340640;
        Sun, 06 Mar 2022 19:39:00 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5005172oak.12.2022.03.06.19.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:39:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 7/7] usb: typec: mux: Add On Semi fsa4480 driver
Date:   Sun,  6 Mar 2022 19:40:40 -0800
Message-Id: <20220307034040.1111107-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
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

The ON Semiconductor FSA4480 is a USB Type-C port multimedia switch with
support for analog audio headsets. It allows sharing a common USB Type-C
port to pass USB2.0 signal, analog audio, sideband use wires and analog
microphone signal.

Due to lacking upstream audio support for testing, the audio muxing is
left untouched, but implementation of muxing the SBU lines is provided
as a pair of Type-C mux and switch devices. This provides the necessary
support for enabling the DisplayPort altmode on devices with this
circuit.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None

Changes since v2:
- Expanded Kconfig help text.
- Fixed copyright year
- Fixed spelling mistakes in comments
- Introduce FSA4480_MAX_REGISTER
- Use dev_err_probe()
- Removed some useless blank lines.

Changes since v1:
- None

 drivers/usb/typec/mux/Kconfig   |  10 ++
 drivers/usb/typec/mux/Makefile  |   1 +
 drivers/usb/typec/mux/fsa4480.c | 216 ++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/usb/typec/mux/fsa4480.c

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index edead555835e..5eb2c17d72c1 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -2,6 +2,16 @@
 
 menu "USB Type-C Multiplexer/DeMultiplexer Switch support"
 
+config TYPEC_MUX_FSA4480
+	tristate "ON Semi FSA4480 Analog Audio Switch driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Driver for the ON Semiconductor FSA4480 Analog Audio Switch, which
+	  provides support for muxing analog audio and sideband signals on a
+	  common USB Type-C connector.
+	  If compiled as a module, the module will be named fsa4480.
+
 config TYPEC_MUX_PI3USB30532
 	tristate "Pericom PI3USB30532 Type-C cross switch driver"
 	depends on I2C
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index 280a6f553115..e52a56c16bfb 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
new file mode 100644
index 000000000000..ab8d014a6b79
--- /dev/null
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2022 Linaro Ltd.
+ * Copyright (C) 2018-2020 The Linux Foundation
+ */
+
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+
+#define FSA4480_SWITCH_ENABLE	0x04
+#define FSA4480_SWITCH_SELECT	0x05
+#define FSA4480_SWITCH_STATUS1	0x07
+#define FSA4480_SLOW_L		0x08
+#define FSA4480_SLOW_R		0x09
+#define FSA4480_SLOW_MIC	0x0a
+#define FSA4480_SLOW_SENSE	0x0b
+#define FSA4480_SLOW_GND	0x0c
+#define FSA4480_DELAY_L_R	0x0d
+#define FSA4480_DELAY_L_MIC	0x0e
+#define FSA4480_DELAY_L_SENSE	0x0f
+#define FSA4480_DELAY_L_AGND	0x10
+#define FSA4480_RESET		0x1e
+#define FSA4480_MAX_REGISTER	0x1f
+
+#define FSA4480_ENABLE_DEVICE	BIT(7)
+#define FSA4480_ENABLE_SBU	GENMASK(6, 5)
+#define FSA4480_ENABLE_USB	GENMASK(4, 3)
+
+#define FSA4480_SEL_SBU_REVERSE	GENMASK(6, 5)
+#define FSA4480_SEL_USB		GENMASK(4, 3)
+
+struct fsa4480 {
+	struct i2c_client *client;
+
+	/* used to serialize concurrent change requests */
+	struct mutex lock;
+
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
+
+	struct regmap *regmap;
+
+	u8 cur_enable;
+	u8 cur_select;
+};
+
+static const struct regmap_config fsa4480_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FSA4480_MAX_REGISTER,
+};
+
+static int fsa4480_switch_set(struct typec_switch_dev *sw,
+			      enum typec_orientation orientation)
+{
+	struct fsa4480 *fsa = typec_switch_get_drvdata(sw);
+	u8 new_sel;
+
+	mutex_lock(&fsa->lock);
+	new_sel = FSA4480_SEL_USB;
+	if (orientation == TYPEC_ORIENTATION_REVERSE)
+		new_sel |= FSA4480_SEL_SBU_REVERSE;
+
+	if (new_sel == fsa->cur_select)
+		goto out_unlock;
+
+	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
+		/* Disable SBU output while re-configuring the switch */
+		regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE,
+			     fsa->cur_enable & ~FSA4480_ENABLE_SBU);
+
+		/* 35us to allow the SBU switch to turn off */
+		usleep_range(35, 1000);
+	}
+
+	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, new_sel);
+	fsa->cur_select = new_sel;
+
+	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
+		regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
+
+		/* 15us to allow the SBU switch to turn on again */
+		usleep_range(15, 1000);
+	}
+
+out_unlock:
+	mutex_unlock(&fsa->lock);
+
+	return 0;
+}
+
+static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
+{
+	struct fsa4480 *fsa = typec_mux_get_drvdata(mux);
+	u8 new_enable;
+
+	mutex_lock(&fsa->lock);
+
+	new_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
+	if (state->mode >= TYPEC_DP_STATE_A)
+		new_enable |= FSA4480_ENABLE_SBU;
+
+	if (new_enable == fsa->cur_enable)
+		goto out_unlock;
+
+	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, new_enable);
+	fsa->cur_enable = new_enable;
+
+	if (new_enable & FSA4480_ENABLE_SBU) {
+		/* 15us to allow the SBU switch to turn off */
+		usleep_range(15, 1000);
+	}
+
+out_unlock:
+	mutex_unlock(&fsa->lock);
+
+	return 0;
+}
+
+static int fsa4480_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_mux_desc mux_desc = { };
+	struct fsa4480 *fsa;
+
+	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
+	if (!fsa)
+		return -ENOMEM;
+
+	fsa->client = client;
+	mutex_init(&fsa->lock);
+
+	fsa->regmap = devm_regmap_init_i2c(client, &fsa4480_regmap_config);
+	if (IS_ERR(fsa->regmap))
+		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
+
+	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
+	fsa->cur_select = FSA4480_SEL_USB;
+
+	/* set default settings */
+	regmap_write(fsa->regmap, FSA4480_SLOW_L, 0x00);
+	regmap_write(fsa->regmap, FSA4480_SLOW_R, 0x00);
+	regmap_write(fsa->regmap, FSA4480_SLOW_MIC, 0x00);
+	regmap_write(fsa->regmap, FSA4480_SLOW_SENSE, 0x00);
+	regmap_write(fsa->regmap, FSA4480_SLOW_GND, 0x00);
+	regmap_write(fsa->regmap, FSA4480_DELAY_L_R, 0x00);
+	regmap_write(fsa->regmap, FSA4480_DELAY_L_MIC, 0x00);
+	regmap_write(fsa->regmap, FSA4480_DELAY_L_SENSE, 0x00);
+	regmap_write(fsa->regmap, FSA4480_DELAY_L_AGND, 0x09);
+	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, fsa->cur_select);
+	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
+
+	sw_desc.drvdata = fsa;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = fsa4480_switch_set;
+
+	fsa->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(fsa->sw))
+		return dev_err_probe(dev, PTR_ERR(fsa->sw), "failed to register typec switch\n");
+
+	mux_desc.drvdata = fsa;
+	mux_desc.fwnode = dev->fwnode;
+	mux_desc.set = fsa4480_mux_set;
+
+	fsa->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(fsa->mux)) {
+		typec_switch_unregister(fsa->sw);
+		return dev_err_probe(dev, PTR_ERR(fsa->mux), "failed to register typec mux\n");
+	}
+
+	i2c_set_clientdata(client, fsa);
+	return 0;
+}
+
+static int fsa4480_remove(struct i2c_client *client)
+{
+	struct fsa4480 *fsa = i2c_get_clientdata(client);
+
+	typec_mux_unregister(fsa->mux);
+	typec_switch_unregister(fsa->sw);
+
+	return 0;
+}
+
+static const struct i2c_device_id fsa4480_table[] = {
+	{ "fsa4480" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fsa4480_table);
+
+static const struct of_device_id fsa4480_of_table[] = {
+	{ .compatible = "fcs,fsa4480" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fsa4480_of_table);
+
+static struct i2c_driver fsa4480_driver = {
+	.driver = {
+		.name = "fsa4480",
+		.of_match_table = fsa4480_of_table,
+	},
+	.probe_new	= fsa4480_probe,
+	.remove		= fsa4480_remove,
+	.id_table	= fsa4480_table,
+};
+module_i2c_driver(fsa4480_driver);
+
+MODULE_DESCRIPTION("ON Semiconductor FSA4480 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1

