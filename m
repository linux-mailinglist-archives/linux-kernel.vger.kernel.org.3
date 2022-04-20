Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A5509046
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381708AbiDTTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381696AbiDTTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:22:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F52BF4A;
        Wed, 20 Apr 2022 12:19:38 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 78B8622255;
        Wed, 20 Apr 2022 21:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650482376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjU3itzIvEGXkt6RShfQqX8saZi833+CMTU68RceKbQ=;
        b=F9rSym0G72plU7oK+A56qOR5TtXmlsY7KjmAhZmdks/dpMAheGWfs/qkrqPUcD/lgPTvF9
        37z4Bzu6qawEri58sMuCtpgq2Ge311h9JunC3sU8mYumU3hjJO2zz/p0SBqMAvxK189KHl
        Fh3ohRyVZhT8xFuFWjXGRd8RqgJ+qQQ=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 2/2] pinctrl: ocelot: add optional shared reset
Date:   Wed, 20 Apr 2022 21:19:26 +0200
Message-Id: <20220420191926.3411830-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420191926.3411830-1-michael@walle.cc>
References: <20220420191926.3411830-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LAN9668 there is a shared reset line which affects GPIO, SGPIO
and the switch core. Add support for this shared reset line.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 1bdced67464b..843704fa8625 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include "core.h"
@@ -1912,6 +1913,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ocelot_pinctrl *info;
+	struct reset_control *reset;
 	struct regmap *pincfg;
 	void __iomem *base;
 	int ret;
@@ -1927,6 +1929,12 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 
 	info->desc = (struct pinctrl_desc *)device_get_match_data(dev);
 
+	reset = devm_reset_control_get_optional_shared(dev, "switch");
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "Failed to get reset\n");
+	reset_control_reset(reset);
+
 	base = devm_ioremap_resource(dev,
 			platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (IS_ERR(base))
-- 
2.30.2

