Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8B575511
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiGNSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiGNSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B011C3F;
        Thu, 14 Jul 2022 11:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C848162196;
        Thu, 14 Jul 2022 18:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1EFC34114;
        Thu, 14 Jul 2022 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657823627;
        bh=uYJqubEioTmV1YTvZ/Dq1JpUQFHEuaX4No8uowtwz4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCuhAmcmtvA9NNwhysrRYtWPIC3q7sRKn1GqGl1jVy6Uacb6MLCcZ/akrntoT2MRN
         R/KADwJ5BQqoY4Ry6pE63OW+hSSeUUHGYwbCqQouobhH3KXQIc8b30tbG2My95JAyR
         yh0EMxN8W5Jvi8HCZ2L2HTq0QTC9ZCviSUEj+n0Ix5/caQO2B1GXP9Ue3h5zSbgJYJ
         AUN2yZnY2EINbzZwafDaoESx3qcZ1/tPrK3dZ8KySJsyOieIzVqvt9WN+BlsxpyYgI
         QAuIvIpejZgfHcqPmcBOr6fB54P1xLpClemDSZGR0KjzXGL/mR/4Lim0ffAmKPS7qP
         1qvabzRWyPu6A==
Received: by pali.im (Postfix)
        id C1D6B1295; Thu, 14 Jul 2022 20:33:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] gpio: mvebu: Fix check for pwm support on non-A8K platforms
Date:   Thu, 14 Jul 2022 20:33:25 +0200
Message-Id: <20220714183328.4137-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220714115515.5748-1-pali@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm support incompatible with Armada 80x0/70x0 API is not only in
Armada 370, but also in Armada XP, 38x and 39x. So basically every non-A8K
platform. Fix check for pwm support appropriately.

Fixes: 85b7d8abfec7 ("gpio: mvebu: add pwm support for Armada 8K/7K")
Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* reverse the if/else order per Baruch request
---
 drivers/gpio/gpio-mvebu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 2db19cd640a4..de1e7a1a76f2 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -793,8 +793,12 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	u32 offset;
 	u32 set;
 
-	if (of_device_is_compatible(mvchip->chip.of_node,
-				    "marvell,armada-370-gpio")) {
+	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
+		int ret = of_property_read_u32(dev->of_node,
+					       "marvell,pwm-offset", &offset);
+		if (ret < 0)
+			return 0;
+	} else {
 		/*
 		 * There are only two sets of PWM configuration registers for
 		 * all the GPIO lines on those SoCs which this driver reserves
@@ -804,13 +808,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
 			return 0;
 		offset = 0;
-	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
-		int ret = of_property_read_u32(dev->of_node,
-					       "marvell,pwm-offset", &offset);
-		if (ret < 0)
-			return 0;
-	} else {
-		return 0;
 	}
 
 	if (IS_ERR(mvchip->clk))
-- 
2.20.1

