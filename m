Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBA4B4D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbiBNLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349935AbiBNLG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:06:56 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 7C7101A3AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:36:03 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644834963; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kgod48PMYKj7uiCEElfQxLce03IFuziHyb140TCs0Ds=; b=vPXkiGu9wEOyjA9srksdLEFi+5W9rG/KsgIXNJTD1J98PfR4jrW59FYd8jET8OmAFOxW+2k+
 5wpOvQhwSk+EQxmM3pP92WJhAWhoQeQolKc7wfWLsYTMQcsizuYEcbZR2Yr1upF+0htjEMmG
 od7KFOAQRH25MRUi2Osc6WMiFsg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 620a307e19d16b66a91aeb00 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Feb 2022 10:35:42
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17816C2ACA7; Mon, 14 Feb 2022 10:35:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB508C2AC5D;
        Mon, 14 Feb 2022 10:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BB508C2AC5D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        zijuhu@codeaurora.org, tjiang@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v3] Bluetooth: btusb: Improve stability for QCA devices
Date:   Mon, 14 Feb 2022 18:35:35 +0800
Message-Id: <1644834935-23189-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zijun Hu <quic_zijuhu@quicinc.com>

Controller will reset after NVM is downloaded for QCA
device, so wait a moment for reset Done then go ahead
to improve stability.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e03dfbd92fcc..4932c0bb6662 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2994,6 +2994,7 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 #define QCA_PATCH_UPDATED	0x80
 #define QCA_DFU_TIMEOUT		3000
 #define QCA_FLAG_MULTI_NVM      0x80
+#define QCA_BT_RESET_WAIT_MS    100
 
 #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
 #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
@@ -3320,6 +3321,13 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
 		if (err < 0)
 			return err;
+
+		/* WCN6855 2.1 will reset to apply firmware downloaded here, so
+		 * wait ~100ms for reset Done then go ahead, otherwise, it maybe
+		 * cause potential enable failure.
+		 */
+		if (info->rom_version == 0x00130201)
+			msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

