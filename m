Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86349514D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376566AbiATPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:22:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376454AbiATPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 2F0091F4533C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692148;
        bh=80BI0zXGQTgN05p6AlFLM+LNKFXJZZRY/BLdFYtbkxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpBA1veDJR3S5J4pN/mWlU/nnCjmtqM/foKJhUEGedmrunYe3kf7znvovLxWhaza2
         pJU95qJVx4kGn1pXs21yGTwZQSOf5izwCrxb2ctm20TWoQw69CAv7pvUASr3eH6kEc
         5GXu7vLGC5jG4W4OL+F3ILHjDeUP9BLbwIEdUoQjYW9ufmyFZ2mLUCPRn3rB6SHeyg
         eyGS+PrOSgTM/Qfo6g+xc7CLsrcg0BxVMUXPBLGivZKE4uYmaBjoNEkMyhayFjNbW1
         J3gV4hiUQ3w29j3OjSwIpKKckhttH6ZdSKhMrz5QQ04MWKTFrY3N1R5IqgvmlL/Jbv
         tmJRBLrmGWsXg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/9] regulator: rpi-panel: Register with a unique backlight name
Date:   Thu, 20 Jan 2022 10:21:42 -0500
Message-Id: <20220120152150.1952568-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152150.1952568-1-detlev.casanova@collabora.com>
References: <20220120152150.1952568-1-detlev.casanova@collabora.com>
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

