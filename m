Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9CA574C95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiGNL4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbiGNL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24373B973;
        Thu, 14 Jul 2022 04:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8F061A7B;
        Thu, 14 Jul 2022 11:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D68AC385A5;
        Thu, 14 Jul 2022 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657799772;
        bh=KG4givLWyqqySRMF0vaCp1vCFRAlBgr68900m9VDOgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHkzOIqDiBSLfUkFX5faUUwZ8Yz2gHyLz0Rookz6nOnp5J8RRnFVoTip5osmTm+jz
         VeXFKoKFXPExhhh7KhWzFQZGE9U1gyxIvK5ssEdWnmz9lUPhpU1uiNzyziE37kaV9F
         WvLYh6cmXbY3frAiZ0bvwqM/82EKQFn7AHQ9IEMm5vYwbwsjS8PVmulQhJbB++JdTq
         8ZfbXYA42/3pmIPo8MyXdC8+uO3SD7v0tc/z3XvIirMj1mR7g7iKOkXlt+T1xSsuj6
         6cqC8pfHOYeB59REVVpMLKOjJUq9v/OLVXw/oBX+C9pC2ZSUxYVScb0o8MjHpTkztQ
         PHyYkeCSncuTw==
Received: by pali.im (Postfix)
        id CDAA113D3; Thu, 14 Jul 2022 13:56:09 +0200 (CEST)
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
Subject: [PATCH 3/4] ARM: dts: armada-38x: Fix compatible string for gpios
Date:   Thu, 14 Jul 2022 13:55:14 +0200
Message-Id: <20220714115515.5748-3-pali@kernel.org>
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

