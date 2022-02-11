Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8754B2890
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiBKO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiBKO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:57:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FB131;
        Fri, 11 Feb 2022 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591455; x=1676127455;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LXTfK/X+iYlVTDLZZtKr2XEZoQdHlZuEZEWwfCjp6AY=;
  b=V50RyyeVOmXqMe1ArNX9XLOKNrjJuLbyidVVLsIpuTMtwrxUFemj7SoG
   uC+JncsAPZz1cT0IJqKnYMeOgYomy+5tjA5qb4lrn5PNcP1jQddWkXz1W
   5gN0GYlKF4Wuh2jmPbXK/9hOWvj0paE/poeLRC6BmsDw3kDAqd/wuj93c
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 06:57:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:57:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:57:34 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:57:30 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 0/3] Add soundcard support for sc7280 based platforms.
Date:   Fri, 11 Feb 2022 20:27:15 +0530
Message-ID: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

This patch set is to add bolero digital macros, WCD and maxim codecs nodes
for audio on sc7280 based platforms.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1639503391-10715-10-git-send-email-quic_srivasam@quicinc.com/
	-- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613100
	-- https://patchwork.kernel.org/project/linux-arm-msm/patch/20220202053207.14256-1-tdas@codeaurora.org/.
	-- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=601249

Changes Since V3:
    -- Move digital codec macro nodes to board specific dtsi file.
    -- Update pin controls in lpass cpu node.
    -- Update dependency patch list.
    -- Create patches on latest kernel.
Changes Since V2:
    -- Add power domains to digital codec macro nodes.
    -- Change clock node usage in lpass cpu node.
    -- Add codec mem clock to lpass cpu node.
    -- Modify the node names to be generic.
    -- Move sound and codec nodes to root node.
    -- sort dai links as per reg.
    -- Fix typo errors
Changes Since V1:
    -- Update the commit message of cpu node patch.
    -- Add gpio control property to support Euro headset in wcd938x node.
    -- Fix clock properties in lpass cpu and digital codec macro node.

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and
    external codecs
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: add sound card support

 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |  12 ++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 299 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     |  59 ++++++
 3 files changed, 370 insertions(+)

-- 
2.7.4

