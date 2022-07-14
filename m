Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420957551C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiGNSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiGNSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497D175B4;
        Thu, 14 Jul 2022 11:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7B95B82886;
        Thu, 14 Jul 2022 18:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F11EC34114;
        Thu, 14 Jul 2022 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657823629;
        bh=bHCnfGkhpaHt2kUmFet5jXNnahSMUqgBM2cXP2rBui0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZd0G25prIji2WDZJmJlw3IwGC+82ufpan0eYMMxgadiOkf/SPXupvckuyP2PdRT3
         rdlqcmCvpQN2Pj0CeTQLJ4v/2ntGHKdfgRAkAimuzt9IJaIBVnc6+PmBFpLmCNlqrh
         LEqIM9sr4TkUPgFzHTKZCL8IF1wWwzuW4mHnj3/H3eWtDjKyvWdjo76bwEUqG1z8+I
         Rho9hfyg8vagdie1yhw6ldFpE2Jv4ATrCpujEwNQ6sa6ErtwlxpigOdjmYYMpoRm5x
         XpKPLY/ipudlE+oV15ZBbK7+qqI8LVmgndIhJdcrPWHgdd8FyM4ADmcRPb42xAd2Q2
         bUJVq8LTihxHA==
Received: by pali.im (Postfix)
        id AE7DC277A; Thu, 14 Jul 2022 20:33:46 +0200 (CEST)
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
Subject: [PATCH v2 4/4] ARM: dts: armada-39x: Fix compatible string for gpios
Date:   Thu, 14 Jul 2022 20:33:28 +0200
Message-Id: <20220714183328.4137-4-pali@kernel.org>
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

Armada 39x supports per CPU interrupts for gpios, like Armada XP.

So add compatible string "marvell,armadaxp-gpio" for Armada 39x GPIO nodes.

Driver gpio-mvebu.c which handles both pre-XP and XP variants already
provides support for per CPU interrupts on XP and newer variants.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: d81a914fc630 ("ARM: dts: mvebu: armada-39x: add missing nodes describing GPIO's")
---
 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index e0b7c2099831..ef3a3859802c 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -213,7 +213,7 @@
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
 				ngpios = <32>;
 				gpio-controller;
@@ -227,7 +227,7 @@
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
 				reg = <0x18140 0x40>;
 				ngpios = <28>;
 				gpio-controller;
-- 
2.20.1

