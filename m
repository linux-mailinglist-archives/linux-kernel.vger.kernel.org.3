Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2966D588263
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiHBTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiHBTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:18:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B613CCE;
        Tue,  2 Aug 2022 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467923; x=1691003923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ky3hajG51y45sWKL2Azm+Pql0QLC7hUAs8rv8/gaqfw=;
  b=FCb9vVFYx0OvpzLtDKwrn1exv+woOqnt1TtEGIBeRiF2eDVbcHWPPbjh
   lTg+uK/Wcsb/aUpZkQSzb6+NvLRQJ8/BZcP1OehTqW/lgkxLNJzU7qgLk
   pZUBiOj5PEjBkVS0Z9wDicBBN+uP6CslvLejkDLzHTsTlUqOVfQajGQOY
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg09-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 78DF9211BD; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 3/5] usb: dwc3: Add function suspend and function wakeup support
Date:   Tue,  2 Aug 2022 12:18:38 -0700
Message-Id: <1659467920-9095-4-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB host sends function suspend and resume notifications to
device through SET_FEATURE setup packet. This packet is directed
to the interface to which function suspend/resume is intended to.
Add support to handle this packet by delegating the request to composite
layer. To exit from function suspend the interface needs to trigger a
function wakeup in case it wants to initate a data transfer. Expose a
new gadget op so that an interface can send function wakeup request to
the host.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/ep0.c    | 12 ++++--------
 drivers/usb/dwc3/gadget.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3306b1c..e08e522 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -519,6 +519,7 @@
 #define DWC3_DGCMD_SET_SCRATCHPAD_ADDR_LO	0x04
 #define DWC3_DGCMD_SET_SCRATCHPAD_ADDR_HI	0x05
 
+#define DWC3_DGCMD_XMIT_DEV		0x07
 #define DWC3_DGCMD_SELECTED_FIFO_FLUSH	0x09
 #define DWC3_DGCMD_ALL_FIFO_FLUSH	0x0a
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 4cc3d3a..cedc890 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -30,6 +30,8 @@
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
 static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		struct dwc3_ep *dep, struct dwc3_request *req);
+static int dwc3_ep0_delegate_req(struct dwc3 *dwc,
+				 struct usb_ctrlrequest *ctrl);
 
 static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
 		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
@@ -365,7 +367,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 * Function Remote Wake Capable	D0
 		 * Function Remote Wakeup	D1
 		 */
-		break;
+		return dwc3_ep0_delegate_req(dwc, ctrl);
 
 	case USB_RECIP_ENDPOINT:
 		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
@@ -511,13 +513,7 @@ static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
 
 	switch (wValue) {
 	case USB_INTRF_FUNC_SUSPEND:
-		/*
-		 * REVISIT: Ideally we would enable some low power mode here,
-		 * however it's unclear what we should be doing here.
-		 *
-		 * For now, we're not doing anything, just making sure we return
-		 * 0 so USB Command Verifier tests pass without any errors.
-		 */
+		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d6697da..0b2947e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2357,6 +2357,35 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	return ret;
 }
 
+static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int interface_id)
+{
+	int	ret = 0;
+	u32	reg;
+	struct	dwc3 *dwc = gadget_to_dwc(g);
+
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+
+	/*
+	 * If the link is in LPM, first bring the link to U0
+	 * before triggering function wakeup. Ideally this
+	 * needs to be expanded to other LPMs as well in
+	 * addition to U3
+	 */
+	if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U3) {
+		dwc3_gadget_wakeup(g);
+		return -EAGAIN;
+	}
+
+	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_XMIT_DEV,
+					       0x1 | (interface_id << 4));
+
+	if (ret)
+		dev_err(dwc->dev, "Function wakeup HW command failed, ret %d\n",
+			ret);
+
+	return ret;
+}
+
 static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
@@ -2978,6 +3007,7 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
+	.func_wakeup		= dwc3_gadget_func_wakeup,
 	.set_selfpowered	= dwc3_gadget_set_selfpowered,
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
-- 
2.7.4

