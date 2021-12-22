Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA747CD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbhLVH3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:29:48 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5768 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640158187; x=1671694187;
  h=from:to:cc:subject:date:message-id;
  bh=0ejRRfqIpyGBT+yHRzGWEvQYeapOKIN/RtCAbWM4Mb0=;
  b=KItuY1bXLSXt/1Lj6auD+AFHqeHU5PK8xZzU9IsAyMbamQ/CxV8lMa1j
   uPlkUQHDvumwUhkyKoBp8MJNABVW44e+LI1ea6ebo3Gy3S9LE1t7gYZk+
   UNCJAg9g8w1UZin86kCcSPSD6OUCtPe347z6AuZ2IizaYEr5N7MNMIZ1r
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 23:29:46 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Dec 2021 23:29:44 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx229.qualcomm.com ([10.204.179.152])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Dec 2021 12:59:27 +0530
Received: by hyd-lablnx229.qualcomm.com (Postfix, from userid 2390365)
        id 25F4C215DB; Wed, 22 Dec 2021 12:59:26 +0530 (IST)
From:   Panicker Harish <quic_pharish@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        quic_saluvala@quicinc.com,
        Panicker Harish <quic_pharish@quicinc.com>
Subject: [PATCH v4] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Date:   Wed, 22 Dec 2021 12:59:05 +0530
Message-Id: <1640158145-24569-1-git-send-email-quic_pharish@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBS timers are not stopped properly once BT OFF is triggered.
we could see IBS commands being sent along with version command,
so stopped IBS timers while Bluetooth is off.

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")

Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
----
v4:
  * Used del_timer_sync() instead of mod_timer() to stop the timer and
    to make sure the handler has finished executing on other CPUs.

v3:
  *Addressed reviewers comments
  *updated commit message

v2:
  * Addressed the username
  * The full implementation of IBS is based on timers
    to that reason we have used timers.

v1: initial patch
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index dd768a8..9e99311 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1928,6 +1928,9 @@ static int qca_power_off(struct hci_dev *hdev)
 	hu->hdev->hw_error = NULL;
 	hu->hdev->cmd_timeout = NULL;
 
+	del_timer_sync(&qca->wake_retrans_timer);
+	del_timer_sync(&qca->tx_idle_timer);
+
 	/* Stop sending shutdown command if soc crashes. */
 	if (soc_type != QCA_ROME
 		&& qca->memdump_state == QCA_MEMDUMP_IDLE) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

