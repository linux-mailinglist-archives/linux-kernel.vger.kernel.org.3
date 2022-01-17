Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E9490627
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiAQKlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiAQKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:41:03 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:1::465:209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F2C06161C;
        Mon, 17 Jan 2022 02:41:03 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JcpNF1CkLzQjgQ;
        Mon, 17 Jan 2022 11:41:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642416059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJPqdtXimTgX1JvnFhivqUBJea/o8yZVEVyqYw+RAsA=;
        b=j8bHj2WtOqj5k+4cfNwYLo/4G/Ki6PSuFP/7XvCExJ6z74sDZ2WAMELjsUXJ87qBZM220q
        BVgoUxBHzcX/IKY4H+5riklQ3Df+olNWEm7jrhMrbsLlTn5LIp0sfCVRBxk+sEdKtvnLkF
        cHaYlxoIIxocZixdTnGLLzOEkRguJyhpmBbt3amqJ1INLKm6xgIRqo4FPaaPiVHRbhjjA4
        nbq3KVkBEK0IxfSbyUNxHdyiAUyVF18LwZp8Y1iYJnAz8+aXUZZWiqIE9gM/zxNMnhbDyo
        1seY7xB8RHRAI1irYnvcWcDRJVq1Uq/f1K9dopPGQM312GSzbQZRPjkS3277vA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] hwmon: (max6639) Add regulator support
Date:   Mon, 17 Jan 2022 11:40:24 +0100
Message-Id: <4c644f279f6e205d3c9540a4ad35825e4d5f2da1.1642413668.git.sylv@sylv.io>
In-Reply-To: <cover.1642413668.git.sylv@sylv.io>
References: <cover.1642413668.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support for boards where the fan-supply have to be
powered up before it can be used.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/max6639.c | 64 +++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index ccc0f047bd44..0b241f029229 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -87,6 +87,9 @@ struct max6639_data {
 	/* Register values initialized only once */
 	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
 	u8 rpm_range;		/* Index in above rpm_ranges table */
+
+	/* Optional regulator for FAN supply */
+	struct regulator *reg;
 };
 
 static struct max6639_data *max6639_update_device(struct device *dev)
@@ -516,6 +519,11 @@ static int max6639_detect(struct i2c_client *client,
 	return 0;
 }
 
+static void max6639_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
 static int max6639_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -528,6 +536,30 @@ static int max6639_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
+
+	data->reg = devm_regulator_get_optional(dev, "fan");
+	if (IS_ERR(data->reg)) {
+		if (PTR_ERR(data->reg) != -ENODEV) {
+			err = (int)PTR_ERR(data->reg);
+			dev_warn(dev, "Failed looking up fan supply: %d\n", err);
+			return err;
+		}
+		data->reg = NULL;
+	} else {
+		/* Spin up fans */
+		err = regulator_enable(data->reg);
+		if (err) {
+			dev_err(dev, "Failed to enable fan supply: %d\n", err);
+			return err;
+		}
+		err = devm_add_action_or_reset(dev, max6639_regulator_disable,
+					       data->reg);
+		if (err) {
+			dev_err(dev, "Failed to register action: %d\n", err);
+			return err;
+		}
+	}
+
 	mutex_init(&data->update_lock);
 
 	/* Initialize the max6639 chip */
@@ -545,23 +577,39 @@ static int max6639_probe(struct i2c_client *client)
 static int max6639_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-	if (data < 0)
-		return data;
+	struct max6639_data *data = dev_get_drvdata(dev);
+	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+
+	if (ret < 0)
+		return ret;
+
+	if (data->reg)
+		regulator_disable(data->reg);
 
 	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
+			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
 }
 
 static int max6639_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-	if (data < 0)
-		return data;
+	struct max6639_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	if (data->reg) {
+		ret = regulator_enable(data->reg);
+		if (ret) {
+			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+	if (ret < 0)
+		return ret;
 
 	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
+			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.33.1

