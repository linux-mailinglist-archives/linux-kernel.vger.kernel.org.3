Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FE505DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiDRRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiDRRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:53:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAA43205A;
        Mon, 18 Apr 2022 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650304246; x=1681840246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDey9EPA2yqQlkCWU3s3Y7wY4b/UIREsMHL7hfPNrug=;
  b=EOiE52N83aKeF3uge/rk2C8WNBV8XxvBFVoXbmpT98X+Vq/M0GBzaHDU
   wB5V3H2HC3U5vcsF4CGe1Y0LOKNypp8WzOyxKlJ1ArvF+ziw/U7sqbpZ5
   fzqW5lMiykfAE2VZSN0O4I9zZJhj7zHQRfXooPe4eqU4zynhNJUpO+CuB
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 10:50:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 10:50:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:45 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 10:50:44 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v4 1/2] bus: mhi: host: Bail on writing register fields if read fails
Date:   Mon, 18 Apr 2022 11:50:25 -0600
Message-ID: <1650304226-11080-2-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
References: <1650304226-11080-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Helper API to write register fields relies on successful reads
of the register/address prior to the write. Bail out if a failure
is seen when reading the register before the actual write is
performed.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/host/boot.c     | 22 ++++++++++++++++------
 drivers/bus/mhi/host/init.c     | 22 +++++++++++++++++-----
 drivers/bus/mhi/host/internal.h |  7 ++++---
 drivers/bus/mhi/host/main.c     |  9 ++++++---
 drivers/bus/mhi/host/pm.c       | 15 +++++++++++----
 5 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index b0da7ca..26d0edd 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -19,8 +19,8 @@
 #include "internal.h"
 
 /* Setup RDDM vector table for RDDM transfer and program RXVEC */
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
-		      struct image_info *img_info)
+int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+		     struct image_info *img_info)
 {
 	struct mhi_buf *mhi_buf = img_info->mhi_buf;
 	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
@@ -28,6 +28,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	u32 sequence_id;
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
 		bhi_vec->dma_addr = mhi_buf->dma_addr;
@@ -45,11 +46,17 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
 	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
 
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
-			    BHIE_RXVECDB_SEQNUM_BMSK, sequence_id);
+	ret = mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+				  BHIE_RXVECDB_SEQNUM_BMSK, sequence_id);
+	if (ret) {
+		dev_err(dev, "Failed to write sequence ID for BHIE_RXVECDB\n");
+		return ret;
+	}
 
 	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
 		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
+
+	return 0;
 }
 
 /* Collect RDDM buffer during kernel panic */
@@ -198,10 +205,13 @@ static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
 
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
 
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
-			    BHIE_TXVECDB_SEQNUM_BMSK, sequence_id);
+	ret = mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+				  BHIE_TXVECDB_SEQNUM_BMSK, sequence_id);
 	read_unlock_bh(pm_lock);
 
+	if (ret)
+		return ret;
+
 	/* Wait for the image download to complete */
 	ret = wait_event_timeout(mhi_cntrl->state_event,
 				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a8c18c5f..3842611 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -547,9 +547,14 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
 
 	/* Write to MMIO registers */
-	for (i = 0; reg_info[i].offset; i++)
-		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
-				    reg_info[i].mask, reg_info[i].val);
+	for (i = 0; reg_info[i].offset; i++) {
+		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
+					  reg_info[i].mask, reg_info[i].val);
+		if (ret) {
+			dev_err(dev, "Unable to write to MMIO registers\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -1117,8 +1122,15 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 		 */
 		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
 				     mhi_cntrl->rddm_size);
-		if (mhi_cntrl->rddm_image)
-			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
+		if (mhi_cntrl->rddm_image) {
+			ret = mhi_rddm_prepare(mhi_cntrl,
+					       mhi_cntrl->rddm_image);
+			if (ret) {
+				mhi_free_bhie_table(mhi_cntrl,
+						    mhi_cntrl->rddm_image);
+				goto error_reg_offset;
+			}
+		}
 	}
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index b47d8ef..01fd10a 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -324,8 +324,9 @@ int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
 				    u32 val, u32 delayus);
 void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 		   u32 offset, u32 val);
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 val);
+int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
+				     void __iomem *base, u32 offset, u32 mask,
+				     u32 val);
 void mhi_ring_er_db(struct mhi_event *mhi_event);
 void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
 		  dma_addr_t db_val);
@@ -339,7 +340,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
 void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
 int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
 void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      struct image_info *img_info);
 void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
 
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 9021be7..142eea1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -65,19 +65,22 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 val)
+int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
+				     void __iomem *base, u32 offset, u32 mask,
+				     u32 val)
 {
 	int ret;
 	u32 tmp;
 
 	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
 	if (ret)
-		return;
+		return ret;
 
 	tmp &= ~mask;
 	tmp |= (val << __ffs(mask));
 	mhi_write_reg(mhi_cntrl, base, offset, tmp);
+
+	return 0;
 }
 
 void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index c000a92..dc2e8ff 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -129,13 +129,20 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cn
 
 void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
 {
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
 	if (state == MHI_STATE_RESET) {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_RESET_MASK, 1);
+		ret = mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+					  MHICTRL_RESET_MASK, 1);
 	} else {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_MHISTATE_MASK, state);
+		ret = mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+					  MHICTRL_MHISTATE_MASK, state);
 	}
+
+	if (ret)
+		dev_err(dev, "Failed to set MHI state to: %s\n",
+			mhi_state_str(state));
 }
 
 /* NOP for backward compatibility, host allowed to ring DB in M2 state */
-- 
2.7.4

