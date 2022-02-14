Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2055F4B4FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbiBNMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:21:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbiBNMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:21:05 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C834926D;
        Mon, 14 Feb 2022 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644841258; x=1676377258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MW9gwIUptsYLqIzS86VeUTXVM3BIYMlecniPn+jF7iU=;
  b=IhyHrgbNd+6q3h9SB71owo7p7xlks/JUpnQKi+xdAPaTia/wR3LrLoRU
   ViUq3eGTbaCS5xICTMz3DMsi85YFRQTktbVvaSGnXjWTB4VVsty+hn0Wh
   isQD0tZhmNVAD5e6KYHeaIIkqrpcdkfMboRiJHiZkxb2cZEiNqVu5Uy/v
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 04:20:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:20:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 04:20:56 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 04:20:53 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Date:   Mon, 14 Feb 2022 17:50:16 +0530
Message-ID: <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
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

From: Daehwan Jung <dh10.jung@samsung.com>

xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
controller reset and controller ready operations can be fatal to the
system when controller is timed out. Reduce the timeout to 1 second
and print a error message when the time out happens.

Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---

v2:
- Add error print statements in the code that change log refers to

 drivers/usb/host/xhci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dc357ca..bb9ea3f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -196,9 +196,11 @@ int xhci_reset(struct xhci_hcd *xhci)
 		udelay(1000);
 
 	ret = xhci_handshake(&xhci->op_regs->command,
-			CMD_RESET, 0, 10 * 1000 * 1000);
-	if (ret)
+			CMD_RESET, 0, 1 * 1000 * 1000);
+	if (ret) {
+		xhci_err(xhci, "Host controller reset timed out\n");
 		return ret;
+	}
 
 	if (xhci->quirks & XHCI_ASMEDIA_MODIFY_FLOWCONTROL)
 		usb_asmedia_modifyflowcontrol(to_pci_dev(xhci_to_hcd(xhci)->self.controller));
@@ -210,7 +212,11 @@ int xhci_reset(struct xhci_hcd *xhci)
 	 * than status until the "Controller Not Ready" flag is cleared.
 	 */
 	ret = xhci_handshake(&xhci->op_regs->status,
-			STS_CNR, 0, 10 * 1000 * 1000);
+			STS_CNR, 0, 1 * 1000 * 1000);
+	if (ret) {
+		xhci_err(xhci, "Host controller is not ready within timeout\n");
+		return ret;
+	}
 
 	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
 	xhci->usb2_rhub.bus_state.suspended_ports = 0;
-- 
2.7.4

