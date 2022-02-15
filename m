Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3684B669F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiBOIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:54:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiBOIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:25 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE5C113AF3;
        Tue, 15 Feb 2022 00:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915255; x=1676451255;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2klZSnNbrPct6qfytchZbXyJRfiEzPuHYhw/gAIeLg0=;
  b=dJ1bQQ2IeIxbp/YFkhjqlOY3iq5El6FSTTt/xxWv37oZfTul9cSsrpLo
   QbSM73FrTTbunkBbxpuaEthqcycPfvvw0QCN5vULff2erHG63KOlOVORb
   WEEEx6Oka65ouUeOq8PPSti6tS923WtYtc/rZzfbG+6br9SS0F35MccC+
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 00:54:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:15 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:10 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 0/6] Add Qualcomm Technologies, Inc. PM8008 regulator driver
Date:   Tue, 15 Feb 2022 14:23:45 +0530
Message-ID: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Satya Priya (6):
  dt-bindings: regulator: Add pm8008 regulator bindings
  dt-bindings: mfd: pm8008: Add regulators node
  mfd: pm8008: Add mfd cell struct to register LDOs
  regulator: Add a regulator driver for the PM8008 PMIC
  arm64: dts: qcom: pm8008: Add base dts file
  arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  49 ++++-
 .../bindings/regulator/qcom,pm8008-regulator.yaml  |  28 +++
 arch/arm64/boot/dts/qcom/pm8008.dtsi               |  46 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  66 +++++++
 drivers/mfd/qcom-pm8008.c                          |  26 ++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-pm8008-regulator.c          | 213 +++++++++++++++++++++
 8 files changed, 431 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c

-- 
2.7.4

