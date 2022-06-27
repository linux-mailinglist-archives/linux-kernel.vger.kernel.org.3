Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504B55D6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiF0Tow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiF0Tot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:44:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA241902B;
        Mon, 27 Jun 2022 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656359088; x=1687895088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gbmkiqUHNSRVRHLgiUBfs10D3dIZWe5Ipt0uI9OWR4Q=;
  b=TtrDkkJyfG/RZVCbJpax9B3skzyBcu5sE6AqTyrzuZvT1Y8n/iBvjbjV
   6RARJpV+yoe2CpCCZO1Boy4XFVn8Q2x+hm26hKe+Oont3hcDir1TWtlWJ
   OKDSdoxBNWQRdc1XT43wxzifIN1pGhKF4xRh/5oPMOC+2nqWUJfiVl9AI
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 12:44:47 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:44:47 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 12:44:47 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: firmware: qcom-scm: Add "allow-multi-call" property
Date:   Mon, 27 Jun 2022 12:44:32 -0700
Message-ID: <1656359076-13018-2-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For firmware that supports it, allow multiple SCM calls to be passed
down to it by removing the serialization lock in the SCM driver.

There is a patch already [1] to convert the bindings to YAML. I will
make a patch against it when it gets accepted.

[1] https://lore.kernel.org/linux-arm-msm/20220626183247.142776-3-david@ixit.cz/

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 0f4e5ab..8a68018 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -43,6 +43,8 @@ Required properties:
   clock and "bus" for the bus clock per the requirements of the compatible.
 - qcom,dload-mode: phandle to the TCSR hardware block and offset of the
 		   download mode control register (optional)
+- allow-multi-call: Specify this to remove SCM call serialization. Need to
+		    ensure that the firmware being used supports this.
 
 Example for MSM8916:
 
-- 
2.7.4

