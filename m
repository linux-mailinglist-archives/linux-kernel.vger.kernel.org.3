Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B5495152
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbiATPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:22:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376617AbiATPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 756C81F45345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692159;
        bh=toJZplNzOWnhWEhBs7DUXgaZJA8ric2HVhNCIQ2EX3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErOZIZkGc0EWd6WWHuaidybGNKG6sbnjaGPSHW67m5eI5/kCGGkhVm7RSgoVWBAUT
         MmQMuAy4PRL9Gsc9mw6rtOrEzn6mQBdaI2pFpMidSD3PBroHLKxHjmsuF9Aa/90A/o
         A2NvWcQYuM4HdehjU+TWEGK1vX1Z/OVYbH2MfrQ+4R3fH0FuUnLM8Qr80w1COeiNfW
         ZXd8VZj0FHFc4QLrA9GIvHtSFIgbCWFuFwCFaZ39grzl3whN1uPiuzYOMAn4VZ5f5s
         UNGU2acAlRSQZX0BSGe1Xk6R79CDV/gTSEp1bzdp7lbTUFT0kGUiHphivfqIKmsNVW
         h9tVeuCyID94w==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 7/9] regulator: rpi-panel: Remove get_brightness hook
Date:   Thu, 20 Jan 2022 10:21:48 -0500
Message-Id: <20220120152150.1952568-8-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152150.1952568-1-detlev.casanova@collabora.com>
References: <20220120152150.1952568-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The driver was implementing a get_brightness function that
tried to read back the PWM setting of the display to report
as the current brightness.
The controller on the display does not support that, therefore
we end up reporting a brightness of 0, and that confuses
systemd's backlight service.

Remove the hook so that the framework returns the current
brightness automatically.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 998233f14085..8090b9a485b5 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -207,31 +207,8 @@ static int attiny_update_status(struct backlight_device *bl)
 	return ret;
 }
 
-static int attiny_get_brightness(struct backlight_device *bl)
-{
-	struct attiny_lcd *state = bl_get_data(bl);
-	struct regmap *regmap = state->regmap;
-	int ret, brightness, i;
-
-	mutex_lock(&state->lock);
-
-	for (i = 0; i < 10; i++) {
-		ret = regmap_read(regmap, REG_PWM, &brightness);
-		if (!ret)
-			break;
-	}
-
-	mutex_unlock(&state->lock);
-
-	if (ret)
-		return ret;
-
-	return brightness;
-}
-
 static const struct backlight_ops attiny_bl = {
 	.update_status	= attiny_update_status,
-	.get_brightness	= attiny_get_brightness,
 };
 
 static int attiny_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
-- 
2.34.1

