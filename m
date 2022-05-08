Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11151ED62
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiEHMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiEHMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:16:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B9DF05;
        Sun,  8 May 2022 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652011961; x=1683547961;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6rnWEHeEX+XKODlHAQn1lzCSCnz29X+Ks2qhyPPDDlk=;
  b=p5kvMr0BY7Nslsq9VXgjRqG7s+zzwNJVc27km0xyGuJ4WpCZ0xZ6n9Dq
   zfJES12Q0GtrnqtqLi7VwX4XgIckAvJcgZHEIbP2cPEf3Rz8A/bZtZlol
   zOOSHhEylAMxpt1BpUNkIgiNJKMuzdA98zeLoFsApgTTa4qrFL1O7mjUu
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 May 2022 05:12:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 05:12:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 05:12:39 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 05:12:33 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <wcheng@codeaurora.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [v3 0/3] Add QCOM SNPS PHY overriding params support
Date:   Sun, 8 May 2022 17:42:24 +0530
Message-ID: <1652011947-18575-1-git-send-email-quic_kriskura@quicinc.com>
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

Added support for overriding tuning parameters in QCOM SNPS PHY
from device tree.

changes in v3:
Added support for phy tuning paramters to be represented in bps and
corresponding register values to be written are obtained by traversing
through data map declared in the driver.

changes in v2:
Reading the individual fields in each overriding register from device tree.

Krishna Kurapati (2):
  phy: qcom-snps: Add support for overriding phy tuning parameters
  arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280 IDP device

Sandeep Maheswaram (1):
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params
    bindings

 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  87 +++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   6 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 252 ++++++++++++++++++++-
 3 files changed, 343 insertions(+), 2 deletions(-)

-- 
2.7.4

