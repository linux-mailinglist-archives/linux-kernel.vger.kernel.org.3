Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2A50A324
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389413AbiDUOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389670AbiDUOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:50:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496543392;
        Thu, 21 Apr 2022 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650552478; x=1682088478;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jdLbh9Bv+MJD1MlZVeRD4tPqBfZObL+Ofc8cPc83C7Y=;
  b=ysbeKAKOQ725JlB/zs73A2GD7Ch/X7KanbaCLQM+pCL6H6MoBWCXWwAT
   piqaLirsoyLCn7r+sP0rWuzjTw61SPsz3RT8kCdOJJ4GC74wNd049okIj
   EtfMGu7a7xlAPhDs0xCcPPDHT56m5DOXPaWixTbevg95Xc8CHN89gB6Ki
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Apr 2022 07:47:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:47:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:47:57 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 07:47:53 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v9 00/12] Add soundcard support for sc7280 based platforms.
Date:   Thu, 21 Apr 2022 20:17:27 +0530
Message-ID: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
    1.0 and CRD 2.0
  arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
    3.0/3.1
  arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0 and CRD
    2.0
  arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
  arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0 and 2.0
  arm64: dts: qcom: sc7280: Add max98360a codec node for CRD 3.0/3.1
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0 and CRD
    2.0
  arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
  arm64: dts: qcom: sc7280: Add sound node for CRD 1.0 and CRD 2.0
  arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1

 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts        |  31 +++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 213 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi    |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          | 225 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi              | 190 ++++++++++++++++++
 5 files changed, 667 insertions(+)

-- 
2.7.4

