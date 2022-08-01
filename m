Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0731E58676E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiHAK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiHAK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2531A04A;
        Mon,  1 Aug 2022 03:27:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w7so10027041ply.12;
        Mon, 01 Aug 2022 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hld/LwJZmpI7SSFkZzrwucLdPGX6JD19gxp/p1qSXXA=;
        b=Axx8121q9h4v9e99XYadG6Kg7vgzQec74kh60Otf9yCT/h/x3UgvEyNiCNIGiw+ina
         jmHyAI9BKZtj3QEvkoTnkZ+q5xLBcvS5umkwM+QPyzREv9bdjlCKU9lqWxuILm0z5eh3
         Kbhb1ycRsWAWRGi6QTHCrk0NYBPOm4lVBZobu5PD7+2ASpHqeEaGkHbLRGwi756GUu1N
         bHvFdO1cUzU5bbc1vrLhFMAGTLxArGBmAHZS1y7vOQpuziwquBHks6q535OECy8yeDFX
         pI6E8OK812rb7pCVylB3Bbx/HSq/+nKyrkGaTITU+aGEu0PpWpprBi2I8VNIh5UR4qf8
         IlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hld/LwJZmpI7SSFkZzrwucLdPGX6JD19gxp/p1qSXXA=;
        b=lo1dEuDWzCM1/Ii9Du3+ChE/LbKSnqrw30JeVRdbsMS07uLfNxlvCsLw2+B5KsDa47
         VFd8pWukV/mEhJKDMLTFNKrXes5QT1s1xeoU2lvO4hq7Mju4vOK7hdZB0fT3PiV5EwBm
         cVRc+Hko+koQA+0B8N6TuKRcrN81OCluD377cNrfiorLwTXa3pw0a3krzBJnRCBXcYpT
         +ze5RMd/mdl9J2AzKmduDNqH+R13f72+HZ00CQRzbRTiO+x1abMaYLyZ3Xf5egHDtOZe
         5X4f0cKNOSEtiRhfMbRIlJu0GdNQ+N37PPU6OssJbu8iZ6Dfvez4VFykz/irFwQHjfUu
         f4zw==
X-Gm-Message-State: ACgBeo1U1Pto64NChsliouO0EG+QIApoW1oQAvguqtCX1+5oko1ybFXs
        DGOphTo3VQDcTjP+2BQNQJrpefq93Qw=
X-Google-Smtp-Source: AA6agR4wZ1ePsXl/0MxEGav1fKUQLipX9uPB5Uw9DNNNZsGCAmkrqonwyl6Ou+ZfFjL7RcLszY+AHg==
X-Received: by 2002:a17:902:ca0b:b0:16d:d562:42dc with SMTP id w11-20020a170902ca0b00b0016dd56242dcmr13586425pld.26.1659349648338;
        Mon, 01 Aug 2022 03:27:28 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:28 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 5/7] usb: typec: tcpci_rt1711h: Add compatible id with rt1715
Date:   Mon,  1 Aug 2022 18:14:45 +0800
Message-Id: <20220801101447.86207-6-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
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
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 43 ++++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 33d8ea95b7c1..da35dd3e8a59 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -19,6 +19,8 @@
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
+#define RT1711H_DID		0x2171
+#define RT1715_DID		0x2173
 
 #define RT1711H_PHYCTRL1	0x80
 #define RT1711H_PHYCTRL2	0x81
@@ -30,6 +32,7 @@
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
 #define RT1711H_AUTOIDLEEN	BIT(3)
+#define RT1711H_ENEXTMSG	BIT(4)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -48,6 +51,7 @@ struct rt1711h_chip {
 	struct device *dev;
 	struct regulator *vbus;
 	bool src_en;
+	u16 did;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -84,8 +88,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
 
 static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
-	int ret;
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
 
 	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
@@ -93,6 +98,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
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
@@ -230,7 +243,7 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 	return 0;
 }
 
-static int rt1711h_check_revision(struct i2c_client *i2c)
+static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *chip)
 {
 	int ret;
 
@@ -248,7 +261,15 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
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
@@ -257,16 +278,18 @@ static int rt1711h_probe(struct i2c_client *client,
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
@@ -317,13 +340,15 @@ static int rt1711h_remove(struct i2c_client *client)
 
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
2.25.1

