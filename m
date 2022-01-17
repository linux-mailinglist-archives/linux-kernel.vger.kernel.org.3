Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD34901B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiAQFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:46:30 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:35343 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiAQFo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642398269; x=1673934269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tkvJg0bK1J5Qw2IRlwsLrL8etQk+wSQ0vBjKhalSILY=;
  b=VDMbQIEauGAQhFYl5XXGXHnLHp5lJ8Oq5zMZe8Wth2EDr6AaDy/Jq+Xr
   f9ZJqmp2ZTeBStaS3HLB9ISVXcGlB4MCmcHv/P8K0gzXKss8rhZLuyTEz
   2NrtD6GDYDcy0Xo6YEYUY+OoHgpLwt4b/tYbZZFiDS9klcRMqcYMO19uU
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 21:44:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:44:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:28 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:24 -0800
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
Subject: [PATCH v10 1/6] usb: host: xhci: plat: Add suspend quirk for dwc3 controller
Date:   Mon, 17 Jan 2022 11:14:03 +0530
Message-ID: <1642398248-21753-2-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend check if any wakeup capable devices are connected to the
controller (directly or through hubs), and set the wakeup enable property
for xhci plat device.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Change device_set_wakeup_capable to device_set_wakeup_enable as 
wakeup capable false was deleting the sysfs property.

 drivers/usb/host/xhci-plat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9..1c8fadb 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -431,6 +431,14 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
+static void xhci_dwc3_suspend_quirk(struct usb_hcd *hcd, struct device *dev)
+{
+	if (usb_wakeup_enabled_descendants(hcd->self.root_hub))
+		device_set_wakeup_enable(dev, true);
+	else
+		device_set_wakeup_enable(dev, false);
+}
+
 static int __maybe_unused xhci_plat_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
@@ -440,6 +448,10 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
 	ret = xhci_priv_suspend_quirk(hcd);
 	if (ret)
 		return ret;
+
+	if (of_device_is_compatible(dev->parent->of_node, "snps,dwc3"))
+		xhci_dwc3_suspend_quirk(hcd, dev);
+
 	/*
 	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
 	 * to do wakeup during suspend.
-- 
2.7.4

