Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8367558A6F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiHEHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiHEHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:18:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA775396;
        Fri,  5 Aug 2022 00:18:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w14so1905111plp.9;
        Fri, 05 Aug 2022 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zbgh2rgkAipGuhCwaEdIJ5QN1l75SbejwY6P2FNLcRI=;
        b=Cz/6Sm8o9QXAi1UDUhJXmuLmUEO+SyQQpke2NROxKqtVltCrCBKcWc+bhtmVqR336W
         I878a8T0XAjVHqbvRKdWKLb4xWIGGT+SkYiE1NC6X04f31pzksExIsej6B9CCYcEgOws
         QJi0Bk0vuBQCSB3sLGecm+SjoLjUKB/jgjTQ/Na1IOlQUacTQ1QpME0bddO/9qgIby68
         Nd3kypS+2TGAUMpt3XuHkiLHG7R4ryoy4hY+uQP+o8pAktjRLHb5tUwOa6Y1OPHwftE2
         v227ArLR0nqaJ87toTtV3SftjXgbIZ9M+2rHdtXSSte1w99vI9bze5gj8vpaX1SrgnuW
         S8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zbgh2rgkAipGuhCwaEdIJ5QN1l75SbejwY6P2FNLcRI=;
        b=YnAMp+pGt+e1uyq4LwPjLAf5YxWM1Z+qHE6o9HQsGXK4j6B4xL8s7VD+iv/EQdThtM
         /5sVqh+uhEdanr2iv12lvOahd31Ys0d35DkbSAQN/naPd+JR8jiCL9APl2NxVRyIrRKq
         m274Xrvlhy+2Br5o9f3sVNv8GIXdKVEUeERd+U72kwNmemJarapg2TV5sGUkiJUwh5OE
         JKLQTFGUg8FJQZRgsWQy6nv+ENtNHvw2hGl9RXNDIl33AdQe94frtRN4M9Xnv3X6pNf6
         3CbA/mnjj301XPBAWx341vS2PMt1p01sM4jyG91sNh1Y66lteYEsiz7o9m44WyR2WLzl
         zpBA==
X-Gm-Message-State: ACgBeo07mtNRz4Spf9nZ9caUFG3tHrp/sBLBK/s4cZAc+ZlGwWgCAVFm
        UOuaEAmatU0KZqTay9iGX2Q=
X-Google-Smtp-Source: AA6agR5biHhF/rWe8KEFpxANXG5AOxXtNntHsmoSVPpqYj4LvoiSr16ElVesJP7lj+tnp//FIYMhIw==
X-Received: by 2002:a17:90a:c690:b0:1f5:858e:f538 with SMTP id n16-20020a17090ac69000b001f5858ef538mr2556673pjt.10.1659683891719;
        Fri, 05 Aug 2022 00:18:11 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:18:11 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 6/7] usb: typec: tcpci: Move function "tcpci_to_typec_cc" to common
Date:   Fri,  5 Aug 2022 15:17:12 +0800
Message-Id: <20220805071714.150882-7-gene.chen.richtek@gmail.com>
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

Move transition function "tcpci_to_typec_cc" to common header

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 22 ----------------------
 include/linux/usb/tcpci.h      | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 8127847..50674ec 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -27,11 +27,6 @@
 #define	VPPS_VALID_MIN_MV			100
 #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
 
-#define tcpc_presenting_rd(reg, cc) \
-	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
-	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
-	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
-
 struct tcpci {
 	struct device *dev;
 
@@ -218,23 +213,6 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
 			    TCPC_CMD_LOOK4CONNECTION);
 }
 
-static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
-{
-	switch (cc) {
-	case 0x1:
-		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
-	case 0x2:
-		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
-	case 0x3:
-		if (sink)
-			return TYPEC_CC_RP_3_0;
-		fallthrough;
-	case 0x0:
-	default:
-		return TYPEC_CC_OPEN;
-	}
-}
-
 static int tcpci_get_cc(struct tcpc_dev *tcpc,
 			enum typec_cc_status *cc1, enum typec_cc_status *cc2)
 {
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 20c0bed..1765745 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -167,6 +167,11 @@
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
 
+#define tcpc_presenting_rd(reg, cc) \
+	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
+	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
+	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
+
 struct tcpci;
 
 /*
@@ -207,4 +212,21 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci);
 
 struct tcpm_port;
 struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
+
+static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
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
 #endif /* __LINUX_USB_TCPCI_H */
-- 
2.7.4

