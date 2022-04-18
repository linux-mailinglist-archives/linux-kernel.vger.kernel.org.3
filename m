Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC83505D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiDRRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiDRRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:25:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15133A1A;
        Mon, 18 Apr 2022 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650302580; x=1681838580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TUDh1P4g0jsnsPATt1iFcZ2ZfjR5qo7apigNyVsZJ3k=;
  b=oHmQAETe7jJwaTHo6H1JyL3K2JdSVPH0Xmdw1SM0cup2JMq/R99Iui0W
   RmmlGSMArPNKSdrn3YlIsyqkfwd8Of+an9QXovuGVLh0SCxepJAErM/j8
   baOPeiq4w/d6U+nWuXQKqk/5lWVkELSX4jqMdShNJJ2PfCA8heei8WwJs
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 10:22:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 10:22:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:22:52 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:22:51 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v4] bus: mhi: host: Wait for ready state after reset
Date:   Mon, 18 Apr 2022 11:22:42 -0600
Message-ID: <1650302562-30964-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <quic_hemantk@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

v4:
Cleanup email domain change

v3:
Rebase and use dev_err over dev_warn

v2: 
Fix subject and remove use of cur_state

 drivers/bus/mhi/host/pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 3d90b8e..c000a92 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -476,6 +476,15 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
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

