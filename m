Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F7488B03
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiAIRZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:25:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33326 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiAIRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749122; x=1673285122;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=pY/vgC3mibUTksylngWUfaDZ+uO3n7is8v7CToQVCw4=;
  b=vk6mjJcCerO2hmAoyrNutr/Zo4vmVNEr7EXKXteKrVLxEPCNfqy9AbPy
   MdKdugrvb0Y6IyXn8KTgxqVKvF2yZRUxh0UMCmIedvWN7bnfC91NHPbmf
   IGggL2cSIBo/Z+Xac5zsCYppkolGk5wnpj8dKH1fOlyQ71EKOA4penyoK
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 09:25:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:25:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:21 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:17 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 00/10] Add APSS RSC to Cluster power domain
Date:   Sun, 9 Jan 2022 22:54:57 +0530
Message-ID: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches 1 to 4 adds/corrects the cpuidle states/
apps_rsc TCS configuration to make it same as downstream kernel.

The patches 5, 6 and 7 adds apps_rsc device to cluster power domain such
that when cluster is going to power down the cluster pre off notification
will program the 'sleep' and 'wake' votes in SLEEP TCS and WAKE TCSes.

The patches 8, 9 and 10 are to program the next wakeup in CONTROL_TCS.

[1], [2] was older way of programming CONTROL_TCS (exporting an API and
calling when last CPU was entering deeper low power mode). Now with patch
number 5,6 and 7 the apps RSC is added to to cluster power domain and hence
these patches are no longer needed with this series.

The series is tested on SM8250 with latest linux-next tag next-20220107.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20190218140210.14631-3-rplsssn@codeaurora.org/
[2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=59613

Lina Iyer (1):
  soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain

Maulik Shah (9):
  arm64: dts: qcom: sm8150: Correct TCS configuration for apps rsc
  arm64: dts: qcom: sm8250: Add cpuidle states
  arm64: dts: qcom: sm8350: Correct TCS configuration for apps rsc
  arm64: dts: qcom: sm8450: Update cpuidle states parameters
  dt-bindings: soc: qcom: Update devicetree binding document for
    rpmh-rsc
  arm64: dts: qcom: Add power-domains property for apps_rsc
  PM: domains: Store the closest hrtimer event of the domain CPUs
  soc: qcom: rpmh-rsc: Save base address of drv
  soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      |   6 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   7 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 106 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   3 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  29 ++---
 drivers/base/power/domain_governor.c               |   1 +
 drivers/soc/qcom/rpmh-internal.h                   |   9 +-
 drivers/soc/qcom/rpmh-rsc.c                        | 138 +++++++++++++++++++--
 drivers/soc/qcom/rpmh.c                            |   4 +-
 include/linux/pm_domain.h                          |   1 +
 10 files changed, 271 insertions(+), 33 deletions(-)

-- 
2.7.4

