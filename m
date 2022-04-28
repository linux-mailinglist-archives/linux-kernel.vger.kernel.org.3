Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD5513BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351358AbiD1TIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351350AbiD1TIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:08:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F37BAB86;
        Thu, 28 Apr 2022 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651172695; x=1682708695;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2+AjbD7jqLLejH2LIwYZzfLa2wTbFMTWJ4g7CUb1Q6A=;
  b=R1ycRTRbOB/ouqQTrpzbsfAM2jnVZPxiBp45XF+AifAd2fgiUjO3w/0c
   sqh0CiVzgQDd0pg78imi6UkgWb7BToS5+0xVuzgZIrFBl8QSLseV+UKMT
   x1YfMq8FxvJBQ1X0gMXDaG/p5UvQ9yenLOlDflt3k8nqpdDk9nbOs8EKf
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2022 12:04:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 12:04:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 12:04:54 -0700
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 12:04:53 -0700
From:   Mayank Rana <quic_mrana@quicinc.com>
To:     <peter.chen@kernel.org>, <balbi@kernel.org>,
        <mathias.nyman@linux.intel.com>, <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Date:   Thu, 28 Apr 2022 12:04:48 -0700
Message-ID: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ring_doorbell_for_active_rings() API is being called from
multiple context. This specific API tries to get virt_dev
based endpoint using passed slot_id and ep_index. Some caller
API is having check against slot_id and ep_index using
xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
only check ep_index against -1 value but not upper bound i.e.
EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
based endpoint which checks both slot_id and ep_index to get
valid endpoint.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0b6806..3bab4f3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -62,6 +62,9 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			 u32 field1, u32 field2,
 			 u32 field3, u32 field4, bool command_must_succeed);
 
+static struct xhci_virt_ep *xhci_get_virt_ep(struct xhci_hcd *xhci,
+			unsigned int slot_id, unsigned int ep_index);
+
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
  * address of the TRB.
@@ -457,7 +460,9 @@ static void ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 	unsigned int stream_id;
 	struct xhci_virt_ep *ep;
 
-	ep = &xhci->devs[slot_id]->eps[ep_index];
+	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
+	if (!ep)
+		return;
 
 	/* A ring has pending URBs if its TD list is not empty */
 	if (!(ep->ep_state & EP_HAS_STREAMS)) {
-- 
2.7.4

