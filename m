Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6FD4E2655
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347326AbiCUMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiCUMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:30:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6A766C;
        Mon, 21 Mar 2022 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647865725; x=1679401725;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=N7CyycHVhv+dne4d0tslDZ1H8AP/lg7jcnOTTH0BktE=;
  b=r15TGJpsjgodu9+Jukdt4k8yXnJ7gQ2Qonzdp8UzrCD7vhO+vVjwnO0K
   cVS0YzRMMPeCJeY7L9HXxaz6wlR08YJRPZFKecnIap6PM+fHsDVbnDMfB
   IoNvheaFBHCTrWUwrdUi+mtCUukCU8f62hYnZsJ/7iIJm/o1/EgxlfJ38
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 05:28:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:28:44 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:28:43 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:28:39 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/3] Add soundcard support for sc7280 based platforms.
Date:   Mon, 21 Mar 2022 17:58:13 +0530
Message-ID: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=625134
    -- https://patchwork.kernel.org/project/alsa-devel/list/?series=625078
    -- https://patchwork.kernel.org/project/linux-arm-msm/patch/20220202053207.14256-1-tdas@codeaurora.org/.
    -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=601249
    -- Clock reset control patches

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

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and
    external codecs
  arm64: dts: qcom: sc7280: Add lpass cpu node
  arm64: dts: qcom: sc7280: Add dt nodes for sound card

 arch/arm64/boot/dts/qcom/sc7280-crd.dts        |  14 ++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 293 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           |  63 ++++++
 4 files changed, 378 insertions(+)

-- 
2.7.4

