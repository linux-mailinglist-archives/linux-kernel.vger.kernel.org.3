Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0C5AF989
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIGByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:54:11 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59D84EFA;
        Tue,  6 Sep 2022 18:54:08 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12243fcaa67so32630338fac.8;
        Tue, 06 Sep 2022 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uBXAhg5xwFy0mhOLbydMclamY/1BpuecKL5EQM7c3VY=;
        b=eKfoAT/A0CaJroi9nBiMh4Bz1DrRiYOD1UJ1DKGpM6vroLunU65HPw7W9LEfKwMSD7
         SjaUDrugGFOCEu4mF4zHIQHga7P/zYccd429CGaQRTZSPKnxoBSm3KYyG61jrWpOy4Gf
         55QdufY0cP4jlHAbUfyIQk8uzRuVKjwzJsxJ78fz80bDlhuWti7mRyWoLLzRZFN5VjCR
         zHSmx/H+gDhhBu/YS1vuBUm9CIcAFEK0PzU6ZMXdTeZuCr3/SVtl+9A9/9vxuJWr1If5
         r2tGn0HNbuLF2K2gZah+yje69ZIWv0SNcAKO0CXKBdlRLPNC/aLJVbF0SvDYlxy5ddaF
         aCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uBXAhg5xwFy0mhOLbydMclamY/1BpuecKL5EQM7c3VY=;
        b=PuTB2YsXtdc0Xc/3dVrzvUlNEF5kU9fLPiuMzXOgaqstwT0F/ngYWsdBgoxKvAxLcy
         HRXmrOwokjQZ5ZGZMPZLfLkcfcIreE38766wOZ+9Xtq+mJQkv+MmAclvIxwF397lBWlX
         c2vGIQWofJIp+yrkTiI3nFHdqf5WdKjJbYuH8y5pOt0yxWzVV7+ijPFgbjRehtY/gWC0
         zc+laH6arFCEYUlJSiyjZZb9qepPuWywq1yGZYdb63gEf7N6JGFS9Uj+g7XLQQU3hfi4
         eAAjm7BE1WhpVIDI4abjo/cE2jfcYqDfEEBwapNvv54ZCMB6V38evhwvTst36HSio5XS
         b/Bg==
X-Gm-Message-State: ACgBeo2BEJZq9Mku3ZQYVpGb83SE3Hx7wrfu/m9aOGenWR9SgJWn8WhT
        nwNNekggXPE9q5vCTqlPWfw=
X-Google-Smtp-Source: AA6agR6hiYlQN79qU5CAlOiZnUMoPF8Cfxrxi+chj6IKfP+tqEhI7bW69QqbXrSfVtBfqlfIE5YEmA==
X-Received: by 2002:a05:6808:140a:b0:345:7a77:2e9a with SMTP id w10-20020a056808140a00b003457a772e9amr10797191oiv.225.1662515647447;
        Tue, 06 Sep 2022 18:54:07 -0700 (PDT)
Received: from nuclearis3.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870e24800b0011e4c574dfcsm7951595oac.40.2022.09.06.18.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 18:54:07 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, jdelvare@suse.com,
        dev@aboehler.at, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 2/3] hwmon: (tps23861) reduce count of i2c transactions for port_status
Date:   Tue,  6 Sep 2022 20:54:04 -0500
Message-Id: <20220907015405.16547-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.34.3
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
allows simplifying things a bit.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
  - Do not brag about negative line count in commit message
  - Do not change port number in port_status output

 drivers/hwmon/tps23861.c | 79 ++++++++++++----------------------------
 1 file changed, 24 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index f7c59ff7ae8e..019009b71a90 100644
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
+	unsigned int mode = ~0;
 
-	regmap_read(data->regmap, OPERATING_MODE, &regval);
-
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
-
-	for (i = 1; i < TPS23861_NUM_PORTS + 1; i++) {
-		seq_printf(s, "Port: \t\t%d\n", i);
-		seq_printf(s, "Operating mode: %s\n", tps23861_port_operating_mode(priv, i));
-		seq_printf(s, "Detected: \t%s\n", tps23861_port_detect_status(priv, i));
-		seq_printf(s, "Class: \t\t%s\n", tps23861_port_class_status(priv, i));
-		seq_printf(s, "PoE Plus: \t%s\n", tps23861_port_poe_plus_status(priv, i));
+	unsigned int i, mode, poe_plus, status;
+
+	regmap_read(priv->regmap, OPERATING_MODE, &mode);
+	regmap_read(priv->regmap, POE_PLUS, &poe_plus);
+
+	for (i = 0; i < TPS23861_NUM_PORTS; i++) {
+		regmap_read(priv->regmap, PORT_1_STATUS + i, &status);
+
+		seq_printf(s, "Port: \t\t%d\n", i + 1);
+		seq_printf(s, "Operating mode: %s\n", port_operating_mode_string(mode, i));
+		seq_printf(s, "Detected: \t%s\n", port_detect_status_string(status));
+		seq_printf(s, "Class: \t\t%s\n", port_class_status_string(status));
+		seq_printf(s, "PoE Plus: \t%s\n", port_poe_plus_status_string(poe_plus, i));
 		seq_printf(s, "Resistance: \t%d\n", tps23861_port_resistance(priv, i));
 		seq_putc(s, '\n');
 	}
-- 
2.34.3

