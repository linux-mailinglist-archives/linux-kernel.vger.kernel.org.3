Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1F520AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiEJBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiEJBs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:48:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB6289BDC;
        Mon,  9 May 2022 18:45:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e5so13454236pgc.5;
        Mon, 09 May 2022 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nP61nKy/ZPvS3vrbOJaB+tc2rmY8ROtm0Xppu8VLlno=;
        b=DCH/WQHYliiBOM5qtU28mWlxYWa0xEhfYgyUf43q9BDAmCFxHJfCZi/pZarlHfGJoY
         UqhtZdkilfcKTzRuNdpO6n1i3LHWiGKt6FNX6KLh6Ec4/grUGWdpmjoYWt9+OrJrcK3o
         rAIYDZlGzNFBsbpO5VdnE8SIjw484E7uyIEp92r/rXF2UolFc3Tx3Ua0lpEeJyGBV4dP
         /E+RJI0tEyvx/20IPKLFFEvwzGtU+wr/E1lxfdIXjc81WiXHEhpLjv4CE4lJvMgDtANJ
         sFSjwA9ttKUKEn96X8v4eQgkvHx2NiZvnt8OLaPF2SC14/6kfZxcPWPHUXmFzDod0zYt
         E0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nP61nKy/ZPvS3vrbOJaB+tc2rmY8ROtm0Xppu8VLlno=;
        b=2VUjVz3m9zB2L901MpNcYDFqHJD/fW8DWi4fRFY/ZXHZQDitW+a1H6VDNEkGcdLlqy
         eeIAwFTqT4x19u4N9w9PnY37tzNoYxy1aBi5JJu8CVTN242cvBtCRvarlErq/JQaw2cG
         Zg1JWtvOnWjITwQP/v16tBplVMt6zP1CUiszvSefnvsUXB4iY0ytlKvoh4TLT7NM/ryj
         N/RYAH7duI9d2QALXtB2yQcdZPQZ92GETp0iklGPFvqY80XCPJdzR69A+m7IctIEBPlh
         UwDeeGKxKerUL0sX+8VbRKOiE4QamNSqUKWAcaBjjjOjAAswFx9b5F2hl0/VCjJhB0UN
         xj6w==
X-Gm-Message-State: AOAM532R/1qGAumTfTRirZG887tlIz0FwnuwJPSaza21pxIGHZrLABV8
        I8bircdI0zi7geNuBxDUem91gRvpFKo=
X-Google-Smtp-Source: ABdhPJwzT/+uJ2WTtLY2nkbyUT0PnbYSh7AqMNOP0QKEmBYONx6/3TFc58YIa9s0ov22A+8PSn8wnw==
X-Received: by 2002:a63:68c4:0:b0:3c6:c9a6:e316 with SMTP id d187-20020a6368c4000000b003c6c9a6e316mr5139838pgc.399.1652147101507;
        Mon, 09 May 2022 18:45:01 -0700 (PDT)
Received: from localhost.localdomain ([49.216.43.238])
        by smtp.gmail.com with ESMTPSA id x186-20020a627cc3000000b0050dc7628134sm9590075pfc.14.2022.05.09.18.44.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2022 18:45:00 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, bryan_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tcpci_mt6360: Update for BMC PHY setting
Date:   Tue, 10 May 2022 09:44:52 +0800
Message-Id: <1652147092-19255-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Update MT6360 BMC PHY Tx/Rx setting for the compatibility.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

Recently, there's some USBPD MT6360 IOP issue from the user.
From our RD's comment, BMC PHY Tx/Rx setting need to be updated for
the compatibility issue.
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index f1bd9e0..8a952ea 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -15,6 +15,9 @@
 
 #include "tcpci.h"
 
+#define MT6360_REG_PHYCTRL1	0x80
+#define MT6360_REG_PHYCTRL3	0x82
+#define MT6360_REG_PHYCTRL7	0x86
 #define MT6360_REG_VCONNCTRL1	0x8C
 #define MT6360_REG_MODECTRL2	0x8F
 #define MT6360_REG_SWRESET	0xA0
@@ -22,6 +25,8 @@
 #define MT6360_REG_DRPCTRL1	0xA2
 #define MT6360_REG_DRPCTRL2	0xA3
 #define MT6360_REG_I2CTORST	0xBF
+#define MT6360_REG_PHYCTRL11	0xCA
+#define MT6360_REG_RXCTRL1	0xCE
 #define MT6360_REG_RXCTRL2	0xCF
 #define MT6360_REG_CTDCTRL2	0xEC
 
@@ -106,6 +111,27 @@ static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 	if (ret)
 		return ret;
 
+	/* BMC PHY */
+	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL1, 0x3A70);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, MT6360_REG_PHYCTRL3,  0x82);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, MT6360_REG_PHYCTRL7, 0x36);
+	if (ret)
+		return ret;
+
+	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL11, 0x3C60);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, MT6360_REG_RXCTRL1, 0xE8);
+	if (ret)
+		return ret;
+
 	/* Set shipping mode off, AUTOIDLE on */
 	return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
 }
-- 
2.7.4

