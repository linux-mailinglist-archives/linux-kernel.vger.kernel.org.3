Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6090A505DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiDRRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbiDRRx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:53:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D980516582;
        Mon, 18 Apr 2022 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650304249; x=1681840249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cbyg66neQZEsS6a0A9bUci2T5ICx1QxyL7MnY+bDDa8=;
  b=ugMqHNs7dCfWpGC3iwVDpgkFZ8d7C4ZvWuGokWcRK+tktB1eeIbznoD2
   ULYp2QMUvG+H/954axFIPoh/YPBA+9tWg687x8/bmmx0kukL554pwPp7W
   LSSRVZ9McQx6YPVsL0ObcfhPrAJwvJpyCAZp+uyXThkBpKWQWO0Rr9BLj
   s=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 10:50:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 10:50:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:47 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:47 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v4 2/2] bus: mhi: host: Optimize and update MMIO register write method
Date:   Mon, 18 Apr 2022 11:50:26 -0600
Message-ID: <1650304226-11080-3-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
References: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

As of now, MMIO writes done after ready state transition use the
mhi_write_reg_field() API even though the whole register is being
written in most cases. Optimize this process by using mhi_write_reg()
API instead for those writes and use the mhi_write_reg_field()
API for MHI config registers only.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/host/init.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 3842611..cbb86b2 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -439,74 +439,65 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	struct {
 		u32 offset;
-		u32 mask;
 		u32 val;
 	} reg_info[] = {
 		{
-			CCABAP_HIGHER, U32_MAX,
+			CCABAP_HIGHER,
 			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
 		},
 		{
-			CCABAP_LOWER, U32_MAX,
+			CCABAP_LOWER,
 			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
 		},
 		{
-			ECABAP_HIGHER, U32_MAX,
+			ECABAP_HIGHER,
 			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
 		},
 		{
-			ECABAP_LOWER, U32_MAX,
+			ECABAP_LOWER,
 			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
 		},
 		{
-			CRCBAP_HIGHER, U32_MAX,
+			CRCBAP_HIGHER,
 			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
 		},
 		{
-			CRCBAP_LOWER, U32_MAX,
+			CRCBAP_LOWER,
 			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
 		},
 		{
-			MHICFG, MHICFG_NER_MASK,
-			mhi_cntrl->total_ev_rings,
-		},
-		{
-			MHICFG, MHICFG_NHWER_MASK,
-			mhi_cntrl->hw_ev_rings,
-		},
-		{
-			MHICTRLBASE_HIGHER, U32_MAX,
+			MHICTRLBASE_HIGHER,
 			upper_32_bits(mhi_cntrl->iova_start),
 		},
 		{
-			MHICTRLBASE_LOWER, U32_MAX,
+			MHICTRLBASE_LOWER,
 			lower_32_bits(mhi_cntrl->iova_start),
 		},
 		{
-			MHIDATABASE_HIGHER, U32_MAX,
+			MHIDATABASE_HIGHER,
 			upper_32_bits(mhi_cntrl->iova_start),
 		},
 		{
-			MHIDATABASE_LOWER, U32_MAX,
+			MHIDATABASE_LOWER,
 			lower_32_bits(mhi_cntrl->iova_start),
 		},
 		{
-			MHICTRLLIMIT_HIGHER, U32_MAX,
+			MHICTRLLIMIT_HIGHER,
 			upper_32_bits(mhi_cntrl->iova_stop),
 		},
 		{
-			MHICTRLLIMIT_LOWER, U32_MAX,
+			MHICTRLLIMIT_LOWER,
 			lower_32_bits(mhi_cntrl->iova_stop),
 		},
 		{
-			MHIDATALIMIT_HIGHER, U32_MAX,
+			MHIDATALIMIT_HIGHER,
 			upper_32_bits(mhi_cntrl->iova_stop),
 		},
 		{
-			MHIDATALIMIT_LOWER, U32_MAX,
+			MHIDATALIMIT_LOWER,
 			lower_32_bits(mhi_cntrl->iova_stop),
 		},
-		{ 0, 0, 0 }
+		{0, 0}
 	};
 
 	dev_dbg(dev, "Initializing MHI registers\n");
@@ -547,13 +538,22 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
 
 	/* Write to MMIO registers */
-	for (i = 0; reg_info[i].offset; i++) {
-		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
-					  reg_info[i].mask, reg_info[i].val);
-		if (ret) {
-			dev_err(dev, "Unable to write to MMIO registers\n");
-			return ret;
-		}
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg(mhi_cntrl, base, reg_info[i].offset,
+			      reg_info[i].val);
+
+	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NER_MASK,
+				  mhi_cntrl->total_ev_rings);
+	if (ret) {
+		dev_err(dev, "Unable to write MHICFG register\n");
+		return ret;
+	}
+
+	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NHWER_MASK,
+				  mhi_cntrl->hw_ev_rings);
+	if (ret) {
+		dev_err(dev, "Unable to write MHICFG register\n");
+		return ret;
 	}
 
 	return 0;
-- 
2.7.4

