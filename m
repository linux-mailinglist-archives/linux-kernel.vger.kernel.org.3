Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015FA47208C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhLMFcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:32:24 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:8488 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639373543; x=1670909543;
  h=from:to:cc:subject:date:message-id;
  bh=AwY+n2QVGFMYvsateJK/8dQELieJjA0Q6bnXLB6eSZw=;
  b=SE/IVWRsPW8EfDp+Gz7XxkJvlmSUoDOHscbb4daEklCU4xCSy5hKAVWo
   Oz0A2OT/K2QVe6fS/RHBfPwuSPfQelNcne73HW6HcaVbnrpRJXdsB47yl
   MZpqiKErhypTpBLJ6aPRFItO3jPG2Z0uznxHQX2kjKV8KYmuQ6NaaeIom
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Dec 2021 21:32:23 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Dec 2021 21:32:22 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx229.qualcomm.com ([10.204.179.152])
  by ironmsg02-blr.qualcomm.com with ESMTP; 13 Dec 2021 11:02:03 +0530
Received: by hyd-lablnx229.qualcomm.com (Postfix, from userid 2390365)
        id 481C221587; Mon, 13 Dec 2021 11:02:02 +0530 (IST)
From:   Panicker Harish <quic_pharish@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        quic_saluvala@quicinc.com,
        Panicker Harish <quic_pharish@quicinc.com>
Subject: [PATCH v2] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Date:   Mon, 13 Dec 2021 11:01:36 +0530
Message-Id: <1639373496-28009-1-git-send-email-quic_pharish@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change stops IBS timers during BT OFF.

Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>

v2:
  * Addressed the username
  * The full implementation of IBS is based on timers
    to that reason I have used timers.

v1: initial patch
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index dd768a8..6f44b26 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1928,6 +1928,9 @@ static int qca_power_off(struct hci_dev *hdev)
 	hu->hdev->hw_error = NULL;
 	hu->hdev->cmd_timeout = NULL;
 
+	mod_timer(&qca->tx_idle_timer, 0);
+	mod_timer(&qca->wake_retrans_timer, 0);
+
 	/* Stop sending shutdown command if soc crashes. */
 	if (soc_type != QCA_ROME
 		&& qca->memdump_state == QCA_MEMDUMP_IDLE) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

