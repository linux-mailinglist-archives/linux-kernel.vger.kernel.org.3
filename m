Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28C50DF48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiDYLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbiDYLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:49:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED9403EC;
        Mon, 25 Apr 2022 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650887151; x=1682423151;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2v5pcIcc7ZbQcIJ3HV4B8vMrv3Kkrvvxf+oOjkNr99w=;
  b=lPTDvwCtgibS8PgByjqKGKA3saQtAAFpdqsyWM/cCCjWqBCVMfV3V+7s
   UCucdqmmnImyHAXA2QDZj42aDtU0DrSa9cBVwnLeCmJ3H+zILTYSYtagY
   h9P4QVHE2hyGjE3dZmwoV/3lakRdHTO5civIMIel4HJzww3ppnQPJntYd
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Apr 2022 04:44:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:44:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 04:44:50 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 04:44:43 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <bjorn.andersson@linaro.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>,
        <quic_aravindh@quicinc.com>, <steev@kali.org>
Subject: [PATCH v10 0/4] Add support for the eDP panel over aux_bus
Date:   Mon, 25 Apr 2022 17:14:28 +0530
Message-ID: <1650887072-16652-1-git-send-email-quic_sbillaka@quicinc.com>
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

This series adds support for generic eDP panel over aux_bus.

These changes are dependent on the following patches:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220211224006.1797846-5-dmitry.baryshkov@linaro.org/
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220211224006.1797846-6-dmitry.baryshkov@linaro.org/

Sankeerth Billakanti (4):
  drm/msm/dp: Add eDP support via aux_bus
  drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
  drm/msm/dp: wait for hpd high before aux transaction
  drm/msm/dp: Support the eDP modes given by panel

 drivers/gpu/drm/msm/dp/dp_aux.c     |  21 +++++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |   3 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c |  29 +++++++---
 drivers/gpu/drm/msm/dp/dp_catalog.h |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 104 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_display.h |   1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  21 ++++++--
 drivers/gpu/drm/msm/dp/dp_parser.c  |  23 +-------
 drivers/gpu/drm/msm/dp/dp_parser.h  |  14 ++++-
 9 files changed, 177 insertions(+), 40 deletions(-)

-- 
2.7.4

