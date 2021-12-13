Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5D4733B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhLMSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbhLMSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso11382631wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L26QAQQcTwvk9g4RJGDyk1KPZJQ2+Mcn67zF6WZ46Tk=;
        b=nwMF68xQhLMQiy7BGFuGPjIv1QBzKA/WhAhJ5WVxTQi/YF71dqNQ93w/BLlNfP/5/w
         6He4QIGp5qN95RSQoEqSqTbKIHcKp+4xnxs9wtYlEOuCgfUJp8D8trc1vKNJhTFC7/eC
         hROi9dKHCth6SXl8/Dlzufy+j4DoWYxdyw3FfiD/23O+7ogooJK4h+vy6dSvNCIZegM9
         BYES8GOewV+blDJxwRfIl8qw8gCop8ECuJ81EJv1PuOVXr5A3G8pvS/sRoOt9ZEdWTcM
         VCEZqjTX6yAFSSPZIzd1YaTXUGYaXwp/PNgDC3uuLcJZ3iX4XT+oBWsdTekYUWRg7V1Y
         IFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L26QAQQcTwvk9g4RJGDyk1KPZJQ2+Mcn67zF6WZ46Tk=;
        b=Cu422kTEe/LxmJOGEVxrhcsr7wce9kvh5/QRiyXVEJyU/g16J9BB5qVrBPcHHUugXo
         ucOAs5s2j+X32wRxy4O93BnLE2dgiluYMrhMPoCCEXftTQF3U74h2bo+NfoJQmpPIV4T
         B/AIFrAUL4JbyEo2GXxGNwefZUbwNW6YUJKz16jA0DTejeSGj3fyCdJR1xZpkcuDkzv7
         ZNveguMubo5i0zufyALTplJrc9rK11yi8dwC3Bv7bKSlKDa+Fg6GsDIT/SQQYGcnTz+B
         SeljqT8S5OnV4WonOMo+fS+CS349FPn4uyjIidGppZ5dgzj3gnAuyCB9xKwh8h+T/iXL
         4yBA==
X-Gm-Message-State: AOAM5325Z3CdgAj6O/Bn3gui2WgI5qIZKsoRQAHo+EQvrHct++Wij0mK
        Rg9TYFqDi6V+5MvjrHbGFWA=
X-Google-Smtp-Source: ABdhPJxvheQ548tVU0F3sUfSNeeyzYRs2JPHAldsQSo1hKrHqAEVEVgrIqC9DKXrXlsUPoOeDKMzHA==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr335168wmc.56.1639419100775;
        Mon, 13 Dec 2021 10:11:40 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id t127sm8750956wma.9.2021.12.13.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:11:40 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 2/3] drm/vkms: add support for multiple overlay planes
Date:   Mon, 13 Dec 2021 19:11:30 +0100
Message-Id: <20211213181131.17223-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213181131.17223-1-jose.exposito89@gmail.com>
References: <20211213181131.17223-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new module parameter to allow to set the number of overlay planes
to create. Set it to 1 by default in order to keep the "enable_overlay"
backwards compatible.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 5 +++++
 drivers/gpu/drm/vkms/vkms_drv.h    | 1 +
 drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 0ffe5f0e33f7..bb98f6c6c561 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -51,6 +51,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static unsigned int num_overlay_planes = 1;
+module_param_named(num_overlay_planes, num_overlay_planes, uint, 0444);
+MODULE_PARM_DESC(num_overlay_planes, "Number of overlay planes to create");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
@@ -229,6 +233,7 @@ static int __init vkms_init(void)
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
 	config->overlay = enable_overlay;
+	config->num_overlay_planes = num_overlay_planes;
 
 	return vkms_create(config);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d48c23d40ce5..33bdf717e3cd 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -97,6 +97,7 @@ struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
+	unsigned int num_overlay_planes;
 	/* only set when instantiated */
 	struct vkms_device *dev;
 };
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2e805b2d36ae..6f26998fdb7e 100644
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
+		for (n = 0; n < vkmsdev->config->num_overlay_planes; n++) {
+			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (vkmsdev->config->cursor) {
-- 
2.25.1

