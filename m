Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD646766A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380443AbhLCLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:36:14 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:17883 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbhLCLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:36:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638531164; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=30OU0DOAnq8WARciCG8pog5LrSAWa8kI5oyMnk0D4vw=; b=Zwfl7lx16jjl+BtJbyr1eHD2CDPK0/XfVaTgcojUpwYSVnjetrJinYfEXaQ22KtPF770RBDF
 mtzvzVjhCV3nW/zuo7tup2qPHSLzCH5lSuIhwRduPzFwo2DXPu+BPpLuJov35Drq9ILnkEbz
 HL6UJmH+TdSufoD14J2H3eYxtAc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61aa00555daaeec7979bbc3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 11:32:37
 GMT
Sender: srivasam=codeaurora.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22FAEC4338F; Fri,  3 Dec 2021 11:32:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A42AC4338F;
        Fri,  3 Dec 2021 11:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7A42AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.com
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Subject: [PATCH v4 0/5]  Add pin control support for lpass sc7280
Date:   Fri,  3 Dec 2021 17:02:15 +0530
Message-Id: <1638531140-25899-1-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to split lpass variant common pin control
functions and SoC specific functions and to add lpass sc7280 pincontrol support.
It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.

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
  pinctrl: qcom: Move chip specific functions to right files
  pinctrl: qcom: Update clock voting as optional
  pinctrl: qcom: Add SC7280 lpass pin configuration

 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 -----------
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 ++++++++++
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++
 drivers/pinctrl/qcom/Kconfig                       |  16 ++
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 252 +--------------------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |  98 ++++++++
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    | 169 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    | 166 ++++++++++++++
 9 files changed, 704 insertions(+), 374 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

