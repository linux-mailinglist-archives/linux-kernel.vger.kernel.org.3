Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A451C353
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381042AbiEEPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiEEPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:08:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C85AA59;
        Thu,  5 May 2022 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651763095; x=1683299095;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=lK4AYco/HD5kRmKSXiIurHbHQwGh4G7Y3jLU0XeK+XY=;
  b=lDdpF6g39b+xQ8dGMRYM/0PlnG+euko8Mlqb3azN6KAZnodZTcYrnyf2
   IpgoIo3Ba3KJ7V1ru1OAtdIXFGRvvUureRbAYALuARE4RyNjkOapyrFh/
   D4B8c99XcucaoxjA/S61OPIWQTBbn1XlPXQg7JoV2GDJOqinBcdEtnYHW
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 08:04:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:04:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 08:04:53 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 08:04:48 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v14 0/4] Add lpass pin control support for audio on sc7280 based targets
Date:   Thu, 5 May 2022 20:33:20 +0530
Message-ID: <1651763004-32533-1-git-send-email-quic_srivasam@quicinc.com>
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

 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  75 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          |  76 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi              | 131 ++++++++++++++++++++++
 3 files changed, 282 insertions(+)

-- 
2.7.4

