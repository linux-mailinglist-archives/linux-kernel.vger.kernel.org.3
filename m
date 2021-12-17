Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7347856D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhLQHKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:10:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40835 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLQHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639725021; x=1671261021;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OBF12AFTQ/rvRAEK+WbmtQAw/FieWK9byHw9Nr+Ga8M=;
  b=H6/Fu+Sth2XcIUQTXGcakZllIdxmOXll2/PpjVG2sm5S9nclcqQXIH3X
   e4v+gBzbSxK7DO4R3poJhBVXT3heO36Xk6vYOgaGyZP2ExXt4iGcQYjiI
   XjHiEBMlIeacwrm+uJeJZo0aV+dXg7avV6FRuJaeBNCWZkiydplyjIpuP
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Dec 2021 23:10:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:10:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 16 Dec 2021 23:10:19 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 16 Dec 2021 23:10:14 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v4] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for DWC3 controller
Date:   Fri, 17 Dec 2021 12:39:57 +0530
Message-ID: <1639724997-21809-1-git-send-email-quic_c_sanm@quicinc.com>
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
v4:
Changed pdev->dev.parent->of_node to sysdev->of_node

 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9..1a57573 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -327,6 +327,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 					 &xhci->imod_interval);
 	}
 
+	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
+		xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
 		ret = PTR_ERR(hcd->usb_phy);
-- 
2.7.4

