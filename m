Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53A50F235
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbiDZHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343902AbiDZHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:24:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5BDF1B;
        Tue, 26 Apr 2022 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650957694; x=1682493694;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0ucwVlpscpdQ5Ufmgu+kNlv/rwMKi8SndF3Ds24Os8k=;
  b=KGf0guSRh7HFApSuMqwbEZnEN1qygoMSWG4bY5q3HGGqyyTGNfDoCx9u
   +7kaQgdS7LoVnUNJNLOdnL+aPRlu1fkL9YtNEdSS6BUduc8Sdp3qB/eWV
   U2H47ipFmGf6z1zZu9ypGfQTIGlzf8k/REX8HZBJ4jEbhh5zy8Bis4syK
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 00:21:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:21:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:21:32 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:21:28 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v11 0/4] Add lpass pin control support for audio on sc7280 based targets
Date:   Tue, 26 Apr 2022 12:51:02 +0530
Message-ID: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add lpass pin control support for Audio over I2S,
wcd codec and digital mics.

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
  arm64: dts: qcom: sc7280: Add MI2S pinmux specifications for CRD
    3.0/3.1
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node
  arm64: dts: qcom: sc7280-herobrine: Add lpi pinmux properties for CRD
    3.0/3.1

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 118 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       |  98 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 147 +++++++++++++++++++++++++
 3 files changed, 363 insertions(+)

-- 
2.7.4

