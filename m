Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD250E51F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiDYQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiDYQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:07:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ADA2AC66;
        Mon, 25 Apr 2022 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650902637; x=1682438637;
  h=from:to:cc:subject:date:message-id;
  bh=hrOoewtJhmgZVFNviaA6Slr7SEW6ryGKzcMbCayfMvQ=;
  b=GJiaGkaM8dAn0LCedjg76oynHLGAspzQVQz4GPYf5ZClSMJKrhlsNqjd
   zoi+PPkA2GbhD0x50cvfIFhrmVLAromMjvpSayNIf8/vGrkLsOFwiU4Ur
   fAM1cghFIXPu2DPJvyf+x3svd14aGzb9/HCK5+CbWdMJuKu3vsQLUGGJx
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 09:03:57 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Apr 2022 09:03:55 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Apr 2022 21:33:53 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 58808BD1; Mon, 25 Apr 2022 21:33:52 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
        linus.walleij@linaro.org, digetx@gmail.com,
        briannorris@chromium.org, quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V5 1/5] mmc: core: Capture eMMC and SD card errors
Date:   Mon, 25 Apr 2022 21:33:46 +0530
Message-Id: <1650902626-4870-1-git-send-email-quic_c_sbhanu@quicinc.com>
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

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/core/core.c  |  6 ++++++
 include/linux/mmc/host.h | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8cc2b74..6d086e9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2247,6 +2247,12 @@ void mmc_rescan(struct work_struct *work)
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
index c193c50..eb8bc5b 100644
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
@@ -501,6 +520,7 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	u32			err_stats[MMC_ERR_MAX];
 	unsigned long		private[] ____cacheline_aligned;
 };
 
@@ -635,6 +655,12 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
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
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

