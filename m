Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3760495A19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378770AbiAUGos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:44:48 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33381 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378763AbiAUGor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642747487; x=1674283487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zRG3gH0OAuV4AFliy9juiq8ATfYC/v57zrcVecvZMY=;
  b=fXwzptY0fg/XdNYQjGR0ozBp/X/+TtwpoNisCqQL9UaJy9br+GCCTGUR
   ef0OAjCbpal3yNRSuu9823HaCZ6o1HY3wRiQADlHdCfXcApRC2cn+XPz4
   5mtG3x3Bk+Peg0COczun4cYFsRA6qgtVbofWft2IVpwgGw8xZfCMfcnhk
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 22:44:47 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 22:44:45 -0800
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jan 2022 12:14:33 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id 3DA5B225AE; Fri, 21 Jan 2022 12:14:32 +0530 (IST)
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pillair@quicinc.com, dianders@chromium.org,
        kuabhs@chromium.org, briannorris@chromium.org,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [RFC 1/2] ath10k: Set tx credit to one for wcn3990 snoc based devices
Date:   Fri, 21 Jan 2022 12:14:26 +0530
Message-Id: <20220121064427.32059-2-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121064427.32059-1-quic_youghand@quicinc.com>
References: <20220121064427.32059-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for WCN3990, the host driver can send two wmi commands at once,
now it is limiting to one because if HOST wants to initiate 2 DMA transfers,
it is possible when copy complete interrupt for first DMA reaches HOST,
CE has already updated SRRI for both DMA transfers and is in the middle
of 2nd DMA.HOST uses SRRI to interpret how many DMA’s have been completed
and tries to unmap/free both the DMA entries, but CE is  still in the middle
of 2nd DMA which can cause SMMU issues or corruption.

Tested-on: WLAN.HL.3.2.2.c10-00757-QCAHLSWMTPL-1
Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath10k/htc.c  | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/htc.h  |  1 +
 drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index f0e12556e7dce..fcaed7d176568 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -92,6 +92,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = true,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -128,6 +129,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = true,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -165,6 +167,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -196,6 +199,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.bmi_large_size_download = true,
 		.dynamic_sar_support = true,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -232,6 +236,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -268,6 +273,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -304,6 +310,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -343,6 +350,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = true,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -385,6 +393,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -434,6 +443,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -480,6 +490,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -516,6 +527,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -554,6 +566,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -625,6 +638,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
+		.tx_credit_limit = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -654,6 +668,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.tx_mac_seq_by_fw = true,
 		.dynamic_sar_support = true,
+		.tx_credit_limit = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 61ee413d902a7..108980476d654 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -630,13 +630,20 @@ int ath10k_htc_wait_target(struct ath10k_htc *htc)
 		return -ECOMM;
 	}
 
-	htc->total_transmit_credits = __le16_to_cpu(msg->ready.credit_count);
+	if (ar->hw_params.tx_credit_limit)
+		htc->total_transmit_credits =
+			__le16_to_cpu(HTC_HOST_MAX_CREDIT_COUNT);
+	else
+		htc->total_transmit_credits =
+			__le16_to_cpu(msg->ready.credit_count);
+
 	htc->target_credit_size = __le16_to_cpu(msg->ready.credit_size);
 
 	ath10k_dbg(ar, ATH10K_DBG_HTC,
-		   "Target ready! transmit resources: %d size:%d\n",
+		   "Target ready! transmit resources: %d size:%d actual credits:%d\n",
 		   htc->total_transmit_credits,
-		   htc->target_credit_size);
+		   htc->target_credit_size,
+		   msg->ready.credit_count);
 
 	if ((htc->total_transmit_credits == 0) ||
 	    (htc->target_credit_size == 0)) {
diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index 14e5c3f712c11..a84d76f062d36 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -41,6 +41,7 @@ struct ath10k;
  */
 
 #define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
+#define HTC_HOST_MAX_CREDIT_COUNT	1
 
 enum ath10k_htc_tx_flags {
 	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 0dec9f01cd4dd..0d96df311b026 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -625,6 +625,9 @@ struct ath10k_hw_params {
 	bool tx_mac_seq_by_fw;
 
 	bool dynamic_sar_support;
+
+	/* limit tx credit */
+	bool tx_credit_limit;
 };
 
 struct htt_rx_desc;
-- 
2.29.0

