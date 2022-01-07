Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6B487C31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiAGS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiAGS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:28:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:28:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c66so4500457wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/cIP//uzFRFV87jVN39f0dog6UQJqLvS7DxqTem8FA=;
        b=omF6CXERZiso6S/q+xBfFG4E6S/jaE5rhg2lyaB1S0VsuJykXq2QgUaB5S1UQAJqtB
         oECLCGvRwZoytXrxX2PyxZFavqhxT2aTAlIDOUOtmvY5K+3r3Vyt5usx6LZXuJOSpFLq
         GDM1clQaRGsLAC08w8hhuTKV+JNvEgBpVo1q29+LprgQvraZVP/qA3j5q8CNTzK7mrxl
         HP+VctVlrDjf3X+wdeHTldpAaURkah2hCUw9IfXGMAE96voKDMG+VcvzOxljJSbIFtv7
         GZm+TChh7JheMXrgOMEw7+3fuSQS0+CodckyVpLpMaaagvJ83sC4zk2SkpiIAQc2Stqv
         GFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/cIP//uzFRFV87jVN39f0dog6UQJqLvS7DxqTem8FA=;
        b=vyf+2+g6DKefQ9ZCyf1+MvJPfbR88vyodf1OlPMPzv/yF5jtgueHTbT/8iNu3Ss7JK
         8b3Z2G1ApFbvhmaA2ul/GoRmsIsqxVSWYIeh1p3cMeNrDYo6fXnnLcm3RW/1J4HGLjV5
         toOf2ujbTUqJPHqkwpWNKudMOEF9Lqx1sjiQlSvXaqJOkuhKqM5lU7eSAo4AoUi9ERYW
         esaEHrVDr4QB0ryXXF/WMKy8yvvUiZ/dmAxvAIbb1BvRjDtTCDod28SB37evnOzxBrQN
         Vf9klS9H+dIzFMgtr+CFEEHuoKG2kaQ8ivy7Upy8aAxcdU7pb2+nI8gnW0zXIMzbhhaU
         fQzA==
X-Gm-Message-State: AOAM5330Rw6EKwENM9d1key2EDSC6s7jbwJ3j1EeWR1ES+c29kQCVOrv
        IELmNvwTyPJZKVMmdji6+Ns=
X-Google-Smtp-Source: ABdhPJzgi0ea+eTwdq3v8ZTeIM8py3U0zCuqsI7NW7v8/Iaophy4AcWFjxE+mAZuZRI3V4JPClnmWg==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr1706234wmj.182.1641580093982;
        Fri, 07 Jan 2022 10:28:13 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p62sm4913499wmp.10.2022.01.07.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:28:13 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND v2 2/3] drm/vkms: add support for multiple overlay planes
Date:   Fri,  7 Jan 2022 19:28:08 +0100
Message-Id: <20220107182809.141003-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107182809.141003-1-jose.exposito89@gmail.com>
References: <20220107182809.141003-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create 8 overlay planes instead of 1 when the "enable_overlay" module
parameter is set.

The following igt-gpu-tools tests were executed without finding
regressions. Notice than the numbers are identical:

                    |     master branch     |      this  patch      |
                    | SUCCESS | SKIP | FAIL | SUCCESS | SKIP | FAIL |
 kms_atomic         |      10 |   02 |   00 |      10 |   02 |   00 |
 kms_plane_cursor   |      09 |   45 |   00 |      09 |   45 |   00 |
 kms_plane_multiple |      01 |   23 |   00 |      01 |   23 |   00 |
 kms_writeback      |      04 |   00 |   00 |      04 |   00 |   00 |

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2:

 - Set the number of overlay planes as a constant instead of as a
   module parameter (Melissa Wen)

 - Add a test results in the commit message (Melissa Wen)
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
 drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d48c23d40ce5..9496fdc900b8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -20,6 +20,8 @@
 #define XRES_MAX  8192
 #define YRES_MAX  8192
 
+#define NUM_OVERLAY_PLANES 8
+
 struct vkms_writeback_job {
 	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
 	struct dma_buf_map data[DRM_FORMAT_MAX_PLANES];
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2e805b2d36ae..ba0e82ae549a 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -57,15 +57,18 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct vkms_plane *primary, *cursor = NULL;
 	int ret;
 	int writeback;
+	unsigned int n;
 
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
 	if (vkmsdev->config->overlay) {
-		ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
-		if (ret)
-			return ret;
+		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
+			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (vkmsdev->config->cursor) {
-- 
2.25.1

