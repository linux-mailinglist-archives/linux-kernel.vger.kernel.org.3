Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E74FFE32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiDMSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiDMSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:55:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51F3C493;
        Wed, 13 Apr 2022 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649875964; x=1681411964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kIdWbaHtEU0x9HW6lYv/3aJs5QjFHoVlujqamdmcyc=;
  b=AXfVHdMqLIdOuk2XVpxhtiZLKOP0BGhBxy0n7qbJbKGanEDwZldC1qcg
   h9NKxfe1G6zkKKBwi37n2U3ngcg7+kUarLCWFQ/btRPQfi5hW/fIUtob7
   yH0pxRqI4y4pCxZEihVts3dVbFwO0/H4ALHf146tpEEIs3DP9x4tjNN4a
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 11:52:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:52:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 11:52:42 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 11:52:41 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>
Subject: [PATCH v3] bus: mhi: host: Wait for ready state after reset
Date:   Wed, 13 Apr 2022 12:52:26 -0600
Message-ID: <1649875946-32516-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

After the device has signaled the end of reset by clearing the reset bit,
it will automatically reinit MHI and the internal device structures.  Once
That is done, the device will signal it has entered the ready state.

Signaling the ready state involves sending an interrupt (MSI) to the host
which might cause IOMMU faults if it occurs at the wrong time.

If the controller is being powered down, and possibly removed, then the
reset flow would only wait for the end of reset.  At which point, the host
and device would start a race.  The host may complete its reset work, and
remove the interrupt handler, which would cause the interrupt to be
disabled in the IOMMU.  If that occurs before the device signals the ready
state, then the IOMMU will fault since it blocked an interrupt.  While
harmless, the fault would appear like a serious issue has occurred so let's
silence it by making sure the device hits the ready state before the host
completes its reset processing.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---

v3:
Rebase and use dev_err over dev_warn

v2: 
Fix subject and remove use of cur_state

 drivers/bus/mhi/host/pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index a0e91bd..f46158e 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -483,6 +483,15 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 		 * hence re-program it
 		 */
 		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+
+		if (!MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
+			/* wait for ready to be set */
+			ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs,
+						 MHISTATUS,
+						 MHISTATUS_READY_MASK, 1, 25000);
+			if (ret)
+				dev_err(dev, "Device failed to enter READY state\n");
+		}
 	}
 
 	dev_dbg(dev,
-- 
2.7.4

