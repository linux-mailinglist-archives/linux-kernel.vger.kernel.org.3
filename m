Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C64FC741
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiDKWEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350312AbiDKWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15BC11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id EC8301F43C7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649714441;
        bh=qFt9ZOB1/K3f6j95e83uUTQsFAU8GObxCwVCXrvjk/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LREqFUxnsMN90DJgwmRZ7u6JNL5myGlW9jIG6varDOlXyjxoaIFSYimM5MxRzygAs
         O5Ad1UoO1cqMO/unKfXTrk0zWOzrvi7HFGS6s9j7NcVoWJRsglcuvuR6VnXn72aTv0
         i3GQ9LjparoI7L4PfLG7Wr7/lDzzuNBKUQkT88gyQUKvIOVNoGX+ShAUb/as4Hjofr
         cqOagGFMIymj9mocJaqElqqKfJOfxJnRFRxEx4iZwdggA+c5OLZiXw9VmKlqwvtU+G
         Mfi/xgnauguU7GFoNm3sbg1XfVkaAwLnwwIrUiIfcYMWJRVTiz/GIZfJaXlZPIZA1w
         LitM6cQ0nyYgg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v3 15/15] drm/shmem-helper: Remove drm_gem_shmem_purge()
Date:   Tue, 12 Apr 2022 00:59:37 +0300
Message-Id: <20220411215937.281655-16-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
References: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_gem_shmem_purge() was added back in 2019 and never had a user
since then. GEM's purging is now managed by the generic shrinker and
only the "locked" variant of the function is wanted. Remove the obsoleted
function.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 11 -----------
 include/drm/drm_gem_shmem_helper.h     |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8e31056575e3..89c64053247c 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -992,17 +992,6 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL(drm_gem_shmem_purge_locked);
 
-bool drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
-{
-	if (!dma_resv_trylock(shmem->base.resv))
-		return false;
-	drm_gem_shmem_purge_locked(shmem);
-	dma_resv_unlock(shmem->base.resv);
-
-	return true;
-}
-EXPORT_SYMBOL(drm_gem_shmem_purge);
-
 /**
  * drm_gem_shmem_dumb_create - Create a dumb shmem buffer object
  * @file: DRM file structure to create the dumb buffer for
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 7284335ea2c9..197d08452974 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -179,8 +179,6 @@ int drm_gem_shmem_swap_in_pages_locked(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_swap_in_locked(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_evict_locked(struct drm_gem_shmem_object *shmem);
-
-bool drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
 
 struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
-- 
2.35.1

