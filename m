Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750274777D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhLPQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:16:20 -0500
Received: from foss.arm.com ([217.140.110.172]:45626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239276AbhLPQQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:16:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04DB1435;
        Thu, 16 Dec 2021 08:16:15 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.5.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 515D83F73B;
        Thu, 16 Dec 2021 08:16:14 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/panfrost: Avoid user size passed to kvmalloc()
Date:   Thu, 16 Dec 2021 16:16:03 +0000
Message-Id: <20211216161603.983711-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

panfrost_copy_in_sync() takes the number of fences from user space
(in_sync_count) and used to kvmalloc() an array to hold that number of
fences before processing them. This provides an easy method for user
space to trigger the OOM killer (by temporarily allocating large amounts
of kernel memory) or hit the WARN_ONCE() added by 7661809d493b ("mm:
don't allow oversized kvmalloc() calls").

Since we don't expect there to be a large number of fences we can
instead iterate over the fences one-by-one and avoid the temporary
allocation altogether. This also makes the code simpler.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 44 ++++++++-----------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 96bb5a465627..12ab55e5782c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -186,47 +186,31 @@ panfrost_copy_in_sync(struct drm_device *dev,
 		  struct drm_panfrost_submit *args,
 		  struct panfrost_job *job)
 {
-	u32 *handles;
-	int ret = 0;
-	int i, in_fence_count;
-
-	in_fence_count = args->in_sync_count;
-
-	if (!in_fence_count)
-		return 0;
-
-	handles = kvmalloc_array(in_fence_count, sizeof(u32), GFP_KERNEL);
-	if (!handles) {
-		ret = -ENOMEM;
-		DRM_DEBUG("Failed to allocate incoming syncobj handles\n");
-		goto fail;
-	}
+	int i;
+	u32 __user *user_handles = u64_to_user_ptr(args->in_syncs);
 
-	if (copy_from_user(handles,
-			   (void __user *)(uintptr_t)args->in_syncs,
-			   in_fence_count * sizeof(u32))) {
-		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in syncobj handles\n");
-		goto fail;
-	}
-
-	for (i = 0; i < in_fence_count; i++) {
+	for (i = 0; i < args->in_sync_count; i++) {
 		struct dma_fence *fence;
+		u32 handle;
+		int ret;
+
+		ret = copy_from_user(&handle, user_handles + i,
+				     sizeof(handle));
+		if (ret)
+			return -EFAULT;
 
-		ret = drm_syncobj_find_fence(file_priv, handles[i], 0, 0,
+		ret = drm_syncobj_find_fence(file_priv, handle, 0, 0,
 					     &fence);
 		if (ret)
-			goto fail;
+			return ret;
 
 		ret = drm_sched_job_add_dependency(&job->base, fence);
 
 		if (ret)
-			goto fail;
+			return ret;
 	}
 
-fail:
-	kvfree(handles);
-	return ret;
+	return 0;
 }
 
 static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
-- 
2.30.2

