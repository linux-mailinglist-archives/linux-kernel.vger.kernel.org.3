Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41506495A17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378761AbiAUGoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:44:46 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33381 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiAUGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642747485; x=1674283485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gnN8J7Hmx0zp2CogqSWzfQlfG3AuVKS1SW9uZDHI86I=;
  b=CAJKEDuLa3z8/ABriOJF7ov1V3BVxjlfSsROLwzBhdJ0VtZE3zoLDKB7
   psJwCEjhmfwTkmSBcQ6vzw78iLTNxAnsJiCwRw7k+rCiDSYrtDgVw8yFd
   OCp92KMr0+bSY9tDU+n8UkgyUsV4W9FnyJq+KvBfDqGfUhhokBgL/UbiP
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 22:44:45 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 22:44:43 -0800
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jan 2022 12:14:35 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id C04EA225AE; Fri, 21 Jan 2022 12:14:34 +0530 (IST)
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pillair@quicinc.com, dianders@chromium.org,
        kuabhs@chromium.org, briannorris@chromium.org,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [RFC 2/2] ath10k: Delay the unmapping of the buffer
Date:   Fri, 21 Jan 2022 12:14:27 +0530
Message-Id: <20220121064427.32059-3-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121064427.32059-1-quic_youghand@quicinc.com>
References: <20220121064427.32059-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing a corner case smmu fault issue where copy engine is still
accessing the memory though host unmaps it hence as work around
we are delaying the unmapping the memory.

Tested-on: WLAN.HL.3.2.2.c10-00757-QCAHLSWMTPL-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++++++++
 drivers/net/wireless/ath/ath10k/htc.c  |  5 +++++
 drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index fcaed7d176568..65f775fb5ccab 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -93,6 +93,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -130,6 +131,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -168,6 +170,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -200,6 +203,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.bmi_large_size_download = true,
 		.dynamic_sar_support = true,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -237,6 +241,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -274,6 +279,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -311,6 +317,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -351,6 +358,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = true,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -394,6 +402,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -444,6 +453,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -491,6 +501,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -528,6 +539,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -567,6 +579,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -639,6 +652,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = false,
 		.dynamic_sar_support = false,
 		.tx_credit_limit = false,
+		.delay_unmap_buffer = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -669,6 +683,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_mac_seq_by_fw = true,
 		.dynamic_sar_support = true,
 		.tx_credit_limit = true,
+		.delay_unmap_buffer = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 108980476d654..e2640f244918e 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -55,6 +55,11 @@ void ath10k_htc_notify_tx_completion(struct ath10k_htc_ep *ep,
 	ath10k_dbg(ar, ATH10K_DBG_HTC, "%s: ep %d skb %pK\n", __func__,
 		   ep->eid, skb);
 
+	/* WAR - Delay the unmapping of the buffer */
+	if (ar->hw_params.delay_unmap_buffer &&
+	    ep->ul_pipe_id == 3)
+		mdelay(2);
+
 	ath10k_htc_restore_tx_skb(ep->htc, skb);
 
 	if (!ep->ep_ops.ep_tx_complete) {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 0d96df311b026..3f7539e8da0fc 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -628,6 +628,9 @@ struct ath10k_hw_params {
 
 	/* limit tx credit */
 	bool tx_credit_limit;
+
+	/* WAR - Delay the unmapping of the buffer */
+	bool delay_unmap_buffer;
 };
 
 struct htt_rx_desc;
-- 
2.29.0

