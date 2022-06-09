Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1113545337
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbiFIRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344696AbiFIRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:42:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAA102C;
        Thu,  9 Jun 2022 10:42:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 15so21696773pfy.3;
        Thu, 09 Jun 2022 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgWiYXL1B/uo/ktjENEiT/nk+cuNvwQkS3/PMSJ/gS4=;
        b=qjoxGuk6HMHYik+QoHAomdqEdePsDbMiCxW9iV7oIbqgVxuPNVb9ogB0+RtQqJfIT/
         VozuOSx6bF93V7QDzgHj8ytZfJ5JDUqsc8ZBB0iCgMnzjAUEw23DDo9RF+3HgDltuQLj
         udS6xuqYf+z3fCfU51UiCeGN67eWlvvHjP+1BCYiGebHkC/bCzRFkA9ChS4W0S9OZyA4
         dxHNSoPmjH9OITDsxriW9sGe8nzM4slf4z8mjMRq+4SobAiGBK+gVpwrxuupqxRRJuST
         h6Tc/VSfLhMMjg2dEb8H9hfl4EWTwgyhi6C5TanSlEJBuX+ZHFNewvL1TdIz+MehU5G1
         Nebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgWiYXL1B/uo/ktjENEiT/nk+cuNvwQkS3/PMSJ/gS4=;
        b=lcJFRCmK47MrQyA3B0gcnU/NTPsxqY6DF7MvJEkq0Uz4JfntSoyZGXg3hLkVAgiLxB
         37Nc2XVHe3XhWxDX0DwkKNTkOZBH7xsi74NsVvUhJ+bfg14r9QJpnEt/CWDuPuPt1MVF
         IsuC6cenCqOoVz6ph4OtzvT2TfzJMyVLXCe7tR0mUbN03Tt7hZ3UNuaXRStroPKn6FKr
         aFm8sH/eEIrzhy6rceieRf+LwGBOZNUMXV9sphVs7yYAFC+vKQycELe6XM4nxNaxt83J
         8hu5Pj7yBPT0NO4Fue0B6fMfsI6m8nJjeqdufs2c0+5eY/VU1CqK05Jf2mr9j4ylEAqH
         wN1A==
X-Gm-Message-State: AOAM532HEFvUam4rVrsIcWTI5tq/+ror4fRzBf+Dq/ew62DFZOHByN93
        Y0JEtga/eJP4fbC33I/CUAE=
X-Google-Smtp-Source: ABdhPJzQGGfcdelkMUHlTzDatlp7MOnQu81Dg9YLAo3PCkW1cvlc9qYNvkdRn2FBLo/G2ojvbQB6jw==
X-Received: by 2002:aa7:92d2:0:b0:51b:4d60:6475 with SMTP id k18-20020aa792d2000000b0051b4d606475mr56425406pfa.73.1654796524151;
        Thu, 09 Jun 2022 10:42:04 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7904c000000b005187eb4194esm11387900pfo.118.2022.06.09.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:42:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] drm: Add DRM_GEM_FOPS
Date:   Thu,  9 Jun 2022 10:42:11 -0700
Message-Id: <20220609174213.2265938-1-robdclark@gmail.com>
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

v2: Split out DRM_GEM_FOPS instead of making DEFINE_DRM_GEM_FOPS
    varardic
v3: nits

Signed-off-by: Rob Clark <robdclark@chromium.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 9d7c61a122dc..87cffc9efa85 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -314,6 +314,23 @@ struct drm_gem_object {
 	const struct drm_gem_object_funcs *funcs;
 };
 
+/**
+ * DRM_GEM_FOPS - Default drm GEM file operations
+ *
+ * This macro provides a shorthand for setting the GEM file ops in the
+ * &file_operations structure.  If all you need are the default ops, use
+ * DEFINE_DRM_GEM_FOPS instead.
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

