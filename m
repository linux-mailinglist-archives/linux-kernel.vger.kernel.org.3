Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143A54818C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiFMIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbiFMIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:24:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B31A381;
        Mon, 13 Jun 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655108665; x=1686644665;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rUnimfGgeQVNmpcRaMMHnbPRRcrD0+V3YUnAL9R77Wg=;
  b=eZifoheqlos2NcKe9TYAHuSBGeQ5wt31+Wpt9QfXpDk8Ew9B0NG0AgC5
   Q4fu7QFG7XOswRw6+OXAJY6jMsFqz1MsWp+hK6M3Rb2mM2jOVORujxzck
   IU1tk4nt8WBS4JqQ3qOXObMPceFlGLzntUJf47xJi8/1O2bcDaFNicqFJ
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jun 2022 01:24:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 01:24:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:24:24 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 01:24:20 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v15 0/4] Add lpass pin control support for audio on sc7280 based targets
Date:   Mon, 13 Jun 2022 13:54:01 +0530
Message-ID: <1655108645-1517-1-git-send-email-quic_srivasam@quicinc.com>
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

Changes Since V14:
    -- Move secondary MI2S pinmux specifications to new file.
    -- Add qcom,adsp-bypass-mode boolean property in lpass_tlmm Node.
Changes Since V13:
    -- Remove redundant properties in lpass lpi pin control nodes.
    -- Sort lpass lpi pin control nodes.
Changes Since V12:
    -- Split common lpass lpi pin control nodes to functionality specific nodes.
    -- Move common pin control properties to corresponding default nodes.
Changes Since V11:
    -- Move CRD specific pinmux nodes to crd specific file.
Changes Since V10:
    -- Add lpass lpi pinmux and MI2S pinmux support for rev5+ boards.
    -- Remove dependency patches link in the cover-letter as it is merged.
Changes Since V9:
    -- Remove redundant prefix in node name.
Changes Since V8:
    -- Modify label and node names to lpass specific.
    -- Sort nodes as per node names and kind of nodes like pinctrl and device nodes.
Changes Since V7:
    -- Sort mi2s pincontrol nodes as per node name.
    -- Fix typo errors.
Changes Since V6:
    -- Move amp_en node to corresponding consumer patch.
    -- Update label and node names.
    -- Remove redundant drive-strengths.
    -- Remove herobrine crd specific mi2s configuration.
Changes Since V5:
    -- Remove redundant function property in amp_en node.
    -- Move board specific properties of lpass pin control node to board specific file.
    -- Remove redundant properties in pin control nodes.
    -- Move wcd938x codec reset and CTIA/OMTP pin control patches to other series.
Changes Since V4:
    -- Add primary and secondary I2S pinmux nodes for herobrine specific targets.
Changes Since V3:
    -- Add pinctrl nodes for wcd codec reset and CTIA/OMTP headset selection.
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

Srinivasa Rao Mandadapu (4):
  arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
  arm64: dts: qcom: sc7280: Add secondary MI2S pinmux specifications for
    CRD 3.0/3.1
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node
  arm64: dts: qcom: sc7280-herobrine: Add lpi pinmux properties for CRD
    3.0/3.1

 .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   |  20 ++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  |  62 ++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  76 ++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 132 +++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi

-- 
2.7.4

