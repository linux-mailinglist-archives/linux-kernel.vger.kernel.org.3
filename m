Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E603C49A7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315553AbiAYCxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374225AbiAYAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6CBC038AF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:01:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 146A11F438ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061699;
        bh=GeHZOsyvGGJJ4aGx3Jf1/eW+jsfWROA8xn3TnY8RKX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdwqpN7nWmbIhZNt7LG8gdB3dXWkqNEve/hW6ievQwGCSFHaHJGemTR9BV68DA4Nk
         OQ9P+Xsv1wLqKt+bcL/PL+B3NX5paiQVv84W0/JRMQYhGFt/CTZmgxr9NEzjMNfDq7
         uh4II7JZRHw0fNv+7aACJPeV8wSyIwFd6wtDdS6Ibr5XBnRUc1KOTqU3NKx6CN1YmB
         umJaea3GGGKbCyt+EOW3w+H+lG+Tso+3p/gqySmi7ID6DU0pdTJCrzemrhGfewstUa
         0WpIoEVONDcUuC1I0iLHPYsv9zmZnQgxwSgtr6qQ4GYdlF2VG522bEyPiZ6kzORny4
         yfBeVR+p5ZMLg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/9] regulator: rpi-panel: Register with a unique backlight name
Date:   Mon, 24 Jan 2022 17:01:21 -0500
Message-Id: <20220124220129.158891-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

There's no reason why 2 Raspberry Pi DSI displays can't be
attached to a Pi Compute Module, so the backlight names need to
be unique.

Use the parent dev_name. It's not as readable, but is unique.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index ee46bfbf5eee..370b9ae363dd 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -181,8 +181,7 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 0xff;
-	bl = devm_backlight_device_register(&i2c->dev,
-					    "7inch-touchscreen-panel-bl",
+	bl = devm_backlight_device_register(&i2c->dev, dev_name(&i2c->dev),
 					    &i2c->dev, regmap, &attiny_bl,
 					    &props);
 	if (IS_ERR(bl))
-- 
2.34.1

