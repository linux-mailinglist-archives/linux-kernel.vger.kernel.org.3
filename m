Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA8592BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiHOJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbiHOJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:02:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BAF2126E;
        Mon, 15 Aug 2022 02:02:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so6039718pgb.4;
        Mon, 15 Aug 2022 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YxtlsjuQ7jTdutXjJizluXBc5+9WLkbOgzJagCR+62Y=;
        b=icZ7E7ZDumxIIhjv6ctLS6uP/+T1O/1OwSc61ZjvA0J1k2ubuU8bWjcJHR8Cq7VF9w
         YR29OprILy+0WT0Z0yQYK2cKeUALJULIsFSY0/XGQpQUlPySVXHySBJjVBF+fv4TorZg
         Njl8ZbMVdNXIZ23hiuWMjcj1M2riIrvQTnyPbr96JjPeJEwwuZFPVw+Lz9v1agvGDz4H
         t6HK42ZKAGDN2Eq4QEPxCLBsKQmlflILO+sRgrIr3r660ploCAGeQ6CDgObdNXehFcFP
         b8WYMw4txxS37VQOPfEJdJhp1W4llQ3bTYOIaiJWgPo+d7hxGboYpb+oxfTOYBF3hiu/
         NjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YxtlsjuQ7jTdutXjJizluXBc5+9WLkbOgzJagCR+62Y=;
        b=dJVnfDUgEz+aJI3uRQvRyZ/FhNAvlm20Kc39YQ8tUfS2WsmHPQR6fA5AYRKGUq61C3
         gyAEJfHDKMLOA6R7DU2cuCwPUJYL3BjdZ2AQkd0uw4JR+789VAZBKWhbXjGxhbSb09Si
         FjIbztmUyDCAJ6V/lIYzkHAcv6HrO8Q2zn+RYCffJyqxQNrit8c0Dwa5yK7F6Ev/ghoo
         tRgYW5zkcSAF3i7aNFVfjieeXchEyQ8Aax0z0hXE7EYFdyfRwOfbOpDMBuP6wUM0P0ir
         1xiJDLJj5JGTfazMXrO/i4uOt4rGvlBcN3KhVc1tT3eSc3yyYMVwxs+O+3ZewrYf9D29
         CtWQ==
X-Gm-Message-State: ACgBeo3iEajHz7j0ip0achEGZVae7jKPv7FPIKapzof0lWbO6Dz5dRjW
        0O/aG4uWV1Qi8sVKBxliXT8=
X-Google-Smtp-Source: AA6agR5RbPBN0nNQXIQZDEuPOHfGfRcawwH4f6GR3AXNeFvtAVErETXd+CQZ3U7YdHLNiUXSOCMksA==
X-Received: by 2002:a05:6a00:1a49:b0:528:6ea0:14e2 with SMTP id h9-20020a056a001a4900b005286ea014e2mr15210498pfv.22.1660554163220;
        Mon, 15 Aug 2022 02:02:43 -0700 (PDT)
Received: from DESKTOP-IBN2BAQ.localdomain ([123.110.155.185])
        by smtp.gmail.com with ESMTPSA id a17-20020a656411000000b00412a708f38asm5491612pgv.35.2022.08.15.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:02:42 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com, lgirdwood@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RESEND PATCH v8 07/12] usb: typec: tcpci_mt6370: Add MediaTek MT6370 tcpci driver
Date:   Mon, 15 Aug 2022 17:01:20 +0800
Message-Id: <20220815090125.27705-8-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220815090125.27705-1-peterwu.pub@gmail.com>
References: <20220815090125.27705-1-peterwu.pub@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

The MediaTek MT6370 is a highly-integrated smart power management IC,
which includes a single cell Li-Ion/Li-Polymer switching battery
charger, a USB Type-C & Power Delivery (PD) controller, dual
Flash LED current sources, a RGB LED driver, a backlight WLED driver,
a display bias driver and a general LDO for portable devices.

Add support for the Type-C & Power Delivery controller in
MediaTek MT6370 IC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 drivers/usb/typec/tcpm/Kconfig        |  11 ++
 drivers/usb/typec/tcpm/Makefile       |   1 +
 drivers/usb/typec/tcpm/tcpci_mt6370.c | 207 ++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 073fd2ea5e0b..e6b88ca4a4b9 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -35,6 +35,17 @@ config TYPEC_MT6360
 	  USB Type-C. It works with Type-C Port Controller Manager
 	  to provide USB PD and USB Type-C functionalities.
 
+config TYPEC_TCPCI_MT6370
+	tristate "MediaTek MT6370 Type-C driver"
+	depends on MFD_MT6370
+	help
+	  MediaTek MT6370 is a multi-functional IC that includes
+	  USB Type-C. It works with Type-C Port Controller Manager
+	  to provide USB PD and USB Type-C functionalities.
+
+	  This driver can also be built as a module. The module
+	  will be called "tcpci_mt6370".
+
 config TYPEC_TCPCI_MAXIM
 	tristate "Maxim TCPCI based Type-C chip driver"
 	help
diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
index 7d499f3569fd..906d9dced8e7 100644
--- a/drivers/usb/typec/tcpm/Makefile
+++ b/drivers/usb/typec/tcpm/Makefile
@@ -6,4 +6,5 @@ typec_wcove-y				:= wcove.o
 obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
 obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
 obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
+obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
 obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c b/drivers/usb/typec/tcpm/tcpci_mt6370.c
new file mode 100644
index 000000000000..c5bb201a5163
--- /dev/null
+++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeup.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/tcpci.h>
+#include <linux/usb/tcpm.h>
+
+#define MT6370_REG_SYSCTRL8	0x9B
+
+#define MT6370_AUTOIDLE_MASK	BIT(3)
+
+#define MT6370_VENDOR_ID	0x29CF
+#define MT6370_TCPC_DID_A	0x2170
+
+struct mt6370_priv {
+	struct device *dev;
+	struct regulator *vbus;
+	struct tcpci *tcpci;
+	struct tcpci_data tcpci_data;
+};
+
+static const struct reg_sequence mt6370_reg_init[] = {
+	REG_SEQ(0xA0, 0x1, 1000),
+	REG_SEQ(0x81, 0x38, 0),
+	REG_SEQ(0x82, 0x82, 0),
+	REG_SEQ(0xBA, 0xFC, 0),
+	REG_SEQ(0xBB, 0x50, 0),
+	REG_SEQ(0x9E, 0x8F, 0),
+	REG_SEQ(0xA1, 0x5, 0),
+	REG_SEQ(0xA2, 0x4, 0),
+	REG_SEQ(0xA3, 0x4A, 0),
+	REG_SEQ(0xA4, 0x01, 0),
+	REG_SEQ(0x95, 0x01, 0),
+	REG_SEQ(0x80, 0x71, 0),
+	REG_SEQ(0x9B, 0x3A, 1000),
+};
+
+static int mt6370_tcpc_init(struct tcpci *tcpci, struct tcpci_data *data)
+{
+	u16 did;
+	int ret;
+
+	ret = regmap_register_patch(data->regmap, mt6370_reg_init,
+				    ARRAY_SIZE(mt6370_reg_init));
+	if (ret)
+		return ret;
+
+	ret = regmap_raw_read(data->regmap, TCPC_BCD_DEV, &did, sizeof(u16));
+	if (ret)
+		return ret;
+
+	if (did == MT6370_TCPC_DID_A)
+		return regmap_write(data->regmap, TCPC_FAULT_CTRL, 0x80);
+
+	return 0;
+}
+
+static int mt6370_tcpc_set_vconn(struct tcpci *tcpci, struct tcpci_data *data,
+				 bool enable)
+{
+	return regmap_update_bits(data->regmap, MT6370_REG_SYSCTRL8,
+				  MT6370_AUTOIDLE_MASK,
+				  enable ? 0 : MT6370_AUTOIDLE_MASK);
+}
+
+static int mt6370_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_data *data,
+				bool source, bool sink)
+{
+	struct mt6370_priv *priv = container_of(data, struct mt6370_priv,
+						tcpci_data);
+	int ret;
+
+	ret = regulator_is_enabled(priv->vbus);
+	if (ret < 0)
+		return ret;
+
+	if (ret && !source)
+		return regulator_disable(priv->vbus);
+
+	if (!ret && source)
+		return regulator_enable(priv->vbus);
+
+	return 0;
+}
+
+static irqreturn_t mt6370_irq_handler(int irq, void *dev_id)
+{
+	struct mt6370_priv *priv = dev_id;
+
+	return tcpci_irq(priv->tcpci);
+}
+
+static int mt6370_check_vendor_info(struct mt6370_priv *priv)
+{
+	struct regmap *regmap = priv->tcpci_data.regmap;
+	u16 vid;
+	int ret;
+
+	ret = regmap_raw_read(regmap, TCPC_VENDOR_ID, &vid, sizeof(u16));
+	if (ret)
+		return ret;
+
+	if (vid != MT6370_VENDOR_ID)
+		return dev_err_probe(priv->dev, -ENODEV,
+				     "Vendor ID not correct 0x%02x\n", vid);
+
+	return 0;
+}
+
+static void mt6370_unregister_tcpci_port(void *tcpci)
+{
+	tcpci_unregister_port(tcpci);
+}
+
+static int mt6370_tcpc_probe(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv;
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->tcpci_data.regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->tcpci_data.regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to init regmap\n");
+
+	ret = mt6370_check_vendor_info(priv);
+	if (ret)
+		return ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq\n");
+
+	/* Assign TCPCI feature and ops */
+	priv->tcpci_data.auto_discharge_disconnect = 1;
+	priv->tcpci_data.init = mt6370_tcpc_init;
+	priv->tcpci_data.set_vconn = mt6370_tcpc_set_vconn;
+
+	priv->vbus = devm_regulator_get_optional(dev, "vbus");
+	if (!IS_ERR(priv->vbus))
+		priv->tcpci_data.set_vbus = mt6370_tcpc_set_vbus;
+
+	priv->tcpci = tcpci_register_port(dev, &priv->tcpci_data);
+	if (IS_ERR(priv->tcpci))
+		return dev_err_probe(dev, PTR_ERR(priv->tcpci),
+				     "Failed to register tcpci port\n");
+
+	ret = devm_add_action_or_reset(dev, mt6370_unregister_tcpci_port, priv->tcpci);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, mt6370_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to allocate irq\n");
+
+	device_init_wakeup(dev, true);
+	dev_pm_set_wake_irq(dev, irq);
+
+	return 0;
+}
+
+static int mt6370_tcpc_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+
+	return 0;
+}
+
+static const struct of_device_id mt6370_tcpc_devid_table[] = {
+	{ .compatible = "mediatek,mt6370-tcpc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_tcpc_devid_table);
+
+static struct platform_driver mt6370_tcpc_driver = {
+	.driver = {
+		.name = "mt6370-tcpc",
+		.of_match_table = mt6370_tcpc_devid_table,
+	},
+	.probe = mt6370_tcpc_probe,
+	.remove = mt6370_tcpc_remove,
+};
+module_platform_driver(mt6370_tcpc_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("MT6370 USB Type-C Port Controller Interface Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

