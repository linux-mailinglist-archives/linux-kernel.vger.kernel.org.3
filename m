Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE354AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiFNJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiFNJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2F41F84;
        Tue, 14 Jun 2022 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655200166; x=1686736166;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WU2SxIa3e8crrchJ4+uMW6gTSuHsBFIrNtuhSA4zOHA=;
  b=jk1ZFKQ3Wn+FkHTNxUEejTnLzc99roxF0wZ5Ido5dv/Cx41sDG0Nb9f2
   Ln2t91i8xJBFwdcEGcgBoFpzZgjkMfYHxxvGok+30SA3owFX+0d3lLBYT
   IL4bJRtI6mzs+tFbFPdTI4m5i98C1OVgma2XgNNbc8N7xIvSt/d2rr53R
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 02:49:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:49:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:08 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:03 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V15 0/9] Add Qualcomm Technologies, Inc. PM8008 regulator driver
Date:   Tue, 14 Jun 2022 15:18:22 +0530
Message-ID: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
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

Satya Priya (9):
  dt-bindings: mfd: pm8008: Add reset-gpios
  dt-bindings: mfd: pm8008: Change the address cells
  dt-bindings: mfd: pm8008: Add regulators for pm8008
  mfd: pm8008: Add reset-gpios
  mfd: pm8008: Remove the regmap member from pm8008_data struct
  mfd: pm8008: Use i2c_new_dummy_device() API
  regulator: Add a regulator driver for the PM8008 PMIC
  arm64: dts: qcom: pm8008: Add base dts file
  arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  69 +++++-
 arch/arm64/boot/dts/qcom/pm8008.dtsi               |  54 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  66 ++++++
 drivers/mfd/qcom-pm8008.c                          |  60 ++++-
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-pm8008-regulator.c          | 242 +++++++++++++++++++++
 include/linux/mfd/qcom_pm8008.h                    |   9 +
 8 files changed, 492 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c
 create mode 100644 include/linux/mfd/qcom_pm8008.h

-- 
2.7.4

