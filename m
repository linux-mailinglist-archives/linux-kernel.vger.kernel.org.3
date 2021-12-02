Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52282465ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354354AbhLBAZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:25:51 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:46542 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354336AbhLBAZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404515; x=1669940515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8OWuRcA3lxtUFLm25cs+ndOW/6ZK4EfEP56wGsWdKl4=;
  b=BcqBkAgnXEOaNnx7HXNfOrNUcO/WMckTgVDevDsgvHh4mbnIBA4xsPiw
   u7mnrcPsz68dY6BJ47e1g5sLBPmIrRF26kXwvuq6JmMuYL+rmu83Dty7t
   ZNAWTpuNcwesiMKfq7Z2Oe3CjtsL6GGo9DzdCuyyzYxr+oIFv5ySP2+Yu
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 16:21:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:21:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:54 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:53 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH v6 0/5] Add GCC and RPMh clock support for SDX65 
Date:   Wed, 1 Dec 2021 16:21:30 -0800
Message-ID: <cover.1638402361.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Hello,
Changes from v5:
 - Collected Vinod Koul's and Rob's Reviewed-by for the patches
 - Rebased on the latest tip of Torvald's tree (MAINTAINERS: co-maintain random.c)

Changes from v4:
 - Fixed comments from vinod koul on Clock Alpha PLL and GCC driver support patches
 - Addressed Rob's comments related to GCC dt-binding patch
 - Collected Vinod Koul's Reviewed-by for the dt-bindings patches

Changes from v3:
 - Fixed DTbindings and unused variables errors reported by kernel test bot
 - Rebased on top of v5.16-rc1

Changes from v2:
 - Addressed Taniya Das and Vinod Koul's comments related to adding LUCID_EVO
   PLL type and rpmh support patches
 - Collected Rob's Acked-by for the dt-bindings patches

Changes from v1:
 - Addressed Bjorn's comments related to the GCC support patch
 - Collected Bjorn's and Rob's Reviewed-by for the dt-bindings patches

This patch series adds bindings and device driver changes for GCC, pdc and RPMh
clock support for SDX65 Platform.

Thanks,
Vamsi

Vamsi Krishna Lanka (2):
  clk: qcom: Add LUCID_EVO PLL type for SDX65
  clk: qcom: Add SDX65 GCC support

Vamsi krishna Lanka (3):
  dt-bindings: clock: Add SDX65 GCC clock bindings
  dt-bindings: clock: Introduce RPMHCC bindings for SDX65
  clk: qcom: Add support for SDX65 RPMh clocks

 .../bindings/clock/qcom,gcc-sdx65.yaml        |   80 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |  204 ++-
 drivers/clk/qcom/clk-alpha-pll.h              |    3 +
 drivers/clk/qcom/clk-rpmh.c                   |   25 +
 drivers/clk/qcom/gcc-sdx65.c                  | 1603 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdx65.h    |  122 ++
 9 files changed, 2021 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx65.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx65.h


base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
-- 
2.33.1

