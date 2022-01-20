Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829349559C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbiATUpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:45:17 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15503 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiATUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642711516; x=1674247516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVkemQwZkoxm+9DhleE/PjTxXOeu2kwjkp28PcOXQIQ=;
  b=laCM5sW/NsIIwxggza5RvTCP5WAFxSa974qEL7d0BEeDSUKylB66/sk2
   hjCYNE6+Ax7Tsyeqveglb4alyD4NppcpPcJ8y6nMVIdAMwuing3eUX8qp
   A2Q1g6U2qucypkJbhFKqleQHqHbdQ+7sLWAA3dEXeLbNBiVY1Rj0fsGv/
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 12:45:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 12:45:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:45:16 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 12:45:15 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null pointer dereference
Date:   Thu, 20 Jan 2022 12:41:37 -0800
Message-ID: <20220120204132.17875-4-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120204132.17875-1-quic_amelende@quicinc.com>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add a null check for the pwrkey->data pointer after it is assigned
in pm8941_pwrkey_probe().  This avoids a potential null pointer
dereference when pwrkey->data->has_pon_pbs is accessed later in
the probe function.

Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/input/misc/pm8941-pwrkey.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 0ce00736e695..ac08ed025802 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 
 	pwrkey->dev = &pdev->dev;
 	pwrkey->data = of_device_get_match_data(&pdev->dev);
+	if (!pwrkey->data) {
+		dev_err(&pdev->dev, "match data not found\n");
+		return -ENODEV;
+	}
 
 	parent = pdev->dev.parent;
 	regmap_node = pdev->dev.of_node;
-- 
2.34.1

