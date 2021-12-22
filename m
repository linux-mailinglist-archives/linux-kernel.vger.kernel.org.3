Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5747D7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbhLVTdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:33:55 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:65165 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhLVTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:33:54 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 07MznESxgf6fn07MznJHFa; Wed, 22 Dec 2021 20:33:51 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 22 Dec 2021 20:33:51 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, swboyd@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/msm/dp: Simplify dp_debug_init() and dp_debug_get()
Date:   Wed, 22 Dec 2021 20:33:47 +0100
Message-Id: <dc2d6f535379dd38a5e3f9ba502f1f2b3d1f56b7.1640201523.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp_debug_init() always returns 0. So, make it a void function and simplify
the only caller accordingly.

While at it remove a useless 'rc' initialization in dp_debug_get()

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/dp/dp_debug.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index da4323556ef3..338f1f9c4d14 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -207,9 +207,8 @@ static const struct file_operations test_active_fops = {
 	.write = dp_test_active_write
 };
 
-static int dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
+static void dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
 {
-	int rc = 0;
 	struct dp_debug_private *debug = container_of(dp_debug,
 			struct dp_debug_private, dp_debug);
 
@@ -229,17 +228,15 @@ static int dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
 			debug, &dp_test_type_fops);
 
 	debug->root = minor->debugfs_root;
-
-	return rc;
 }
 
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
 		struct dp_usbpd *usbpd, struct dp_link *link,
 		struct drm_connector *connector, struct drm_minor *minor)
 {
-	int rc = 0;
 	struct dp_debug_private *debug;
 	struct dp_debug *dp_debug;
+	int rc;
 
 	if (!dev || !panel || !usbpd || !link) {
 		DRM_ERROR("invalid input\n");
@@ -266,11 +263,7 @@ struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
 	dp_debug->hdisplay = 0;
 	dp_debug->vrefresh = 0;
 
-	rc = dp_debug_init(dp_debug, minor);
-	if (rc) {
-		devm_kfree(dev, debug);
-		goto error;
-	}
+	dp_debug_init(dp_debug, minor);
 
 	return dp_debug;
  error:
-- 
2.32.0

