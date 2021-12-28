Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBA480654
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhL1FUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhL1FUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:20:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11146C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:24 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j124so28410111oih.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VN6g2mXvfM1KCsUt0asBDpDPGoZHaGgVVhC+vigu24g=;
        b=p3XsuBH5Ce+4XFxnUxDm5VhCHRNFmrL5SaMVH97RiQELYCAVjcUVXrtdL1H/IYGGPg
         QUVBViJiXyUF2G8BlpVkvwfCdFYf00fwIiqcAwlVzzwHghOYVC2WoG4Ly2wX2VlLHZzD
         RRG1qHfZDbJGMSRLiRVOBCvCu6NLySe/ZQNC+CWHkbhMKu6tgzfCZvDLpLRx8sFVrToy
         NA1cREOjgLEC2sImrGGz7h3BMI41jeYk9PnI89jbiotXiRZHzt2qMRXMCg4QXjf7mp91
         rbz6eFl7rsGH69J0bX4/cHzpZEgB5iKPCRSw9tZMhB+EymL81IHLta5bQsEg7zT4+899
         jc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VN6g2mXvfM1KCsUt0asBDpDPGoZHaGgVVhC+vigu24g=;
        b=SDSizQ0XIiimcno7sbYVUp3w0Z+POINfsL8K/7vzQG/MKNS8yNJGd75m79APTTd/b5
         oqW3gyxyPkpMUbPGclYmd0hnCPUzez0dP4/CbqIpoyOF/3ATCvmWQx0mgGz+A5efq/hx
         SVvP8E7RZvjI13pW3+L0ExlAWKSlFlk0f0TI6PclqZugfETWps/TODY5rSJ4DyYes2uK
         ERDkNOoEfsb5P2Nh3HxsCzCZk6SnpMFuq8Der0J1G62NNblbs0YvtTR0uS87eXUS77Mu
         5VjFgPkuyIoql19TuBkZRNjUg2VamtOFM8I6MZMESFreSB6ae3mTrVKAALdxCW8/42IM
         Oceg==
X-Gm-Message-State: AOAM533UW2EY/x9ONy7zs6iF1XXzUETyZwkyRv6Jv/xq4JsYc13sTqCE
        d7IJ5w7ZPusckLLDSsSMom5BeA==
X-Google-Smtp-Source: ABdhPJxkRBJpLMaoG851Ug1pzt6f1LSJsisYbH6ezhVt++Ag/ATsiBQjESXSx28m+PmGh+VY+SBdAA==
X-Received: by 2002:a05:6808:2309:: with SMTP id bn9mr15021540oib.42.1640668823417;
        Mon, 27 Dec 2021 21:20:23 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j5sm3002277oou.23.2021.12.27.21.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 21:20:23 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 8/8] usb: typec: mux: Add On Semi fsa4480 driver
Date:   Mon, 27 Dec 2021 21:21:16 -0800
Message-Id: <20211228052116.1748443-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ON Semiconductor FSA4480 is a USB Type-C port multimedia switch with
support for analog audio headsets. It allows sharing a common USB Type-C
port to pass USB2.0 signal, analog audio, sideband use wires and analog
microphone signal.

Due to lacking upstream audio support for testing, the audio muxing is
left untouched, but implementation of muxing the SBU lines is provided
as a pair of TypeC mux and switch devices. This provides the necessary
support for enabling the DisplayPort altmode on devices with this
circuit.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/typec/mux/Kconfig   |   9 ++
 drivers/usb/typec/mux/Makefile  |   1 +
 drivers/usb/typec/mux/fsa4480.c | 220 ++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/usb/typec/mux/fsa4480.c

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index edead555835e..5e20112c3f51 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -2,6 +2,15 @@
 
 menu "USB Type-C Multiplexer/DeMultiplexer Switch support"
 
+config TYPEC_MUX_FSA4480
+	tristate "ON Semi FSA4480 Analog Audio Switch driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Driver for the ON Semiconductor FSA4480 Analog Audio Switch, which
+	  provides support for muxing analog audio and sideband signals on a
+	  common USB Type-C connector.
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
index 000000000000..ac2d8648db6a
--- /dev/null
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Copyright (C) 2018-2020 The Linux Foundation
+ */
+
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
+	/* used to serialize concurrect change requests */
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
+	.max_register = FSA4480_RESET,
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
+	if (IS_ERR(fsa->regmap)) {
+		dev_err(dev, "failed to initialize regmap\n");
+		return PTR_ERR(fsa->regmap);
+	}
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
+	if (IS_ERR(fsa->sw)) {
+		dev_err(dev, "failed to register typec switch: %ld\n", PTR_ERR(fsa->sw));
+		return PTR_ERR(fsa->sw);
+	}
+
+	mux_desc.drvdata = fsa;
+	mux_desc.fwnode = dev->fwnode;
+	mux_desc.set = fsa4480_mux_set;
+
+	fsa->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(fsa->mux)) {
+		typec_switch_unregister(fsa->sw);
+		dev_err(dev, "failed to register typec mux: %ld\n", PTR_ERR(fsa->mux));
+		return PTR_ERR(fsa->mux);
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
+
+module_i2c_driver(fsa4480_driver);
+
+MODULE_DESCRIPTION("ON Semiconductor FSA4480 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1

