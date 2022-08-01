Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33928586771
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiHAK1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHAK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147413135D;
        Mon,  1 Aug 2022 03:27:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so11541217pjz.1;
        Mon, 01 Aug 2022 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMQXlAeibSzqAHZrn8sdnWaDWRBBULUI/PyUWAhs7hM=;
        b=oCzMuYJfl7tSHzg8p3lJYwNGlbDHl7kcbAon3AdnoL8p611lgqJUpV1ltxHDvaPZbf
         CMftQN02NbtnXCmy4R0Xa6Ea4DrNraeKR0ecFWy5sXVskcT4ORFm1Ve5aSNSIE2XukzG
         HnnBAseDVFRHeAfq9/NgzGuPn4rZDp/US1va8giByPVulMxX8STkQvMyicoD4t23kbNr
         G7vlpVllv1HpS9bIwG2a7RNRzUmHj0Wet8vWn7HDnbdkP46u4vNN2cFhJJr7F7pTWmz4
         t8nsODWOFOhrFtWYnqvKtrC9PqMXIFUKw+RRE6eeAcBOwiJ9vYsE0rYhL7Acwyk4gLlD
         6chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMQXlAeibSzqAHZrn8sdnWaDWRBBULUI/PyUWAhs7hM=;
        b=pDBkzwwhZQCic7rV/C/Eh3Le+WSQsvF6xOMXasqeLvwpjkMUi84E3leM/yRQOwtUUz
         c6Zzoblqle+2yie00rg/oCFtgiRb4f6DInmGBCZiMCfL1Ynn2bTMXc5tkfE/dHWRgwkX
         dKIMd1kAb0pJT5K6izZmHLG55f4g3LS3OQOGc0kayEXT/fdKfKZBfhmd8VDEZZnmA0Ps
         Uv0Ufe9xBl9T0rPb+yEUy3cvXgRbohwOIay0t0OuuHnc1iZCDcDACtIX7f4Ai5Ool6cE
         RLR2O5AUmh8OkQezd7Dy7rEXaMVl6O5KDNurpKk5+XODOBfKeqCftrT1AVYnvhfN9Ejw
         jxeQ==
X-Gm-Message-State: ACgBeo24v0Cv7fNkhAd6fhdPokNNC+goSK64tvty8/SPs+JUXc7yt+07
        8H9aCim63I5AgtzKdXwVXTQ=
X-Google-Smtp-Source: AA6agR6qM15kGKNw3PzJ7gxZyJ2rJPPP423PNyoDHHmeRqNJA/vprLTjiuEKCv+OSqcnND59rYVS1g==
X-Received: by 2002:a17:902:e749:b0:16c:3d6f:aba3 with SMTP id p9-20020a170902e74900b0016c3d6faba3mr15607878plf.135.1659349650979;
        Mon, 01 Aug 2022 03:27:30 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:30 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 6/7] usb: typec: tcpci: Move function "tcpci_to_typec_cc" to common
Date:   Mon,  1 Aug 2022 18:14:46 +0800
Message-Id: <20220801101447.86207-7-gene.chen.richtek@gmail.com>
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

Move transition function "tcpci_to_typec_cc" to common header

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 22 ----------------------
 drivers/usb/typec/tcpm/tcpci.h | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f33e08eb7670..0f45d456df32 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -28,11 +28,6 @@
 #define	VPPS_VALID_MIN_MV			100
 #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
 
-#define tcpc_presenting_rd(reg, cc) \
-	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
-	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
-	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
-
 struct tcpci {
 	struct device *dev;
 
@@ -219,23 +214,6 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
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
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index b2edd45f13c6..3f45cb0426df 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -166,6 +166,11 @@
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
 
+#define tcpc_presenting_rd(reg, cc) \
+	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
+	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
+	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
+
 struct tcpci;
 
 /*
@@ -206,4 +211,22 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci);
 
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
+
 #endif /* __LINUX_USB_TCPCI_H */
-- 
2.25.1

