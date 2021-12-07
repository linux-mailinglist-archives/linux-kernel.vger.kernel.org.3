Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73C246B3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhLGHgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:36:37 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40331 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhLGHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638862386; x=1670398386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EoBuBtj/CKp/HWzfb39zfxN4Nrr9d2HqG5zVFr+fPkQ=;
  b=ZepunwatZ4O7Lu/v1MNc9jH/0RV8zvQ9Ejp+RYK3IPTtC2qhfAGDwm6E
   wTfHct5b7vOJ+83U6FjCy54d1i9UWhQtjwQ/d4kJmQJ1ZrmxBk/72PwSE
   X+vyHUDl6gCAWui0w80bvpBYcqUVECFmXqdTpatKJ+b1GnzRWQDKT8fm/
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 23:33:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 23:33:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 23:33:05 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 23:33:04 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH v7 0/3] Add PLL and GCC clock support for SDX65 
Date:   Mon, 6 Dec 2021 23:32:48 -0800
Message-ID: <cover.1638861860.git.quic_vamslank@quicinc.com>
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
Changes from v6:
 - Addressed stephen's comments related to GCC and PLL patches
 - separated PLL and GCC patches from rpmh patches as suggested by Bjorn

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

Vamsi krishna Lanka (1):
  dt-bindings: clock: Add SDX65 GCC clock bindings

 .../bindings/clock/qcom,gcc-sdx65.yaml        |   80 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-alpha-pll.c              |  204 ++-
 drivers/clk/qcom/clk-alpha-pll.h              |    3 +
 drivers/clk/qcom/gcc-sdx65.c                  | 1611 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdx65.h    |  122 ++
 7 files changed, 2003 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx65.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx65.h


base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
-- 
2.33.1

