Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AED507D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358408AbiDSXGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355423AbiDSXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:06:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B126139;
        Tue, 19 Apr 2022 16:03:32 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 049782224D;
        Wed, 20 Apr 2022 01:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650409411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nUDiuC5jlPYztqB/jf/79JO4aaNqPyVA96EPXebqV4=;
        b=T47MFtALaTdWyjIbdZAijetlCO/qg4WHJbAjc6jDcfao48NYimtTGo4XUl899//Iz/ItmX
        VA8UoqMcTIBvY9Yivw90PHGN3cJuzabr98JHBgIfL1QBTbE3Fh3iINF+OeXdlQHy76MI7M
        gGv1OsJlAhcY/no+ik0ao0d1A715bjI=
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
Subject: [PATCH v2 2/2] pinctrl: ocelot: add optional shared reset
Date:   Wed, 20 Apr 2022 01:03:24 +0200
Message-Id: <20220419230324.3221779-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419230324.3221779-1-michael@walle.cc>
References: <20220419230324.3221779-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LAN9668 there is a shared reset line which affects GPIO, SGPIO
and the switch core. Add support for this shared reset line.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 1bdced67464b..b25eb04e4e1d 100644
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
@@ -1927,6 +1929,13 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 
 	info->desc = (struct pinctrl_desc *)device_get_match_data(dev);
 
+	reset = devm_reset_control_get_optional_shared(dev, "switch");
+	if (IS_ERR(reset)) {
+		dev_err(dev, "Failed to get reset\n");
+		return PTR_ERR(reset);
+	}
+	reset_control_reset(reset);
+
 	base = devm_ioremap_resource(dev,
 			platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (IS_ERR(base))
-- 
2.30.2

