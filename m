Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876CD467ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381959AbhLCQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:11:24 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:22667 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381953AbhLCQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:11:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638547678; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WzzSBVHA8ASC7Q4/2/wpuCOHjl5U3+rLQX15XbsmR4s=; b=TutG5Hv8lhq4/9yaToDk+tWPQUr9OQkFQ86Zf1ZxFebD237EqCE1Glq7eN5XPSGrAkKVv6S/
 3zXirsIwCC5JVoMipMHYJQ4n4SKTaf9x+Iig60rg4ygLK3JyF4lWKnqIbwkqG1hiYS4BNe9K
 5FnekG6fl902FiVo1agYscZ1oVU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 61aa40dde7d68470afc03756 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 16:07:57
 GMT
Sender: srivasam=codeaurora.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DED44C43639; Fri,  3 Dec 2021 16:07:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 225A8C4338F;
        Fri,  3 Dec 2021 16:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 225A8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.com
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Subject: [PATCH v8 00/10] Add support for audio on SC7280 based targets
Date:   Fri,  3 Dec 2021 21:37:28 +0530
Message-Id: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add support for Audio over wcd codec,
digital mics, through digital codecs and without ADSP.

Changes Since V7:
    -- Fix indentation errors.
    -- Bisect patches to avoid interdependency.
Changes Since V6:
    -- Split cdc dma regmap config macros.
    -- Add write dma reg fields for i2s path.
    -- Add helper function to distinguish rxtx and va dma ports.
    -- Optimizing clock and reg name in cpu dt-bindings.
    -- Update buffer management for cdc dma path.
    -- Remove Kconfig fields of machine driver.
Changes Since V5:
    -- Include MI2S primary node to snd_soc_dai_driver in lpass-sc7280 platform driver.
    -- Move dependency patch list to corresponding patch.
    -- Add support for missing cdc-dma ports.
    -- Change if/else conditional statements to switch cases.
    -- Add missing error handlings.
    -- Typo errors fix.
Changes Since V4:
    -- Remove unused variable in lpass-sc7280 platform driver.
Changes Since V3:
    -- Remove redundant power domain controls. As power domains can be configured from dtsi.
Changes Since V2:
    -- Split lpass sc7280 cpu driver patch and create regmap config patch.
    -- Create patches based on latest kernel tip.
    -- Add helper function to get dma control and lpaif handle.
    -- Remove unused variables.
Changes Since V1:
    -- Typo errors fix
    -- CPU driver readable/writable apis optimization.
    -- Add Missing config patch
    -- Add Common api for repeated dmactl initialization.

Srinivasa Rao Mandadapu (10):
  ASoC: qcom: SC7280: Update config for building codec dma drivers
  ASoC: qcom: Move lpass_pcm_data structure to lpass header
  ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
  ASoC: qcom: Add helper function to get dma control and lpaif handle
  ASoC: qcom: Add register definition for codec rddma and wrdma
  ASoC: qcom: Add regmap config support for codec dma driver
  ASoC: qcom: Add support for codec dma driver
  ASoC: qcom: Add lpass CPU driver for codec dma control
  ASoC: dt-bindings: Add SC7280 lpass cpu bindings
  ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  70 ++-
 sound/soc/qcom/Kconfig                             |  11 +
 sound/soc/qcom/Makefile                            |   4 +
 sound/soc/qcom/lpass-cdc-dma.c                     | 275 +++++++++
 sound/soc/qcom/lpass-cpu.c                         | 244 +++++++-
 sound/soc/qcom/lpass-lpaif-reg.h                   | 127 ++++-
 sound/soc/qcom/lpass-platform.c                    | 617 ++++++++++++++++++---
 sound/soc/qcom/lpass-sc7280.c                      | 441 +++++++++++++++
 sound/soc/qcom/lpass.h                             | 162 ++++++
 9 files changed, 1864 insertions(+), 87 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-cdc-dma.c
 create mode 100644 sound/soc/qcom/lpass-sc7280.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

