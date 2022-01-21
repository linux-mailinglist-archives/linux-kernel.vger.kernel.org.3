Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257B24961F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381574AbiAUPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381536AbiAUPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8BC061744
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:21:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 8F1B61F46214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778490;
        bh=r2NUuVpLB3Cn7OcgzQz7XHk2TvhI+FZhqWFg7FO+3BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzNQpGdnZS5R/oj54hGdYMdDgIy6KogxpbzxvxykxzNTQTvClZuOE5FTwJe0+BMcG
         ZG5YR59CGUI6JgJvfx1pEgdo5iSyva3jH+CWEGPoxIz38+xosa0X4cN9MxMJP/4VkX
         eJ8pYuiD1TSDM4vhYhK6dhd724flyIzpzAMYu6+GmeLFfxfdCyhEXcpLHMrQYvPgRS
         dHMbmDhrzKw843StpRG52M/BKdwFAB+2JfaI9U5BkEfLPMcH/wd0536BbSSJo1N4ro
         hZ6yzoCAuIEcsZ9Xf+lHYzl+oElk06p+8jV4m663/gRXt5p6qV38PKAzxptVewnmGM
         aGvJokb0giCHw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/9] regulator: rpi-panel: Ensure the backlight is off during probe.
Date:   Fri, 21 Jan 2022 10:20:51 -0500
Message-Id: <20220121152056.2044551-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The initial state of the Atmel is not defined, so ensure the
backlight PWM is set to 0 by default.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index a4af7adad2b5..b3629a1e0e50 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -250,6 +250,7 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(regmap, REG_POWERON, 0);
 	msleep(30);
+	regmap_write(regmap, REG_PWM, 0);
 
 	config.dev = &i2c->dev;
 	config.regmap = regmap;
-- 
2.34.1

