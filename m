Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58DD49A7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315591AbiAYCxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374234AbiAYAQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50023C038AF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:01:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 954E11F438FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061702;
        bh=mp0tkZLX7tw26KY5Skjy5PePDYT8EZn9ewhzvxDKrbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCT33eWqw4pxs+yhUVMZLtqSf/8GYh0J4Wkp6nTh5xxs+5b9p+y2hWcBpd/AqYSmA
         oRI7XkvYLCPHIDnhAwuKXr1rRWTEoFc9da7YMdS1R0wxXHSdHIZJdI3JwxHwnwoVfa
         MYeExtx3CPjl1zMpFS8KQ1pNrM8XGpbMgGLEb8jL1d9TlLMMAZVxU6zuk1gE5N/CYL
         oHnImIqjs4aiwOpm/NgNkaM/wJU4+F4a70TbpUPualPksdjdBp4FEA7BLtoL0Z3zCh
         SCSBcjAp4UffpzkRIyjI7ZFzmGQMntQ3orHxi0r8oxLqVvBxixgXsxlGTPTHfAs6rL
         acZNeeFUCsdSg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 4/9] regulator: rpi-panel: Ensure the backlight is off during probe.
Date:   Mon, 24 Jan 2022 17:01:24 -0500
Message-Id: <20220124220129.158891-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The initial state of the Atmel is not defined, so ensure the
backlight PWM is set to 0 by default.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
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

