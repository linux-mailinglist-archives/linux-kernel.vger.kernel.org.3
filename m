Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2C5686B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiGFL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGFL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8FD25C49;
        Wed,  6 Jul 2022 04:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2590561E72;
        Wed,  6 Jul 2022 11:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32EC341C0;
        Wed,  6 Jul 2022 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657106950;
        bh=4ASXZQVP9AzJtJ0hy++BPz1LtZi0DXsVgS0qlgbwSbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbCf7YAm60jIpENUSEoVes5cgy39ZTGG4d0Nlncn6DWpQHhL4pyJyJzhqiDW45j6v
         W+dDhR1R5dKHCCugt0BGOYP29VX/ruqj3uiGC419sEYRLPAWyPmanSOrTmWl1g04Fn
         d/SrR/g8458dK3JjC78mBMMCfFUt9wADGcXUGpcdNlGWEf8fVSjDbC6SNRbsUfJpPT
         wR/Egc5HIgPhDlGKPg0/1B7qeyPhoZUwCeHRoTpF+jQhVZYJrc4XCGlpu0orv0j5OK
         Va+5eXFgtNW0cQudJXHg5TXao3RtGIXOaIn9OZKeJr/bR+JenjDzrAaurMan82yp/F
         NCoTRY3YQWsow==
Received: by pali.im (Postfix)
        id C51F87F1; Wed,  6 Jul 2022 13:29:07 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] leds: syscon: Implement support for value property
Date:   Wed,  6 Jul 2022 13:28:28 +0200
Message-Id: <20220706112828.27278-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706112828.27278-1-pali@kernel.org>
References: <20220706112828.27278-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new value property specify when is LED enabled. By default its value
is from the mask and therefore LED is enabled when bit is set. This change
allows to define inverted logic (0 - enable LED, 1 - disable LED) by
setting value property to zero.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/leds/leds-syscon.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index 7eddb8ecb44e..337a0bada967 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -29,6 +29,7 @@ struct syscon_led {
 	struct regmap *map;
 	u32 offset;
 	u32 mask;
+	u32 value;
 	bool state;
 };
 
@@ -41,10 +42,10 @@ static void syscon_led_set(struct led_classdev *led_cdev,
 	int ret;
 
 	if (value == LED_OFF) {
-		val = 0;
+		val = ~sled->value;
 		sled->state = false;
 	} else {
-		val = sled->mask;
+		val = sled->value;
 		sled->state = true;
 	}
 
@@ -85,6 +86,8 @@ static int syscon_led_probe(struct platform_device *pdev)
 		return -EINVAL;
 	if (of_property_read_u32(np, "mask", &sled->mask))
 		return -EINVAL;
+	if (of_property_read_u32(np, "value", &sled->value))
+		sled->value = sled->mask;
 
 	state = of_get_property(np, "default-state", NULL);
 	if (state) {
@@ -94,18 +97,19 @@ static int syscon_led_probe(struct platform_device *pdev)
 			ret = regmap_read(map, sled->offset, &val);
 			if (ret < 0)
 				return ret;
-			sled->state = !!(val & sled->mask);
+			sled->state = (val & sled->mask) == sled->value;
 		} else if (!strcmp(state, "on")) {
 			sled->state = true;
 			ret = regmap_update_bits(map, sled->offset,
 						 sled->mask,
-						 sled->mask);
+						 sled->value);
 			if (ret < 0)
 				return ret;
 		} else {
 			sled->state = false;
 			ret = regmap_update_bits(map, sled->offset,
-						 sled->mask, 0);
+						 sled->mask,
+						 ~sled->value);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.20.1

