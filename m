Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93640575EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGOKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGOKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:04:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D229837;
        Fri, 15 Jul 2022 03:04:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x184so4280247pfx.2;
        Fri, 15 Jul 2022 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fo6J+XbkB7jjFutwN0VEI7YAOj/+xVVF5CCYclhdBW8=;
        b=cpZqSeLeXgdFr2xselYTiiyS8QmVWfuiDmxChj7HxYmgiUfjLE8/1PgSKTdXI2l6AY
         hDVqVGF8dd9yNNRSx+ar2TvH/V4prpOelnV9VCpx6zeWFGdsf+aYsYw+2Ea4rIHWsSqF
         tNg9bQagye59J/1AAQy8y0pbU4lyXJH7H+FWPM8uIvg1WjPQNB6zF8MIKhMhNWb8ptvt
         7NbqvmrV1pjyRfVFhhd2UArs2lM0Fhw/hFtZ1OlfT3KrTAAajj+LRSF7IpIAxaEA2ZmP
         QkviGo1oZ6fm4BGxoCSQIQyQYrdMaiTZzSFbQwq2SQ4IisfhWe+izHODLXyFZyWS9Bmv
         ZDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fo6J+XbkB7jjFutwN0VEI7YAOj/+xVVF5CCYclhdBW8=;
        b=T00zc1G+q5ptnahUDonJzuHFwdVnU6EW+SjsjyO/Bb1ibTeqPIenPqmFXRjxUvdUCt
         idLr60xqjV8VmJWICL6/WSBLXnrx7HzxkElsxBkY1nZjvb+axnbyEf+NR1N5oCyvcgjm
         fD4WP2Ctya4VN44vnIEdkQ6rmhBYG92sFBAyIcv29GfLH5ID8CTv+qpd1Lp5+FQ6pezh
         x0GR9TEQaIWvs+pUbXeEb4w418dWM/kMpyTUDx2Qged1wGdKYKYuQhACH1ZYFtji68VB
         c9Lngf8mm+fKLWoFiU157mbqdsSflQfhQJhjimoQBXTB7PrQa7HglNNjxDhVv7jQ92dP
         HR1Q==
X-Gm-Message-State: AJIora9J2SPrPl3ChtDE/eLJyivacFPO4RkbEZksOBGvE+leOOpLkOdn
        jEZAanit+U2fLs7yH4hEnwU=
X-Google-Smtp-Source: AGRyM1tIJYCQbdShB8m/Lq0TBH8HHecZlnvolRiCPWc6nIJdTSDw0VUSFNsGsQCNp4wIVp0QnCZ4bA==
X-Received: by 2002:a05:6a00:1d8f:b0:52a:b787:b480 with SMTP id z15-20020a056a001d8f00b0052ab787b480mr13150767pfw.71.1657879480774;
        Fri, 15 Jul 2022 03:04:40 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:569:4518:3851:6d9:846d:fbd1])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709028d8c00b0016c1948ef7esm3033791plo.296.2022.07.15.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:04:40 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH 3/3] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Date:   Fri, 15 Jul 2022 18:04:18 +0800
Message-Id: <20220715100418.155011-4-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
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

Add compatible with rt1715

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 168 +++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..1fba98e4ef03 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,22 +10,31 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
 #include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
+#define RT1715_DID		0x2173
 
-#define RT1711H_RTCTRL8		0x9B
+#define RT1711H_PHYCTRL1	0x80
+#define RT1711H_PHYCTRL2	0x81
+
+#define RT1711H_RTCTRL4		0x93
+/* rx threshold of rd/rp: 1b0 for level 0.4V/0.7V, 1b1 for 0.35V/0.75V */
+#define RT1711H_BMCIO_RXDZSEL	BIT(0)
 
+#define RT1711H_RTCTRL8		0x9B
 /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
 #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
+#define RT1711H_AUTOIDLEEN_MASK	BIT(3)
+#define RT1711H_ENEXTMSG_MASK	BIT(4)
 
 #define RT1711H_RTCTRL11	0x9E
-
 /* I2C timeout = (tout + 1) * 12.5ms */
 #define RT1711H_RTCTRL11_SET(en, tout) \
 			     (((en) << 7) | ((tout) & 0x0F))
@@ -35,10 +44,17 @@
 #define RT1711H_RTCTRL15	0xA2
 #define RT1711H_RTCTRL16	0xA3
 
+#define RT1711H_RTCTRL18	0xAF
+/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
+#define BMCIO_RXDZEN_MASK	BIT(0)
+
 struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct regulator *vbus;
+	bool src_en;
+	u16 did;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -75,8 +91,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
 
 static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
-	int ret;
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
 
 	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
@@ -84,6 +101,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 	if (ret < 0)
 		return ret;
 
+	/* Enable PD30 extended message for RT1715 */
+	if (chip->did == RT1715_DID) {
+		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
+					 RT1711H_ENEXTMSG_MASK, 0xFF);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* I2C reset : (val + 1) * 12.5ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
 			     RT1711H_RTCTRL11_SET(1, 0x0F));
@@ -101,7 +126,37 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 		return ret;
 
 	/* dcSRC.DRP : 33% */
-	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	if (ret < 0)
+		return ret;
+
+	/* Enable phy discard retry, retry count 7, rx filter deglitech 100 us */
+	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
+	if (ret < 0)
+		return ret;
+
+	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
+	/* wait time : (val * .4167) us */
+	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
+}
+
+static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
+			    bool src, bool snk)
+{
+	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	int ret;
+
+	if (chip->src_en == src)
+		return 1;
+
+	if (src)
+		ret = regulator_enable(chip->vbus);
+	else
+		ret = regulator_disable(chip->vbus);
+
+	if (!ret)
+		chip->src_en = src;
+	return ret ? ret : 1;
 }
 
 static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
@@ -109,8 +164,93 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 {
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
 
-	return rt1711h_write8(chip, RT1711H_RTCTRL8,
-			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
+				  RT1711H_AUTOIDLEEN_MASK, enable ? 0 : 0xFF);
+}
+
+/*
+ * Selects the CC PHY noise filter voltage level according to the current
+ * CC voltage level.
+ *
+ * @param cc_level The CC voltage level for the port's current role
+ * @return EC_SUCCESS if writes succeed; failure code otherwise
+ */
+static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip,
+	enum typec_cc_status cc1, enum typec_cc_status cc2)
+{
+	u32 rxdz_en = 0, rxdz_sel = 0;
+	int ret;
+
+	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
+	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
+		if (chip->did == RT1715_DID) {
+			rxdz_en = 1;
+			rxdz_sel = 1;
+		} else {
+			rxdz_en = 1;
+			rxdz_sel = 0;
+		}
+	} else {
+		rxdz_en = 0;
+		rxdz_sel = 1;
+	}
+
+	ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
+				 BMCIO_RXDZEN_MASK, rxdz_en);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
+				  RT1711H_BMCIO_RXDZSEL, rxdz_en);
+}
+
+#define tcpc_presenting_rd(reg, cc) \
+	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
+	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
+	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
+
+static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
+{
+	switch (cc) {
+	case 0x1:
+		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
+	case 0x2:
+		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
+	case 0x3:
+		if (sink)
+			return TYPEC_CC_RP_3_0;
+		fallthrough;
+	case 0x0:
+	default:
+		return TYPEC_CC_OPEN;
+	}
+}
+
+static int rt1711h_get_cc(struct tcpci *tcpci, struct tcpci_data *tdata,
+			  enum typec_cc_status *cc1, enum typec_cc_status *cc2)
+{
+	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	unsigned int reg, role_control;
+	int ret;
+
+	ret = regmap_read(chip->data.regmap, TCPC_ROLE_CTRL, &role_control);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(chip->data.regmap, TCPC_CC_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	*cc1 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC1_SHIFT) &
+				 TCPC_CC_STATUS_CC1_MASK,
+				 reg & TCPC_CC_STATUS_TERM ||
+				 tcpc_presenting_rd(role_control, CC1));
+	*cc2 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC2_SHIFT) &
+				 TCPC_CC_STATUS_CC2_MASK,
+				 reg & TCPC_CC_STATUS_TERM ||
+				 tcpc_presenting_rd(role_control, CC2));
+
+	return rt1711h_init_cc_params(chip, *cc1, *cc2);
 }
 
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
@@ -209,7 +349,11 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
 		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
 		return -ENODEV;
 	}
-	return 0;
+	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
+	if (ret < 0)
+		return ret;
+	dev_info(&i2c->dev, "did is 0x%04x\n", ret);
+	return ret;
 }
 
 static int rt1711h_probe(struct i2c_client *client,
@@ -228,6 +372,8 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
+	chip->did = ret;
+
 	chip->data.regmap = devm_regmap_init_i2c(client,
 						 &rt1711h_regmap_config);
 	if (IS_ERR(chip->data.regmap))
@@ -245,8 +391,14 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	chip->vbus = devm_regulator_get(&client->dev, "vbus");
+	if (IS_ERR(chip->vbus))
+		return PTR_ERR(chip->vbus);
+
 	chip->data.init = rt1711h_init;
+	chip->data.set_vbus = rt1711h_set_vbus;
 	chip->data.set_vconn = rt1711h_set_vconn;
+	chip->data.get_cc = rt1711h_get_cc;
 	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR_OR_NULL(chip->tcpci))
@@ -273,6 +425,7 @@ static int rt1711h_remove(struct i2c_client *client)
 
 static const struct i2c_device_id rt1711h_id[] = {
 	{ "rt1711h", 0 },
+	{ "rt1715", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
@@ -280,6 +433,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 #ifdef CONFIG_OF
 static const struct of_device_id rt1711h_of_match[] = {
 	{ .compatible = "richtek,rt1711h", },
+	{ .compatible = "richtek,rt1715", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
-- 
2.25.1

