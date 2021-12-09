Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4FD46E96F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhLIN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:57:02 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:61906 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbhLIN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:56:59 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 08:56:59 EST
DKIM-Signature: a=rsa-sha256;
        b=J+dutm1BO13lkiGxsFDiVmBVVHg33t8T83KpR2Kt0bwkyZ0/KkPk+NiVmD1kAS3foX850t/WTttcyiE4/vZnzrdTwXVfQVMCbhHp0nrCmwXYj16h5AlzF3zF3eIFHXfl/Dx0Vqmic5KG4v4J4edPXuCR9zRVRBvURs4JT2l1rdY=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=8GqwgYzSdxovfAPPkPeO5+SyqeQ4nFWOB9oWvto4tYc=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.250.176.229])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id E67787E0261;
        Thu,  9 Dec 2021 21:46:46 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH] usb: dwc3: add sprs_ctrl_trans_quirk
Date:   Thu,  9 Dec 2021 21:46:16 +0800
Message-Id: <20211209134616.20031-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNOSElWH08aTBoYTUpLTU
        oaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Lgw6ST5OUUNNNwETHBQ6
        NjoKFA9VSlVKTUhCS05MTUtMSEJJVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQUhLQ003Bg++
X-HM-Tid: 0a7d9f7249d5d999kuwse67787e0261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.

Some special peripherals can't handle the control transfer well.
For example, TF card reader (aaaa:8816):
usb 1-1: new high-speed USB device number 2 using xhci-hcd
usb 1-1: device descriptor read/all, error -110
From the usb analyzer, always return NAK in the data phase.

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

