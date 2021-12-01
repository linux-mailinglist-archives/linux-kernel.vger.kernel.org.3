Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D394654C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352071AbhLASKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbhLASKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:10:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18401C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:07:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z6so18339382plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+NX3gtEouviDYYWwLITzdsLQeio17BWeB+ByMH2wiw=;
        b=qJe9Y/WnG9v5EpWjsltHKjnV5SIP2/a3F5ANkxdXf1eIobVB18O7P9GWQKbQwMYKVH
         dNIpBezf57Qs2miROrqg0f4S/PCmsAeffZ4pYL680rLj4TTkNfDOuWphYoOugCbL4Zzu
         WvkNX7Y7tOCeGnkW2wSmoQl8LGsPUIT+aWaqCFRpUAEQ9s1dtyErWcl3wSzh0ecZIpbc
         SOK6O1ttXbY15+4rCQKmKha+rbZF3lD7NrX3gEVFTWHgm+6qPYyyASSD1Zp4P4+k+jd9
         w3z3XfmY6Ctd5eq29rKnuRkwzLc07ABxhCcK/53RijWHh9eblFU2lasBN+2r/B3JyF6r
         iuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+NX3gtEouviDYYWwLITzdsLQeio17BWeB+ByMH2wiw=;
        b=Ve32fL3IFRXtu1AZVpR0YHobHev9xzyjH5eTj7ahelmWacl9qEH3Jc8m8T2DbFcR2y
         1R5F+2SmS8G5SSjIQrjuySVeu2Pj24DSXpdfqJU+tHyZrba5r0xSCS0CP46uY5BsMAIW
         6R6ND7ajIuDIHAFJ4MDS9aFYnJw8g7/zG/w34ivimirOXuvMHincREljVRx5l2tXkT3n
         b/wA57rjzMG6PGe7XyAjpgSUKtz3nfv+UoD5QTp/I7IEHVxR1irGTkw8qrSA4jH9rqs0
         eVyvzMHvU7IGiAt77ByO7rthL7POI0R8mrPYS/hPzr4X3CC87BfqSkz+pTduXsDXjM+U
         LrrA==
X-Gm-Message-State: AOAM533dNQ1kKUiyVG+JoutzwhSe5oNbN6+TqbRK0nFZrqhVDMUmA3iF
        HUcA0e1VwHNpjMHDpBMQnx5FX2ZPhgbe/Q==
X-Google-Smtp-Source: ABdhPJwAyGKBpZQs/RfZUfOLIJT3k+ufQ/LA5o7NGwxT3nB+d62kJddvjVPtUrhbDB0EjKMmpEHmQw==
X-Received: by 2002:a17:902:82c1:b0:141:e920:3b4c with SMTP id u1-20020a17090282c100b00141e9203b4cmr9361932plz.64.1638382021455;
        Wed, 01 Dec 2021 10:07:01 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w142sm462582pfc.115.2021.12.01.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:07:01 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/3] usb: Add "wake on" functionality for newer Synopsis XHCI controllers
Date:   Wed,  1 Dec 2021 13:06:52 -0500
Message-Id: <20211201180653.35097-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201180653.35097-1-alcooperx@gmail.com>
References: <20211201180653.35097-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "wake on" support for the newer Synopsis based XHCI only controller.
This works on the 72165 and 72164 and newer chips and does not work
on 7216 based systems. Also switch the USB sysclk to a slower clock
on suspend to save additional power in S2. The clock switch will only
save power on the 72165b0 and newer chips and is a nop on older chips.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 46 +++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index e63457e145c7..d2524b70ea16 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -47,6 +47,8 @@
 #define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000
 #define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		0x00800000
 #define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		0x00400000
+#define   USB_CTRL_USB_PM_XHC_PME_EN_MASK		0x00000010
+#define   USB_CTRL_USB_PM_XHC_S2_CLK_SWITCH_EN_MASK	0x00000008
 #define USB_CTRL_USB_PM_STATUS		0x08
 #define USB_CTRL_USB_DEVICE_CTL1	0x10
 #define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003
@@ -190,10 +192,6 @@ static void usb_init_common(struct brcm_usb_init_params *params)
 
 	pr_debug("%s\n", __func__);
 
-	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
-	/* 1 millisecond - for USB clocks to settle down */
-	usleep_range(1000, 2000);
-
 	if (USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE)) {
 		reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
 		reg &= ~USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE);
@@ -222,6 +220,17 @@ static void usb_wake_enable_7211b0(struct brcm_usb_init_params *params,
 		USB_CTRL_UNSET(ctrl, CTLR_CSHCR, ctl_pme_en);
 }
 
+static void usb_wake_enable_7216(struct brcm_usb_init_params *params,
+				 bool enable)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+
+	if (enable)
+		USB_CTRL_SET(ctrl, USB_PM, XHC_PME_EN);
+	else
+		USB_CTRL_UNSET(ctrl, USB_PM, XHC_PME_EN);
+}
+
 static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 {
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
@@ -295,6 +304,20 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 	usb2_eye_fix_7211b0(params);
 }
 
+static void usb_init_common_7216(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+
+	USB_CTRL_UNSET(ctrl, USB_PM, XHC_S2_CLK_SWITCH_EN);
+	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
+
+	/* 1 millisecond - for USB clocks to settle down */
+	usleep_range(1000, 2000);
+
+	usb_wake_enable_7216(params, false);
+	usb_init_common(params);
+}
+
 static void usb_init_xhci(struct brcm_usb_init_params *params)
 {
 	pr_debug("%s\n", __func__);
@@ -302,14 +325,20 @@ static void usb_init_xhci(struct brcm_usb_init_params *params)
 	xhci_soft_reset(params, 0);
 }
 
-static void usb_uninit_common(struct brcm_usb_init_params *params)
+static void usb_uninit_common_7216(struct brcm_usb_init_params *params)
 {
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	pr_debug("%s\n", __func__);
 
-	USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
+	if (!params->wake_enabled) {
+		USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
 
+		/* Switch to using slower clock during suspend to save power */
+		USB_CTRL_SET(ctrl, USB_PM, XHC_S2_CLK_SWITCH_EN);
+	} else {
+		usb_wake_enable_7216(params, true);
+	}
 }
 
 static void usb_uninit_common_7211b0(struct brcm_usb_init_params *params)
@@ -371,9 +400,9 @@ static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 
 static const struct brcm_usb_init_ops bcm7216_ops = {
 	.init_ipp = usb_init_ipp,
-	.init_common = usb_init_common,
+	.init_common = usb_init_common_7216,
 	.init_xhci = usb_init_xhci,
-	.uninit_common = usb_uninit_common,
+	.uninit_common = usb_uninit_common_7216,
 	.uninit_xhci = usb_uninit_xhci,
 	.get_dual_select = usb_get_dual_select,
 	.set_dual_select = usb_set_dual_select,
@@ -396,6 +425,7 @@ void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params)
 
 	params->family_name = "7216";
 	params->ops = &bcm7216_ops;
+	params->suspend_with_clocks = true;
 }
 
 void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params)
-- 
2.17.1

