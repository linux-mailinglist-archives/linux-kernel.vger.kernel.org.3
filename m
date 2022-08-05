Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD158A6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiHEHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiHEHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:18:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2B74DFF;
        Fri,  5 Aug 2022 00:18:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso7462707pjf.5;
        Fri, 05 Aug 2022 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEVGEWigHsjLc/9KUb1DdWR50Rx5DGz/VoYfslPo05w=;
        b=qmNnXznenDiFBsdgJDVRWbtNE+WQ+7M53YC9VxiHCqqVSb9yD2AYW9MTxTfaul2x3E
         9aUwUfYzKZyAf3VzYj3sfXZnA+wGxyoJWL78hnZfwNfgSVhwN+GXLVvQQAVaAyBC/P1b
         O75sgbcTWntlPiNt06BxkH8SWxrPM+6t1w4xsdKRIfSsTFj+fEFKGF3ppM5JntSVWDpD
         6gatcDSJFdjjn3eCmB5D2lC0brxOCXq6NqHpT639JY4pUUdoflY72i+SqxBwwckTGb0s
         R1GL0MqtP9s0b6QQBLJRSPZh0KMc6NW5W28MkaTgOBrNbPGEyKLJTWfX128v44V0xOAO
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEVGEWigHsjLc/9KUb1DdWR50Rx5DGz/VoYfslPo05w=;
        b=RSNuk6V56tkCyAk0l85nYejipV1mGpOfmsQRuA7x4RGDSQAoPQ9lE/plIv6O8HzNMq
         w4KwgHl9Rt4VPGqrUx4Dfh616F/4r13lGiVoOIe+jWZdMLZO2ScxdSRZmEPI6J0cgaJN
         GOfuNDu/L3ce97VHErYeYfAlpO+4DOvFrFw+o+U4uJpd1QMgUKJESgU2+N0wKEUj1j46
         Yf9IrL0lsC/uuYrPB38Hm30b0nd98qiYOh2ypAWzXx8bXe2i0UoOFin30QwYVZaFG4jA
         9sONxvIRorn+M7JVugRAzVmOsUdZg0SNH7Gye+TOUa1PQ7hejXGUie/qo5XxYlgCug+o
         kw1g==
X-Gm-Message-State: ACgBeo1p9f5lt3Cuz4cZhkFtrbm4oeZ6EzMudNez6mzRxTO3yFxo1xoi
        JZyCgtb3b0bWQZrii1bwPeY=
X-Google-Smtp-Source: AA6agR5w1kRyMmJe2RLaIkObkC5qWpAjhhuaR8cKPGGqF+Wd9GpK1ZuiWFj3nNJwPCv1iAwgQOJ4mw==
X-Received: by 2002:a17:90a:1b8e:b0:1f3:7c7:9c3 with SMTP id w14-20020a17090a1b8e00b001f307c709c3mr14660124pjc.8.1659683887706;
        Fri, 05 Aug 2022 00:18:07 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:18:07 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 5/7] usb: typec: tcpci_rt1711h: Add compatible id with rt1715
Date:   Fri,  5 Aug 2022 15:17:11 +0800
Message-Id: <20220805071714.150882-6-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add compatible id with rt1715, and add initial setting for
specific support PD30 command.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 43 +++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 5c51d04..ff7deae 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -18,6 +18,8 @@
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
+#define RT1711H_DID		0x2171
+#define RT1715_DID		0x2173
 
 #define RT1711H_PHYCTRL1	0x80
 #define RT1711H_PHYCTRL2	0x81
@@ -29,6 +31,7 @@
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
 #define RT1711H_AUTOIDLEEN	BIT(3)
+#define RT1711H_ENEXTMSG	BIT(4)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -47,6 +50,7 @@ struct rt1711h_chip {
 	struct device *dev;
 	struct regulator *vbus;
 	bool src_en;
+	u16 did;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -83,8 +87,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
 
 static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
-	int ret;
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
 
 	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
@@ -92,6 +97,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 	if (ret < 0)
 		return ret;
 
+	/* Enable PD30 extended message for RT1715 */
+	if (chip->did == RT1715_DID) {
+		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
+					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* I2C reset : (val + 1) * 12.5ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
 			     RT1711H_RTCTRL11_SET(1, 0x0F));
@@ -229,7 +242,7 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 	return 0;
 }
 
-static int rt1711h_check_revision(struct i2c_client *i2c)
+static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *chip)
 {
 	int ret;
 
@@ -247,7 +260,15 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
 		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
 		return -ENODEV;
 	}
-	return 0;
+	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
+	if (ret < 0)
+		return ret;
+	if (ret != chip->did) {
+		dev_err(&i2c->dev, "did is not correct, 0x%04x\n", ret);
+		return -ENODEV;
+	}
+	dev_dbg(&i2c->dev, "did is 0x%04x\n", ret);
+	return ret;
 }
 
 static int rt1711h_probe(struct i2c_client *client,
@@ -256,16 +277,18 @@ static int rt1711h_probe(struct i2c_client *client,
 	int ret;
 	struct rt1711h_chip *chip;
 
-	ret = rt1711h_check_revision(client);
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->did = (size_t)device_get_match_data(&client->dev);
+
+	ret = rt1711h_check_revision(client, chip);
 	if (ret < 0) {
 		dev_err(&client->dev, "check vid/pid fail\n");
 		return ret;
 	}
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
 	chip->data.regmap = devm_regmap_init_i2c(client,
 						 &rt1711h_regmap_config);
 	if (IS_ERR(chip->data.regmap))
@@ -316,13 +339,15 @@ static int rt1711h_remove(struct i2c_client *client)
 
 static const struct i2c_device_id rt1711h_id[] = {
 	{ "rt1711h", 0 },
+	{ "rt1715", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id rt1711h_of_match[] = {
-	{ .compatible = "richtek,rt1711h", },
+	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
+	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
-- 
2.7.4

