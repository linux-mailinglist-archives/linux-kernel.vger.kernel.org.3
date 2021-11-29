Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD059461195
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbhK2KEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:04:30 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:24454 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345215AbhK2KC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:02:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638179951; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JbZ6qYrIdMbs43FeU6Vwl7zE58GS4284/ICeuacW9sI=; b=H9yW+3S1TItC7de6y9iV/JtDl+tDamPJ1sbPXnCQFvjuvXZ5a0xNO9rR/EN0gBAOvznSXoEa
 F9s9vi42EFQQjpN4Uk0+gLc2AUn26+QeYVvVtksvXSOP9CMm3cI7+2J4gL9JxleLeBuYrwDN
 lZdt02L00XIcXz8igqdor3iYPaU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61a4a46f5daaeec79760cd94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 09:59:10
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC668C4338F; Mon, 29 Nov 2021 09:59:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7812AC4338F;
        Mon, 29 Nov 2021 09:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7812AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v3 0/5] Add pin control support for lpass sc7280
Date:   Mon, 29 Nov 2021 15:28:47 +0530
Message-Id: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to split lpass variant common pin control
functions and SoC specific functions and to add lpass sc7280 pincontrol support.
It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.

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
 drivers/pinctrl/qcom/Makefile                      |   2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 253 +--------------------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           | 140 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    | 127 +++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    | 125 ++++++++++
 8 files changed, 646 insertions(+), 376 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

