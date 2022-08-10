Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2058F3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiHJUp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiHJUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:45:18 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0221D31C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:45:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso10440568otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dMcktl1QXrQAu4/lxweJmgGTRoL5J5XiIsn76k36QrA=;
        b=jItK5DhkxS9JwW9BxVt6w130JsHuD7G3/9fdDOaLd7KFnb2va6uV6QUYEwkCM5mh/Q
         MI0pY6eFOfJG37CwEj5huPQN8PbdHyptxwYvUZ66pUkqV0SUQNFrleGzqS3veUmwBRe7
         /8jxVYn/XnEifJClw8L+dG+w7plF/pPDJCnnRQsCggqn25MoCIau+yVYb2vB13D8vHKR
         e2tSdmmdP0CnE6hxaG0XFe0fCHJB7RBqSCNVVFKL5rHt2vT4igXP0RYrj3OTefudDhug
         9KNcP7cEzEb9eCNcG0n/6U1IobXObM9sZo1HXNdykzX/4CADxpx+jWqWtW/ga2EZqNjg
         +A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dMcktl1QXrQAu4/lxweJmgGTRoL5J5XiIsn76k36QrA=;
        b=MdfTE5UYj1OHILTSZbgMGEJb1i2zi86RNzlrzOLuux4auEccW8Sat2GpoEXBz4E1T9
         Po5/1bB4jEGZIg3TOYbqXgw9Oo7fBf6UpHEBBiBLlz27Re9gbpWBxQwJG5og/MUcRlbA
         dZqjcKt5KYzQ9SIzfYlqXLyLAYJB5A9/bN5qgmeGto1uJwrVlIpLtPoaWZql4fDifoh5
         sohuAUR0vHlJy2+Cm6QEUhsjEBou0MtJBQSjPN0vALU6aQiOeU3q/Nby4TFxt9sWB4I3
         RJIyBaPSmEJERvq4QVB4el9cT47FqlYOkpckZ0L56/scdkHAYozGsd8tPvIVbdeF6elo
         x3SA==
X-Gm-Message-State: ACgBeo2OzAElUzu6+WmXoT8p87Bs2gWLXuDi9UafBtA3gCRySBSMks5S
        S2hzjWxAJ8A5OIpmCL1STgfrY7Sv6R30NQ==
X-Google-Smtp-Source: AA6agR5qnj51lBYmtlv62UVEk/P8fwZKAXmcs/gkZnrofJrOCcC8VPx2S+L/RUq/faJKOTZUYGwdNg==
X-Received: by 2002:a9d:4d13:0:b0:636:bdd9:b57b with SMTP id n19-20020a9d4d13000000b00636bdd9b57bmr8751953otf.26.1660164315819;
        Wed, 10 Aug 2022 13:45:15 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f12-20020a056870548c00b000f2455e26acsm3968218oan.48.2022.08.10.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 13:45:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: mux: Introduce GPIO-based SBU mux
Date:   Wed, 10 Aug 2022 13:47:50 -0700
Message-Id: <20220810204750.3672362-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A design found in various Qualcomm-based boards is to use a USB switch,
controlled through a pair of GPIO lines to connect, disconnect and
switch the orientation of the SBU lines in USB Type-C applications.

This introduces a generic driver, which implements the typec_switch and
typec_mux interfaces to perform these operations.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/typec/mux/Kconfig        |   6 +
 drivers/usb/typec/mux/Makefile       |   1 +
 drivers/usb/typec/mux/gpio-sbu-mux.c | 171 +++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/usb/typec/mux/gpio-sbu-mux.c

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 5eb2c17d72c1..c46fa4f9d3df 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -12,6 +12,12 @@ config TYPEC_MUX_FSA4480
 	  common USB Type-C connector.
 	  If compiled as a module, the module will be named fsa4480.
 
+config TYPEC_MUX_GPIO_SBU
+	tristate "Generic GPIO based SBU mux for USB Type-C applications"
+	help
+	  Say Y or M if your system uses a GPIO based mux for managing the
+	  connected state and the swapping of the SBU lines in a Type-C port.
+
 config TYPEC_MUX_PI3USB30532
 	tristate "Pericom PI3USB30532 Type-C cross switch driver"
 	depends on I2C
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index e52a56c16bfb..dda67e19b58b 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
+obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
new file mode 100644
index 000000000000..35f7bd3029a9
--- /dev/null
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+
+struct gpio_sbu_mux {
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *select_gpio;
+
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
+
+	struct mutex lock; /* protect enabled and swapped */
+	bool enabled;
+	bool swapped;
+};
+
+static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
+			       enum typec_orientation orientation)
+{
+	struct gpio_sbu_mux *sbu_mux = typec_switch_get_drvdata(sw);
+	bool enabled;
+	bool swapped;
+
+	mutex_lock(&sbu_mux->lock);
+
+	enabled = sbu_mux->enabled;
+
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+		enabled = false;
+		break;
+	case TYPEC_ORIENTATION_NORMAL:
+		swapped = false;
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		swapped = true;
+		break;
+	}
+
+	if (enabled != sbu_mux->enabled)
+		gpiod_set_value(sbu_mux->enable_gpio, enabled);
+
+	if (swapped != sbu_mux->swapped)
+		gpiod_set_value(sbu_mux->select_gpio, swapped);
+
+	sbu_mux->enabled = enabled;
+	sbu_mux->swapped = swapped;
+
+	mutex_unlock(&sbu_mux->lock);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
+			    struct typec_mux_state *state)
+{
+	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
+
+	mutex_lock(&sbu_mux->lock);
+
+	switch (state->mode) {
+	case TYPEC_STATE_SAFE:
+	case TYPEC_STATE_USB:
+		sbu_mux->enabled = false;
+		break;
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_E:
+		sbu_mux->enabled = true;
+		break;
+	default:
+		break;
+	}
+
+	gpiod_set_value(sbu_mux->enable_gpio, sbu_mux->enabled);
+
+	mutex_unlock(&sbu_mux->lock);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_probe(struct platform_device *pdev)
+{
+	struct typec_switch_desc sw_desc = { };
+	struct typec_mux_desc mux_desc = { };
+	struct device *dev = &pdev->dev;
+	struct gpio_sbu_mux *sbu_mux;
+
+	sbu_mux = devm_kzalloc(dev, sizeof(*sbu_mux), GFP_KERNEL);
+	if (!sbu_mux)
+		return -ENOMEM;
+
+	mutex_init(&sbu_mux->lock);
+
+	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(sbu_mux->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
+				     "unable to acquire enable gpio\n");
+
+	sbu_mux->select_gpio = devm_gpiod_get(dev, "select", GPIOD_OUT_LOW);
+	if (IS_ERR(sbu_mux->select_gpio))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->select_gpio),
+				     "unable to acquire select gpio\n");
+
+	sw_desc.drvdata = sbu_mux;
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.set = gpio_sbu_switch_set;
+
+	sbu_mux->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(sbu_mux->sw))
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->sw),
+				     "failed to register typec switch\n");
+
+	mux_desc.drvdata = sbu_mux;
+	mux_desc.fwnode = dev_fwnode(dev);
+	mux_desc.set = gpio_sbu_mux_set;
+
+	sbu_mux->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(sbu_mux->mux)) {
+		typec_switch_unregister(sbu_mux->sw);
+		return dev_err_probe(dev, PTR_ERR(sbu_mux->mux),
+				     "failed to register typec mux\n");
+	}
+
+	platform_set_drvdata(pdev, sbu_mux);
+
+	return 0;
+}
+
+static int gpio_sbu_mux_remove(struct platform_device *pdev)
+{
+	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
+
+	gpiod_set_value(sbu_mux->enable_gpio, 0);
+
+	typec_mux_unregister(sbu_mux->mux);
+	typec_switch_unregister(sbu_mux->sw);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_sbu_mux_match[] = {
+	{ .compatible = "gpio-sbu-mux", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gpio_sbu_mux_match);
+
+static struct platform_driver gpio_sbu_mux_driver = {
+	.probe = gpio_sbu_mux_probe,
+	.remove = gpio_sbu_mux_remove,
+	.driver = {
+		.name = "gpio_sbu_mux",
+		.of_match_table = gpio_sbu_mux_match,
+	},
+};
+module_platform_driver(gpio_sbu_mux_driver);
+
+MODULE_DESCRIPTION("GPIO based SBU mux driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

