Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFC47426F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhLNMZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:25:31 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:34499 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbhLNMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639484730; x=1671020730;
  h=from:to:cc:subject:date:message-id;
  bh=gcMacxEyDo30QltC6fQCSelGFEJ7rS/QRKo+F/IgMJM=;
  b=deaxrayglTUcfkq1wl+Pb0AyIqihz57YQ93n1gAnXJq4wkcaWykftNT8
   DO17ZoSZuvxDpC/PGBcLKhgvJ+214+28BwFfTuVql5GYQb9NP740208LF
   cC0mClEy9kLTvgeb6U+RjTHIxwnbtCDjb6qyyAz+ajPsf95kWSc4Bgasz
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Dec 2021 04:25:29 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Dec 2021 04:25:27 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx229.qualcomm.com ([10.204.179.152])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Dec 2021 17:55:09 +0530
Received: by hyd-lablnx229.qualcomm.com (Postfix, from userid 2390365)
        id 837642158D; Tue, 14 Dec 2021 17:55:08 +0530 (IST)
From:   Panicker Harish <quic_pharish@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        quic_saluvala@quicinc.com,
        Panicker Harish <quic_pharish@quicinc.com>
Subject: [PATCH v3] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Date:   Tue, 14 Dec 2021 17:54:51 +0530
Message-Id: <1639484691-28202-1-git-send-email-quic_pharish@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBS timers are not stopped properly once BT OFF is triggered.
we could see IBS commands being sent along with version command,
so stopped IBS timers while Bluetooth is off.

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")

Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
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

