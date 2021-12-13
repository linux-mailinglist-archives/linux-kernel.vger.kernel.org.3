Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F373C4733B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbhLMSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241711AbhLMSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12166646wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=ebJJ52GfshhjdOeOLj4xc0X1TjsexXLbPjpxlTZN3+kZq9w+ZRup8HjxhqlWI9kC5j
         6YvHc4n6xZzUVApWRKW0taYd/OB9Oa4JzHqffwc7y2bNqiwHo3/83leRNDFIC0uBTut9
         MTnUunzTRDjzexMXRiLwrHqNpAmxEBH1T8hn/aPXASlVP8+DUNCV9nfYT6H55rYXtGje
         VT/sIfrowy4gW8GEfTpObCVssF0tGXeo0uVaEM5aKyd+o2vcmcgHB+Mmz2AV0a/4rl4s
         KfCwkBbZZrIPT0d9g8bvRDb1fNM4uGUz/N8Luwc5oVwuAVKPHvrciYNhh+IU0RB6SZk/
         T8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=yN6ne1IE9Ko+iLaMOPC7TtYiWAvV0969m5mWR8Deq0ePXcBLiLUVoVN4D4t+Qv7lxV
         UHf3Q3YgPzyUKYBgar7+mR/PcLT6Ysl8/7nJfdJFEiZCJwJ7lhttjagTIDa15bDy1ixo
         /V4PwAOr/F3CsqT+wUA3SEl4/CoW3HrjBXbiQ3gorg/gw2xk0we/ybsdJAX8NEiCMKj0
         FpJfPP05G38Dyn2Y/ZSFSEvJPbcvdZWKynhvQn5H1jRYeV8xdJYPXfabmFu4qRrbfA78
         /tSu3NXjXG7cfg+o1uejXqmLT4MJKZx/diLsNfjKVNB8zKZ+u9sGFPMnVzal7uUldVWz
         WO3Q==
X-Gm-Message-State: AOAM532CWyeCgoY1HwF3wJSuptly30ksv1MaeRwnPiKP5d94MUBkZFhR
        peEZYmTFydTlHR1f3/yNMJk=
X-Google-Smtp-Source: ABdhPJyfQFFdMLlstFu4ZT190nQFT3inzt1bjDzISqxrWE4zsWyirInch5YIHXakodSbJe0Ataqppg==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr41519157wmb.19.1639419099777;
        Mon, 13 Dec 2021 10:11:39 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id t127sm8750956wma.9.2021.12.13.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:11:39 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/3] drm/vkms: refactor overlay plane creation
Date:   Mon, 13 Dec 2021 19:11:29 +0100
Message-Id: <20211213181131.17223-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213181131.17223-1-jose.exposito89@gmail.com>
References: <20211213181131.17223-1-jose.exposito89@gmail.com>
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

