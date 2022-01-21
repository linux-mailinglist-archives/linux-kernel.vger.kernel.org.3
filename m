Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E64961EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381533AbiAUPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381534AbiAUPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A43C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:21:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 3B6371F4620F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778487;
        bh=80BI0zXGQTgN05p6AlFLM+LNKFXJZZRY/BLdFYtbkxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdCia6B48T1WyJRbqV8VBwL8L2R4Mj6Sw4lTyCXLVSo94MEaVq9cYJvp4oeh9pqra
         1zekUD/QHR8DuhwX2Zg2l61JWosNxZt0mRn1E3geN5WYG8seWBlIVemUy4FaawJ+k+
         nZdFTEJSgHILOWJDPNnrgSiscwifKIVCTZYSttAJ2Owk1PtttB8ss7FXbKoS1MIVtA
         YOM8JVI6xmKd/MJLm1dCsXV40UvfKUDbgPqrF1emPZZe7TebDxpJDifjWw2rjLO1B+
         bikzjN31KuCgwBSCrgCmT+k/dCERzwt4S5D4XeouWFd95VhoD96g2R1JIVTsD57RK9
         l2joZQtTCl12A==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/9] regulator: rpi-panel: Register with a unique backlight name
Date:   Fri, 21 Jan 2022 10:20:48 -0500
Message-Id: <20220121152056.2044551-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
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

