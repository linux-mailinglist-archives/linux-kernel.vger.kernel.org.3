Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9C586774
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiHAK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiHAK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86093B95B;
        Mon,  1 Aug 2022 03:27:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v18so10031754plo.8;
        Mon, 01 Aug 2022 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56/QJjULF7AfhC6vcAuv9Bly6Dkpm9meWtKBdCbDI90=;
        b=dCOo1FunfTVLFeGxeKtOmWYLZCwAVx/HuA8tXZY5lJnHrME/Hj8XXx2MnuAJNAddbq
         HkVSSdNXTBOn2cZgxRihFz5B7W9OvtFD76g76TiO4tYCeCkCXa2LB2iG9+xDgUVem4k8
         peaevhqX6B0MxW0njkE5X3gzrn1a+bmYtj3z8eaZdrENnexDbOQXuT8CkNAbycy7jfXg
         HXjUPSj0TNM9U4JIBQuJvycAyIFSYVbouvanEfRUkmcVXLmQkkgwAL7psrb/X06H0IEb
         guc1x4GwPJ/7FVmOEtcfkYj60ii9o+142ioyeYs8Q7uc8W8h+vAoZwi6K+AG6On9UOPX
         fZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56/QJjULF7AfhC6vcAuv9Bly6Dkpm9meWtKBdCbDI90=;
        b=Db8VOWwCntLS5HZjIr/5Yl3MSTMuT2z0frxaSsGr2rZdoG+JYVbbSaqEJsg4TWAum1
         kdyVm70giLN1ah0eD5VWQjG00khncj2QvHts6QknfO6369hZnsQyKxYMQQnyK9q9EUIP
         YqmTLfX4XeqdA0CoFy9dEjTivvDDgMfpapfu3RiygVtsp6Ddkf3sgf/bph+QGmXf9C7l
         YPPrkyufLKvfK194tqB6m4Lzh0+WfppPQNull6naD8ZB/jV1S/RlsfPMZPtjFam/KfF6
         WJmHaVKeFt+hFURot1hW5hp2NpjDtrrh4OvJbS+0iCA8iCSfzw5vfohQD7W08yhyMMhq
         97mw==
X-Gm-Message-State: ACgBeo0cGwGBdHFr24ETulL4O4ALHhK0nh2kBPQaMeRbYntfbCgNQNdp
        jM3FYKGT5F8Ctnj3HFqtIsA=
X-Google-Smtp-Source: AA6agR6eVx8+14LniTe55nM7Nmy9BGY51yMgSjQnu/IXnM2mbJT04adOamzI3yk5kjDdW47CwxL2Ew==
X-Received: by 2002:a17:902:8302:b0:16d:d74f:e5cc with SMTP id bd2-20020a170902830200b0016dd74fe5ccmr13541293plb.6.1659349653572;
        Mon, 01 Aug 2022 03:27:33 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:33 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 7/7] usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level
Date:   Mon,  1 Aug 2022 18:14:47 +0800
Message-Id: <20220801101447.86207-8-gene.chen.richtek@gmail.com>
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

Fix CC PHY noise filter of voltage level according to
current cc voltage level

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 58 +++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index da35dd3e8a59..6d2568de553b 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -25,8 +25,11 @@
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
@@ -45,6 +48,10 @@
 #define RT1711H_RTCTRL15	0xA2
 #define RT1711H_RTCTRL16	0xA3
 
+#define RT1711H_RTCTRL18	0xAF
+/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
+#define BMCIO_RXDZEN	BIT(0)
+
 struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
@@ -165,6 +172,53 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
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
@@ -225,6 +279,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 		/* Clear cc change event triggered by starting toggling */
 		if (status & TCPC_CC_STATUS_TOGGLING)
 			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
+		else
+			rt1711h_init_cc_params(chip, status);
 	}
 
 out:
-- 
2.25.1

