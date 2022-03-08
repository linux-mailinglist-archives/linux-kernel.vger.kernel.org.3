Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF14D1DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbiCHQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiCHQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:56:21 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBC517DF;
        Tue,  8 Mar 2022 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646758524; x=1678294524;
  h=from:to:cc:subject:date:message-id;
  bh=IJhYGSqQ+TjX2Hrn6OQWdW1SWaoeh6rjSgOhCsAhXwM=;
  b=N0ZC+xhxm367ThHAelk9bPeDVUJyhVwsXKyDGbqUWsMqyJdziYwLjhV0
   H/+ZRyWgdGaxz6vKUs6NynCAcO+JLGus+MH0ofZ+VhQT2rLAvRoJu67N3
   SRK0FeqdM8gbOwdDQu7f1CXqi7jtLOpqkSx/WB3nbu6UyWkPRp+Jd+BxC
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 08:55:23 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Mar 2022 08:55:21 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 22:25:03 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 3206453BE; Tue,  8 Mar 2022 22:25:02 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v5 0/5] Update mdp clk to max supported value to support higher refresh rates
Date:   Tue,  8 Mar 2022 22:24:55 +0530
Message-Id: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel clock driver assumes that initial rate is the
max rate for that clock and was not allowing it to scale
beyond the assigned clock value.

Drop the assigned clock rate property and vote on the mdp clock as per
calculated value during the usecase.

Changes in v2:
- Remove assigned-clock-rate property and set mdp clk during resume sequence.
- Add fixes tag.

Changes in v3:
- Remove extra line after fixes tag.(Stephen Boyd)
- Add similar changes for sc7180, sdm845 which uses opp table for voting mdp clk.(Stephen Boyd)
- Drop patch: "drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table"

Changes in v4:
- Add similar change for sm8250.(Dmitry)

Changes in v5:
- Add change to set mdp clk to max frequency in opp table during mdp probe/bind.

Vinod Polimera (5):
  arm64/dts/qcom/sc7280: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sc7180: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sdm845: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sm8250: remove assigned-clock-rate property for mdp clk
  drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table
    during probe

 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 9 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 5 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.7.4

