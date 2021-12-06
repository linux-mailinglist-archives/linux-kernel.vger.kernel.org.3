Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DACD46A08A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445059AbhLFQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:05:30 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444112AbhLFQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:02:07 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6F9whL003232;
        Mon, 6 Dec 2021 16:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=LuQGWl9MC186XjkSHLspk8zPVPBxHOXk77t/6daUfYY=;
 b=8RvrBHWzawcNLW0ZOXDI8+HJIJVGqOf6agyZBkzuJHdBU1QMM2bqO/WUZOwU6l0mlsg8
 3bGZdM/x4fwNAkdlxBFSc9fYdmzOltI/4Asb0HevL3q6DbJsXI7oKrkCxiJ5rzWg7/CC
 F6wzxIFIsnVj62QpQY46/SCUOdfQfwu/WH9Ih/p5t0MABd5aCC4OvenMHtzv72CvRdhO
 s/OZ23rrlrC8KyRBzttxBPgNPJW1Md6EGgzMgpo/TOR68sphmnJFRDO4zBnCwEdlmqi2
 ZnjLDbC6X/9Ni0eRmANAoV/VnzEOFeOObmOFVmhpP15p/CCGrR5wTShblYLLbL3awEhh vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csmx0g8c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:58:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC29E10002A;
        Mon,  6 Dec 2021 16:58:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D448620930D;
        Mon,  6 Dec 2021 16:58:23 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 6 Dec 2021 16:58:23
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 2/3] usb: dwc2: drd: add role-switch-default-node support
Date:   Mon, 6 Dec 2021 16:56:42 +0100
Message-ID: <1638806203-6624-3-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using usb-role-switch, while the usb role is not yet define
(USB_ROLE_NONE), the user may want to configure the default mode to host
or device.
Use role-switch-default-mode for that purpose.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/core.h |  3 +++
 drivers/usb/dwc2/drd.c  | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 37185eb..e2fe642 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -869,6 +869,8 @@ struct dwc2_hregs_backup {
  *                      - USB_DR_MODE_HOST
  *                      - USB_DR_MODE_OTG
  * @role_sw:		usb_role_switch handle
+ * @role_sw_default_mode: default operation mode of controller while usb role
+ *			is USB_ROLE_NONE
  * @hcd_enabled:	Host mode sub-driver initialization indicator.
  * @gadget_enabled:	Peripheral mode sub-driver initialization indicator.
  * @ll_hw_enabled:	Status of low-level hardware resources.
@@ -1065,6 +1067,7 @@ struct dwc2_hsotg {
 	enum usb_otg_state op_state;
 	enum usb_dr_mode dr_mode;
 	struct usb_role_switch *role_sw;
+	enum usb_dr_mode role_sw_default_mode;
 	unsigned int hcd_enabled:1;
 	unsigned int gadget_enabled:1;
 	unsigned int ll_hw_enabled:1;
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index aa6eb76..4f453ec 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -24,6 +24,10 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
 	gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN | GOTGCTL_VBVALOEN;
 	gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
 	gotgctl &= ~(GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL);
+	if (hsotg->role_sw_default_mode == USB_DR_MODE_HOST)
+		gotgctl |= GOTGCTL_AVALOVAL | GOTGCTL_VBVALOVAL;
+	else if (hsotg->role_sw_default_mode == USB_DR_MODE_PERIPHERAL)
+		gotgctl |= GOTGCTL_BVALOVAL | GOTGCTL_VBVALOVAL;
 	dwc2_writel(hsotg, gotgctl, GOTGCTL);
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -105,6 +109,14 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
+	if (role == USB_ROLE_NONE) {
+		/* default operation mode when usb role is USB_ROLE_NONE */
+		if (hsotg->role_sw_default_mode == USB_DR_MODE_HOST)
+			role = USB_ROLE_HOST;
+		else if (hsotg->role_sw_default_mode == USB_DR_MODE_PERIPHERAL)
+			role = USB_ROLE_DEVICE;
+	}
+
 	if (role == USB_ROLE_HOST) {
 		already = dwc2_ovr_avalid(hsotg, true);
 	} else if (role == USB_ROLE_DEVICE) {
@@ -146,6 +158,7 @@ int dwc2_drd_init(struct dwc2_hsotg *hsotg)
 	if (!device_property_read_bool(hsotg->dev, "usb-role-switch"))
 		return 0;
 
+	hsotg->role_sw_default_mode = usb_get_role_switch_default_mode(hsotg->dev);
 	role_sw_desc.driver_data = hsotg;
 	role_sw_desc.fwnode = dev_fwnode(hsotg->dev);
 	role_sw_desc.set = dwc2_drd_role_sw_set;
-- 
2.7.4

