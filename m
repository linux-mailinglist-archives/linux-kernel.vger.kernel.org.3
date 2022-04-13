Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2B4FF9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiDMPYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiDMPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:24:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D3747566;
        Wed, 13 Apr 2022 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649863303; x=1681399303;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3N2kt1c2FPhVfb4mXhigLF/ssk+WM5dkEKEoJhIMsJk=;
  b=KpRWTuy2qm2pw0a0glgoTU5L/EWqZ6iUjkyrXFu36Kf42jYF4ufF3H05
   Ya0BsW71VWMI7jdhsT/1w09uyw4VCXjqLDX8EARm3J4fC62VeJk7BONih
   e/UZk1s3Xg1KPJkVUXglU6gauFdjk9YANMokwZJxVMAu8HHGRxIUK8nq0
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 08:21:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:21:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:21:42 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:21:37 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 0/4] Add soundcard support for sc7280 based platforms.
Date:   Wed, 13 Apr 2022 20:51:13 +0530
Message-ID: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=631506
    -- https://patchwork.kernel.org/project/linux-arm-msm/patch/20220202053207.14256-1-tdas@codeaurora.org/.
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=601249
    -- Clock reset control patches

Changes Since V6:
    -- Modify link-names and audio routing in a sound node.
    -- Move amp_en pin control node to appropriate consumer patch.
    -- Split patches as per digital macro codecs and board specific codecs and sort it.
    -- Modify label and node names to lpass specific.
Changes Since V5:
    -- Move soc specific bolero digital codec nodes to soc specific file.
    -- Bring wcd938x codec reset pin control and US/EURO HS selection nodes from other series.
    -- Change node name and remove redundant status property in sound node.
Changes Since V4:
    -- Update nodes in sorting order.
    -- Update DTS node names as per dt-bindings.
    -- Update Node properties in proper order.
    -- Update missing pinctrl properties like US/EURO HS selection, wcd reset control.
    -- Remove redundant labels.
    -- Remove unused size cells and address cells in tx macro node.
    -- Keep all same nodes at one place, which are defined in same file.
    -- Add max98360a codec node to herobrine board specific targets.
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
    -- Fix typo errors.
Changes Since V1:
    -- Update the commit message of cpu node patch.
    -- Add gpio control property to support Euro headset in wcd938x node.
    -- Fix clock properties in lpass cpu and digital codec macro node.

Srinivasa Rao Mandadapu (4):
  arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital
    macro codecs
  arm64: dts: qcom: sc7280: Add nodes for wcd9385 and max98360a codec
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: Add dt nodes for sound card

 arch/arm64/boot/dts/qcom/sc7280-crd.dts        |  29 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 215 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 184 +++++++++++++++++++++
 4 files changed, 436 insertions(+)

-- 
2.7.4

