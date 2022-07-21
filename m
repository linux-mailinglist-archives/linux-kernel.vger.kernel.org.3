Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702657C440
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiGUGM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiGUGMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79547B368;
        Wed, 20 Jul 2022 23:12:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l124so844338pfl.8;
        Wed, 20 Jul 2022 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hzEOaxWyXcgWSZbVbpmgwfVNJAPnS8A7yGnafWxV6w=;
        b=ZtIshzHxy4tiyIn3KVe9cqqVXS6JR2xz+WNqNDM/cVO/QFKiqAbE2iTmRAYbIO2xt9
         DsfRuavLBDufzR/cSBidtfg9LHZT6Z+SHB2FC5I67zeUUTE4f8MvZsRzmjDSrs3J8xdt
         sFwlepI7y9Y5HwCzz59CjJrYD21KM5/A1aI7pnWR9cTSVKSTT2sEStIj8xXCZQ9Ghk7l
         KTjoLWd/N8Ul/WNJBKUD/EQVDPQW/vUQLFjjuSgXW9GgZgRgysaNInHDPfWQcaPxg0Tr
         qzLXT7HPQpfyuEzchRQVZPrmFTtFn8uLMNlPPc9jWnnAQ+CI2pNle6sCzU/G+7sD7xld
         t9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hzEOaxWyXcgWSZbVbpmgwfVNJAPnS8A7yGnafWxV6w=;
        b=ffM4byYxSPG3s1TNdf4DLf4nDiVRHXimNjQBYJcT0srJ21H3o5SzDU5TgC4hb7OAZs
         ahJ+NEzrGzglucaj03gFAWydUZX4fkJzwkg08UDxTEAdzlN0n+Eo1mS80PMREUE0vAsM
         S/f6h7UpSO9Sj/J1FIBIe/yQ5t0opSARA64f2q4adP1hoAn4RmFTgViFEvdtWKdLtlFh
         L8j/59EPGw2LgYM9woZGRO5wiNvcqIMi0F74kMazqtQ1JM4yLW2BvzaCCu8ZZqKSlTU7
         1mmN279y6KWzn/LdOq01yfvF1JMI1ukpfwkyeae2Z5jJW79+5UaeQTAu09m5PsfiUPfe
         kn3g==
X-Gm-Message-State: AJIora/PuEqOZVTajg6HmiG4RrdTqCeAfXM+NfTl7lmffVUZYgRL8u1S
        Ipk9qvnSFSKf1MphHCXK52o=
X-Google-Smtp-Source: AGRyM1sO5bBbid2lrf5WMRi/9TD8OOKKc2UByghI8Jd45LDLjGvqJv/Bms8BApu2wAfyBb2f88cJvA==
X-Received: by 2002:a05:6a00:428e:b0:52b:7e40:56cf with SMTP id bx14-20020a056a00428e00b0052b7e4056cfmr15842729pfb.72.1658383928073;
        Wed, 20 Jul 2022 23:12:08 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:12:07 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 6/6] usb: typec: tcpci_rt1711h: Fix CC PHY noise filter of voltage level
Date:   Thu, 21 Jul 2022 14:11:44 +0800
Message-Id: <20220721061144.35139-7-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 83 +++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 3316dfaeee0d..f0c46bf7f00b 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -22,8 +22,11 @@
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
@@ -32,7 +35,6 @@
 #define RT1711H_ENEXTMSG_MASK	BIT(4)
 
 #define RT1711H_RTCTRL11	0x9E
-
 /* I2C timeout = (tout + 1) * 12.5ms */
 #define RT1711H_RTCTRL11_SET(en, tout) \
 			     (((en) << 7) | ((tout) & 0x0F))
@@ -42,6 +44,10 @@
 #define RT1711H_RTCTRL15	0xA2
 #define RT1711H_RTCTRL16	0xA3
 
+#define RT1711H_RTCTRL18	0xAF
+/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
+#define BMCIO_RXDZEN_MASK	BIT(0)
+
 struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
@@ -162,6 +168,77 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 				  RT1711H_AUTOIDLEEN_MASK, enable ? 0 : 0xFF);
 }
 
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
+/*
+ * Selects the CC PHY noise filter voltage level according to the current
+ * CC voltage level.
+ *
+ * @param cc_level The CC voltage level for the port's current role
+ * @return 0 if writes succeed; failure code otherwise
+ */
+static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
+{
+	int ret, cc1, cc2;
+	u8 role = 0;
+	u32 rxdz_en = 0, rxdz_sel = 0;
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
+				  RT1711H_BMCIO_RXDZSEL, rxdz_sel);
+}
+
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
 				      struct tcpci_data *tdata,
 				      enum typec_cc_status cc)
@@ -222,6 +299,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
 		/* Clear cc change event triggered by starting toggling */
 		if (status & TCPC_CC_STATUS_TOGGLING)
 			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
+		else
+			rt1711h_init_cc_params(chip, status);
 	}
 
 out:
-- 
2.25.1

