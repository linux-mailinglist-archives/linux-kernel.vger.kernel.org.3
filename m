Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB98A4AAD64
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 02:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357301AbiBFBqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 20:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiBFBqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 20:46:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0DC043186;
        Sat,  5 Feb 2022 17:46:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y9so1796588pjf.1;
        Sat, 05 Feb 2022 17:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+3p4iPoAuDe6IQHUpiM97wxc+cfuSo072IauohFRPY=;
        b=HDazBo9gw+zTBrBLCTLkikT4SmMAYY+bqMRZxcJP5GC04RVn5yBJ00hRswiyKJCUsc
         80vuZgSHSvWW749XcAkJFjdspTlCiEcMxatTNBKfmyXSsvSIorNPGnX4XjrKzC3ntLaq
         D9/3PDItV1FCTaYQJqW5gpPx67gGotQK6tKY87f7ogDNwVklVXB7sewCiyk7IQvFHCMf
         HnLLp//UGoGt+pW+CkD4l95wN/AtZF6VZOlWVRoKW4+opc8QGXjcLjmzudTPUVwf2Hsv
         KBT7WY1nzTbqmx9WIpLZilEZdH7ZwLqxRZDeFVhybg9pAU8arALBmqiMAIlsqFFFKjYv
         HaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+3p4iPoAuDe6IQHUpiM97wxc+cfuSo072IauohFRPY=;
        b=tyx7QUg2PdiltW+h+5XC4xn5IzUFMURlR7TZ+1lYUWQ48A9tAdfh+B43IZhj5YK6Eo
         YDBnGZUA9MUypabuROw2yMWDC4+I4j2yWzl7i3o5qYYguY+mYTBD99G+Zoh5PnGulpiV
         VPdpIaEeS2J4Bs5c/OdaEmQwGLzxnh91FL9aRhN/y4aCdnV1tygT/O7O0CdBLirlpkUd
         V5DLKX6LO9xsP6LMlzvEbO7yeN5uwv6O0CsoyoRIsBHpBZivDZeTzUTDHqM2ifufJig4
         VXulCFikvr+mLTKJqXHN7q8p/pfGGdgC0IIl5rRjBRpsemlA6akEGUcndLUfUE/rqKij
         4WyA==
X-Gm-Message-State: AOAM5320ngkFkQd7UmD5VWa8Id4FQzcmwZTGm+vjy7dLfStelOx0YcX6
        fDUoEfW5/asj/4jZ1J/2cfo=
X-Google-Smtp-Source: ABdhPJzumaU8Mo2A3CFHZub70Sioa5qjRh0p9sXlTHvemh3vQWwIRTb9xR/2aFurOI5VzAHYCALs5g==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr11179738pjb.4.1644111962515;
        Sat, 05 Feb 2022 17:46:02 -0800 (PST)
Received: from charizard.lan (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j23sm4869829pgb.75.2022.02.05.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 17:46:01 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Date:   Sat,  5 Feb 2022 17:45:32 -0800
Message-Id: <20220206014532.372109-1-andrew.smirnov@gmail.com>
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

It is necessary that:

   ROLE_SWITCH && device_property_read_bool(dwc->dev, "usb-role-switch")

is true in order for dwc3_get_dr_mode() to _not_ force us from OTG to
PERIPHERAL mode here:

   if (mode == USB_DR_MODE_OTG &&
       (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
        !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
	!DWC3_VER_IS_PRIOR(DWC3, 330A))
	mode = USB_DR_MODE_PERIPHERAL;

and dwc3_drd_init() to be called later in dwc3_core_init_mode(). To
avoid always ignoring extcon device returned by dwc3_get_extcon()
modify the above check to also account for dwc->edev.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Previous discussion:

https://lore.kernel.org/linux-usb/20220131192102.4115473-1-andrew.smirnov@gmail.com/

 drivers/usb/dwc3/core.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/drd.c  | 50 -------------------------------------
 2 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f2448d0a9d39..0ae152e47a00 100644
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
@@ -1561,6 +1607,13 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}

+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = PTR_ERR(dwc->edev);
+		dev_err_probe(dwc->dev, ret, "failed to get extcon");
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
