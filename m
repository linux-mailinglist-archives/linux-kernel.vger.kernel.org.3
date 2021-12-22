Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9247CCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbhLVGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:10:26 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20260 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhLVGKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640153424; x=1671689424;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=aVYPNj9FnpbJdkBdwW17uIxyL8/YiwYGHnGCnoJTjAE=;
  b=bExXnS7fbo+tEyoUx1dTn5lkilh5+Vvsu8HQV4U3MQ2sIhGDTLozmsyb
   ScUyFyjaqkwnkKWYeo/gmJbwyoBsC+0508iuE5XJ7jp+ls1Zzljd0L7AT
   P5qlutWMpnS2RL+oeoAUxdqZFPX3lEWcC0PWQH63NviwaoY4AKprieZml
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 22:10:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 22:10:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 22:10:07 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 22:10:02 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for DWC3 controller
Date:   Wed, 22 Dec 2021 11:39:43 +0530
Message-ID: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
Runtime suspend of phy drivers was failing from DWC3 driver as runtime
usage value is 2 because the phy is initialized from DWC3 and HCD core.
DWC3 manages phy in their core drivers. Set this quirk to avoid phy
initialization in HCD core.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
v5:
Added comment to explain the change done.
v4:
Changed pdev->dev.parent->of_node to sysdev->of_node

 drivers/usb/host/xhci-plat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9..e6014d4 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -327,6 +327,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
 					 &xhci->imod_interval);
 	}
 
+	/*
+	 * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
+	 * DWC3 manages phy in their core drivers. Set this quirk to avoid phy
+	 * initialization in HCD core.
+	 */
+	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
+		xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
-- 
2.7.4

