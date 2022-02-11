Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0064B1FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347919AbiBKIDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:03:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347909AbiBKIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:03:48 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 6F137BC4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:03:48 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644566628; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nF9XH8XJCDk7v0HhA0wn4IzrdqbTbiufUXlzSglbXeM=; b=NPPJocjJo8U/isqI3/lkBeILc591ck+/flxm/K8gDK7qKwydw0YISH/9jo//iZFRTOgB3jnt
 LigvvCtprGp65xHhnF63EOW8hSNPoAn+646FX9k0nYaxVHC/kVBpV2vavI7Ofu6dKM9LtRce
 YkvPHS33j/1Mqzb7MKwr3U4zjzs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6206186219d16b66a93a7074 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Feb 2022 08:03:46
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4E6DC43619; Fri, 11 Feb 2022 08:03:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 661BAC4338F;
        Fri, 11 Feb 2022 08:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 661BAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        zijuhu@codeaurora.org, tjiang@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2] Bluetooth: btusb: Improve stability for QCA devices
Date:   Fri, 11 Feb 2022 16:03:40 +0800
Message-Id: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
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
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e03dfbd92fcc..20e36f53d2e7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2994,6 +2994,7 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 #define QCA_PATCH_UPDATED	0x80
 #define QCA_DFU_TIMEOUT		3000
 #define QCA_FLAG_MULTI_NVM      0x80
+#define QCA_BT_RESET_WAIT_MS    100
 
 #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
 #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
@@ -3320,6 +3321,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
 		if (err < 0)
 			return err;
+		/* Controller will reset after NVM is downloaded, so wait a moment
+		 * for reset Done, it will improve stability.
+		 */
+		msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

