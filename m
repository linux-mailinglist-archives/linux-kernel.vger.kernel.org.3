Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBF4B286A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiBKOzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:55:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351111AbiBKOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:55:52 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523961AE;
        Fri, 11 Feb 2022 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591351; x=1676127351;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=l+zQGEVSkem0Lfm/Lr3g2q66KqstuPi5Ur0AUi2o700=;
  b=L/IikKRfL2rC7A0plqc0j5aok9Ox/nqsBZ4Im7GN73dUur7YPRyhPWqR
   qzyoir2d59JAyDi0OxJgnIazF/SCgfG0nHBp+lbevTY98MgZSaqBkd+vb
   vwx29c/8S1PGFykYEXp5ilJ/ZHBM+HL4+fOVCY/xDq9Ial8aAK5boJDzS
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 06:55:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:55:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:55:50 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:55:46 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v3 0/2] Add lpass pin control support for audio on sc7280 based targets
Date:   Fri, 11 Feb 2022 20:25:03 +0530
Message-ID: <1644591305-6235-1-git-send-email-quic_srivasam@quicinc.com>
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

This patch set is to add lpass pin control support for Audio over I2S,
wcd codec and digital mics.
This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com/

Changes Since V2:
    -- Move lpass pin control node to main dtsi file.
    -- Sort nodes alphabetically.
    -- Remove redundant wcd reset gpio nodes.
    -- Remove redundant input-enable field in dmic pin control nodes.
    -- Update amp_en node. 
    -- Fix typo errors.
    -- Modify node names.
    -- Create patches on latest kernel.    
Changes Since V1:
    -- Merge pinmux and pinconf properties in amp_en and wcd pin reset node.
    -- Split common i2s pin control nodes to functionality specific nodes.
    -- Move board specific properties to board specific dtsi file.
    -- Update dmic pin control node name.

Srinivasa Rao Mandadapu (2):
  arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  41 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 188 +++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+)

-- 
2.7.4

