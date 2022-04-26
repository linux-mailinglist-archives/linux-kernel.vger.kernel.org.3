Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1B50F7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbiDZJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbiDZJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:34:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492C3F326;
        Tue, 26 Apr 2022 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650963508; x=1682499508;
  h=from:to:cc:subject:date:message-id;
  bh=Q251io/kJJuj8uHbuLecwGWxnXivBjY2LaiYPZX3vSQ=;
  b=Dm+ISPdfrvz4+wBcHt8bX5lwUSop6MKOM4Tc0P72GlAdu1KEf1sulqsc
   FM1KqSqROIgf2fueCxGkCPtGqlW8NAgM4xbPCzmAKx28juvQINUGDakUm
   1xHJnUOCciHSaFvohjiCLv9wvunZeG+m/xoW8zTGJgKM7/C2rlbyL9dbB
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 01:58:28 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 01:58:26 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 26 Apr 2022 14:28:09 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 621D63085; Tue, 26 Apr 2022 14:28:08 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        riteshh@codeaurora.org, asutoshd@codeaurora.org, colyli@suse.de,
        axboe@kernel.dk, kch@nvidia.com, cw9316.lee@samsung.com,
        sbhanu@codeaurora.org, joel@jms.id.au, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kamasali <quic_kamasali@quicinc.com>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] sdhci-msm: Add err_stat's in CQE path
Date:   Tue, 26 Apr 2022 14:28:01 +0530
Message-Id: <1650963481-11139-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaik Sajida Bhanu <sbhanu@codeaurora.org>

Add err_stat's in CQE path for eMMC.

Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/queue.c      |  4 ++++
 drivers/mmc/host/cqhci-core.c |  7 +++++++
 drivers/mmc/host/sdhci.c      | 21 ++++++++++++++-------
 include/linux/mmc/host.h      | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a3d4460..7b07520 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -100,6 +100,10 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	bool recovery_needed = false;
 
+	host->err_stats[MMC_ERR_CMDQ_REQ_TIMEOUT]++;
+	mmc_log_string(host,
+	"Request timed out! Active reqs: %d Req: %p Tag: %d\n",
+	mmc_cqe_qcnt(mq), req, req->tag);
 	switch (issue_type) {
 	case MMC_ISSUE_ASYNC:
 	case MMC_ISSUE_DCMD:
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 311b510..03d4064 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -825,6 +825,13 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
 	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
 	    cmd_error || data_error || ice_err){
 		mmc->need_hw_reset = true;
+		if (status & CQHCI_IS_RED)
+			mmc->err_stats[MMC_ERR_CMDQ_RED]++;
+		if (status & CQHCI_IS_GCE)
+			mmc->err_stats[MMC_ERR_CMDQ_GCE]++;
+		if (status & CQHCI_IS_ICCE)
+			mmc->err_stats[MMC_ERR_CMDQ_ICCE]++;
+
 		cqhci_error_irq(mmc, status, cmd_error, data_error);
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2215202..a76c514 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3905,20 +3905,27 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 	if (!host->cqe_on)
 		return false;
 
-	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
+	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
 		*cmd_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_TIMEOUT)
+		if (intmask & SDHCI_INT_CRC)
+			host->mmc->err_stats[MMC_ERR_CMD_CRC]++;
+	} else if (intmask & SDHCI_INT_TIMEOUT) {
 		*cmd_error = -ETIMEDOUT;
-	else
+		host->mmc->err_stats[MMC_ERR_CMD_TIMEOUT]++;
+	} else
 		*cmd_error = 0;
 
-	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
+	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
 		*data_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
+		if (intmask & SDHCI_INT_DATA_CRC)
+			host->mmc->err_stats[MMC_ERR_DAT_CRC]++;
+	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		*data_error = -ETIMEDOUT;
-	else if (intmask & SDHCI_INT_ADMA_ERROR)
+		host->mmc->err_stats[MMC_ERR_DAT_TIMEOUT]++;
+	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		*data_error = -EIO;
-	else
+		host->mmc->err_stats[MMC_ERR_ADMA]++;
+	} else
 		*data_error = 0;
 
 	/* Clear selected interrupts. */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3d00bcf..c38072e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -80,6 +80,9 @@ struct mmc_ios {
 	bool enhanced_strobe;			/* hs400es selection */
 };
 
+#define NUM_LOG_PAGES           10
+#define mmc_log_string(mmc_host, fmt, ...)      do { } while (0)
+
 struct mmc_clk_phase {
 	bool valid;
 	u16 in_deg;
@@ -93,6 +96,24 @@ struct mmc_clk_phase_map {
 
 struct mmc_host;
 
+enum {
+	MMC_ERR_CMD_TIMEOUT,
+	MMC_ERR_CMD_CRC,
+	MMC_ERR_DAT_TIMEOUT,
+	MMC_ERR_DAT_CRC,
+	MMC_ERR_AUTO_CMD,
+	MMC_ERR_ADMA,
+	MMC_ERR_TUNING,
+	MMC_ERR_CMDQ_RED,
+	MMC_ERR_CMDQ_GCE,
+	MMC_ERR_CMDQ_ICCE,
+	MMC_ERR_REQ_TIMEOUT,
+	MMC_ERR_CMDQ_REQ_TIMEOUT,
+	MMC_ERR_ICE_CFG,
+	MMC_ERR_MAX,
+};
+
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -471,6 +492,7 @@ struct mmc_host {
 	struct mmc_supply	supply;
 
 	struct dentry		*debugfs_root;
+	u32                     err_stats[MMC_ERR_MAX];
 
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
-- 
2.7.4

