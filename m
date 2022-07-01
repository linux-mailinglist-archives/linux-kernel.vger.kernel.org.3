Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D7562F6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiGAJED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGAJD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:03:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF452F005;
        Fri,  1 Jul 2022 02:03:57 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 085B26601995;
        Fri,  1 Jul 2022 10:03:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656666236;
        bh=RmdslR01N1MBAgH0PuAGwuMu+yy8zq6PlP6HQWG4wYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHrfgsTuoRx8kOzlzVaWvklMsHeGG13lF79SxJNVQbDTriU/ELNxzpwemsXd/HJ6N
         tCgqYRHlBxMlkuqLP3wsvalsaUDzYtkehIk70F1HgELnpzz4FiOPyAtyY4y5UswUDN
         yAfyeqq7GMAYr/O9HKsoT/o1xbyv232TpRHF5nPetXV/bIdrNp6Q3ggZZvtcXuVttG
         Eg8Ad61hn6u3fNaXzZdHbQACed/6jgtaBhm55qJoAveWbHXi0f717HOAgAlTlD2G75
         U7x206lJR1eFRFcfFdZcuxuWhuc+VzhdBI/8dKCJrNzOZ7u51CzPwOWOBQgagOvI9I
         rrmFFUrwntThg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Date:   Fri,  1 Jul 2022 12:02:40 +0300
Message-Id: <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
handle imported dma-bufs properly, which results in mapping of something
else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup when
userspace writes to the memory mapping of a dma-buf that was imported into
Tegra's DRM GEM.

Majority of DRM drivers prohibit mapping of the imported GEM objects.
Mapping of imported GEMs require special care from userspace since it
should sync dma-buf because mapping coherency of the exporter device may
not match the DRM device. Let's prohibit the mapping for all DRM drivers
for consistency.

Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c              | 4 ++++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 86d670c71286..fc9ec42fa0ab 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1034,6 +1034,10 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 {
 	int ret;
 
+	/* Don't allow imported objects to be mapped */
+	if (obj->import_attach)
+		return -EINVAL;
+
 	/* Check for valid size. */
 	if (obj_size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ad0e02991ca..6190f5018986 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -609,17 +609,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
  */
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma)
 {
-	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 
-	if (obj->import_attach) {
-		/* Drop the reference drm_gem_mmap_obj() acquired.*/
-		drm_gem_object_put(obj);
-		vma->vm_private_data = NULL;
-
-		return dma_buf_mmap(obj->dma_buf, vma, 0);
-	}
-
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
 		drm_gem_vm_close(vma);
-- 
2.36.1

