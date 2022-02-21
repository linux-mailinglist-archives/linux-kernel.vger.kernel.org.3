Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86394BEA85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiBUTVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:21:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBUTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:21:12 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796B65BA;
        Mon, 21 Feb 2022 11:20:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ay3so4834216plb.1;
        Mon, 21 Feb 2022 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PmMzc3Va1w+KOBN2YdFqKkIyR6yiUL/sLdp9Unbsylo=;
        b=f0xildKewdHi4utTJZUwE8qCDIi54z0LidIMmFtBlNw+NrmMGGagzGP9Rch76Eh1Ay
         jHUL0z8nt1yZbadIO4YpR2nHR8X/xK4kZtP1/zxrqLcmBUbp0dwQXHjsrtfwESOAYar4
         bUet/s+X2rcg4y7effLxUpg77gq7xqIbflbFE1acJw+mCvbe8+rt3va+NIFvzgj/OEHL
         jxSFKgxvWLly3Kq9rtLpEM9khIFTfoERC/3ikqMNfGLJyPjPXBrsThNFuZaG9HtDPJ87
         VbIbvGLDSJeSC5ua8ByBOzsTOfmZfKFxGSOdt7UBg4cWwpNVY4OBRVAouqw+zszDhBO3
         vWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PmMzc3Va1w+KOBN2YdFqKkIyR6yiUL/sLdp9Unbsylo=;
        b=xG6mkZM2PgcsY5LoAjFrIJJuxVx4EEiDuG0I/lR1GPMtirJWx9LOs5hGhBP2UIyD5w
         Cuefc3pfgGtOOcVi22W+CfbOdqt23BkG40Wqc7IG+b9pDMv62vQiTkWNgZbX7djXESsA
         mafKXztTa+vahhJt4ETZnq0lLRjQpWAQfDLhYvYC4IRi5lxP+w2YVhuc4dxZM06wH9ZF
         m7gFkbJCcAPwx8CEHcraHnl0vS9Qw4Brnd911Z2/PMzc34Vi4P9A+gNVmS0PAElaD6ZH
         FtnjmIaiq6v8pPcsN0atDyPSQROawJ3tc1peiYFUyTIAtnwbj0jt5zzDezty1lrfJNak
         JjKQ==
X-Gm-Message-State: AOAM5304QP4988TXtcKyxzb1gFbD/6aQmc2NpxyrQt13ynWiRBEwD3EA
        BlhvSYJ57bdqK1dgDHxKLt0=
X-Google-Smtp-Source: ABdhPJz0L6P/4hrPZYEYfASRtyboDkYRiDSLuAez2Gcq+DsWPP36PhCWKehrTZ+zYdEiAYbeXfiMSg==
X-Received: by 2002:a17:903:2352:b0:14c:ba3c:2eae with SMTP id c18-20020a170903235200b0014cba3c2eaemr19719032plh.80.1645471247882;
        Mon, 21 Feb 2022 11:20:47 -0800 (PST)
Received: from charizard.lan (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a030600b001bc62ecad28sm113490pje.41.2022.02.21.11.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:20:47 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Date:   Mon, 21 Feb 2022 11:20:20 -0800
Message-Id: <20220221192020.346622-1-andrew.smirnov@gmail.com>
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

If the extcon device exists, get the mode from the extcon device. If
the controller is DRD and the driver is unable to determine the mode,
only then default the dr_mode to USB_DR_MODE_PERIPHERAL.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

v1 of the patch:

https://lore.kernel.org/linux-usb/20220206014532.372109-1-andrew.smirnov@gmail.com/T/#u

previons discussion:

https://lore.kernel.org/linux-usb/20220131192102.4115473-1-andrew.smirnov@gmail.com/


 drivers/usb/dwc3/core.c | 56 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/drd.c  | 50 ------------------------------------
 2 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f2448d0a9d39..09f283288ce7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
@@ -84,7 +85,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 		 * mode. If the controller supports DRD but the dr_mode is not
 		 * specified or set to OTG, then set the mode to peripheral.
 		 */
-		if (mode == USB_DR_MODE_OTG &&
+		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
 		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
 		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
 		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
@@ -1462,6 +1463,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	}
 }

+static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *np_phy;
+	struct extcon_dev *edev = NULL;
+	const char *name;
+
+	if (device_property_read_bool(dev, "extcon"))
+		return extcon_get_edev_by_phandle(dev, 0);
+
+	/*
+	 * Device tree platforms should get extcon via phandle.
+	 * On ACPI platforms, we get the name from a device property.
+	 * This device property is for kernel internal use only and
+	 * is expected to be set by the glue code.
+	 */
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
+		edev = extcon_get_extcon_dev(name);
+		if (!edev)
+			return ERR_PTR(-EPROBE_DEFER);
+
+		return edev;
+	}
+
+	/*
+	 * Try to get an extcon device from the USB PHY controller's "port"
+	 * node. Check if it has the "port" node first, to avoid printing the
+	 * error message from underlying code, as it's a valid case: extcon
+	 * device (and "port" node) may be missing in case of "usb-role-switch"
+	 * or OTG mode.
+	 */
+	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
+	if (of_graph_is_present(np_phy)) {
+		struct device_node *np_conn;
+
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+		if (np_conn)
+			edev = extcon_find_edev_by_node(np_conn);
+		of_node_put(np_conn);
+	}
+	of_node_put(np_phy);
+
+	return edev;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1561,6 +1607,14 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}

+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = PTR_ERR(dwc->edev);
+		dev_err_probe(dwc->dev, ret, "failed to get extcon");
+
+		goto err3;
+	}
+
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
 		goto err3;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index e2b68bb770d1..9a414edc439a 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,7 +8,6 @@
  */

 #include <linux/extcon.h>
-#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>

@@ -438,51 +437,6 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }

-static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
-	struct extcon_dev *edev = NULL;
-	const char *name;
-
-	if (device_property_read_bool(dev, "extcon"))
-		return extcon_get_edev_by_phandle(dev, 0);
-
-	/*
-	 * Device tree platforms should get extcon via phandle.
-	 * On ACPI platforms, we get the name from a device property.
-	 * This device property is for kernel internal use only and
-	 * is expected to be set by the glue code.
-	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
-		edev = extcon_get_extcon_dev(name);
-		if (!edev)
-			return ERR_PTR(-EPROBE_DEFER);
-
-		return edev;
-	}
-
-	/*
-	 * Try to get an extcon device from the USB PHY controller's "port"
-	 * node. Check if it has the "port" node first, to avoid printing the
-	 * error message from underlying code, as it's a valid case: extcon
-	 * device (and "port" node) may be missing in case of "usb-role-switch"
-	 * or OTG mode.
-	 */
-	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
-
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-		if (np_conn)
-			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
-	}
-	of_node_put(np_phy);
-
-	return edev;
-}
-
 #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
 #define ROLE_SWITCH 1
 static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
@@ -575,10 +529,6 @@ int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;

-	dwc->edev = dwc3_get_extcon(dwc);
-	if (IS_ERR(dwc->edev))
-		return PTR_ERR(dwc->edev);
-
 	if (ROLE_SWITCH &&
 	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
 		ret = dwc3_setup_role_switch(dwc);
--
2.25.1
