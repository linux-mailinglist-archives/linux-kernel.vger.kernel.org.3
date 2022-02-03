Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352694A832E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbiBCLdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:33:25 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36751 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350241AbiBCLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643888002; x=1675424002;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CKB6XxhPcmYXpzASIp+ItgBcBPMlb9gXew6VSrAap/I=;
  b=UX8HCLErpwnYWjBPUo6n0kdTOjFFDFjfMz6fYgE0tWUpsPwB7K1TRDAC
   4JQc8J39gF69a0RLgvy00KNV40oPRdklbqesZmZ6I3f+d4spVRFZzfLNe
   l869ptjrOb6chiZQeUIy1AE6ok8xpP6fLStRfz9PM7aQlIlDbJ39b4W4n
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2022 03:33:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:33:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:21 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:18 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 0/3] Add soundcard support for sc7280 based platforms.
Date:   Thu, 3 Feb 2022 17:02:58 +0530
Message-ID: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add bolero digital macros, WCD and maxim codecs nodes
for audio on sc7280 based platforms.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638551345-24979-2-git-send-email-srivasam@codeaurora.com/
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1639503391-10715-10-git-send-email-quic_srivasam@quicinc.com/
	-- https://patchwork.kernel.org/project/linux-arm-msm/patch/20220202053207.14256-1-tdas@codeaurora.org/.
	-- MSM DP node yet to be upstreamed.
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 176 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 181 +++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)

-- 
2.7.4

