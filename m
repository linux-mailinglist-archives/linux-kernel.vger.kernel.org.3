Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61644D1576
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiCHLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiCHLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:04:30 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982C1EEEE;
        Tue,  8 Mar 2022 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646737414; x=1678273414;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GW/+fDB+z4PNAfR4cYiK4QwxG8jERYPP5qxmJL/8Z/M=;
  b=HgAKRtxc4yQNhrTYcqUWhRsqONfXYnu1dTY8UtvkoO7msB5X5R/0rDP5
   4+4yTVtxC7wBdpSs2AQcZPWYEE2h5q7hrVffBOkqtXZrdhIfxA0jeyCE2
   SCS1juBxL+Ymzp+L9Q6qpYHqJtzHjacck40E6HwZ9pFxmwXCj4eUxA7bJ
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Mar 2022 03:03:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:03:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 03:03:33 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 03:03:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v10 0/7] Add pin control support for lpass sc7280
Date:   Tue, 8 Mar 2022 16:33:07 +0530
Message-ID: <1646737394-4740-1-git-send-email-quic_srivasam@quicinc.com>
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

This patch series is to split lpass variant common pin control
functions and SoC specific functions and to add lpass sc7280 pincontrol support.
It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.

Changes Since V9:
    -- Add pinctrl groups macro to Kconfig.
Changes Since V8:
    -- Remove redundant headers included in v8.
Changes Since V7:
    -- Update optional clock voting with conditional check.
    -- Add const to lpi_pinctrl_variant_data structure.
    -- Update required headers and remove redundant.
    -- Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
    -- Fix typo errors.
Changes Since V6:
    -- Update conditional clock voting to optional clock voting.
    -- Update Kconfig depends on field with select.
    -- Fix typo errors. 
Changes Since V5:
    -- Create new patch by updating macro name to lpi specific.
    -- Create new patch by updating lpi pin group structure with core group_desc structure.
    -- Fix typo errors.
    -- Sort macros in the make file and configuration file.
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

Srinivasa Rao Mandadapu (7):
  dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specific
  dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl bindings
  pinctrl: qcom: Update macro name to LPI specific
  pinctrl: qcom: Update lpi pin group structure
  pinctrl: qcom: Extract chip specific LPASS LPI code
  pinctrl: qcom: Add SC7280 lpass pin configuration
  pinctrl: qcom: Update clock voting as optional

Tested this on SM8250 MTP with WSA and WCD codecs.
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 133 -----------
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 ++++++++++
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 133 +++++++++++
 drivers/pinctrl/qcom/Kconfig                       |  17 ++
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 255 ++-------------------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |  86 +++++++
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    | 168 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    | 165 +++++++++++++
 9 files changed, 704 insertions(+), 370 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

-- 
2.7.4

