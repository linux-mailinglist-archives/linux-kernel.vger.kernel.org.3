Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E752CB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiESE2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiESE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:28:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADE50E13;
        Wed, 18 May 2022 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652934500; x=1684470500;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IXzLhD9xmqUGm8zzDEoxBnegWvmmOoO5hL6NhU9eJ4g=;
  b=Ic2M7Dfd+pB4VqiqiLx7G/faqkH7Qr/Ddir/6E7Wc1DmqG9fuT6OZXpk
   ZnAhE/Uq3l6XrRiX3+CbLZbLFqzyu1HmOtAVitSzKYMfRnK023H7OBLkT
   0gHtnL5eifQiZnMalwflA/5L0l5z3yUueXVPMt/Q1cLQPduUyvJkNAlm2
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 21:28:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:28:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 21:28:19 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 21:28:13 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v6 0/3] Add QCOM SNPS PHY overriding params support
Date:   Thu, 19 May 2022 09:58:06 +0530
Message-ID: <1652934489-23386-1-git-send-email-quic_kriskura@quicinc.com>
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

changes in v6:
Fixed errors in dt-bindings.
Fixed nitpick in driver code.

changes in v5:
Fixed nitpicks in code.
Added minimum and maximum for each parameter added in dt-bindings.
Added proper suffixes to each parameter as per dtschema.

changes in v4:
Fixed nitpicks in code.
Initial compliance test results showed overshoot in the middle of eye
diagram. The current dt values were put in place to correct it and fix
overshoot issue.

changes in v3:
Added support for phy tuning parameters to be represented in bps and
corresponding register values to be written are obtained by traversing
through data map declared in the driver.

changes in v2:
Reading the individual fields in each overriding register from
device tree.

Krishna Kurapati (2):
  phy: qcom-snps: Add support for overriding phy tuning parameters
  arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280 IDP device

Sandeep Maheswaram (1):
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params
    bindings

 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  96 ++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   6 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 268 ++++++++++++++++++++-
 3 files changed, 368 insertions(+), 2 deletions(-)

-- 
2.7.4

