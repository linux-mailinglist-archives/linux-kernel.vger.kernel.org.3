Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B293C484DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiAEGEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:04:13 -0500
Received: from box.trvn.ru ([194.87.146.52]:59435 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236309AbiAEGEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:04:02 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 1EAF94206A;
        Wed,  5 Jan 2022 11:03:58 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641362638; bh=DjJJ7gWun3Q4+s3Ds07ABkL7/Fme7iFeHa0zyKq7N4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFAe0wbhQZT5Smaw8kKpDqxOj7qGycRdX8NINABvdJ1OEUqBqAIVtS/uU0z6qV0Q5
         7OlxkJezNtCsceZ/s8+/AFH+na892JjaOnohDmS07kaaMsAwfq/NNV7HmFOKtwj25N
         3cT4XDzYIFJJskf/1bxEYe+sdA8lZb+vax3WPg7XaLvF6vN2+P74S5i+K379TJYeMq
         LwqYR4mfjcESy/pR4fuIV/SkXP1SFHrrW1Y7l/3tSLJW+5Mq2x9mNjO+PX3oqoC57P
         NNG6vAPd+e9sZYcYss/5/cgT7TZ6PplUJm9QGYw0rS1opsdIUJ3TLcS4nwiFv8aQdZ
         g0LUYk1SCP1Fg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 3/6] Input: zinitix - Handle proper supply names
Date:   Wed,  5 Jan 2022 11:03:20 +0500
Message-Id: <20220105060323.7928-4-nikita@trvn.ru>
In-Reply-To: <20220105060323.7928-1-nikita@trvn.ru>
References: <20220105060323.7928-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The supply names of the Zinitix touchscreen were a bit confused, the new
bindings rectifies this.

To deal with old and new devicetrees, first check if we have "vddo" and in
case that exists assume the old supply names. Else go and look for the new
ones.

We cannot just get the regulators since we would get an OK and a dummy
regulator: we need to check explicitly for the old supply name.

Use struct device *dev as a local variable instead of the I2C client since
the device is what we are actually obtaining the resources from.

Cc: Mark Brown <broonie@kernel.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: phone-devel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[Slightly changed the legacy regulator detection]
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
This patch was previously submitted here:
https://lore.kernel.org/linux-input/20210625113435.2539282-2-linus.walleij@linaro.org/

Changes since the original patch:
 - Address the review comments by Dmitry:
   Drop explicit OF check and use of_find_property()
Changes in v2:
 - Reword the legacy regulator comment to drop "... and warn" as no
   warning is done. (I think adding a warning is not very useful here)
---
 drivers/input/touchscreen/zinitix.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 1e70b8d2a8d7..e84e4c3b1b3a 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -252,16 +252,27 @@ static int zinitix_init_touch(struct bt541_ts_data *bt541)
 
 static int zinitix_init_regulators(struct bt541_ts_data *bt541)
 {
-	struct i2c_client *client = bt541->client;
+	struct device *dev = &bt541->client->dev;
 	int error;
 
-	bt541->supplies[0].supply = "vdd";
-	bt541->supplies[1].supply = "vddo";
-	error = devm_regulator_bulk_get(&client->dev,
+	/*
+	 * Some older device trees have erroneous names for the regulators,
+	 * so check if "vddo" is present and in that case use these names.
+	 * Else use the proper supply names on the component.
+	 */
+	if (of_find_property(dev->of_node, "vddo-supply", NULL)) {
+		bt541->supplies[0].supply = "vdd";
+		bt541->supplies[1].supply = "vddo";
+	} else {
+		/* Else use the proper supply names */
+		bt541->supplies[0].supply = "vcca";
+		bt541->supplies[1].supply = "vdd";
+	}
+	error = devm_regulator_bulk_get(dev,
 					ARRAY_SIZE(bt541->supplies),
 					bt541->supplies);
 	if (error < 0) {
-		dev_err(&client->dev, "Failed to get regulators: %d\n", error);
+		dev_err(dev, "Failed to get regulators: %d\n", error);
 		return error;
 	}
 
-- 
2.30.2

