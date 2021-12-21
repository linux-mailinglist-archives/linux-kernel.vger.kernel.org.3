Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8416747BAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhLUHVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:21:19 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16998 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235019AbhLUHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640071271; x=1671607271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JGow5gSyCVGGIvARjpIWCWieeUWr8i3gh6AHITcaPMM=;
  b=XObdVQvIQwosaJ6zmf/U0xngpAmN0dPLMj4/WMNVa4fVT81sQoK+BmcA
   N7rmS7FYOXU2GyqnISyO4ymT9Cay/tqeJXDDKRCTnDyKXstGvN+oB8uFu
   6lDjQ3NHXRlXV46qHVqKkQdA/J5GvNjlv3gatZFiZB+mEnWjKqGlrZqb3
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Dec 2021 23:21:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:21:10 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:21:10 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:21:07 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v4 08/11] bindings: spmi: spmi-pmic-arb: mark interrupt properties as optional
Date:   Tue, 21 Dec 2021 15:20:06 +0800
Message-ID: <1640071211-31462-9-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Mark all interrupt related properties as optional instead of
required.  Some boards do not required PMIC IRQ support and it
isn't needed to handle SPMI bus transactions, so specify it as
optional.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
index ca645e2..6332507 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
@@ -29,6 +29,8 @@ Required properties:
 - #size-cells : must be set to 0
 - qcom,ee : indicates the active Execution Environment identifier (0-5)
 - qcom,channel : which of the PMIC Arb provided channels to use for accesses (0-5)
+
+Optional properties:
 - interrupts : interrupt list for the PMIC Arb controller, must contain a
                single interrupt entry for the peripheral interrupt
 - interrupt-names : corresponding interrupt names for the interrupts
-- 
2.7.4

