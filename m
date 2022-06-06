Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88AC53EEEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiFFTyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiFFTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:54:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A01FE;
        Mon,  6 Jun 2022 12:54:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so6995670pgc.4;
        Mon, 06 Jun 2022 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U22q+bCY4VehZDY1ro1wKhQ9JA/5THGWTqZ5PD1r04Q=;
        b=MsRh9c98MvoAppDPeqo38Vb739JyYwj+s41ar9mghVqyhGsmukgMPi8IRp/2ifr+/1
         wQUx2lZuy3g5xrM+gAYUS2bNFC3/1WHTkaJmkc6iVqDutQ5aYD6gdfcq+qxJ9r8B77Xl
         MSS2HCpHn+G/A/MNwYJ8UhktBiScFyL6xUiQZnY7PvOCVX9O5HdFIrRqph2pvjgMGBRJ
         G1007ZgbrDnvrFm3gcnAT64XrMDrUTQQG+JSzKGlArdPK5w4NiiM9gzegK8PDTkou/gF
         ej5Oe62IVuk91glANudWjZN9AxhpX9TOaxrB3G8ttEn79cmf3yPfPl1xGyuni1H/xeM/
         9Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U22q+bCY4VehZDY1ro1wKhQ9JA/5THGWTqZ5PD1r04Q=;
        b=wqC/hzxjkxKChEXoJa5nRgs6LKckt8gMjMUBxTLFbm4jWVehFIjq5yUtq3skGTk41g
         KXXOIpJPrQZVZE8tRO2L76dKE4mRqLk4gBkakOon787wivfmKuotrEY8DXluaDhVh4tG
         CNufKs2rHqFP82buN3m+ztUB7Ae9AcpRqDGYfQ3Yky+46pcBZDrDRxBWlx6z80HdKWGn
         aOOJx1ZIVfuFegZIhgLNGz/Ls2hR/3cJ/7MdzIezdpB7WNsKJT/gxU4YGibBXvYwvGYR
         pbj9c9j5c3Ig+4BFyXXiraERU+4qz08UUxUUHF3mfbS+eGIXQlDxa5o1tKOPeQdIRA9B
         xvjg==
X-Gm-Message-State: AOAM530PLgjdi6EOO0a1g/NQulNdP+KWZX4dv8SC7dUF0UDlZQ5tMxWK
        gdNL/wiBvvt8Cw4oXq4uAME=
X-Google-Smtp-Source: ABdhPJyOhQAvqpntmLlHAcjV3qfEg+KW6muhda1YLTUDNbrs9eK1BvjRMgvyNwrpCI/PRLxHSCMoEw==
X-Received: by 2002:a65:64d9:0:b0:3fc:5285:5d63 with SMTP id t25-20020a6564d9000000b003fc52855d63mr22376970pgv.456.1654545266970;
        Mon, 06 Jun 2022 12:54:26 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm4556724plk.275.2022.06.06.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:54:25 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm: Add DRM_GEM_FOPS
Date:   Mon,  6 Jun 2022 12:54:31 -0700
Message-Id: <20220606195432.1888346-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The DEFINE_DRM_GEM_FOPS() helper is a bit limiting if a driver wants to
provide additional file ops, like show_fdinfo().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/drm/drm_gem.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 9d7c61a122dc..dc88d4a2cdf6 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -314,6 +314,23 @@ struct drm_gem_object {
 	const struct drm_gem_object_funcs *funcs;
 };
 
+/**
+ * DRM_GEM_FOPS - Default drm GEM file operations
+ *
+ * This macro provides a shorthand for setting the GEM file ops in the
+ * &file_operations structure.
+ */
+#define DRM_GEM_FOPS \
+	.open		= drm_open,\
+	.release	= drm_release,\
+	.unlocked_ioctl	= drm_ioctl,\
+	.compat_ioctl	= drm_compat_ioctl,\
+	.poll		= drm_poll,\
+	.read		= drm_read,\
+	.llseek		= noop_llseek,\
+	.mmap		= drm_gem_mmap
+
+
 /**
  * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM drivers
  * @name: name for the generated structure
@@ -330,14 +347,7 @@ struct drm_gem_object {
 #define DEFINE_DRM_GEM_FOPS(name) \
 	static const struct file_operations name = {\
 		.owner		= THIS_MODULE,\
-		.open		= drm_open,\
-		.release	= drm_release,\
-		.unlocked_ioctl	= drm_ioctl,\
-		.compat_ioctl	= drm_compat_ioctl,\
-		.poll		= drm_poll,\
-		.read		= drm_read,\
-		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_mmap,\
+		DRM_GEM_FOPS,\
 	}
 
 void drm_gem_object_release(struct drm_gem_object *obj);
-- 
2.36.1

