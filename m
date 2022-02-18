Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E504BB777
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiBRLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:01:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiBRLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:01:50 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F5369CA;
        Fri, 18 Feb 2022 03:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645182092; x=1676718092;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nmO1R1AbO5NZYge2KeRNstQ39RMFmw5doltCaCpOedc=;
  b=syDaiyP/WlFfz7E4CA0sY6zok0c67M3yIpjKuk5ZW9/gHGlCDjvHltNS
   7f/RJUKCocpJvdPEyJdWWL4yDUIJzmwtwMxXMP42S+lNmZ1089UX4LqRF
   /udz9le3RtZMnKR0Tb2YTDY34dIn58Wm+kI5V7SuRnnsr6SkKF70ttxsC
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Feb 2022 03:01:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:01:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:31 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:26 -0800
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
Subject: [PATCH V7 0/5] Add Qualcomm Technologies, Inc. PM8008 regulator driver
Date:   Fri, 18 Feb 2022 16:30:58 +0530
Message-ID: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
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

Satya Priya (5):
  dt-bindings: mfd: pm8008: Add pm8008 regulators
  mfd: pm8008: Add mfd cell struct to register LDOs
  regulator: Add a regulator driver for the PM8008 PMIC
  arm64: dts: qcom: pm8008: Add base dts file
  arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  50 ++++-
 arch/arm64/boot/dts/qcom/pm8008.dtsi               |  44 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  66 +++++++
 drivers/mfd/qcom-pm8008.c                          |  27 ++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-pm8008-regulator.c          | 205 +++++++++++++++++++++
 7 files changed, 393 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c

-- 
2.7.4

