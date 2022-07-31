Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82F585D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiGaDTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 23:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiGaDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:19:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5912ACB;
        Sat, 30 Jul 2022 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659237541; x=1690773541;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=KZKgEaYFp030UeBJld4BwuJcO0bDdIsR7ZB1bbf5yIo=;
  b=vIzmBpDGxi5lmrqfGabr8DkOwa5lh2+plZVafeEI5wmo5p7uI6E/wa2m
   afek4ZK8dTA+ViDO73rRFFm7Zpg4uB6fk1uFl878uZiijDwaisMHrLt7q
   om/4hQxu/ES0FEz5ZWEZQYZ/JPSbrTaHiBnSgcySVU8H31p/kPYKkHtJ3
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Jul 2022 20:19:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 20:19:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 20:19:00 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 20:18:55 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: qcom: Provide stubs for dwc3_qcom_read_usb2_speed function
Date:   Sun, 31 Jul 2022 08:48:50 +0530
Message-ID: <1659237530-436-1-git-send-email-quic_kriskura@quicinc.com>
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

This patch intends to fix a build issue that is occurring due to
dwc3_qcom_read_usb2_speed function which uses usb_hub_find_child API
in its effors to get the speed of devices (HS/FS/LS) connected.

usb_hub_find_child API is a part of usb core compiled into the kernel
when CONFIG_USB=y. In some builds (make randconfig for i386)
CONFIG_USB is not set and the usb core is not compiled into the
kernel causing linking errors.

Provide stubs for dwc3_qcom_read_usb2_speed function to use
usb_hub_find_child API only if CONFIG_USB is set. Else return
USB_SPEED_UNKNOWN.

Fixes: 6895ea55c385 (usb: dwc3: qcom: Configure wakeup interrupts during suspend)
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index c5e482f..bd8dc5a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -299,6 +299,7 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 	icc_put(qcom->icc_path_apps);
 }
 
+#ifdef CONFIG_USB
 static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
@@ -318,6 +319,12 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 
 	return udev->speed;
 }
+#else
+static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
+{
+	return USB_SPEED_UNKNOWN;
+}
+#endif
 
 static void dwc3_qcom_enable_wakeup_irq(int irq, unsigned int polarity)
 {
-- 
2.7.4

