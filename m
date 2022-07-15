Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C325762B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiGONWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:22:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41377A4B;
        Fri, 15 Jul 2022 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657891321; x=1689427321;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nI2RPm3w4Un0V6ziztJ+VrqsFe9o/d2uY5zky8/U5Lo=;
  b=DPVSTAJo537+ZlnNrAbcDtsFkGoRkPn4xmQLo8wfy9Mut0FaTzd7bzFT
   pfB7WAlmb+Dy5KNf8bgK0ZFyfl+BmD4DOQGsPhSv4Fs4+a1x7SYglsuzd
   /Gg2RvpCSU6MOYk7+EWrK8pCWbLmiQr1lNkNJRtBjahAmuj1Z20E/2Xhc
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jul 2022 06:22:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 06:22:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 06:22:00 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 06:21:56 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't probed properly
Date:   Fri, 15 Jul 2022 18:51:52 +0530
Message-ID: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")

In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
probe, driver ends up reading the wakeup capability of dwc3 core as false
leading to instability in suspend/resume path.

To avoid this scenario, ensure dwc3_probe is successful by checking
if appropriate driver is assigned to it or not after the of_platform_populate
call. If it isn't then defer dwc3-qcom probe as well.

Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
v2: Set return value to EPROBE_DEFER to drop reference to dwc3 node

 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7703655..6676b39 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		dev_err(dev, "failed to get dwc3 platform device\n");
 	}
 
+	if (!qcom->dwc3->dev.driver)
+		ret = -EPROBE_DEFER;
+
 node_put:
 	of_node_put(dwc3_np);
 
-- 
2.7.4

