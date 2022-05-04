Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF751A3FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352392AbiEDP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiEDP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:28:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4E4474B;
        Wed,  4 May 2022 08:24:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so3446159wmj.1;
        Wed, 04 May 2022 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0+dOonjyXB+u/RPDdGeIJKQE4fMwvUsn4WlnEiMshU=;
        b=YY9vBebDEgCZNjAmaLhjdYzaTqnAHEGlxSJawmMGqbg4pKN4YjtYcHCjw9OGiyf/ye
         vzqWImpXfFCqll276rqhRwlIiIwLSGTUBHEAhdvuq5ZkiQjBPZBXwxVJndESB6fcuBKY
         vohnEeNggv73lCZjTOpgdXdyn++4g8Sw1mbv8rhS8oeOPOaTHlaDOsDKPL3JQUg0CNj1
         ktyCdYJJdzbw+nipTopjOCLDR3cShnhLL+ZpU+/SyJUUEyqrYsG4W+Cztfaso9JytgS1
         q/O0Eilz3fkUYNUYYslcm08o9f7gZA1vzw95zwYIZZeUhVa1rQtPXGOHAt64SXzIL8sf
         pj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0+dOonjyXB+u/RPDdGeIJKQE4fMwvUsn4WlnEiMshU=;
        b=WQgEPhrfRUqKrxg1u0pnuOH3QraeWR7YJHQzRn7osB8CY814y+rQvro+y4jsdVefGk
         +huisbL4JDtWG/74p59Uj4UjAUez1EcAfR0wgNKaZwlf3FQ5RzKMCQlVUnvWS7wjbK8R
         92oktnSdnNzj9i+19qSpSj7dJX5Jpy/hGQ9MPwi5gBHZHTt10zDbyA5gTDMC6vxRijBk
         GRaEQO0/rV72uecxT08ikpVeAjOtQS8x84yIM7DcKXjcjXll1X/UkzDQRoDqk3M0Ti2D
         0pT5tj3596sNUK7hfdWPAOg2H9QzoCOREHd2NqpOlLipMsmK8z30b705h0CsJ9xxvxq+
         XEVw==
X-Gm-Message-State: AOAM53059HknQzupbFZT/EEKV3XsdnxUe2KNNzBvg8OoPMQ41TL+0k3D
        ESJbjdvbSKhyJxt1wnugEDmKjc9ck00=
X-Google-Smtp-Source: ABdhPJxuCA0jS5OuPVXnnGgLs8Hy3fEvmxK8UOE0o/zR+PYdbBt5zeS6/NiNrBZ7/rymeQnCRK/sZA==
X-Received: by 2002:a05:600c:1f0d:b0:394:23f0:4530 with SMTP id bd13-20020a05600c1f0d00b0039423f04530mr18326wmb.30.1651677887892;
        Wed, 04 May 2022 08:24:47 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id s14-20020adfa28e000000b0020c5253d91csm11541041wra.104.2022.05.04.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:24:47 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] input/touchscreen: imagis: Add support for Imagis IST3038B
Date:   Wed,  4 May 2022 18:24:05 +0300
Message-Id: <20220504152406.8730-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504152406.8730-1-markuss.broks@gmail.com>
References: <20220504152406.8730-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imagis IST3038B is another variant of Imagis IST3038 IC, which has
a different register interface from IST3038C (possibly firmware defined).
This should also work for IST3044B (though untested), however other
variants using this interface/protocol(IST3026, IST3032, IST3026B,
IST3032B) have a different format for coordinates, and they'd need
additional effort to be supported by this driver.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/imagis.c | 58 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index b667914a44f1..57bb8f31ac1f 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -13,7 +13,7 @@
 
 #define IST3038C_HIB_ACCESS		(0x800B << 16)
 #define IST3038C_DIRECT_ACCESS		BIT(31)
-#define IST3038C_REG_CHIPID		0x40001000
+#define IST3038C_REG_CHIPID		(0x40001000 | IST3038C_DIRECT_ACCESS)
 #define IST3038C_REG_HIB_BASE		0x30000100
 #define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
 #define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
@@ -31,8 +31,21 @@
 #define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
+#define IST3038B_REG_STATUS		0x20
+#define IST3038B_REG_CHIPID		0x30
+#define IST3038B_WHOAMI			0x30380b
+
+struct imagis_properties {
+	unsigned int interrupt_msg_cmd;
+	unsigned int touch_coord_cmd;
+	unsigned int whoami_cmd;
+	unsigned int whoami_val;
+	bool protocol_b;
+};
+
 struct imagis_ts {
 	struct i2c_client *client;
+	const struct imagis_properties *tdata;
 	struct input_dev *input_dev;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
@@ -84,8 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	int i;
 	int error;
 
-	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE,
-				    &intr_message);
+	error = imagis_i2c_read_reg(ts, ts->tdata->interrupt_msg_cmd, &intr_message);
 	if (error) {
 		dev_err(&ts->client->dev,
 			"failed to read the interrupt message: %d\n", error);
@@ -104,9 +116,13 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
 
 	for (i = 0; i < finger_count; i++) {
-		error = imagis_i2c_read_reg(ts,
-					    IST3038C_REG_TOUCH_COORD + (i * 4),
-					    &finger_status);
+		if (ts->tdata->protocol_b)
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd, &finger_status);
+		else
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd + (i * 4),
+						    &finger_status);
 		if (error) {
 			dev_err(&ts->client->dev,
 				"failed to read coordinates for finger %d: %d\n",
@@ -261,6 +277,12 @@ static int imagis_probe(struct i2c_client *i2c)
 
 	ts->client = i2c;
 
+	ts->tdata = device_get_match_data(dev);
+	if (!ts->tdata) {
+		dev_err(dev, "missing chip data\n");
+		return -EINVAL;
+	}
+
 	error = imagis_init_regulators(ts);
 	if (error) {
 		dev_err(dev, "regulator init error: %d\n", error);
@@ -279,15 +301,13 @@ static int imagis_probe(struct i2c_client *i2c)
 		return error;
 	}
 
-	error = imagis_i2c_read_reg(ts,
-			IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS,
-			&chip_id);
+	error = imagis_i2c_read_reg(ts, ts->tdata->whoami_cmd, &chip_id);
 	if (error) {
 		dev_err(dev, "chip ID read failure: %d\n", error);
 		return error;
 	}
 
-	if (chip_id != IST3038C_WHOAMI) {
+	if (chip_id != ts->tdata->whoami_val) {
 		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
 		return -EINVAL;
 	}
@@ -343,9 +363,25 @@ static int __maybe_unused imagis_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3038b_data = {
+	.interrupt_msg_cmd = IST3038B_REG_STATUS,
+	.touch_coord_cmd = IST3038B_REG_STATUS,
+	.whoami_cmd = IST3038B_REG_CHIPID,
+	.whoami_val = IST3038B_WHOAMI,
+	.protocol_b = true,
+};
+
+static const struct imagis_properties imagis_3038c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3038C_WHOAMI,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
-	{ .compatible = "imagis,ist3038c", },
+	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
+	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imagis_of_match);
-- 
2.35.1

