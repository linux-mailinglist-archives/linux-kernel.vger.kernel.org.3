Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A44E5ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbiCXGjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348207AbiCXGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:39:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D275972F9;
        Wed, 23 Mar 2022 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648103864; x=1679639864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kaHDHzYnkeLY5hfEE/V9FOwVrbW8djaEM+Hu25ZuQpw=;
  b=CvK8mSyA9ah2LI83HDM22Vfp9JlCSKt4FvsijObXvS7wcIU1ais9891o
   gHYGhQJI1HSdYd+bb1bFhWnS/IC3VfFaBD+yUIVx9ZdrGVhfiRlPzoT7K
   oHDxM2Y8c1fiEr/5Tf+hWQNyTv7GS4f1cxsaACcz8+xE6YCMNloWrdPnd
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 23:37:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:37:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:43 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:38 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
Date:   Thu, 24 Mar 2022 12:07:11 +0530
Message-ID: <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the phy init is done from dwc3 and also xhci which makes the
runtime_usage value 2 for the phy which causes issue during runtime
suspend. When we run the below command the runtime_status still shows
active.
echo auto > /sys/bus/platform/devices/88e3000.phy/power/control

dwc3 manages PHY by own DRD driver, so skip the management by
HCD core by setting this quirk.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/dwc3/host.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index eda8719..d4fcf06 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -13,6 +13,12 @@
 #include <linux/platform_device.h>
 
 #include "core.h"
+#include <linux/usb/xhci-plat.h>
+#include <linux/usb/xhci-quirks.h>
+
+static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
+	.quirks = XHCI_SKIP_PHY_INIT,
+};
 
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
@@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
 		}
 	}
 
+	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
+			sizeof(xhci_plat_dwc3_xhci));
+	if (ret) {
+		dev_err(dwc->dev, "failed to add data to xHCI\n");
+		goto err;
+	}
+
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
-- 
2.7.4

