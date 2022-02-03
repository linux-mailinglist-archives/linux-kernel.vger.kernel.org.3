Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514A4A8018
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiBCIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:00:42 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59011 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243764AbiBCIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643875235; x=1675411235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxnGpZbD0kpPes3OMo1bth+EcSxHpnt3Lvs3J3lXJps=;
  b=ob61RYbJgaT5CGpfWLTIVHD4IYyUlg0GfTryeCeYLJErQhjGrqdg9LZS
   FAlih3FT1B+BS9OdTw0MbCQ8M1LD+FcYrnK2QCUFVaKbW4Yzo7yvHsoIX
   C9l+oS8wePDluAKkWL5IoWCbr5uXVnEV/DNxs+rZO62HgZiMoLCvuD2YQ
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 00:00:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:00:34 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:34 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:33 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 3/3] usb: dwc3: Issue core soft reset before enabling run/stop
Date:   Thu, 3 Feb 2022 00:00:17 -0800
Message-ID: <20220203080017.27339-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203080017.27339-1-quic_wcheng@quicinc.com>
References: <20220203080017.27339-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is recommended by the Synopsis databook to issue a DCTL.CSftReset
when reconnecting from a device-initiated disconnect routine.  This
resolves issues with enumeration during fast composition switching
cases, which result in an unknown device on the host.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/core.c   |  4 +---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 11 +++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f4c09951b517..d128c7f22b01 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
-static int dwc3_core_soft_reset(struct dwc3 *dwc);
-
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
  */
-static int dwc3_core_soft_reset(struct dwc3 *dwc)
+int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
 	int		retries = 1000;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d418ed55a566..e15b83a6f094 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1527,6 +1527,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
+int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1efa30907d42..94cfbe32da8d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2572,6 +2572,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 						dwc->ev_buf->length;
 		}
 	} else {
+		/*
+		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 1.90a
+		 * Section 4.1.9, it specifies that for a reconnect after a
+		 * device-initiated disconnect requires a core soft reset
+		 * (DCTL.CSftRst) before enabling the run/stop bit.
+		 */
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_core_soft_reset(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+
+		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
 	}
 
