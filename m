Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8A46BF75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhLGPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:39:35 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:8428 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhLGPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638891363; x=1670427363;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+JtkatBp8v6ZMxtHE7u09m24+2lvT2HIopks0TpRuaE=;
  b=T20nP6X/auBEqCbbtsTfLCTXWOsU6CNhYrmP6UFvIIdTuPEJWxqpMT5E
   V/AzTg6C8aTjDhsc6l4kErvOm2RirCGByH7lpNxeCpwkWgKox98uoJDwK
   53wNYQFbJkluVtsKCUXazVLU+FhHyV1TPoB5awN/ycBaZdYWcvtR7sM9P
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 07:36:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:36:02 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 07:36:02 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 07:35:55 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <plai@codeaurora.org>, <bgoswami@codeaurora.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <rohitkr@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/5] Add pin control support for lpass sc7280
Date:   Tue, 7 Dec 2021 21:05:34 +0530
Message-ID: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to split lpass variant common pin control
functions and SoC specific functions and to add lpass sc7280 pincontrol support.
It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.

Changes Since V4:
    -- Update commit message and description of the chip specific extraction patch.
    -- Sort macros in kconfig and makefile.
    -- Update optional clock voting to conditional clock voting.
    -- Fix typo errors.
    -- Move to quicinc domain email id's.
Changes Since V3:
    -- Update separate Kconfig fields for sm8250 and sc7280.
    -- Update module license and description.
    -- Move static variables to corresponding .c files from header file.

Changes Since V2:
    -- Add new dt-bindings for sc7280 lpi driver.
    -- Make clock voting change as separate patch.
    -- Split existing pincontrol driver and make common functions 
       as part of separate file.
    -- Rename lpass pincontrol lpi dt-bindings to sm8250 specific dt-bindings
		
Changes Since V1:
    -- Make lpi pinctrl variant data structure as constant
    -- Add appropriate commit message
    -- Change signedoff by sequence.

Srinivasa Rao Mandadapu (5):
  dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specific
  dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl bindings
  pinctrl: qcom: Extract chip specific LPASS LPI code
  pinctrl: qcom: Add SC7280 lpass pin configuration
  pinctrl: qcom: Update clock voting as optional

 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 -----------
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 ++++++++++
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++
 drivers/pinctrl/qcom/Kconfig                       |  16 ++
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 249 ++-------------------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |  85 +++++++
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    | 170 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    | 165 ++++++++++++++
 9 files changed, 697 insertions(+), 365 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

-- 
2.7.4

