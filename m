Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74763495153
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbiATPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376589AbiATPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E831C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:22:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 8A83F1F45346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692160;
        bh=idCRqSfxdKKzhaecaARxomPwbXX0Gq6x7F6Y/PBqvN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsIM9kB+e0zc+lGZ/eKc9qU7DgSH3XAtbt9Ok2jYTIwZ539i6jxCvrjUJsS4OD8up
         tI5LmTwBxKFZMcPgwaD5iTJIHk1atcQXjD5UTv/W/qNDHx+9Tw7/HzM4LMeyJvRyeO
         g5Xi06joYh6I4kZG+eTxbsnA8OzDypzLrKr5UaO06ZthBhxN1IabmfRP9CKgEUJUgM
         iKfxA2vfNXG5hx0TFEvQCcfsebuF9l+s0Bur1aJsR61Oy7Zb/g7vda6VqIhk6heItG
         fM99nKY5lqLJsU6yM+1/eyXPPO8DdHC0Ori1FKQuKKNVphYB6hanXSIa3UWwJrF6Pd
         ZDq10gnR6w+UQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 8/9] regulator/rpi-panel-attiny: Don't read the LCD power status
Date:   Thu, 20 Jan 2022 10:21:49 -0500
Message-Id: <20220120152150.1952568-9-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152150.1952568-1-detlev.casanova@collabora.com>
References: <20220120152150.1952568-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The I2C to the Atmel is very fussy, and locks up easily on
Pi0-3 particularly on reads.

The LCD power status is controlled solely by this driver, so
rather than reading it back from the Atmel, use the cached
status last set.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 8090b9a485b5..8b80c0de1022 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -144,24 +144,8 @@ static int attiny_lcd_power_disable(struct regulator_dev *rdev)
 static int attiny_lcd_power_is_enabled(struct regulator_dev *rdev)
 {
 	struct attiny_lcd *state = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret, i;
-
-	mutex_lock(&state->lock);
-
-	for (i = 0; i < 10; i++) {
-		ret = regmap_read(rdev->regmap, REG_PORTC, &data);
-		if (!ret)
-			break;
-		usleep_range(10000, 12000);
-	}
-
-	mutex_unlock(&state->lock);
-
-	if (ret < 0)
-		return ret;
 
-	return data & PC_RST_BRIDGE_N;
+	return state->port_states[REG_PORTC - REG_PORTA] & PC_RST_BRIDGE_N;
 }
 
 static const struct regulator_init_data attiny_regulator_default = {
-- 
2.34.1

