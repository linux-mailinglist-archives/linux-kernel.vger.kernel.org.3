Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEA466709
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359155AbhLBPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:49:00 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:24353 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359132AbhLBPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:48:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638459933; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Mam5fJ/g0ud+mA5jIn/QLyomgHNukbcMWyEljhMxKKE=; b=d/AucsFtjye9PBPGW0kq8V8XaHl4sBXtYdm5k5WgeD++pezF7MTrCXeMRInAfRifXZRzcaF+
 mGC4zw+1w7exegNoC2ss+qMUHlr53FDdGvYSlPlyaI7T1JQrRYPqbmJDkE4C6W+wQanP8qGj
 MkLc+YK89uiP/ggHH7rOMrOuAPo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61a8e9b9642caac318df4f9b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Dec 2021 15:43:53
 GMT
Sender: srivasam=codeaurora.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71139C43637; Thu,  2 Dec 2021 15:43:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FF68C4338F;
        Thu,  2 Dec 2021 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7FF68C4338F
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
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 00/10] Add support for audio on SC7280 based targets
Date:   Thu,  2 Dec 2021 21:13:16 +0530
Message-Id: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

This patch set is to add support for Audio over wcd codec,
digital mics, through digital codecs and without ADSP.

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
  ASoC: qcom: Move lpass_pcm_data structure to lpass header
  ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
  ASoC: qcom: Add register definition for codec rddma and wrdma
  ASoC: qcom: Add lpass CPU driver for codec dma control
  ASoC: qcom: Add helper function to get dma control and lpaif handle
  ASoC: qcom: Add support for codec dma driver
  ASoC: qcom: Add regmap config support for codec dma driver
  ASoC: dt-bindings: Add SC7280 lpass cpu bindings
  ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
  ASoC: qcom: SC7280: Update config for building codec dma drivers

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

