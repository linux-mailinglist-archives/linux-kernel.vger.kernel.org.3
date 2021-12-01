Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290FB4654C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352021AbhLASKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbhLASKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:10:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:07:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h24so18618529pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWKI66hVWIsm1UjmNtmr6LT7Fi7B/zNN7cFHtvKJDKs=;
        b=QENXn3UhkrxYHTUnnU/Qqlf3ke8S1612FM0FGyrmbHzRXQQC4yBY5pRGoGXpvisB0r
         IyLRSpPBMkdL5uUIxdvfk2sZH5AH+WVnhMeYCZt1jF7qc5lWbRQXG8LW9yXfKm66WuV+
         q4CQo6WRC2xMRyQuY0wh+6d+wxjwV+x+ffDXUhV87Fhng135sFSJnE7W63XZeMarMYOd
         3g4hG/oA88/5pq0ABrsuQdb8GMLv6rBRSvXI+S/bWEkQh+E7BzFIHhOIpJRL0vfZEoA6
         XulROLr2zFjxcdz/m112UiT3WMOSGghOG11hC/pNsHP92XpOjizXDyWy+u5JGT91gLjd
         9Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWKI66hVWIsm1UjmNtmr6LT7Fi7B/zNN7cFHtvKJDKs=;
        b=HrgvRJzpnxArlLG2TMPU3AtqYlOj6axV+uEbNi/akdS1Xx7qnmlY5WAOyB17ip07OY
         dnXuqkkFJSj0VE3gU9Cc5LxFPeDs0ma28MxgL1K1C1gUH9/VMSugkA7AaK+0/XT5RP3J
         CmEMaJagHRe40DwYGugUAdMmj8WIRcyzYkfn40U6UK2HF4ZgxiPrjqPBbMMTCWVgy/xL
         viF33t2O9NI3ieNEWUGHHB7AOePxOh2rTF40cwldb4eSTVcf8gizxBVQmKDAFkmSqK0q
         6wJlGC3ilUCaP4cxWbGu8I8oLVDiqwV4XpibdJueXtl5+PWlF1CiNmr+rsPA4lBG/w52
         78hQ==
X-Gm-Message-State: AOAM530l0554ccjuKsOGEwEpJWsn6Z0ufHW5McXAnc/Yu5Wo5umQ9hNF
        facDK8JUKnFCC5ffIJPhfiEA93GohPZMvQ==
X-Google-Smtp-Source: ABdhPJxO8QODxk+y6B10Qtq3Y+cGUdOf8qcl/BPukwUHTst/HAy6gFol6DNjPAOP2G6YgYyGaoTiuQ==
X-Received: by 2002:a17:902:d2cf:b0:141:b347:df9d with SMTP id n15-20020a170902d2cf00b00141b347df9dmr9249283plc.37.1638382020132;
        Wed, 01 Dec 2021 10:07:00 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w142sm462582pfc.115.2021.12.01.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:06:59 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/3] phy: usb: Leave some clocks running during suspend
Date:   Wed,  1 Dec 2021 13:06:51 -0500
Message-Id: <20211201180653.35097-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201180653.35097-1-alcooperx@gmail.com>
References: <20211201180653.35097-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY client driver does a phy_exit() call on suspend or rmmod and
the PHY driver needs to know the difference because some clocks need
to be kept running for suspend but can be shutdown on unbind/rmmod
(or if there are no PHY clients at all).

The fix is to use a PM notifier so the driver can tell if a PHY
client is calling exit() because of a system suspend or a driver
unbind/rmmod.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 38 +++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 116fb23aebd9..0f1deb6e0eab 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -18,6 +18,7 @@
 #include <linux/soc/brcmstb/brcmstb.h>
 #include <dt-bindings/phy/phy.h>
 #include <linux/mfd/syscon.h>
+#include <linux/suspend.h>
 
 #include "phy-brcm-usb-init.h"
 
@@ -70,12 +71,35 @@ struct brcm_usb_phy_data {
 	int			init_count;
 	int			wake_irq;
 	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
+	struct notifier_block	pm_notifier;
+	bool			pm_active;
 };
 
 static s8 *node_reg_names[BRCM_REGS_MAX] = {
 	"crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
 };
 
+static int brcm_pm_notifier(struct notifier_block *notifier,
+			    unsigned long pm_event,
+			    void *unused)
+{
+	struct brcm_usb_phy_data *priv =
+		container_of(notifier, struct brcm_usb_phy_data, pm_notifier);
+
+	switch (pm_event) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		priv->pm_active = true;
+		break;
+	case PM_POST_RESTORE:
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		priv->pm_active = false;
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
 static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
 {
 	struct phy *gphy = dev_id;
@@ -91,6 +115,9 @@ static int brcm_usb_phy_init(struct phy *gphy)
 	struct brcm_usb_phy_data *priv =
 		container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
 
+	if (priv->pm_active)
+		return 0;
+
 	/*
 	 * Use a lock to make sure a second caller waits until
 	 * the base phy is inited before using it.
@@ -120,6 +147,9 @@ static int brcm_usb_phy_exit(struct phy *gphy)
 	struct brcm_usb_phy_data *priv =
 		container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
 
+	if (priv->pm_active)
+		return 0;
+
 	dev_dbg(&gphy->dev, "EXIT\n");
 	if (phy->id == BRCM_USB_PHY_2_0)
 		brcm_usb_uninit_eohci(&priv->ini);
@@ -488,6 +518,9 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	priv->pm_notifier.notifier_call = brcm_pm_notifier;
+	register_pm_notifier(&priv->pm_notifier);
+
 	mutex_init(&priv->mutex);
 
 	/* make sure invert settings are correct */
@@ -528,7 +561,10 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 
 static int brcm_usb_phy_remove(struct platform_device *pdev)
 {
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(&pdev->dev);
+
 	sysfs_remove_group(&pdev->dev.kobj, &brcm_usb_phy_group);
+	unregister_pm_notifier(&priv->pm_notifier);
 
 	return 0;
 }
@@ -539,6 +575,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
 	if (priv->init_count) {
+		dev_dbg(dev, "SUSPEND\n");
 		priv->ini.wake_enabled = device_may_wakeup(dev);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			brcm_usb_uninit_xhci(&priv->ini);
@@ -578,6 +615,7 @@ static int brcm_usb_phy_resume(struct device *dev)
 	 * Uninitialize anything that wasn't previously initialized.
 	 */
 	if (priv->init_count) {
+		dev_dbg(dev, "RESUME\n");
 		if (priv->wake_irq >= 0)
 			disable_irq_wake(priv->wake_irq);
 		brcm_usb_init_common(&priv->ini);
-- 
2.17.1

