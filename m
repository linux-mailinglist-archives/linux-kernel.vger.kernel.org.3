Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B371D47F762
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhLZPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 10:14:13 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:54450 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhLZPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:14:12 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1VDpnig8t1UGB1VDqnOSgw; Sun, 26 Dec 2021 16:14:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Dec 2021 16:14:11 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, bjorn.andersson@linaro.org,
        swboyd@chromium.org, quic_khsieh@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/msm/dp: Fix a potential double free in an error handling path
Date:   Sun, 26 Dec 2021 16:14:05 +0100
Message-Id: <6fd20c8779d6b03a5b54509af25b478049482087.1640531508.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dp_bridge' is devm_alloc'ed, so there is no need to free it explicitly or
there will be a double free().

Fixes: 8a3b4c17f863 ("drm/msm/dp: employ bridge mechanism for display enable and disable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/dp/dp_drm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 188e77c59885..d4d360d19eba 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -243,7 +243,6 @@ struct drm_bridge *msm_dp_bridge_init(struct msm_dp *dp_display, struct drm_devi
 	rc = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (rc) {
 		DRM_ERROR("failed to attach bridge, rc=%d\n", rc);
-		kfree(dp_bridge);
 		return ERR_PTR(rc);
 	}
 
-- 
2.32.0

