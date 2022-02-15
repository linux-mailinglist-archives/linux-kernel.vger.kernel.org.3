Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF804B6198
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiBODYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiBODYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:24:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2BBAB459
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:24:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m22so13394626pfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWi/O5nJDLI+tNetDw/Ev6zUKQmU4GrSqp5n8nSHbx4=;
        b=cH3SsTCDZtptXFpBGJiNfLdA+WiZF819l8uh4FCwJbLHyll5CCg1qQyeVnRoIKp0jd
         UzTEGrAlDFLKsvfrLUPO2cyQR7V8ge2XkoQ76Do/DMHT5XY4Gys7TrBRKgJTcK/CKEly
         NlpoI7nSrO+zRLa4y6WYqMQnU4BaXsL7QZgFK1+3TkAAXpuULDQPczgJbKC98r6I07hN
         YWvIa+3/YuKK6iLw/sv9VTnWWPpNNZ8240Zfz+VdH8+oIZuRojFuS6hk3KXv46B82zzJ
         pj6n8qmDE390S58ISOapvDx0gWqpFiIcYo0EQ8RQG/T6QEiBLoXoi/BiG029qFkQud7u
         RW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWi/O5nJDLI+tNetDw/Ev6zUKQmU4GrSqp5n8nSHbx4=;
        b=S7uKmmPFwHP7DszGw4dqpxMkao2GqtS849mtSe1kTeAnsbHuyctA4UKS3Q779Fk7qr
         SDgpQ48M1h/7VQeh7uGp5ebxZ9IeT/WKEIgMRQMpGg50GhH2Y1nzHCh680uNfKYUyb1C
         eU2Eg1BakrP+XiXyVd52zMx5va53LaNn/VQoaZOjTyujn7+mZmlja7oIs9Mv6VuLHygG
         7a2cOdx5z1BsHBRsAkMc7zaaLDX524YiiKzWF4bXIgrei0hqsr35uUJ2i95AsWM6bvRK
         LrJdgt0skotGM1W7VrD4LKW7ZRiR1PrvILkvpo1VHugfZyGUbZJfY234tQTE1JvSI1d9
         RRug==
X-Gm-Message-State: AOAM530FeQBX6i3UFEtd9sY8gyHcCrjSE9SFqkU7qD0CtHfeDLJmfIp1
        hGnJzpUXP5265kTrd/iENpsu0LOjDwo=
X-Google-Smtp-Source: ABdhPJzwvvVrlxC6vO4ybEODwecpFbI0/rwqAnm8JDxaOmnd4sWkMfFcz7DKurU1f8V0miTnOJAYcA==
X-Received: by 2002:a63:864a:: with SMTP id x71mr1865535pgd.272.1644895464775;
        Mon, 14 Feb 2022 19:24:24 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b2sm803390pgg.59.2022.02.14.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 19:24:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM BRCMSTB USB2
        and USB3 PHY DRIVER),
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v2] phy: usb: Add "wake on" functionality for newer Synopsis XHCI controllers
Date:   Mon, 14 Feb 2022 19:24:21 -0800
Message-Id: <20220215032422.5179-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

Add "wake on" support for the newer Synopsis based XHCI only controller.
This works on the 72165 and 72164 and newer chips and does not work
on 7216 based systems. Also switch the USB sysclk to a slower clock
on suspend to save additional power in S2. The clock switch will only
save power on the 72165b0 and newer chips and is a nop on older chips.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- properly subject with 'phy: '

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
2.25.1

