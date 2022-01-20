Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C049514F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbiATPWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:22:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35468 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376568AbiATPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 474F81F4533C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692154;
        bh=r2NUuVpLB3Cn7OcgzQz7XHk2TvhI+FZhqWFg7FO+3BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLly7VUzvC4Qg/0krVuij9DtYEETbpDfY2IziS6baQ8u71D17P/BXPaONx9H3qZEM
         KeKbMX3hsuBh1kYxzFcbAtxqG/iVWepJG9PT4KPmuZrI7s8TYZfSZhxVhe9qPTrd53
         rtrMQkG6Hhh7QM9O2sBy/GeC3V71Af0bTcyFMs0tgbVa1PqXVLVnuQymNIFBF3vA3j
         lZvrc4x4wIbYE6xeZmidJwpYFXWGShXgyAwRPe25uSwmR/u0G+1p+b5kCwUYdUeWBq
         hc+lmIw9EIF5kbJUxQFbrj3mA86/ohdo/mROqzsoM6CXyfJaLUBPHlB7zNE6V3wpiU
         tt6NHHI6ogqrw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/9] regulator: rpi-panel: Ensure the backlight is off during probe.
Date:   Thu, 20 Jan 2022 10:21:45 -0500
Message-Id: <20220120152150.1952568-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120152150.1952568-1-detlev.casanova@collabora.com>
References: <20220120152150.1952568-1-detlev.casanova@collabora.com>
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

