Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D929547EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiFMEba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiFMEb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:31:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515ED1BE8D;
        Sun, 12 Jun 2022 21:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655094686; x=1686630686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WYW4d7D+CS129HBo6dQLjfN0OMcgEmaQaskPaNJ48pg=;
  b=RzvJaib3A07CHKn8CfLQOamSfTwrZ1e1yftMBVcu/3IXV4TvaTKRa/5Q
   /cDEFXviODDdIxnEfISbqTOQ3cCXEfN1bNBLatBXdKLlQxnWsjAlHi26I
   hRwahj4/UKSXvVdhz5feFogfvyOFdjqpva1FSgTPrVxrUuKcDLwq2OXA8
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Jun 2022 21:31:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 21:31:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 12 Jun 2022 21:31:25 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 12 Jun 2022 21:31:19 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [v21 3/5] usb: dwc3: qcom: Add helper functions to enable,disable wake irqs
Date:   Mon, 13 Jun 2022 10:00:52 +0530
Message-ID: <1655094654-24052-4-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com>
References: <1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com>
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

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Adding helper functions to enable,disable wake irqs to make
the code simple and readable.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 58 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 6cba990..7352124 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -296,50 +296,44 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 	icc_put(qcom->icc_path_apps);
 }
 
+static void dwc3_qcom_enable_wakeup_irq(int irq)
+{
+	if (!irq)
+		return;
+
+	enable_irq(irq);
+	enable_irq_wake(irq);
+}
+
+static void dwc3_qcom_disable_wakeup_irq(int irq)
+{
+	if (!irq)
+		return;
+
+	disable_irq_wake(irq);
+	disable_irq_nosync(irq);
+}
+
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	if (qcom->hs_phy_irq) {
-		disable_irq_wake(qcom->hs_phy_irq);
-		disable_irq_nosync(qcom->hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->dp_hs_phy_irq) {
-		disable_irq_wake(qcom->dp_hs_phy_irq);
-		disable_irq_nosync(qcom->dp_hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
 
-	if (qcom->dm_hs_phy_irq) {
-		disable_irq_wake(qcom->dm_hs_phy_irq);
-		disable_irq_nosync(qcom->dm_hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
 
-	if (qcom->ss_phy_irq) {
-		disable_irq_wake(qcom->ss_phy_irq);
-		disable_irq_nosync(qcom->ss_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	if (qcom->hs_phy_irq) {
-		enable_irq(qcom->hs_phy_irq);
-		enable_irq_wake(qcom->hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->dp_hs_phy_irq) {
-		enable_irq(qcom->dp_hs_phy_irq);
-		enable_irq_wake(qcom->dp_hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
 
-	if (qcom->dm_hs_phy_irq) {
-		enable_irq(qcom->dm_hs_phy_irq);
-		enable_irq_wake(qcom->dm_hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
 
-	if (qcom->ss_phy_irq) {
-		enable_irq(qcom->ss_phy_irq);
-		enable_irq_wake(qcom->ss_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
-- 
2.7.4

