Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA846FA92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhLJGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhLJGQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:16:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9DC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 22:12:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so7611855pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 22:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/LgIoqp+9eCFXsSIrUddR1cUnlEA0gr3FDJwt9FwpB4=;
        b=F/DKMOqCADZ2iys8N9RMtDYqvtaevKIV8kYJyzYWwlm3CrgaNQHO6yt7PgDEiHDMQq
         uuiWG0jnT8jE5egMgW/BwiUqsf8fHa1DOyj50L26Ty+hWnBNh2a30CWPM3rTp6gRYd46
         KdJrc+eZY2R8KoU48ukES6FztFrsS7msrqHRYDm66WVXn5xawk+NG5d67Z6ijoaTMSvg
         kc2U9KVyd/nD427OvpfABNrZ0Nfem/E7jWg9BRMYf8u/6fiCT4wLJHYvlCfVG6yABruU
         JW6m1F6Z2DnYjQxv4fGHiLBKVcJaZ/eboqnQ7WwNGTWrKAYzAJ1K7oTPdaGuviR6/vqG
         ttqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/LgIoqp+9eCFXsSIrUddR1cUnlEA0gr3FDJwt9FwpB4=;
        b=fITfaT4g0JExzhrHCIuR2JSaiCpt1nQL98EvT4rch1vkZRL2sPjJUXRkHM5Yqgvs8V
         Fvsp01DgEXNu3lt8lq+vNp4FpUtRtEUJH7XZYtf/jH68TCyEPHTrH6XK6b/AcUqzwT99
         zBT7HzVxLwZnznbstIs3lz+9PmPWV33O1FiboYTmYehi8tdr2sZ0xx+sELe7hidgfcUS
         AfIw5XJBXCA5AEN6bGOru8TgjQuke4/gWN3+UxkGgJl3fQhztPZgu9sagJy0xM1Q3hWv
         JKWkTg/iAZ5P+BJneQu7XSUcWga3b4vbVi9zT7OxJ/gk0I0mTYgPGxhBWOMaND9wf05l
         /hPw==
X-Gm-Message-State: AOAM5317fXQUJaqmTSC7uqMk28osureFE2gRZdxpFD7dl6szv3uVYl+H
        yUxAjlGmW6exOAEEXZ4uNvk=
X-Google-Smtp-Source: ABdhPJwjyoGaZ8qyg+I7MEr/BNnu9mrOaLLSZfkwqNoALutrr6ljVlILgf7r7M9mA00KxdlS0cTOBw==
X-Received: by 2002:a63:6848:: with SMTP id d69mr36797444pgc.496.1639116745620;
        Thu, 09 Dec 2021 22:12:25 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id i2sm1792234pfg.90.2021.12.09.22.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 22:12:25 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Fix inconsistent object in IS_ERR and PTR_ERR
Date:   Fri, 10 Dec 2021 06:11:48 +0000
Message-Id: <20211210061152.29087-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent object in IS_ERR and PTR_ERR in
igt_dmabuf_import_same_driver and igt_dmabuf_import_same_driver_lmem.
As obj is the return value of __i915_gem_object_create_user,
the proper object to be passed as argument to PTR_ERR is obj.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
index 4a6bb64c3a35..3cc74b0fed06 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
@@ -102,7 +102,7 @@ static int igt_dmabuf_import_same_driver_lmem(void *arg)
 	obj = __i915_gem_object_create_user(i915, PAGE_SIZE, &lmem, 1);
 	if (IS_ERR(obj)) {
 		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
-		       PTR_ERR(dmabuf));
+		       PTR_ERR(obj));
 		err = PTR_ERR(obj);
 		goto out_ret;
 	}
@@ -158,7 +158,7 @@ static int igt_dmabuf_import_same_driver(struct drm_i915_private *i915,
 					    regions, num_regions);
 	if (IS_ERR(obj)) {
 		pr_err("__i915_gem_object_create_user failed with err=%ld\n",
-		       PTR_ERR(dmabuf));
+		       PTR_ERR(obj));
 		err = PTR_ERR(obj);
 		goto out_ret;
 	}
-- 
2.17.1

