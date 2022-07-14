Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2A57512A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiGNOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiGNOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:55:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A8474F6;
        Thu, 14 Jul 2022 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657810525; x=1689346525;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=f7RaRgDoZZGQ1vuyDsPSY35GCbn3E4x7n2cFx773AbU=;
  b=SJ2Ckgt+pj9y5/5jkjiITiaXR1HthPxBfJEmuCWkCHU6V2/cCSHodGmX
   AemYBLzQZvzCJ004TNEHOeV5bHQVApCMpTk9wgIeg/0TE8Q3RlbUr7Q/6
   LcqEjIoP/jWsrsZ4ASz1GcMU2AtbFGfOFcUg5aEXYkVLyKy3+w8yPy7fm
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Jul 2022 07:55:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:55:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:55:24 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:55:20 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't probed properly
Date:   Thu, 14 Jul 2022 20:25:16 +0530
Message-ID: <1657810516-31143-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SC7180 devices, it is observed that dwc3 probing is deferred
because device_links_check_suppliers() finds that '88e3000.phy'
isn't ready yet.

As a part of its probe call, dwc3-qcom driver checks if dwc3 core
is wakeup capable or not. If the dwc3 core is wakeup capable, driver
configures dwc-qcom's power domain to be always ON. Also it configures
dp/dm interrupts accordingly to support wakeup from system suspend.

More info regarding the same can be found at:
commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status"
commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")

In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
probe, driver ends up reading the wakeup capability of dwc3 core as false
leading to instability in suspend/resume path.

To avoid this scenario, ensure dwc3_probe is successful by checking
if appropriate driver is assigned to it or not after the of_platform_populate
call. If it isn't then defer dwc3-qcom probe as well.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7703655..096d1414 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		dev_err(dev, "failed to get dwc3 platform device\n");
 	}
 
+	if (!qcom->dwc3->dev.driver)
+		return -EPROBE_DEFER;
+
 node_put:
 	of_node_put(dwc3_np);
 
-- 
2.7.4

