Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48549880F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbiAXSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:15:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56203 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbiAXSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643048158; x=1674584158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SjrQNLm3+7esMzoKo8xxleZRgcv3vxJh/gbHLOQw4LQ=;
  b=UPjPrDCw9RTHGi/9tPFUdo1wx4Q/XQC21EAsdgJZRuIA3y2W/rJWnuj3
   b0p6DBlLQlCuGkTqG0XDkAX9vIgVf+BlGvEU4Q3kXu30Z8ApFtr27WixZ
   GpPTd8CQrdYYTF1w1j8KlvcOQtJaHPew1gwdsdFkPBsQfU2VPJq4+e43R
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 10:15:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:15:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 10:15:57 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 10:15:52 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>
Subject: [PATCH v1 2/2] drm/panel-edp: Add sharp panel support for sc7280
Date:   Mon, 24 Jan 2022 23:45:14 +0530
Message-ID: <1643048114-2996-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643048114-2996-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1643048114-2996-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eDP panel support for sc7280 CRD platform.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 176ef0c..bb2e346 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1605,6 +1605,14 @@ static const struct panel_desc sharp_lq123p1jx31 = {
 	},
 };
 
+static const struct panel_desc sharp_lq140m1jw46 = {
+	.bpc = 8,
+	.size = {
+		.width = 309,
+		.height = 173,
+	},
+};
+
 static const struct drm_display_mode starry_kr122ea0sra_mode = {
 	.clock = 147000,
 	.hdisplay = 1920,
@@ -1719,6 +1727,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "sharp,lq123p1jx31",
 		.data = &sharp_lq123p1jx31,
 	}, {
+		.compatible = "sharp_lq140m1jw46",
+		.data = &sharp_lq140m1jw46,
+	}, {
 		.compatible = "starry,kr122ea0sra",
 		.data = &starry_kr122ea0sra,
 	}, {
-- 
2.7.4

