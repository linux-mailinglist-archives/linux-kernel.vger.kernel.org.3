Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD794BB5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiBRJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:34:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiBRJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:34:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94213F46;
        Fri, 18 Feb 2022 01:34:05 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21I9XuT5012082;
        Fri, 18 Feb 2022 03:33:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645176836;
        bh=5ZdztmiUZEJkMgmXrReLjUq+5pxyCYZ2a0fG4eNTku0=;
        h=From:To:CC:Subject:Date;
        b=pVBob8gjChKwoGyBWG+d6SaS3B7daockWs5xvWXjOBEhvSFGeN6pnKTbtbTSPomA2
         waatfQ/sFs6TvR79wP0SLtrJxOHIR0iSz5ZmywI96reo3ii2KkWoMhCSUrZG9rSaGJ
         Ru1RSFktd+k5w2qWgZP/vxBtoKVBbQJRszNNS3zU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21I9XuMS107473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Feb 2022 03:33:56 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 18
 Feb 2022 03:33:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 18 Feb 2022 03:33:55 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21I9XqsO126362;
        Fri, 18 Feb 2022 03:33:53 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc3: drd: Add support for extcon drd notifier even with usb role switch config enabled
Date:   Fri, 18 Feb 2022 15:03:47 +0530
Message-ID: <20220218093348.1098-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AM62x SoC, the USB controller supports USB role switching by using the
extcon drd notifiers. The current implementation does not accommodate this.
If usb role switching is enabled then drd notifiers are not added. If usb
role switching is not enabled then the dr_mode is forced to peripheral
(dwc3_get_dr_mode) and role switching will not be possible(dwc3_set_mode).

Therefore, rearrange the "if else" logic such that extcon drd notifiers can
be added even with usb role switching enabled.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/usb/dwc3/drd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index b919ea3d87f2..0e86b1d8b50c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -583,12 +583,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (ROLE_SWITCH &&
-	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
-		ret = dwc3_setup_role_switch(dwc);
-		if (ret < 0)
-			return ret;
-	} else if (dwc->edev) {
+	if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -598,7 +593,14 @@ int dwc3_drd_init(struct dwc3 *dwc)
 		}
 
 		dwc3_drd_update(dwc);
-	} else {
+	}
+
+	if (ROLE_SWITCH &&
+	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		ret = dwc3_setup_role_switch(dwc);
+		if (ret < 0)
+			return ret;
+	} else if (!dwc->edev) {
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
 
 		/* use OTG block to get ID event */
-- 
2.17.1

