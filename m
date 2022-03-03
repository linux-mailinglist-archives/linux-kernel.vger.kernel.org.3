Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F104CBFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiCCOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCCOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:31:57 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1E18CC47;
        Thu,  3 Mar 2022 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646317871; x=1677853871;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=q3nQUbvoUVhuvtL8hT3x3bxzCoG1VYLBMmyxslJbAcY=;
  b=VhEB4QRf9a8Jy6UWCdDSEpFtJxK6ARG2FRVSr+iF4oiOJ3rx7RNk7hOy
   4/ez4Pfgjs2t2dPERhmR0PeGsOV7GRoVukuj0Ok8f9CxH6KZUEBd+2hRa
   i+btDj8CXhYYc4X/zen4Y6Od7Gz466VS5BaAREbWMCV1PGKNy9tDn+S2v
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Mar 2022 06:31:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 06:31:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 3 Mar 2022 06:31:09 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 3 Mar 2022 06:31:03 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <vkoul@kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v7 0/2] Add support for SoundWire1.6 audio cgcr register control
Date:   Thu, 3 Mar 2022 20:00:49 +0530
Message-ID: <1646317851-14414-1-git-send-email-quic_srivasam@quicinc.com>
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

This patch series is to add v1.6.0 compatible name for qcom soundwire
driver and corresponding dt bindings.

Changes Since V6:
    -- Update commit message
    -- Update Example with reset control in dt bindings.
Changes Since V5:
    -- Constify static struct qcom_swrm_data global variables.
    -- Remove redundant swrm_v1_6_data variable.
Changes Since V4:
    -- Dropped audio cgcr control patch due to dependency on clock patches.
    -- Update dt-bindings as per new reset control properties.
Changes Since V3:
    -- Add v1.6.0 compatible name and soundwire data structure.
    -- Change macro define name properly.
    -- Update bindings for new property.
    -- Change commit message description.
    -- Change signedoff by sequence.
Changes since v2:
    -- Update error check after ioremap.
Changes since v1:
    -- Add const name to mask value.
Srinivasa Rao Mandadapu (2):
  soundwire: qcom: Add compatible name for v1.6.0
  dt-bindings: soundwire: qcom: Add bindings for audio clock reset
    control property

 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 14 ++++++++++++++
 drivers/soundwire/qcom.c                                 |  1 +
 2 files changed, 15 insertions(+)

-- 
2.7.4

