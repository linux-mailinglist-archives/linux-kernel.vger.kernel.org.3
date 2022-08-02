Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2344587A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiHBJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiHBJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:53:22 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510A167C7;
        Tue,  2 Aug 2022 02:53:20 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 4FF8CFF808;
        Tue,  2 Aug 2022 09:53:15 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux io-domain dependency
Date:   Tue,  2 Aug 2022 11:52:52 +0200
Message-Id: <20220802095252.2486591-2-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802095252.2486591-1-foss+kernel@0leil.net>
References: <20220802095252.2486591-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

On some Rockchip SoCs, some SoC pins are split in what are called IO
domains.

An IO domain is supplied power externally, by regulators from a PMIC for
example. This external power supply is then used by the IO domain as
"supply" for the IO pins if they are outputs.

Each IO domain can configure which voltage the IO pins will be operating
on (1.8V or 3.3V).

There already exists an IO domain driver for Rockchip SoCs[1]. This
driver allows to explicit the relationship between the external power
supplies and IO domains[2]. This makes sure the regulators are enabled
by the Linux kernel so the IO domains are supplied with power and
correctly configured as per the supplied voltage.
This driver is a regulator consumer and does not offer any other
interface for device dependency.

However, IO pins belonging to an IO domain need to have this IO domain
correctly configured before they are being used otherwise they do not
operate correctly (in our case, a pin configured as output clock was
oscillating between 0 and 150mV instead of the expected 1V8).

In order to make this dependency transparent to the consumer of those
pins and not add Rockchip-specific code to third party drivers (a camera
driver in our case), it is hooked into the pinctrl driver which is
Rockchip-specific obviously.

[1] drivers/soc/rockchip/io-domain.c
[2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++++++++++++
 drivers/pinctrl/pinctrl-rockchip.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 32e41395fc76..c3c2801237b5 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -24,6 +24,8 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -2370,6 +2372,12 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 	dev_dbg(dev, "enable function %s group %s\n",
 		info->functions[selector].name, info->groups[group].name);
 
+	if (info->groups[group].io_domain &&
+	    !platform_get_drvdata(info->groups[group].io_domain)) {
+		dev_err(info->dev, "IO domain device is required but not probed yet, deferring...");
+		return -EPROBE_DEFER;
+	}
+
 	/*
 	 * for each pin in the pin group selected, program the corresponding
 	 * pin function number in the config register.
@@ -2663,6 +2671,7 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 {
 	struct device *dev = info->dev;
 	struct rockchip_pin_bank *bank;
+	struct device_node *node;
 	int size;
 	const __be32 *list;
 	int num;
@@ -2684,6 +2693,16 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 	if (!size || size % 4)
 		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
 
+	node = of_parse_phandle(np, "rockchip,io-domains", 0);
+	if (node) {
+		grp->io_domain = of_find_device_by_node(node);
+		of_node_put(node);
+		if (!grp->io_domain) {
+			dev_err(info->dev, "couldn't find IO domain device\n");
+			return -ENODEV;
+		}
+	}
+
 	grp->npins = size / 4;
 
 	grp->pins = devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), GFP_KERNEL);
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index ec46f8815ac9..56bc008eb7df 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -434,6 +434,7 @@ struct rockchip_pin_group {
 	unsigned int			npins;
 	unsigned int			*pins;
 	struct rockchip_pin_config	*data;
+	struct platform_device		*io_domain;
 };
 
 /**
-- 
2.37.1

