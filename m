Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840D58A6F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiHEHTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiHEHSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:18:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246A74DEB;
        Fri,  5 Aug 2022 00:18:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g12so1541812pfb.3;
        Fri, 05 Aug 2022 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdJjDYFxYS68E9ZUvuM71CJZvMzbAXojm0SHTDHnZVE=;
        b=M3EQBeTYuIoV/C+5aXlU6ck4Rp/nhgyHrBFT4nyoKJpeGmGV/3BnSE+U8efjyBwvRh
         xSeToo/qe1lbMQvTxoG8trK9RwJZVy7aLGKsmC1m+03T/N8/YocjMURbDvc8SAbnUbUe
         Q6NG0tRwQ0u+AL0Vf059aCqTmZAzsjUxHO2DUZqz3t14qXefAgpTUmZFWJPvh5EbsBYO
         weEHeVxNYsUvilfQb2tQgU1rv8CAdFPgbOCmV2MeXV4Ir3nz7FikZPWUacR/bpF6zDXV
         NmG2nE9sfC3j9jVk/7cCGxUb9/sKPZrrApFa2MWI9tG2ktRaKLOoUvgtU6AnTVC+srcL
         hynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdJjDYFxYS68E9ZUvuM71CJZvMzbAXojm0SHTDHnZVE=;
        b=zO4YJyXhHEIAn4+yFmkfCw/X62wrD30qrUfjc2YvrqeznbkCM9uhIJRVpGbq5j8Tj5
         2g7bCXitp3L02sfTWjHVZlXUUHeSrqK5uSDXZvNi/JQPQCZLdM8FYrh9Bylegy3+2a6n
         XuepxpCWfnRdl1SLiHQP6ddb9Zi+rZnMIDZuiPvLrX2euto/G6rWxdgB1Sk28B7Wg5dv
         R2mgfwG6Uq2bXbyZbLKBTYlNFRvsDHd77vzeoGLby2WmALziei68X2Rzzx/DI8EppjBZ
         89mqLexAu5gFnXY0ub7EsWbLelzea2NYKCuWLi0VitD6ONIyB6WMvSB6zZ8M/WO51rDi
         fOzg==
X-Gm-Message-State: ACgBeo0UGMZ079zldl+RqUcl8tbyVN5YCKcv9kJWYFVO138X3ZW96GpJ
        Y6VM9/jK35NC9p3Ck1xNDsU=
X-Google-Smtp-Source: AA6agR4R+qMqVIYB7Z74fLjIVNabHS1FWajL6pXrjCuEVY7QZGtf2FlklqvJkHAnccpqIcZEjxzXzQ==
X-Received: by 2002:a65:46c1:0:b0:41a:f5f9:b878 with SMTP id n1-20020a6546c1000000b0041af5f9b878mr4724374pgr.497.1659683895201;
        Fri, 05 Aug 2022 00:18:15 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:18:14 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 7/7] usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level
Date:   Fri,  5 Aug 2022 15:17:13 +0800
Message-Id: <20220805071714.150882-8-gene.chen.richtek@gmail.com>
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

Fix CC PHY noise filter of voltage level according to
current cc voltage level

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 58 +++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index ff7deae..5dc34f9 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -24,8 +24,11 @@
 #define RT1711H_PHYCTRL1	0x80
 #define RT1711H_PHYCTRL2	0x81
 
-#define RT1711H_RTCTRL8		0x9B
+#define RT1711H_RTCTRL4		0x93
+/* rx threshold of rd/rp: 1b0 for level 0.4V/0.7V, 1b1 for 0.35V/0.75V */
+#define RT1711H_BMCIO_RXDZSEL	BIT(0)
 
+#define RT1711H_RTCTRL8		0x9B
 /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
 #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
 			    (((ck300) << 7) | ((ship_off) << 5) | \
@@ -44,6 +47,10 @@
 #define RT1711H_RTCTRL15	0xA2
 #define RT1711H_RTCTRL16	0xA3
 
+#define RT1711H_RTCTRL18	0xAF
+/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
+#define BMCIO_RXDZEN	BIT(0)
+
 struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
@@ -164,6 +171,53 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
 }
 
+/*
+ * Selects the CC PHY noise filter voltage level according to the remote current
+ * CC voltage level.
+ *
+ * @status: The port's current cc status read from IC
+ * Return 0 if writes succeed; failure code otherwise
+ */
+static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
+{
+	int ret, cc1, cc2;
+	u8 role = 0;
+	u32 rxdz_en, rxdz_sel;
+
+	ret = rt1711h_read8(chip, TCPC_ROLE_CTRL, &role);
+	if (ret < 0)
+		return ret;
+
+	cc1 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC1_SHIFT) &
+				TCPC_CC_STATUS_CC1_MASK,
+				status & TCPC_CC_STATUS_TERM ||
+				tcpc_presenting_rd(role, CC1));
+	cc2 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC2_SHIFT) &
+				TCPC_CC_STATUS_CC2_MASK,
+				status & TCPC_CC_STATUS_TERM ||
+				tcpc_presenting_rd(role, CC2));
+
+	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
+	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
+		rxdz_en = BMCIO_RXDZEN;
+		if (chip->did == RT1715_DID)
+			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
+		else
+			rxdz_sel = 0;
+	} else {
+		rxdz_en = 0;
+		rxdz_sel = RT1711H_BMCIO_RXDZSEL;
+	}
+
+	ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
+				 BMCIO_RXDZEN, rxdz_en);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
+				  RT1711H_BMCIO_RXDZSEL, rxdz_sel);
+}
+
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
 				      struct tcpci_data *tdata,
 				      enum typec_cc_status cc)
@@ -224,6 +278,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 		/* Clear cc change event triggered by starting toggling */
 		if (status & TCPC_CC_STATUS_TOGGLING)
 			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
+		else
+			rt1711h_init_cc_params(chip, status);
 	}
 
 out:
-- 
2.7.4

