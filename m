Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488F447F670
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhLZKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhLZKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:41:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A00C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l4so7861075wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=Ock4A3uoGStWAqVLbKFpQ0G5feZlxJ5tGxucKxVG85VNVRD+NoFnpyyXQBFQW+up/y
         5YjQonEU+szM63am1pR3OVzffe4Rg6DVnQiPggbfPYjGlrBM2+eSjcipDUU/T7pQaWjN
         oO2p/LoWWIzLj5yfgg9KJHPFLA/nndVKJ+aavpNDpqHA0ULByzl6Uno2+mJVfxaWiAq1
         KIJ099J6+r6cPfyD+XEKBUK2d6MOGgn53wjVdBcf/o4eVqn46ANPDGZWYiLzQ493NYfw
         w9z1TFZ2JYl3ZGVggUM0oXgnyPp/gH1Qy+p+JPe77f/3CzMZ5IpYRGWzS2VDL/bk16/e
         ClbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=cEe5LyOnHk0fLDj7wlTgM2ri6eh8UYPBWfPJWJLIZrOzthV3KFgJGesz6wJMk/qt0H
         uWbtUH5Myls5D04fboEpUxsutk710bB1CUzYvoPUFffe1gB4bJcfvjRNuLhk8mG28e7V
         zZJ5fMusdJlaP2mXYSTGR5cfKL+r/RpK+e7yBSD0MbJwj3SiRSxf5SKkZ5w5Jr7tA8zx
         NYcIqruRI7FfuJhxc5i36tdRzavJH1GPJPs1MjzIwcE8v1TMmtVULDro0RdSIQ0TnUag
         Wwi1j+/kZ9KlUVmBRkHND6sh2WG2SoDTJkEQ/TigMw9V/a1I6S0nmLpBoWl7RRziD/sy
         yfUA==
X-Gm-Message-State: AOAM532N188a0dX/EONnIH1DYrfrRhHdzlGzwAJlM3cWQ5L5b99UU35g
        ImuKmhDOo+A0SSZnP9y61YM=
X-Google-Smtp-Source: ABdhPJzt8QgSrDwaC8ul4L8AhTDytNAzH1P6MVQB50CiqghEZHGW//SXTCTmmRT1vZJ4sWLB0EiNQA==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr9862595wmi.128.1640515267984;
        Sun, 26 Dec 2021 02:41:07 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g9sm12592729wmq.22.2021.12.26.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 02:41:07 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/3] drm/vkms: refactor overlay plane creation
Date:   Sun, 26 Dec 2021 11:40:57 +0100
Message-Id: <20211226104059.11265-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the logic to create an overlay plane to its own function.
Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 04406bd3ff02..2e805b2d36ae 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -32,6 +32,21 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
+static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
+				  struct drm_crtc *crtc)
+{
+	struct vkms_plane *overlay;
+
+	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
+	if (IS_ERR(overlay))
+		return PTR_ERR(overlay);
+
+	if (!overlay->base.possible_crtcs)
+		overlay->base.possible_crtcs = drm_crtc_mask(crtc);
+
+	return 0;
+}
+
 int vkms_output_init(struct vkms_device *vkmsdev, int index)
 {
 	struct vkms_output *output = &vkmsdev->output;
@@ -39,7 +54,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
 	struct drm_crtc *crtc = &output->crtc;
-	struct vkms_plane *primary, *cursor = NULL, *overlay = NULL;
+	struct vkms_plane *primary, *cursor = NULL;
 	int ret;
 	int writeback;
 
@@ -48,12 +63,9 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		return PTR_ERR(primary);
 
 	if (vkmsdev->config->overlay) {
-		overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
-		if (IS_ERR(overlay))
-			return PTR_ERR(overlay);
-
-		if (!overlay->base.possible_crtcs)
-			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
+		ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
+		if (ret)
+			return ret;
 	}
 
 	if (vkmsdev->config->cursor) {
-- 
2.25.1

