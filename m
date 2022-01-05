Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9C484DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiAEGEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:04:01 -0500
Received: from box.trvn.ru ([194.87.146.52]:39641 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236309AbiAEGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:03:58 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9902B4200B;
        Wed,  5 Jan 2022 11:03:55 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641362636; bh=YGq3tK4Qa1gT0lBwrqqbtBTes6WWGLWzf8xd1+IjiT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3O+XX4RRIU2UwRjDcAi+Pxto848paYRKWhbF2B9Inxw/+Sk+nvOuw2LyUivWbb38
         u+yJWrNCxjZiNgr/qwqdFkH6oGAVG2VOtklgbLq3L5BnRgUaY8GLmtkP6ptmp6gmED
         4tpVdPT8wi57aZ90vBBSr60fx0Fma1V1tbZxMpsWetzJvz3WRg2RMsmfoOELgSL5DO
         GbGlweIXuaOEiNAE6/M+0zRvPc4/HanJVcY/J+wlZbz6bLQSZBP9ENn+rRYfDI8x6H
         v0ULjQxMeq9r2AzNDNmn5clPGHGDneBEpAHMjk3X6jrf+6ocW4dx/ZfUnBUcUq2a/i
         BdfXiS2+WomFw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 1/6] input: zinitix: Make sure the IRQ is allocated before it gets enabled
Date:   Wed,  5 Jan 2022 11:03:18 +0500
Message-Id: <20220105060323.7928-2-nikita@trvn.ru>
In-Reply-To: <20220105060323.7928-1-nikita@trvn.ru>
References: <20220105060323.7928-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since irq request is the last thing in the driver probe, it happens
later than the input device registration. This means that there is a
small time window where if the open method is called the driver will
attempt to enable not yet available irq.

Fix that by moving the irq request before the input device registration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Fixes: 26822652c85e ("Input: add zinitix touchscreen driver")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/input/touchscreen/zinitix.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index b8d901099378..1e70b8d2a8d7 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -488,6 +488,15 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, zinitix_ts_irq_handler,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					  client->name, bt541);
+	if (error) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
+		return error;
+	}
+
 	error = zinitix_init_input_dev(bt541);
 	if (error) {
 		dev_err(&client->dev,
@@ -513,15 +522,6 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, zinitix_ts_irq_handler,
-					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					  client->name, bt541);
-	if (error) {
-		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
-- 
2.30.2

