Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5A575514
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiGNSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbiGNSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84811C3F;
        Thu, 14 Jul 2022 11:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E83BBB82883;
        Thu, 14 Jul 2022 18:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616EFC341CA;
        Thu, 14 Jul 2022 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657823628;
        bh=KG4givLWyqqySRMF0vaCp1vCFRAlBgr68900m9VDOgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKmsaa5v5//3cn5rDfJlmr6xJ4t8wH6p6XD98GCIy9plGknnyKdS3NOqOELDUlWbf
         v+HWymv6c+yzaWuZYUgsaSmuVOyZkpPLIcU/jroEbpQ+leKu2kcmi1V2k1x8qkGsO4
         Z2J3N39yn8qdFVKZuC7Jb9UD3og1NM4+4DizCqtQvOAm3hMXjpFOwON/vMuaKgs9l9
         OoEMY8BmPszPjZ7M8psCm0AKDvAHf1cxPhgrgUWKynkb75/XtBp83WkTZj/oX/J/Tw
         VE1aEURRTewWm96EF96jg2AWzeCVIwoF3wAj8H9obUGfWuJ/ZZ2oUBF0//uW+72tHd
         BLxr0Bun6JkwA==
Received: by pali.im (Postfix)
        id B0C7313D3; Thu, 14 Jul 2022 20:33:45 +0200 (CEST)
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
Subject: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for gpios
Date:   Thu, 14 Jul 2022 20:33:27 +0200
Message-Id: <20220714183328.4137-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220714183328.4137-1-pali@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
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

Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
variants like Armada 370 do not support per CPU interrupts for gpios.

So change compatible string for Armada 38x from "marvell,armada-370-gpio"
which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
XP variant or new.

Driver gpio-mvebu.c which handles both pre-XP and XP variants already
provides support for per CPU interrupts on XP and newer variants.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
---
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index df3c8d1d8f64..9343de6947b3 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -292,7 +292,7 @@
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,armada-370-gpio",
+				compatible = "marvell,armadaxp-gpio",
 					     "marvell,orion-gpio";
 				reg = <0x18100 0x40>, <0x181c0 0x08>;
 				reg-names = "gpio", "pwm";
@@ -310,7 +310,7 @@
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,armada-370-gpio",
+				compatible = "marvell,armadaxp-gpio",
 					     "marvell,orion-gpio";
 				reg = <0x18140 0x40>, <0x181c8 0x08>;
 				reg-names = "gpio", "pwm";
-- 
2.20.1

