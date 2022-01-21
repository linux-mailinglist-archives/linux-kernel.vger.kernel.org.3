Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9D4961F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381605AbiAUPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:21:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381510AbiAUPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:21:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 8BEBD1F4620F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642778494;
        bh=2mB2P4wQOPq9kSLMyvSy9LaY6Q067M0W9yvzSk3DLlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmbb5e3qEsxmWG6cBbBUEN8rAxqpUBtJbUtt8ef1TJ2wriBuLgayzlVYjC8s2qQFs
         C4IzTdk93dIe4cZJ/48G+doZd1RklQ0Sp/aPkDasJXBM4Nm/tJmwJCR7DDb2tIex3z
         OBWi4hm2FIYIOoNtZ/o1GBFptDoZBYi4SXySuxqMApGOcdl4n9P6u7Ac6VvEdgyCjn
         WlLaz7bL9eQ3jbTFYqQRekTkd0DzNzDG9zix7jrfVrxhzNtLI0jKtNz1LmPoWMzHHl
         k89lS9ySGlUkMiSVFCRbaBhDS5SPGOSF27W5UFxb/DLDI66moh1Ij/dDYFcCMcU0Uj
         5mdVO341/5Nlg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 9/9] regulator/rpi-panel-attiny: Use two transactions for I2C read
Date:   Fri, 21 Jan 2022 10:20:56 -0500
Message-Id: <20220121152056.2044551-10-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121152056.2044551-1-detlev.casanova@collabora.com>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The I2C to the Atmel is very fussy, and locks up easily on
Pi0-3 particularly on reads.
If running at 100kHz on Pi3, reading the ID register generally
locks up the Atmel, but splitting the register select write and
read into two transactions is reliable.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../regulator/rpi-panel-attiny-regulator.c    | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 8b80c0de1022..e3decc419814 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -234,6 +234,39 @@ static void attiny_gpio_set(struct gpio_chip *gc, unsigned int off, int val)
 	mutex_unlock(&state->lock);
 }
 
+static int attiny_i2c_read(struct i2c_client *client, u8 reg, unsigned int *buf)
+{
+	struct i2c_msg msgs[1];
+	u8 addr_buf[1] = { reg };
+	u8 data_buf[1] = { 0, };
+	int ret;
+
+	/* Write register address */
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = ARRAY_SIZE(addr_buf);
+	msgs[0].buf = addr_buf;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	usleep_range(5000, 10000);
+
+	/* Read data from register */
+	msgs[0].addr = client->addr;
+	msgs[0].flags = I2C_M_RD;
+	msgs[0].len = 1;
+	msgs[0].buf = data_buf;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*buf = data_buf[0];
+	return 0;
+}
+
 /*
  * I2C driver interface functions
  */
@@ -264,7 +297,7 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 		goto error;
 	}
 
-	ret = regmap_read(regmap, REG_ID, &data);
+	ret = attiny_i2c_read(i2c, REG_ID, &data);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read REG_ID reg: %d\n", ret);
 		goto error;
-- 
2.34.1

