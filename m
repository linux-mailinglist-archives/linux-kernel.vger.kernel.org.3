Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8904B4DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiBNLPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:15:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiBNLPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:15:06 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 8DDA9EFF84
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:43:54 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644835435; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rcn9ALIlWKMM2fTTA+HHH8I55YhsQbojYCrOJlAIZU4=; b=J+7iEfwFJGrg00+hUMASg8e8mxBt0mve0sCzaDONZGIwqiRp58jux1m4Akp9zETtB0lpRcX/
 fL8DvzKOLTR6AcMIpK88O4/TYCRfb30tlj/0BlWOhS57BFmwOWwdBaJQvCmMArLLQQfEi2w3
 aQFgFnhgV2vbaw36OJm7HR8z8S4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 620a326519d16b66a926d08a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Feb 2022 10:43:49
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A12CAC43165; Mon, 14 Feb 2022 10:43:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A47C4C43164;
        Mon, 14 Feb 2022 10:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A47C4C43164
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        zijuhu@codeaurora.org, tjiang@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v4] Bluetooth: btusb: Improve stability for QCA devices
Date:   Mon, 14 Feb 2022 18:43:39 +0800
Message-Id: <1644835419-23943-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zijun Hu <quic_zijuhu@quicinc.com>

WCN6855 2.1 will reset to apply firmware downloaded, so wait
a moment for reset done then go ahead to improve stability.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ef5d52f0e123..9e0d59d4382a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2999,6 +2999,7 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 #define QCA_PATCH_UPDATED	0x80
 #define QCA_DFU_TIMEOUT		3000
 #define QCA_FLAG_MULTI_NVM      0x80
+#define QCA_BT_RESET_WAIT_MS    100
 
 #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
 #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
@@ -3325,6 +3326,13 @@ static int btusb_setup_qca(struct hci_dev *hdev)
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

