Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4664F0B57
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356445AbiDCQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiDCQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:51:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5315A1C;
        Sun,  3 Apr 2022 09:49:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x31so6841754pfh.9;
        Sun, 03 Apr 2022 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lm6EDo9U6T46SVMiT4kkA7cUJNXMhvSwyBSrhgcsBh4=;
        b=kIMGUTwCWbnhbAIzMshtJAD4gjDxe+AzzFy+i5lawvCF9X23s+KZcm4NeZEbQ3R7Ax
         ZwFL2IdbrVbnJf7q0+KVLwI0JlHwkiTXzalD0g/vHq2fcjCNpraHbcQSkd9+Pms3FrCN
         /99ijQkDn0cOIpqNol21REsNCrF35/lH3YEAfDK1j41lIQBsM6ZEeWbVkqJi2eXacUR/
         XtSgfwyu42dzTxHtHf+qjCjMxqlWYkiPFKrjjtWWKS9YEo85PUSdn6sonVkH2+YnSNjc
         OyHEqV4+zT0wNVdh/MbOks+LKuHsQx21zwXTOOkqGeF8MoBtZetl+74vQiT2epXrd5th
         Z59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lm6EDo9U6T46SVMiT4kkA7cUJNXMhvSwyBSrhgcsBh4=;
        b=gbxfz+HV+iwggV1hWSTa9GHEIQEXKoc3br89COElJkSdxiXfd5jJw3i4D+S+2M+HxX
         6ZfSucAYwDuI6hwtaf0IrWBUy7SqVZoTr7IHIVOu7JGB8E9lLDQ5rQJnBQgBjdUVj/ZI
         L+QX128vUkV1rObOjHdyN12uZM0midAkWiHrBCTOs+coJ9efZfwq79nm53dPIjSbVaDH
         JxrVxyYIfTUVNWbbsL9Yi/x+ToMR1aqmAf117dKeVOKevUfKNxeKEDDZCp6XCgyWEWzM
         U2jt2jveKDD6Xk+6Tjd6sxjLyrf42sQnD5dMzg3TYlqeZtcw7L2arXAT7gRtnwD7o7lW
         EYNQ==
X-Gm-Message-State: AOAM53313jCQiXGBUW+dc64QlMu5riQ3tLUqz/FAw8arz2Mw1bcfEbmw
        A9zpnnfCEnBvqR60ALLXGvE=
X-Google-Smtp-Source: ABdhPJykfCk2L9MOmLf4SrnSkBFZ32h1SbxIvekrC4hS1eXRkjfbCVQ7xAVyhtRHfmK3Cb2KgiFfyg==
X-Received: by 2002:a05:6a00:13a9:b0:4fa:ae49:7c06 with SMTP id t41-20020a056a0013a900b004faae497c06mr53900569pfg.38.1649004570977;
        Sun, 03 Apr 2022 09:49:30 -0700 (PDT)
Received: from charizard.lan (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm9535971pfu.202.2022.04.03.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:49:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Date:   Sun,  3 Apr 2022 09:49:07 -0700
Message-Id: <20220403164907.662860-1-andrew.smirnov@gmail.com>
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

Changes since [v3] of the patch:

  - Rebased to apply on "main" of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

Changes since [v2] of the patch:

   - Fixed "Minor formatting change" to reflect what was meant by
     review comment

Changes since [v1] of the patch:

   - Reworded commit message
   - Minor formatting change


[v3] https://lore.kernel.org/linux-usb/20220228171252.1827788-1-andrew.smirnov@gmail.com/
[v2] https://lore.kernel.org/linux-usb/20220221192020.346622-1-andrew.smirnov@gmail.com/
[v1] https://lore.kernel.org/linux-usb/20220206014532.372109-1-andrew.smirnov@gmail.com/T/#u

previons discussion:

https://lore.kernel.org/linux-usb/20220131192102.4115473-1-andrew.smirnov@gmail.com/


 drivers/usb/dwc3/core.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/drd.c  | 50 -------------------------------------
 2 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1170b800acdc..39956846b16d 100644
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
@@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 		 * mode. If the controller supports DRD but the dr_mode is not
 		 * specified or set to OTG, then set the mode to peripheral.
 		 */
-		if (mode == USB_DR_MODE_OTG &&
+		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
 		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
 		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
 		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
@@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
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
@@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}

+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = PTR_ERR(dwc->edev);
+		dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+		goto err3;
+	}
+
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
 		goto err3;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index b60b5f7b6dff..f277bebdaa09 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,7 +8,6 @@
  */

 #include <linux/extcon.h>
-#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -439,51 +438,6 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
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
@@ -584,10 +538,6 @@ int dwc3_drd_init(struct dwc3 *dwc)
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
