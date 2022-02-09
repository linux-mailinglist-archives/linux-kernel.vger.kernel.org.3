Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34B4AF04B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiBIL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiBILzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:23 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430ADE00F7E1;
        Wed,  9 Feb 2022 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644403999; x=1675939999;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=y0yZ5q/+c6SfYwXnH7eqJbGk8kSf6a0eSUhic2wJcrY=;
  b=mNdm/bSlG3EpswJ+H/mInbFW9+dl0JrCW/GhOgL7E8OklwbXJjD+jovu
   f6FjFxos4YaXF6pyUcAH9YtQpHpuQ/ixZYiQF0QknERbgnPL1RfZAYqx2
   QYAVYyUBWilP4xO5Dnc1Yxmr883XhPWyRimDO3oyS/nLs40xCYCXxjSkG
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 00:55:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 00:55:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 00:55:49 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 00:55:42 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <dianders@chromium.org>,
        <krzysztof.kozlowski@canonical.com>, <thierry.reding@gmail.com>,
        <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <quic_kalyant@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>,
        <quic_vproddut@quicinc.com>
Subject: [PATCH v3 0/4] Add support for the eDP panel on sc7280 CRD
Date:   Wed, 9 Feb 2022 14:25:28 +0530
Message-ID: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com>
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

Add support for the eDP panel on sc7280 CRD platform. The eDP panel does
not need HPD line for connect disconnect. So, this series will report eDP
as always connected. The driver needs to register for IRQ_HPD only for eDP.
This support will be added later.

These changes are dependent on the following series:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=586263&archive=both&state=*
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=560587&state=%2A&archive=both


Sankeerth Billakanti (4):
  dt-bindings: display: simple: Add sharp LQ140M1JW46 panel
  arm64: dts: qcom: sc7280: Add support for eDP panel on CRD
  drm/panel-edp: Add eDP sharp panel support
  drm/msm/dp: Add driver support to utilize drm panel

 .../bindings/display/panel/panel-simple.yaml       |   2 +
 arch/arm64/boot/dts/qcom/sc7280-crd.dts            | 122 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   8 ++
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  54 ++++++++-
 drivers/gpu/drm/msm/dp/dp_parser.h                 |   3 +
 drivers/gpu/drm/panel/panel-edp.c                  |  31 ++++++
 7 files changed, 216 insertions(+), 6 deletions(-)

-- 
2.7.4

