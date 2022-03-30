Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE84EC934
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348551AbiC3QGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348582AbiC3QGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:06:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD89C23D472;
        Wed, 30 Mar 2022 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648656256; x=1680192256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LO2EsS4wu1rdzNhwPhx0M07udxTKW99QIv0eDN+oIPw=;
  b=x0lAL/01hW7rp1KfKx9/GZnKTI13e+73xAXs6Viyx2L1Zk7nnOz9Nuia
   jkkOD5/BeHGf+8Z256LRXfH0VnLToS8FGtR67f9wSnfLwoL6MIB+gXUUm
   HdNtZEBj29LrUDWfCyaDdsGUYSEHNKbpvHLIX1Wd8uBkbwBrmxQhZMath
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2022 09:04:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:04:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:04:14 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:04:08 -0700
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
        <quic_aravindh@quicinc.com>
Subject: [PATCH v6 7/8] drm/msm/dp: Support edp/dp without hpd
Date:   Wed, 30 Mar 2022 21:32:58 +0530
Message-ID: <1648656179-10347-8-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
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

Some eDP sinks or platform boards will not support hpd.
This patch adds support for those cases.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 1809ce2..8f1fc71 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -244,10 +244,17 @@ void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog)
 
 int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog)
 {
-	u32 state;
+	u32 state, hpd_en;
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
+	hpd_en = dp_read_aux(catalog, REG_DP_DP_HPD_CTRL);
+	hpd_en &= DP_DP_HPD_CTRL_HPD_EN;
+
+	/* no-hpd case */
+	if (!hpd_en)
+		return 0;
+
 	/* poll for hpd connected status every 2ms and timeout after 500ms */
 	return readl_poll_timeout(catalog->io->dp_controller.aux.base +
 				REG_DP_DP_HPD_INT_STATUS,
@@ -586,8 +593,10 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
 	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
 	dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
 
-	/* Enable HPD */
-	dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
+	/* Enable HPD if supported*/
+	if (!of_property_read_bool(catalog->dev->of_node, "no-hpd"))
+		dp_write_aux(catalog, REG_DP_DP_HPD_CTRL,
+				DP_DP_HPD_CTRL_HPD_EN);
 }
 
 u32 dp_catalog_link_is_connected(struct dp_catalog *dp_catalog)
-- 
2.7.4

