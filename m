Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49E52B2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiERHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiERHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:02:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D978154F82;
        Wed, 18 May 2022 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652857371; x=1684393371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PnuZODT/1chnRzWV3cNVEE6KQ80NkkWFAF1Rh1tJ0P8=;
  b=b8r87b+1V50TaYWxDdQ/BJfGSQUS5F7kQxfHHulpozTyqAN9pMNgmDKX
   0sRBwf6jvgHoQ1VyAImnxZHtfSFvi7aBqrFBUUk1tYVPPAkziJNA7p3Bl
   VTHV42ECJ3bXUXYHya0eitcV2fRWTtm5xX2WZASMLOzGWSs7TOkUbrW1o
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 00:02:51 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 May 2022 00:02:49 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 18 May 2022 12:32:25 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id BD527176D; Wed, 18 May 2022 12:32:23 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V6 1/5] mmc: core: Capture eMMC and SD card errors
Date:   Wed, 18 May 2022 12:32:16 +0530
Message-Id: <1652857340-6040-2-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/core/core.c  | 10 +++++++++-
 include/linux/mmc/host.h | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f104..5db5adf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -943,9 +943,11 @@ int mmc_execute_tuning(struct mmc_card *card)
 	}
 
 	/* Only print error when we don't check for card removal */
-	if (!host->detect_change)
+	if (!host->detect_change) {
 		pr_err("%s: tuning execution failed: %d\n",
 			mmc_hostname(host), err);
+		mmc_debugfs_err_stats_inc(host, MMC_ERR_TUNING);
+	}
 
 	return err;
 }
@@ -2242,6 +2244,12 @@ void mmc_rescan(struct work_struct *work)
 		if (freqs[i] <= host->f_min)
 			break;
 	}
+
+	/*
+	 * Ignore the command timeout errors observed during
+	 * the card init as those are excepted.
+	 */
+	host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
 	mmc_release_host(host);
 
  out:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0c9a0..0d7c0f7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -93,6 +93,25 @@ struct mmc_clk_phase_map {
 
 struct mmc_host;
 
+enum mmc_err_stat {
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
+	MMC_ERR_CTRL_TIMEOUT,
+	MMC_ERR_UNEXPECTED_IRQ,
+	MMC_ERR_MAX,
+};
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -498,6 +517,7 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	u32			err_stats[MMC_ERR_MAX];
 	unsigned long		private[] ____cacheline_aligned;
 };
 
@@ -632,6 +652,12 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 }
 
+static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
+					     enum mmc_err_stat stat)
+{
+	host->err_stats[stat] += 1;
+}
+
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

