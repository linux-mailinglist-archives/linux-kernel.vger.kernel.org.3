Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429025AD4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiIEO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiIEO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:28:20 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936CA422C8;
        Mon,  5 Sep 2022 07:28:19 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-127a0d798bdso1322142fac.4;
        Mon, 05 Sep 2022 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A5NouqPuiDnL6q/rdfm8x2vhHZikKRjZq+ka8I8miUM=;
        b=DkbEE6JkX9dvi0SwQpFMnODkvnWAwSDBb6dk1wyJ5nkVZKqyTjnEwiRQ5kC7kh40r6
         FPB+4KLTtmvP3CbJQbjp7grN7yZOe8LMVJvnv+UDbLJiKiaEe3zYezPT5r+P1lM1Qr7i
         k4xohIB8dOyqVogmm2QX4DDBnRPHgJ4F7xseh5RVWUjAYSW6zvkSeLsvZo6HGPT75dk3
         U+3yGDhmO6LPkQdbIPxlmCw7Q1yOlPGFXt8sd/Gmbf+Sr47CKk9oFfCsKm/HQUQxzrYu
         JZnKdvT6nf3VYZY5fo6YT/NPb1RmGxtH2RmTanBPu+ZfA0We0BQQD5C4bFlwUav56b2R
         ZoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A5NouqPuiDnL6q/rdfm8x2vhHZikKRjZq+ka8I8miUM=;
        b=ozHyxymCufQ8H55MHRQcj3kpVvhwlQi3So2RFdExsJyh8DaGXmcEqcalfrzeZGRCn+
         PxDhSsABpJP040qiDrJz20OYlWD1sFAneen7aBPGHgQ9oam0sctF6EsFzfz2M2Nr1e8o
         aJUA4X/GaklygwYDZPpZpCqhxR2Z8W26FWQZ/bTB20A0BIrTlC0LiltdyoOZ5oumCmy/
         kM0z/vYKTtIdm9R02zXfnvaQKpnXWW5HeLpRgBwJzHoLV/Qt3uKNi9qT+yuY7TYUnSkt
         RnFgcC3wXttsVyTA2Wfmg05IEVmg35+xPsxlZ3XSBNythcJc+ttde3/XaLGt2J0B69Uw
         dftw==
X-Gm-Message-State: ACgBeo0o0LWw63peYUL8Gh/4djimaBn23hr5nXo5C0eKg/LQVyX7RVtC
        G5kbr1lpmCmeDKC+nbXU6PA=
X-Google-Smtp-Source: AA6agR5QqlYW/I8wNBmnkFOfJwA0I2u+LGbU5S9OVZFUeqAZHqQVED1idoR5hokNVzxXR/PESqN2tA==
X-Received: by 2002:a05:6870:b384:b0:122:43fc:79db with SMTP id w4-20020a056870b38400b0012243fc79dbmr9212840oap.197.1662388098795;
        Mon, 05 Sep 2022 07:28:18 -0700 (PDT)
Received: from nuclearis3.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id n17-20020a056870241100b0011f00b027bdsm2052857oap.45.2022.09.05.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:28:18 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, jdelvare@suse.com,
        dev@aboehler.at, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 2/3] hwmon: (tps23861) reduce count of i2c transactions for port_status
Date:   Mon,  5 Sep 2022 09:28:05 -0500
Message-Id: <20220905142806.110598-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220905142806.110598-1-mr.nuke.me@gmail.com>
References: <20220905142806.110598-1-mr.nuke.me@gmail.com>
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

When reading the 'port_status' debugfs entry, some I2C registers were
read more than once. This looks inefficient in an I2C trace.

To reduce I2C traffic, update tps23861_port_status_show() to only read
each register once. Indexing the port number from 0 instead of 1 also
allows simplifying things a bit, resulting in a negative line count.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/hwmon/tps23861.c | 75 ++++++++++++----------------------------
 1 file changed, 22 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index f7c59ff7ae8e..0dbd12060b50 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -372,29 +372,12 @@ static const struct hwmon_chip_info tps23861_chip_info = {
 	.info = tps23861_info,
 };
 
-static char *tps23861_port_operating_mode(struct tps23861_data *data, int port)
+static char *port_operating_mode_string(uint8_t mode_reg, unsigned int port)
 {
-	unsigned int regval;
-	int mode;
-
-	regmap_read(data->regmap, OPERATING_MODE, &regval);
+	unsigned int mode = ~0;
 
-	switch (port) {
-	case 1:
-		mode = FIELD_GET(OPERATING_MODE_PORT_1_MASK, regval);
-		break;
-	case 2:
-		mode = FIELD_GET(OPERATING_MODE_PORT_2_MASK, regval);
-		break;
-	case 3:
-		mode = FIELD_GET(OPERATING_MODE_PORT_3_MASK, regval);
-		break;
-	case 4:
-		mode = FIELD_GET(OPERATING_MODE_PORT_4_MASK, regval);
-		break;
-	default:
-		mode = -EINVAL;
-	}
+	if (port < TPS23861_NUM_PORTS)
+		mode = (mode_reg >> (2 * port)) & OPERATING_MODE_PORT_1_MASK;
 
 	switch (mode) {
 	case OPERATING_MODE_OFF:
@@ -410,15 +393,9 @@ static char *tps23861_port_operating_mode(struct tps23861_data *data, int port)
 	}
 }
 
-static char *tps23861_port_detect_status(struct tps23861_data *data, int port)
+static char *port_detect_status_string(uint8_t status_reg)
 {
-	unsigned int regval;
-
-	regmap_read(data->regmap,
-		    PORT_1_STATUS + (port - 1),
-		    &regval);
-
-	switch (FIELD_GET(PORT_STATUS_DETECT_MASK, regval)) {
+	switch (FIELD_GET(PORT_STATUS_DETECT_MASK, status_reg)) {
 	case PORT_DETECT_UNKNOWN:
 		return "Unknown device";
 	case PORT_DETECT_SHORT:
@@ -448,15 +425,9 @@ static char *tps23861_port_detect_status(struct tps23861_data *data, int port)
 	}
 }
 
-static char *tps23861_port_class_status(struct tps23861_data *data, int port)
+static char *port_class_status_string(uint8_t status_reg)
 {
-	unsigned int regval;
-
-	regmap_read(data->regmap,
-		    PORT_1_STATUS + (port - 1),
-		    &regval);
-
-	switch (FIELD_GET(PORT_STATUS_CLASS_MASK, regval)) {
+	switch (FIELD_GET(PORT_STATUS_CLASS_MASK, status_reg)) {
 	case PORT_CLASS_UNKNOWN:
 		return "Unknown";
 	case PORT_CLASS_RESERVED:
@@ -479,16 +450,9 @@ static char *tps23861_port_class_status(struct tps23861_data *data, int port)
 	}
 }
 
-static char *tps23861_port_poe_plus_status(struct tps23861_data *data, int port)
+static char *port_poe_plus_status_string(uint8_t poe_plus, unsigned int port)
 {
-	unsigned int regval;
-
-	regmap_read(data->regmap, POE_PLUS, &regval);
-
-	if (BIT(port + 3) & regval)
-		return "Yes";
-	else
-		return "No";
+	return (BIT(port + 4) & poe_plus) ? "Yes" : "No";
 }
 
 static int tps23861_port_resistance(struct tps23861_data *data, int port)
@@ -497,7 +461,7 @@ static int tps23861_port_resistance(struct tps23861_data *data, int port)
 	__le16 regval;
 
 	regmap_bulk_read(data->regmap,
-			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * (port - 1),
+			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * port,
 			 &regval,
 			 2);
 
@@ -517,14 +481,19 @@ static int tps23861_port_resistance(struct tps23861_data *data, int port)
 static int tps23861_port_status_show(struct seq_file *s, void *data)
 {
 	struct tps23861_data *priv = s->private;
-	int i;
+	unsigned int i, mode, poe_plus, status;
+
+	regmap_read(priv->regmap, OPERATING_MODE, &mode);
+	regmap_read(priv->regmap, POE_PLUS, &poe_plus);
+
+	for (i = 0; i < TPS23861_NUM_PORTS; i++) {
+		regmap_read(priv->regmap, PORT_1_STATUS + i, &status);
 
-	for (i = 1; i < TPS23861_NUM_PORTS + 1; i++) {
 		seq_printf(s, "Port: \t\t%d\n", i);
-		seq_printf(s, "Operating mode: %s\n", tps23861_port_operating_mode(priv, i));
-		seq_printf(s, "Detected: \t%s\n", tps23861_port_detect_status(priv, i));
-		seq_printf(s, "Class: \t\t%s\n", tps23861_port_class_status(priv, i));
-		seq_printf(s, "PoE Plus: \t%s\n", tps23861_port_poe_plus_status(priv, i));
+		seq_printf(s, "Operating mode: %s\n", port_operating_mode_string(mode, i));
+		seq_printf(s, "Detected: \t%s\n", port_detect_status_string(status));
+		seq_printf(s, "Class: \t\t%s\n", port_class_status_string(status));
+		seq_printf(s, "PoE Plus: \t%s\n", port_poe_plus_status_string(poe_plus, i));
 		seq_printf(s, "Resistance: \t%d\n", tps23861_port_resistance(priv, i));
 		seq_putc(s, '\n');
 	}
-- 
2.34.3

