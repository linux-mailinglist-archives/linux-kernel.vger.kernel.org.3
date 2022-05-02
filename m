Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDC516E17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383997AbiEBK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiEBK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:28:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB5334;
        Mon,  2 May 2022 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651487088; x=1683023088;
  h=from:to:cc:subject:date:message-id;
  bh=aIQiPVQV8Y+lL7j3g3uZDmsRTkL6UUd0G/jOVDvWS0Y=;
  b=KkHm87N6r/L7viu6B1Esk8UdSi03rb/xnGG+Vq+KXbTKX6jzl2mWPMNd
   KTQq8qKUBXUP3zWToKQ5qE091ZBpDC1EUm8Q+ZI8oJAMza0VKImwC1ZfC
   szJWKhnk6/54ye2SA1mr42Bj1gSA7UZuwnb5oA63+1A8OShQnc449x2eC
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 03:24:48 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 03:24:46 -0700
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 15:54:30 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 0334420ECC; Mon,  2 May 2022 15:54:30 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
Date:   Mon,  2 May 2022 15:54:08 +0530
Message-Id: <1651487048-30298-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
v1:initial Patch
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

