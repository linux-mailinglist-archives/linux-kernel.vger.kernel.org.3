Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E506C574C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiGNL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbiGNL4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:56:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960485C354;
        Thu, 14 Jul 2022 04:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04B7CCE2696;
        Thu, 14 Jul 2022 11:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36B3C34114;
        Thu, 14 Jul 2022 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657799772;
        bh=kMHYnrEnWCDRZLx3w2/b7o5Qlq/C+lrcPobY/5NWAME=;
        h=From:To:Cc:Subject:Date:From;
        b=GjRXKN9g5LMFI0DX13xliVDcHGudOPZvUDepRt2Uw1pAe75XfnDZ/vKod5jO6OtnF
         v+Uz/mIgbF0zCjRqEj0f85s4hNAiyPeQ63L5zPiGBHCCDjTBvnBXJICkXQ0fNjJWeG
         /YQjkuJ+Q812pCWUiG2XfnJ6C8EHKo0B1pmjUR95WJezFk3fj14fpuvlQ92fJCtRoE
         g9Eur6CDSq9HolDsx90so4jZ+VwZgjFegxZ1hD6AD6KY9lXfAkG8xoxEj6B+Dfkrhr
         wXT/vyFoN57IZBLXUYafzSChpyOF8o1tDWlro15PgE25EjpljtzOc4yxDf7GFV7qHl
         Gp8D1R5iayPCg==
Received: by pali.im (Postfix)
        id E7DF01295; Thu, 14 Jul 2022 13:56:08 +0200 (CEST)
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
Subject: [PATCH 1/4] gpio: mvebu: Fix check for pwm support on non-A8K platforms
Date:   Thu, 14 Jul 2022 13:55:12 +0200
Message-Id: <20220714115515.5748-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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
 drivers/gpio/gpio-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 2db19cd640a4..70a22b68c034 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -793,8 +793,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	u32 offset;
 	u32 set;
 
-	if (of_device_is_compatible(mvchip->chip.of_node,
-				    "marvell,armada-370-gpio")) {
+	if (mvchip->soc_variant != MVEBU_GPIO_SOC_VARIANT_A8K) {
 		/*
 		 * There are only two sets of PWM configuration registers for
 		 * all the GPIO lines on those SoCs which this driver reserves
-- 
2.20.1

