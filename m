Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E958220F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiG0I2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiG0I2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:28:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D645057;
        Wed, 27 Jul 2022 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658910498; x=1690446498;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tvgkr2Ds+DOMW1MZx5jh+W1rCZXn15syWivjTwgXnik=;
  b=R13Qu9KpGmtgiY9k4v6EuX7cAFhx5Wb3uua0t16VZs2jAWVFTeziOsAF
   k4YlVJ9+hEioAquaMLQMIPunGm1RapXnvfjgTJnNVHzWyw8CwbLcVhAw1
   SC2MPqBlO/+uyHrKSGKsQ5DwT7zA/NmIhQYFthfYt6Zc3IVprKs9GOJSf
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jul 2022 01:28:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:28:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:16 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 01:28:13 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V7 0/5] Add support for audio clock gating resets for SC7280
Date:   Wed, 27 Jul 2022 13:57:52 +0530
Message-ID: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v7]
  * Fix commit text of [5/5]. Remove '.' from Fixes tag.

[v6]
  * Add [1], [2] to handle the regmap overlap of lpasscc and lpass_aon 

[v5]
  * Fix the fail path and add pm_runtime_disable().

[v4]
  * Fix the "fixes" tag.

[v3]
  * Remove the maxItems from reg property.

[v2]
  * Update/fix the YAML for reg property against each compatible.

[v1]
  * Add support for clock gating resets for lpass audio clock
    controller & MCLKs.

Satya Priya (2):
  dt-bindings: clock: Add "qcom,adsp-pil-mode" property
  clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon

Taniya Das (3):
  dt-bindings: clock: Add resets for LPASS audio clock controller for
    SC7280
  dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
  clk: qcom: lpass: Add support for resets & external mclk for SC7280

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |  6 +-
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    | 26 ++++++++-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             | 66 +++++++++++++++++++++-
 drivers/clk/qcom/lpasscc-sc7280.c                  | 44 ---------------
 drivers/clk/qcom/lpasscorecc-sc7280.c              | 33 +++++++++++
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  5 ++
 .../dt-bindings/clock/qcom,lpasscorecc-sc7280.h    |  2 +
 7 files changed, 130 insertions(+), 52 deletions(-)

-- 
2.7.4

