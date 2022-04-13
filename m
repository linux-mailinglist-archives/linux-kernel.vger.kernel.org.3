Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B94FFAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiDMP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiDMP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:59:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E26350D;
        Wed, 13 Apr 2022 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649865451; x=1681401451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=foVGuxN7+nmNTCR9xTdDaViL91F/VgCzWYShCQHvVMM=;
  b=b8QMjbuv3RWiCZhlULEbBQTW7JMvCSBVL0+fmFoie3drLTSAwA9igL6c
   IlzVKML1IJQYHZXx2+AIo/cx53jo35gDDRttgCv3XmoiRVWMgFbwmzje7
   g7ZDY+rmxdmVEKOUxs9IQ8AmopXc8fsWbdcW6C/lM5hk1fKiSIJzQvHva
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 08:57:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:57:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:57:16 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:57:15 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <loic.poulain@linaro.org>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v3 2/2] bus: mhi: host: Optimize and update MMIO register write method
Date:   Wed, 13 Apr 2022 09:56:46 -0600
Message-ID: <1649865406-30198-3-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649865406-30198-1-git-send-email-quic_jhugo@quicinc.com>
References: <1649865406-30198-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
index 9ac93b7..04c409b 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -425,74 +425,65 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
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
@@ -533,13 +524,22 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
 
 	/* Write to MMIO registers */
-	for (i = 0; reg_info[i].offset; i++) {
-		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
-					  reg_info[i].mask, reg_info[i].val);
-		if (ret) {
-			dev_err(dev, "Unable to write to MMIO registers");
-			return ret;
-		}
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg(mhi_cntrl, base, reg_info[i].offset,
+			      reg_info[i].val);
+
+	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NER_MASK,
+				  mhi_cntrl->total_ev_rings);
+	if (ret) {
+		dev_err(dev, "Unable to read MHICFG register\n");
+		return ret;
+	}
+
+	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NHWER_MASK,
+				  mhi_cntrl->hw_ev_rings);
+	if (ret) {
+		dev_err(dev, "Unable to read MHICFG register\n");
+		return ret;
 	}
 
 	return 0;
-- 
2.7.4

