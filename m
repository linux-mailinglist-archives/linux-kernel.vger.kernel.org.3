Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB333487C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiAGS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiAGS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:28:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:28:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l4so4517478wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=EVQui/6Rka9+gaqd2Lzk5fQ3Mi3OfoZA8B4MAlgughIVrqnlgxpmIJOgkaQFPQIRMp
         0FOiOEu38cyYgLswHTUAJkZugAEISKSTlONL00Cuz3ZCm1PZ3jju8c6D4pTKhQqaAW+p
         eS3IIMAriMzs4/27LMuFLpNrfe/CUnVYZ4ZO1UGKYFJyh5nVQcXsACGfjtDTO7R9Pfy4
         isElT3hkg3jeIIXLVc/NlMv+vvus9tddgAnPqek9YEO6o2N41RQMh/HfiJQF2Q6kH8AV
         7eO9afYNNHWJB25A1NUQm/pT3/GVmdgxAf/QI/NofR+tRTVyrzYrRymHZRxMuPAQEe5+
         D6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBIfrfnr3GLdb1qUMNUHlNu3PuJL3644gLoGb9X9DGQ=;
        b=DMSR4jAQrw6Uu4JP2h+UIIP87Ib375WdmH0WkongbLJKuGj9se8i+ekxx5qoTStG6e
         aikQPsYYluVuIHYCVnw6BXHvKJDx43OJKxK9X7cRZ7ydLfDPIY6o9bYaRU6ww9nThjLK
         brqLglmpJFA5Xuo7iyuKUNiciXkqGdy7H71k+Lu+UtALej0Zr3BKUB+4TNVJoCknoNp6
         R5ty+Ch07ZYgSvxWcQ+98GydbOQmZ18CUQRc39FrIJ+9mvYVAAeWtU0MKLJDa8hZOL/v
         JZN1P6xFQ4gQRvRT3wNg7HnNId+HksSZc4514vbVBkpgjK4pR2bBcJ0idAUtWgs8x7ur
         pXpA==
X-Gm-Message-State: AOAM531io5rebVBMChkaqemRhEcaAry88iPh2dXuXAsWCZWzVh4i+TGD
        h54S/8XFYN56BMamvCC6GFfCkGIrdZ1IOQ==
X-Google-Smtp-Source: ABdhPJzcXNU1oVPwdUqSiPF6gH0piyIBj1KSJz3M+SIp6nsUqMIPwe7Nnh2a4lhVYplw+ffwWGGoOA==
X-Received: by 2002:a05:600c:4e4b:: with SMTP id e11mr12054556wmq.28.1641580092750;
        Fri, 07 Jan 2022 10:28:12 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p62sm4913499wmp.10.2022.01.07.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:28:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND v2 1/3] drm/vkms: refactor overlay plane creation
Date:   Fri,  7 Jan 2022 19:28:07 +0100
Message-Id: <20220107182809.141003-1-jose.exposito89@gmail.com>
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

