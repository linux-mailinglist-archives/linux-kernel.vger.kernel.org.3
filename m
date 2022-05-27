Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4869F535E01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350872AbiE0KQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbiE0KQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:16:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87596106A6A;
        Fri, 27 May 2022 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653646567; x=1685182567;
  h=from:to:cc:subject:date:message-id;
  bh=JjbnnMSRoLOJod2CWxV4vK/Y2fmBbrZOVMe5g6r53VA=;
  b=vorBKOXolH+pd6ENe7q1O0mgSGiwVvt9J5Hsxny5z7wYg2MAIezGOHLm
   DBHSZvlMTlmGMiGat1LBrWL2RokXeBy5AvQBwMtEPmnoLdkJ7U/Faf/Em
   LwYGopqOf7JLa445Dv3VIZYWt4JbHd5qy3iGTixRaOFpuogsUADUSu1eI
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 03:16:07 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2022 03:16:06 -0700
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 27 May 2022 15:45:48 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id DB92520F2F; Fri, 27 May 2022 15:45:47 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [RESEND v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
Date:   Fri, 27 May 2022 15:45:43 +0530
Message-Id: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the return value of qca_wakeup(), since
.wakeup work inversely with original .prevent_wake.

Fixes: 4539ca67fe8ed (Bluetooth: Rename driver .prevent_wake to .wakeup)
Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index eab34e2..8df1101 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1588,7 +1588,7 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	wakeup = device_may_wakeup(hu->serdev->ctrl->dev.parent);
 	bt_dev_dbg(hu->hdev, "wakeup status : %d", wakeup);
 
-	return !wakeup;
+	return wakeup;
 }
 
 static int qca_regulator_init(struct hci_uart *hu)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

