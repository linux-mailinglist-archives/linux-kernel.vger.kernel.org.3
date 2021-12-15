Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BC476422
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhLOVDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhLOVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:05 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:05 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id i13so21493352qvm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnamIWiam6by9Jdhi724L3CQvNB2/lSRkVxwvCCRpTo=;
        b=E1AEu1MGDxZu4j9qDkDta96pULE2hKFf4bJroAvAfoO6ZR1WTD2ERJD10H4LjEyEeI
         dTQKhY6wVd3TJVuMAb/bffsIFdIwL2YZiftTd5KOw8m+JM1uh69nSPCqoakNr5fIyHap
         h+55/q9gAcX6H85tvC9BsJzN0fsPEn4lYjeISWXbIb2gJ1+48TidjdfjpK+XsMixD4H/
         oFI/YiPt47j041oTRZpU3m99Q4pz56J1PTqfXcW7iSRtXHHyTr8AtDHEyzBY5PfTRJgh
         +rWmMQpk/K3/4+Kv2w7HCiGZr+/foO9LibEUcWulrEO6IUhtTALAzS6wp+AxASB6GsvI
         8DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnamIWiam6by9Jdhi724L3CQvNB2/lSRkVxwvCCRpTo=;
        b=tEWmN0ncJMJXYoVQXN60pa3957iqmEnOVEDvy95PPpQky+D0pqwy/judsQ8qD0Vq+G
         LcBa0JQ258oBs9AcgC4vHikeMz6DvY7chc/lS176+kBhLbPgV0XQKYleIc2jZCz86BPM
         HsoytlPjt4XpdwOCM/0dcKzcRgte4+6IGdQhrnKLGUe34xkJ0EVdQ8iwmJ42dG2GnEy0
         tEynKs07LbIdS8C0nM3ZOijH4slJW+fCFfN1MwiObYEbMWBge04TVasUkyGpB3fglinP
         Xee3J54YTePipcpuOFkGHoqvvw+MNaOPiYSZSfUbBhvk/ks58edsy+ogZzM0OF+RmaLu
         xvXA==
X-Gm-Message-State: AOAM531NgEpyBveD7+7bNtxkEOLjaoierOpRAJiAjp/3eGkx+cs6af2T
        k0uaSaoYGvJAjw9YM3ZQRTY=
X-Google-Smtp-Source: ABdhPJyifKmch0bI2sQrC3Chf/fDbNCvoFrt+qpN0s4H2EE7hzMscwXnhgQhMaapBWbNRPcoFcccHQ==
X-Received: by 2002:a05:6214:1bcb:: with SMTP id m11mr10695510qvc.0.1639602184347;
        Wed, 15 Dec 2021 13:03:04 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:03 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] phy: phy-rockchip-inno-usb2: support muxed interrupts
Date:   Wed, 15 Dec 2021 16:02:49 -0500
Message-Id: <20211215210252.120923-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy has a single muxed interrupt that handles all
interrupts.
Allow the driver to plug in only a single interrupt as necessary.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 168 +++++++++++++-----
 1 file changed, 119 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 29e3a0da8c26..285958fdab38 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -204,6 +204,7 @@ struct rockchip_usb2phy_port {
  * @dcd_retries: The retry count used to track Data contact
  *		 detection process.
  * @edev: extcon device for notification registration
+ * @irq: muxed interrupt for single irq configuration
  * @phy_cfg: phy register configuration, assigned by driver data.
  * @ports: phy port instance.
  */
@@ -218,6 +219,7 @@ struct rockchip_usb2phy {
 	enum power_supply_type	chg_type;
 	u8			dcd_retries;
 	struct extcon_dev	*edev;
+	int			irq;
 	const struct rockchip_usb2phy_cfg	*phy_cfg;
 	struct rockchip_usb2phy_port	ports[USB2PHY_NUM_PORTS];
 };
@@ -927,6 +929,102 @@ static irqreturn_t rockchip_usb2phy_otg_mux_irq(int irq, void *data)
 		return IRQ_NONE;
 }
 
+static irqreturn_t rockchip_usb2phy_irq(int irq, void *data)
+{
+	struct rockchip_usb2phy *rphy = data;
+	struct rockchip_usb2phy_port *rport;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int index;
+
+	for (index = 0; index < rphy->phy_cfg->num_ports; index++) {
+		rport = &rphy->ports[index];
+		if (!rport->phy)
+			continue;
+
+		/* Handle linestate irq for both otg port and host port */
+		ret = rockchip_usb2phy_linestate_irq(irq, rport);
+	}
+
+	return ret;
+}
+
+static int rockchip_usb2phy_port_irq_init(struct rockchip_usb2phy *rphy,
+					  struct rockchip_usb2phy_port *rport,
+					  struct device_node *child_np)
+{
+	int ret;
+
+	/*
+	 * If the usb2 phy used combined irq for otg and host port,
+	 * don't need to init otg and host port irq separately.
+	 */
+	if (rphy->irq > 0)
+		return 0;
+
+	switch (rport->port_id) {
+	case USB2PHY_PORT_HOST:
+		rport->ls_irq = of_irq_get_byname(child_np, "linestate");
+		if (rport->ls_irq < 0) {
+			dev_err(rphy->dev, "no linestate irq provided\n");
+			return rport->ls_irq;
+		}
+
+		ret = devm_request_threaded_irq(rphy->dev, rport->ls_irq, NULL,
+						rockchip_usb2phy_linestate_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy", rport);
+		if (ret) {
+			dev_err(rphy->dev, "failed to request linestate irq handle\n");
+			return ret;
+		}
+		break;
+	case USB2PHY_PORT_OTG:
+		/*
+		 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
+		 * interrupts muxed together, so probe the otg-mux interrupt first,
+		 * if not found, then look for the regular interrupts one by one.
+		 */
+		rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
+		if (rport->otg_mux_irq > 0) {
+			ret = devm_request_threaded_irq(rphy->dev, rport->otg_mux_irq,
+							NULL,
+							rockchip_usb2phy_otg_mux_irq,
+							IRQF_ONESHOT,
+							"rockchip_usb2phy_otg",
+							rport);
+			if (ret) {
+				dev_err(rphy->dev,
+					"failed to request otg-mux irq handle\n");
+				return ret;
+			}
+		} else {
+			rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
+			if (rport->bvalid_irq < 0) {
+				dev_err(rphy->dev, "no vbus valid irq provided\n");
+				ret = rport->bvalid_irq;
+				return ret;
+			}
+
+			ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq,
+							NULL,
+							rockchip_usb2phy_bvalid_irq,
+							IRQF_ONESHOT,
+							"rockchip_usb2phy_bvalid",
+							rport);
+			if (ret) {
+				dev_err(rphy->dev,
+					"failed to request otg-bvalid irq handle\n");
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rockchip_usb2phy_host_port_init(struct rockchip_usb2phy *rphy,
 					   struct rockchip_usb2phy_port *rport,
 					   struct device_node *child_np)
@@ -940,18 +1038,9 @@ static int rockchip_usb2phy_host_port_init(struct rockchip_usb2phy *rphy,
 	mutex_init(&rport->mutex);
 	INIT_DELAYED_WORK(&rport->sm_work, rockchip_usb2phy_sm_work);
 
-	rport->ls_irq = of_irq_get_byname(child_np, "linestate");
-	if (rport->ls_irq < 0) {
-		dev_err(rphy->dev, "no linestate irq provided\n");
-		return rport->ls_irq;
-	}
-
-	ret = devm_request_threaded_irq(rphy->dev, rport->ls_irq, NULL,
-					rockchip_usb2phy_linestate_irq,
-					IRQF_ONESHOT,
-					"rockchip_usb2phy", rport);
+	ret = rockchip_usb2phy_port_irq_init(rphy, rport, child_np);
 	if (ret) {
-		dev_err(rphy->dev, "failed to request linestate irq handle\n");
+		dev_err(rphy->dev, "failed to setup host irq\n");
 		return ret;
 	}
 
@@ -1000,44 +1089,10 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
 	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
 
-	/*
-	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
-	 * interrupts muxed together, so probe the otg-mux interrupt first,
-	 * if not found, then look for the regular interrupts one by one.
-	 */
-	rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
-	if (rport->otg_mux_irq > 0) {
-		ret = devm_request_threaded_irq(rphy->dev, rport->otg_mux_irq,
-						NULL,
-						rockchip_usb2phy_otg_mux_irq,
-						IRQF_ONESHOT,
-						"rockchip_usb2phy_otg",
-						rport);
-		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request otg-mux irq handle\n");
-			goto out;
-		}
-	} else {
-		rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
-		if (rport->bvalid_irq < 0) {
-			dev_err(rphy->dev, "no vbus valid irq provided\n");
-			ret = rport->bvalid_irq;
-			goto out;
-		}
-
-		ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq,
-						NULL,
-						rockchip_usb2phy_bvalid_irq,
-						IRQF_ONESHOT,
-						"rockchip_usb2phy_bvalid",
-						rport);
-		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request otg-bvalid irq handle\n");
-			goto out;
-		}
-	}
+	ret = rockchip_usb2phy_port_irq_init(rphy, rport, child_np);
+	if (ret) {
+		dev_err(rphy->dev, "failed to init irq for host port\n");
+		goto out;
 
 	if (!IS_ERR(rphy->edev)) {
 		rport->event_nb.notifier_call = rockchip_otg_event;
@@ -1117,6 +1172,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
+	rphy->irq = platform_get_irq_optional(pdev, 0);
 	platform_set_drvdata(pdev, rphy);
 
 	ret = rockchip_usb2phy_extcon_register(rphy);
@@ -1196,6 +1252,20 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	if (rphy->irq > 0) {
+		ret = devm_request_threaded_irq(rphy->dev, rphy->irq, NULL,
+						rockchip_usb2phy_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy",
+						rphy);
+		if (ret) {
+			dev_err(rphy->dev,
+				"failed to request usb2phy irq handle\n");
+			goto put_child;
+		}
+	}
+
 	return PTR_ERR_OR_ZERO(provider);
 
 put_child:
-- 
2.25.1

