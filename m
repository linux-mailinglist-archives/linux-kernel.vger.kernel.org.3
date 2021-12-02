Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6B4660C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356751AbhLBJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:56:25 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40078 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356670AbhLBJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638438774; x=1669974774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=14KrR4/MMtskTCagjldDybzElGI2BWUp5xLYygCBPlQ=;
  b=HWm+6oD76OviWrubKG681VeL0ZQeEgmpp0yYB04iGIuJ1McWK5ekry5g
   CIiFCKGryQLc9ifX5iswIZKJTFgnn3v3rssuAyJ7zRewTTJDG93j4soQi
   lnc2vBGlm7gO9RSrfnlqY8bz2jvolz7vgJbT3FUdXpLoyj8H0VGNxI3Xn
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 01:52:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:52:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:53 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:48 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 4/8] usb: dwc3: drd: Register the eud connector child node for dwc3
Date:   Thu, 2 Dec 2021 15:21:23 +0530
Message-ID: <bcb48839a520b8bfc9b09e7a26ba8a8459ab602d.1638430506.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638430506.git.quic_schowdhu@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the child node for dwc3 which is the "eud_usb_connector".
The eud driver will be able to switch the usb role from device to
host and vice versa using the role switch property of dwc3 node.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 drivers/usb/dwc3/drd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d7f7683..b4ea55c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/extcon.h>
+#include <linux/of_platform.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -164,6 +165,27 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
 	return irq;
 }
 
+static int dwc3_register_eud(struct dwc3 *dwc)
+{
+	struct device		*dev = dwc->dev;
+	struct device_node	*np = dev->of_node;
+	int                     ret;
+
+	of_get_child_by_name(np, "eud_usb_connector");
+	if (!np) {
+		dev_dbg(dev, "no usb_connector child node specified\n");
+		return 0;
+	}
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to register usb_connector - %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 void dwc3_otg_init(struct dwc3 *dwc)
 {
 	u32 reg;
@@ -580,6 +602,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
 		ret = dwc3_setup_role_switch(dwc);
 		if (ret < 0)
 			return ret;
+
+		ret = dwc3_register_eud(dwc);
+		if (ret < 0)
+			return ret;
 	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
-- 
2.7.4

