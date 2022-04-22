Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F165150BE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiDVRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbiDVRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2791568;
        Fri, 22 Apr 2022 10:09:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 91E921F46B05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647377;
        bh=EPcCXKeA1LAFjO2ZEEU8z37SDrqevGobpJeJYsDJDSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMzuubHogBCqI/fcPFkN1Z/E0atBiwC4cjim5/njd57NQb8qXbbF1YnT+9lrN2VcX
         Uhc00+qaSpL8lsfBuA+iYyB1YTsVyb4swHRJgGe9OE+JbqolwxsSWRE078LmYkzjk0
         y4+z3dnoLKK55V/z+4oClppHd/PIV/uhpqZ76L4ge5Tp/HstTG0bz7dOAk3Y9TR6rN
         On8Dln9GFg0usl4f0GnG5JM5atTtSewK+/p++3YVaUrx4L6U60Pm68twTtXP98oq0L
         BMrrECredc1RRSOw2ZoWY1LtNsDjmzKJYKihFC0iWXUJf4sQJBYzkv8/2lUHxSV3sS
         TJ8OZFFgKcnmw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E2BF9480C1E; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 14/19] gpio: rockchip: add support for rk3588
Date:   Fri, 22 Apr 2022 19:09:15 +0200
Message-Id: <20220422170920.401914-15-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add V2.1 rockchip gpio controller type, which is part of the
RK3588 SoC.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpio/gpio-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 099e358d2491..f0e279665525 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -26,6 +26,7 @@
 
 #define GPIO_TYPE_V1		(0)           /* GPIO Version ID reserved */
 #define GPIO_TYPE_V2		(0x01000C2B)  /* GPIO Version ID 0x01000C2B */
+#define GPIO_TYPE_V2_1		(0x0101157C)  /* GPIO Version ID 0x0101157C */
 
 static const struct rockchip_gpio_regs gpio_regs_v1 = {
 	.port_dr = 0x00,
@@ -663,7 +664,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	id = readl(bank->reg_base + gpio_regs_v2.version_id);
 
 	/* If not gpio v2, that is default to v1. */
-	if (id == GPIO_TYPE_V2) {
+	if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
 		bank->gpio_regs = &gpio_regs_v2;
 		bank->gpio_type = GPIO_TYPE_V2;
 		bank->db_clk = of_clk_get(bank->of_node, 1);
-- 
2.35.1

