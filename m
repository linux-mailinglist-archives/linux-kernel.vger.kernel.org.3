Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC8481CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhL3OEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:04:52 -0500
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:10726 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbhL3OEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:04:48 -0500
DKIM-Signature: a=rsa-sha256;
        b=oFRei3OJYHj6xA2yRbqb2IoU+wF4W2tnfHbsEwbuq6D7uZwRSGgrtuSf+3xM9QmOm9s/p/Cg66p99QnYSj0P+pVXKfK8VG3b1SVv5I1XK9JfYIksWvEoa14qQ6ZJqHEj6Af26MxdKC8u/deBvuTg8d97orB6DcS5MXquHYVXLhA=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=RWcY89ErvPEeUtYtul67R6QvSk7GdHCL3vo/k7DyrAY=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 0331E2801D3;
        Thu, 30 Dec 2021 21:59:22 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH v3 1/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
Date:   Thu, 30 Dec 2021 21:58:30 +0800
Message-Id: <20211230135832.23005-2-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230135832.23005-1-akingchen@vivo.com>
References: <20211230135832.23005-1-akingchen@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNNHklWHh5OHkJCHh8eGR
        1LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6CDo5Ej5PIREzGR83Hyoa
        SBMaCylVSlVKTU9LQ0xJTE1ITkpDVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBT0pNQjcG
X-HM-Tid: 0a7e0ba35f6cda03kuws0331e2801d3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This quirk is only for dwc3 host mode.
the dwc3 controller can't emurate some devices successfully.
For example, TF card reader (aaaa:8816):
failed log
usb 1-1: new high-speed USB device number 2 using xhci-hcd
usb 1-1: device descriptor read/all, error -110
From the usb analyzer, always return NAK in the data phase.
if enable the GUCTL.SPRSCTRLTRANSEN bit. then the log is:
usb 2-1: new high-speed USB device number 3 using xhci-hcd
usb 2-1: New USB device found, idVendor=aaaa,
idProduct=8816, bcdDevice=13.08
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: Product: MXT USB Device
usb 2-1: Manufacturer: MXTronics
usb 2-1: SerialNumber: 150101v01
usb 2-1: New USB device found, VID=aaaa, PID=8816

Some devices are slow in responding to Control transfers.
Scheduling mulitiple transactions in one microframe/frame
can cause the devices to misbehave. if this qurik is enabled,
the host controller schedules transations for a Control transfer
in defferent microframes/frame.

Signed-off-by: Yaqin Pan <akingchen@vivo.com>
---
 drivers/usb/dwc3/core.c | 4 ++++
 drivers/usb/dwc3/core.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ba74ad7f6995..93ac2c79a2c0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1071,6 +1071,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		 * packet with Retry=1 & Nump != 0)
 		 */
 		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+		if (dwc->sprs_ctrl_trans_quirk)
+			reg |= DWC3_GUCTL_SPRSCTRLTRANSEN;
 
 		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
 	}
@@ -1377,6 +1379,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
+	dwc->sprs_ctrl_trans_quirk = device_property_read_bool(dev,
+				"snps,sprs-ctrl-trans-quirk");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5991766239ba..6048087df1d1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -254,6 +254,7 @@
 
 /* Global User Control Register */
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+#define DWC3_GUCTL_SPRSCTRLTRANSEN	BIT(17)
 
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
@@ -1077,6 +1078,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @sprs_ctrl_trans_quirk: set to enable sparse control transaction quirk.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  */
@@ -1279,6 +1281,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		sprs_ctrl_trans_quirk:1;
 	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
-- 
2.17.1

