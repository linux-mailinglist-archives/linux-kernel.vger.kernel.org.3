Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341674D8753
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiCNOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbiCNOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:48:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420141984;
        Mon, 14 Mar 2022 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647269241; x=1678805241;
  h=from:to:cc:subject:date:message-id;
  bh=f7G/YswmiYVCsRP6W8jrevaUd3XphbqWfCfiw8upItk=;
  b=ysg9my+a/I0Nx5vGb+YQcNEvqWUqZzmNKl5ZjbS2KW1mpbciW5ncg3Vw
   MaVQs6psqHCjXQC0q+g2Z+lBMYMzfPz7CtRef7qH/675NsTuAOYlGdJ9n
   qEXGqSmZZlMz8Rz/b567skWrD/ELgz1uC8Vfyjywnfn3b64ZTjJx3Ra6j
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Mar 2022 07:47:21 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Mar 2022 07:47:19 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Mar 2022 20:17:02 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 29A9C4E31; Mon, 14 Mar 2022 20:17:01 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v6 0/5] Update mdp clk to max supported value to support higher refresh rates 
Date:   Mon, 14 Mar 2022 20:16:52 +0530
Message-Id: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com>
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

Drop the assigned clock rate property and vote on the mdp clock to max frequency
during bind/probe sequence.

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

Changes in v6:
- Remove change log in dt patch.
- Fix the leak reference for opp by adding dev_pm_opp_put. (Dmitry)

Vinod Polimera (5):
  drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table
    during probe
  arm64: dts: qcom: sm7280: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sm7180: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sdm845: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sm8250: remove assigned-clock-rate property for mdp
    clk

 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 9 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
 5 files changed, 16 insertions(+), 28 deletions(-)

-- 
2.7.4

