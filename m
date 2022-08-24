Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39559F6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiHXJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiHXJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:30 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909EE3E744;
        Wed, 24 Aug 2022 02:50:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN6xH8p_1661334624;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN6xH8p_1661334624)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:25 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/9] crypto/ycc: Add device error handling support for ycc hw errors
Date:   Wed, 24 Aug 2022 17:50:16 +0800
Message-Id: <1661334621-44413-5-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

Due to ycc hardware limitations, in REE ycc device cannot be reset to
recover from fatal error (reset register is only valid in TEE and
PCIE FLR only reset queue pointers but not ycc hw), regard all hw errors
except queue error as fatal error.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 drivers/crypto/ycc/ycc_isr.c  | 93 +++++++++++++++++++++++++++++++++++++++++--
 drivers/crypto/ycc/ycc_ring.c | 90 +++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.h |  3 ++
 3 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ycc/ycc_isr.c b/drivers/crypto/ycc/ycc_isr.c
index a86c8d7..28f8918 100644
--- a/drivers/crypto/ycc/ycc_isr.c
+++ b/drivers/crypto/ycc/ycc_isr.c
@@ -15,6 +15,8 @@
 #include "ycc_dev.h"
 #include "ycc_ring.h"
 
+extern void ycc_clear_cmd_ring(struct ycc_ring *ring);
+extern void ycc_clear_resp_ring(struct ycc_ring *ring);
 
 static irqreturn_t ycc_resp_isr(int irq, void *data)
 {
@@ -24,11 +26,93 @@ static irqreturn_t ycc_resp_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/*
- * TODO: will implement when ycc ring actually work.
- */
+static void ycc_fatal_error(struct ycc_dev *ydev)
+{
+	struct ycc_ring *ring;
+	int i;
+
+	for (i = 0; i < YCC_RINGPAIR_NUM; i++) {
+		ring = ydev->rings + i;
+
+		if (ring->type != KERN_RING)
+			continue;
+
+		spin_lock_bh(&ring->lock);
+		ycc_clear_cmd_ring(ring);
+		spin_unlock_bh(&ring->lock);
+
+		ycc_clear_resp_ring(ring);
+	}
+}
+
 static void ycc_process_global_err(struct work_struct *work)
 {
+	struct ycc_dev *ydev = container_of(work, struct ycc_dev, work);
+	struct ycc_bar *cfg_bar = &ydev->ycc_bars[YCC_SEC_CFG_BAR];
+	struct ycc_ring *ring;
+	u32 hclk_err, xclk_err;
+	u32 xclk_ecc_uncor_err_0, xclk_ecc_uncor_err_1;
+	u32 hclk_ecc_uncor_err;
+	int i;
+
+	if (pci_wait_for_pending_transaction(ydev->pdev))
+		pr_warn("Failed to pending transaction\n");
+
+	hclk_err = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_HCLK_INT_STATUS);
+	xclk_err = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_XCLK_INT_STATUS);
+	xclk_ecc_uncor_err_0 = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_XCLK_MEM_ECC_UNCOR_0);
+	xclk_ecc_uncor_err_1 = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_XCLK_MEM_ECC_UNCOR_1);
+	hclk_ecc_uncor_err = YCC_CSR_RD(cfg_bar->vaddr, REG_YCC_HCLK_MEM_ECC_UNCOR);
+
+	if ((hclk_err & ~(YCC_HCLK_TRNG_ERR)) || xclk_err || hclk_ecc_uncor_err) {
+		pr_err("Got uncorrected error, must be reset\n");
+		/*
+		 * Fatal error, as ycc cannot be reset in REE, clear ring data.
+		 */
+		return ycc_fatal_error(ydev);
+	}
+
+	if (xclk_ecc_uncor_err_0 || xclk_ecc_uncor_err_1) {
+		pr_err("Got algorithm ECC error: %x, %x\n",
+			xclk_ecc_uncor_err_0, xclk_ecc_uncor_err_1);
+		return ycc_fatal_error(ydev);
+	}
+
+	/* This has to be queue error. Handling command rings. */
+	for (i = 0; i < YCC_RINGPAIR_NUM; i++) {
+		ring = ydev->rings + i;
+
+		if (ring->type != KERN_RING)
+			continue;
+
+		ring->status = YCC_CSR_RD(ring->csr_vaddr, REG_RING_STATUS);
+		if (ring->status) {
+			pr_err("YCC: Dev: %d, Ring: %d got ring err: %x\n",
+				ydev->id, ring->ring_id, ring->status);
+			spin_lock_bh(&ring->lock);
+			ycc_clear_cmd_ring(ring);
+			spin_unlock_bh(&ring->lock);
+		}
+	}
+
+	/*
+	 * Give HW a chance to process all pending_cmds
+	 * through recovering transactions.
+	 */
+	pci_set_master(ydev->pdev);
+
+	for (i = 0; i < YCC_RINGPAIR_NUM; i++) {
+		ring = ydev->rings + i;
+
+		if (ring->type != KERN_RING || !ring->status)
+			continue;
+
+		ycc_clear_resp_ring(ring);
+	}
+
+	ycc_g_err_unmask(cfg_bar->vaddr);
+	clear_bit(YDEV_STATUS_ERR, &ydev->status);
+	set_bit(YDEV_STATUS_READY, &ydev->status);
 }
 
 static irqreturn_t ycc_g_err_isr(int irq, void *data)
@@ -45,6 +129,9 @@ static irqreturn_t ycc_g_err_isr(int irq, void *data)
 
 	clear_bit(YDEV_STATUS_READY, &ydev->status);
 
+	/* Disable YCC mastering, no new transactions */
+	pci_clear_master(ydev->pdev);
+
 	schedule_work(&ydev->work);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/crypto/ycc/ycc_ring.c b/drivers/crypto/ycc/ycc_ring.c
index d808054..f6f6e40 100644
--- a/drivers/crypto/ycc/ycc_ring.c
+++ b/drivers/crypto/ycc/ycc_ring.c
@@ -483,6 +483,24 @@ int ycc_enqueue(struct ycc_ring *ring, void *cmd)
 	return ret;
 }
 
+static void ycc_cancel_cmd(struct ycc_ring *ring, struct ycc_cmd_desc *desc)
+{
+	struct ycc_flags *aflag;
+
+	dma_rmb();
+
+	aflag = (struct ycc_flags *)desc->private_ptr;
+	if (!aflag || (u64)aflag == CMD_INVALID_CONTENT_U64) {
+		pr_debug("YCC: Invalid aflag\n");
+		return;
+	}
+
+	aflag->ycc_done_callback(aflag->ptr, CMD_CANCELLED);
+
+	memset(desc, CMD_INVALID_CONTENT_U8, sizeof(*desc));
+	kfree(aflag);
+}
+
 static inline void ycc_check_cmd_state(u16 state)
 {
 	switch (state) {
@@ -560,3 +578,75 @@ void ycc_dequeue(struct ycc_ring *ring)
 	if (cnt)
 		YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_RD_PTR, ring->resp_rd_ptr);
 }
+
+/*
+ * Clear incompletion cmds in command queue while rollback cmd_wr_ptr.
+ *
+ * Note: Make sure been invoked when error occurs in YCC internal and
+ * YCC status is not ready.
+ */
+void ycc_clear_cmd_ring(struct ycc_ring *ring)
+{
+	struct ycc_cmd_desc *desc = NULL;
+
+	ring->cmd_rd_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_CMD_RD_PTR);
+	ring->cmd_wr_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_CMD_WR_PTR);
+
+	while (ring->cmd_rd_ptr != ring->cmd_wr_ptr) {
+		desc = (struct ycc_cmd_desc *)ring->cmd_base_vaddr +
+			ring->cmd_rd_ptr;
+		ycc_cancel_cmd(ring, desc);
+
+		if (--ring->cmd_wr_ptr == 0)
+			ring->cmd_wr_ptr = ring->max_desc;
+	}
+
+	YCC_CSR_WR(ring->csr_vaddr, REG_RING_CMD_WR_PTR, ring->cmd_wr_ptr);
+}
+
+/*
+ * Clear response queue
+ *
+ * Note: Make sure been invoked when error occurs in YCC internal and
+ * YCC status is not ready.
+ */
+void ycc_clear_resp_ring(struct ycc_ring *ring)
+{
+	struct ycc_resp_desc *resp;
+	int retry;
+	u32 pending_cmd;
+
+	/*
+	 * Check if the ring has been stopped. *stop* means no
+	 * new transactions, No need to wait for pending_cmds
+	 * been processed under this condition.
+	 */
+	retry = ycc_ring_stopped(ring) ? 0 : MAX_ERROR_RETRY;
+	pending_cmd = YCC_CSR_RD(ring->csr_vaddr, REG_RING_PENDING_CMD);
+
+	ring->resp_wr_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_RSP_WR_PTR);
+	while (!ycc_ring_empty(ring) || (retry && pending_cmd)) {
+		if (!ycc_ring_empty(ring)) {
+			resp = (struct ycc_resp_desc *)ring->resp_base_vaddr +
+				ring->resp_rd_ptr;
+			resp->state = CMD_CANCELLED;
+			ycc_handle_resp(ring, resp);
+
+			if (++ring->resp_rd_ptr == ring->max_desc)
+				ring->resp_rd_ptr = 0;
+
+			YCC_CSR_WR(ring->csr_vaddr, REG_RING_RSP_RD_PTR, ring->resp_rd_ptr);
+		} else {
+			udelay(MAX_SLEEP_US_PER_CHECK);
+			retry--;
+		}
+
+		pending_cmd = YCC_CSR_RD(ring->csr_vaddr, REG_RING_PENDING_CMD);
+		ring->resp_wr_ptr = YCC_CSR_RD(ring->csr_vaddr, REG_RING_RSP_WR_PTR);
+	}
+
+	if (!retry && pending_cmd)
+		ring->type = INVAL_RING;
+
+	ring->status = 0;
+}
diff --git a/drivers/crypto/ycc/ycc_ring.h b/drivers/crypto/ycc/ycc_ring.h
index eb3e6f9..c3e7cbf 100644
--- a/drivers/crypto/ycc/ycc_ring.h
+++ b/drivers/crypto/ycc/ycc_ring.h
@@ -20,6 +20,9 @@
 #define CMD_INVALID_CONTENT_U8		0x7f
 #define CMD_INVALID_CONTENT_U64		0x7f7f7f7f7f7f7f7fULL
 
+#define MAX_SLEEP_US_PER_CHECK		100   /* every 100us to check register */
+#define MAX_ERROR_RETRY			10000 /* 1s in total */
+
 enum ring_type {
 	FREE_RING,
 	USER_RING,
-- 
1.8.3.1

