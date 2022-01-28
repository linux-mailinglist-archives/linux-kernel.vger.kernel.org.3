Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937FA49F411
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiA1HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:10:15 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29221 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232186AbiA1HKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643353814; x=1674889814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jv4vpwDFKDd0TI5RGz7EkxlWKUVVnZnZU0bLRUkF/74=;
  b=TcW3qfkXaDF2ta50+UyDR4sbvw207eDC8X/xJc4LhJj6iNwVzuT9armg
   YcAQ6Rilll4EbB5MmrljXTG9kzAt2zw7BxUhcXyRyr1gz/j4XfhWmUjwK
   tz3E5dIrWWVZrvzJL4fjZGmQtnREFltXH7nH0AojsJ1+AK2754U5WA+tM
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 23:10:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:10:02 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:00 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:09:56 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH 0/9] soc: qcom: llcc: Add LLCC support for SM8450 SoC
Date:   Fri, 28 Jan 2022 12:39:24 +0530
Message-ID: <cover.1643353154.git.quic_saipraka@quicinc.com>
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

This patch series adds support for LLCC on SM8450 SoC. It mainly
consists of LLCC driver changes to incorporate newer LLCC HW found
on SM8450 SoC and the corresponding DT bits to enable LLCC.
Based on qcom/for-next branch.

Huang Yiwei (1):
  soc: qcom: llcc: Add support for 16 ways of allocation

Sai Prakash Ranjan (8):
  soc: qcom: llcc: Update the logic for version info extraction
  soc: qcom: llcc: Add write-cache cacheable support
  soc: qcom: llcc: Add missing llcc configuration data
  soc: qcom: llcc: Update register offsets for newer LLCC HW
  soc: qcom: llcc: Add configuration data for SM8450 SoC
  dt-bindings: arm: msm: Add LLCC compatible for SM8350
  dt-bindings: arm: msm: Add LLCC compatible for SM8450
  arm64: dts: qcom: sm8450: Add LLCC/system-cache-controller node

 .../bindings/arm/msm/qcom,llcc.yaml           |   2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 ++
 drivers/soc/qcom/llcc-qcom.c                  | 102 +++++++++++++++---
 include/linux/soc/qcom/llcc-qcom.h            |   9 +-
 4 files changed, 104 insertions(+), 16 deletions(-)


base-commit: 073a39a2a63abd46339a50eb07bd23958d99efbe
prerequisite-patch-id: 33fc8487573f4dd2ef21bfdfcf57d1437f456df3
prerequisite-patch-id: 026a0e76224498cec9ad15cbbc452f8f4fcdbca9
prerequisite-patch-id: 626323d13e5cc60434e225544b71314fd84adf90
prerequisite-patch-id: a1d79b7d366eb3a749621998580d8607a852a432
prerequisite-patch-id: 51d51021554581d9ccf510a8c9087748b9a77019
prerequisite-patch-id: ecbbd03ca61082e78754d52d1b3e99848185b4d1
prerequisite-patch-id: 6120d52065436b3d5fcc4aa509af2046bea1e344
prerequisite-patch-id: 388f5c230d39b7181a0f563b6fc5b3e35d4d7f75
-- 
2.33.1

