Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185350B990
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448350AbiDVOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445040AbiDVOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:11:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE0E1FA48;
        Fri, 22 Apr 2022 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650636541; x=1682172541;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+eXBjavpBp+lUxItxY7s5i/+Ce8Bg2VM3j1VZJ06res=;
  b=Sg5aUdVFhyPeqVf8fc2QoteYEXyYnnr9CjhD6jgRDm6fmH0yd1zfr08Z
   21vvuN33/2CwDcpBvx+qubvw77aPtc9kWJ1rzxclVVBxg6VCQ6bkk2ntW
   XqHHFCF1XWWseVqfztzwPrZI4qZkeChGJK5JqOd+heoKwTrGMC61FY/It
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 07:09:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 07:09:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 07:09:00 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 07:08:56 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v10 00/12] Add soundcard support for sc7280 based platforms.
Date:   Fri, 22 Apr 2022 19:38:29 +0530
Message-ID: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add bolero digital macros, WCD and maxim codecs nodes
for audio on sc7280 based platforms.

This patch set depends on:
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=631506
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=601249
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=634203
    -- Clock reset control patches

Changes Since V9:
    -- Move wcd codec and digital codec nodes to sc7280-qcard file.
    -- Modify the reg property as per link number in sound node.
    -- Fix the us-euro pin control usage in wcd codec node.
    -- Move wcd pin control nodes to specific crd board files.
    -- Sort max98360a codec node in alphabetical order.
    -- Modify the commit messages.
Changes Since V8:
    -- Split patches as per sc7280 CRD revision 3, 4 and 5 boards.
    -- Add corresponding dt nodes for herobrine crd boards.
    -- Update dai-link node names as per dt-bindings in sound node.
    -- Add reg property in sound node as per dt-bindings which was removed in previous series.
    -- Fix typo errors.
    -- Update wcd codec pin control properties in board specific files.
Changes Since V7:
    -- Remove redundant interrupt names in soundwire node.
    -- Fix typo errors.
    -- Remove redundant reg property in sound node.
    -- Rebased on top of latest kernel tip.
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

Srinivasa Rao Mandadapu (12):
  arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital
    macro codecs
  arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
    1.0/2.0 and IDP boards
  arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
    3.0/3.1
  arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and
    IDP boards
  arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
  arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and IDP
    boards
  arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 and
    IDP boards.
  arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
  arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP
    boards
  arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1

 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts        |  37 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 150 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi    |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          | 218 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        |  75 ++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi              | 190 +++++++++++++++++++
 6 files changed, 678 insertions(+)

-- 
2.7.4

