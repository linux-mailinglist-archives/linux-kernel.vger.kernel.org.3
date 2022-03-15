Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94C4D924B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiCOBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiCOBom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:44:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CC75FC3;
        Mon, 14 Mar 2022 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647308610; x=1678844610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nYJdoTdaXWvHpz6tJG1Vr39/tdMr91NljH5cGWGoauY=;
  b=XzNGhbMZvVZVOFvl0ZuktwjwQGtxNTYU5gljJ0pjpGHAlcfXjIU7xiVf
   mTOluNLoEwctdtT2HmIR7vG8IMKR9Y/ZjfF0bd2Hm64WqXLXBBJ+WkCBo
   splR2H4qIP0Kn84qXCaoBesS08SQejX31UUcSjQEEMqv89+2/2ZZsw6Xr
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Mar 2022 18:43:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:43:29 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 18:43:29 -0700
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 18:43:28 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3] usb: dwc3: Issue core soft reset before enabling run/stop
Date:   Mon, 14 Mar 2022 18:43:17 -0700
Message-ID: <20220315014317.14265-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is recommended by the Synopsis databook to issue a DCTL.CSftReset
when reconnecting from a device-initiated disconnect routine.  This
resolves issues with enumeration during fast composition switching
cases, which result in an unknown device on the host.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 Changes in v3:
   - Removed change from RFC series and placed into its own patch.

 Previous patches:
  https://lore.kernel.org/linux-usb/20220203080017.27339-1-quic_wcheng@quicinc.com/

 drivers/usb/dwc3/core.c   |  4 +---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 11 +++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 18adddfba3da..02d10e1cb774 100644
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
index eb9c1efced05..86e27afef6c5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1530,6 +1530,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
+int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0c883f19a41..448ff6cb9c22 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2544,6 +2544,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
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
 
