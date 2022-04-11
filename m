Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D04FC74A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348815AbiDKWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350298AbiDKWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917726C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 4CB891F43C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649714439;
        bh=ZY21VcCnt1KZ/SFvuhi1MrKpSE1xXyIn448Zho4m5n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQqrK5tFQhoASlfAkhuQPuI9Tnwja1en0GJe/AeFWiWRfYkDYoGp151oCil/a2KXS
         zZavlr2NIQ/mOUxKCg7Ci1rUYaU3TvzDG0D5sMZPSV6vZqJj2DszrdHUFmecOft4uk
         ck6KRrFoCUDdhhmwfdqlP4A1m4YSQOqwDOwldB7a+yAKEaRSxI3O/nkjFO2NLn2PDI
         /qzGt4C01zbpZA8224csl0EkAluE79l1C4T6pyuvaLf269BGtSPx11dQEv/KWEgb0F
         u6TXdJzYtVwDxmxGWEQezSFbkH0/PI4/dF155JtfQwjlnJdsMaYrBenEOX2fg9PhFz
         QqvvuGdl8SBvw==
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
Subject: [PATCH v3 14/15] drm/shmem-helper: Make drm_gem_shmem_get_pages() private
Date:   Tue, 12 Apr 2022 00:59:36 +0300
Message-Id: <20220411215937.281655-15-dmitry.osipenko@collabora.com>
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

VirtIO-GPU driver was the only user of drm_gem_shmem_get_pages()
and it now uses drm_gem_shmem_get_pages_sgt(). Make the get_pages()
private to drm_gem_shmem_helper.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +--
 include/drm/drm_gem_shmem_helper.h     | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7e4851363d14..8e31056575e3 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -538,7 +538,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
 
@@ -555,7 +555,6 @@ int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_gem_shmem_get_pages);
 
 static void drm_gem_shmem_get_pages_no_fail(struct drm_gem_shmem_object *shmem)
 {
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index dc1c2db7d095..7284335ea2c9 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -144,7 +144,6 @@ struct drm_gem_shmem_object {
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
-int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
-- 
2.35.1

