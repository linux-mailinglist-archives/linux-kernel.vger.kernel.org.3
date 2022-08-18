Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53BD598A61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbiHRR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345590AbiHRRZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FCE48;
        Thu, 18 Aug 2022 10:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4536D616FD;
        Thu, 18 Aug 2022 17:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767AFC433C1;
        Thu, 18 Aug 2022 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660843552;
        bh=U4ulU7LUfIxOOKY+jPEQdeirsitxhl7mzZqSCLj9pLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DI/wDz+hwFetaviDPUx/S35ihafJz/fiirF4hzWGi7bbpJIGg0lMUybl5TenFCb/j
         JKqXVUHPN7WspTnqf7Efoo75RAUb8y3cHEwfZBT22+0Z76MdwvJSJ9zlVAR9Sl+wEm
         5tOcALdJgW3DV5+62WeoqvaUTKkVx1DVfWl+tjnkj1zWqHMdOnnmphf8ypMqzgsmzx
         QSPHUXWyB646qiVqtHnR9l9E1AUBebDkaUyYWtM9NCKC8STKCs7nUl7ZqqxuckF4lz
         ouFexmlD9E1CAR0cNYa0GUttQwFXLGdGTdiYoV5X8mKgWj6uN8Y/Y82SWKEatrrFrs
         x1De1mfYJt6hg==
Received: by pali.im (Postfix)
        id E05782868; Thu, 18 Aug 2022 19:25:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] leds: syscon: Implement support for active-low property
Date:   Thu, 18 Aug 2022 19:25:28 +0200
Message-Id: <20220818172528.23062-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818172528.23062-1-pali@kernel.org>
References: <20220818172528.23062-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new active-low property specify that LED has inverted logic
(0 - enable LED, 1 - disable LED).

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/leds/leds-syscon.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index 7eddb8ecb44e..5e605d8438e9 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -29,6 +29,7 @@ struct syscon_led {
 	struct regmap *map;
 	u32 offset;
 	u32 mask;
+	bool active_low;
 	bool state;
 };
 
@@ -41,10 +42,10 @@ static void syscon_led_set(struct led_classdev *led_cdev,
 	int ret;
 
 	if (value == LED_OFF) {
-		val = 0;
+		val = sled->active_low ? sled->mask : 0;
 		sled->state = false;
 	} else {
-		val = sled->mask;
+		val = sled->active_low ? 0 : sled->mask;
 		sled->state = true;
 	}
 
@@ -85,6 +86,8 @@ static int syscon_led_probe(struct platform_device *pdev)
 		return -EINVAL;
 	if (of_property_read_u32(np, "mask", &sled->mask))
 		return -EINVAL;
+	if (of_find_property(np, "active-low", NULL))
+		sled->active_low = true;
 
 	state = of_get_property(np, "default-state", NULL);
 	if (state) {
@@ -95,17 +98,20 @@ static int syscon_led_probe(struct platform_device *pdev)
 			if (ret < 0)
 				return ret;
 			sled->state = !!(val & sled->mask);
+			if (sled->active_low)
+				sled->state = !sled->state;
 		} else if (!strcmp(state, "on")) {
 			sled->state = true;
 			ret = regmap_update_bits(map, sled->offset,
 						 sled->mask,
-						 sled->mask);
+						 sled->active_low ? 0 : sled->mask);
 			if (ret < 0)
 				return ret;
 		} else {
 			sled->state = false;
 			ret = regmap_update_bits(map, sled->offset,
-						 sled->mask, 0);
+						 sled->mask,
+						 sled->active_low ? sled->mask : 0);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.20.1

