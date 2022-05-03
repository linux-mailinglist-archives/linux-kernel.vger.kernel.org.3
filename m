Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7F51836A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiECLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiECLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:46:52 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 04:43:17 PDT
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED91F617
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:43:17 -0700 (PDT)
Received: (qmail 5983 invoked by uid 990); 3 May 2022 11:36:34 -0000
Authentication-Results: read.uberspace.de;
        auth=pass (plain)
From:   Florian Rommel <mail@florommel.de>
To:     airlied@linux.ie, daniel@ffwll.ch, ray.huang@amd.com,
        akpm@linux-foundation.org
Cc:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, Florian Rommel <mail@florommel.de>
Subject: [PATCH] mmap locking API: Fix missed mmap_sem references in comments
Date:   Tue,  3 May 2022 13:33:33 +0200
Message-Id: <20220503113333.214124-1-mail@florommel.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999)
X-Rspamd-Score: -1.599999
Received: from unknown (HELO unkown) (::1)
        by read.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 03 May 2022 13:36:34 +0200
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1e8d7c6a7a6 ("mmap locking API: convert mmap_sem comments") missed
replacing some references of mmap_sem by mmap_lock due to misspelling
(mm_sem instead of mmap_sem).

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                   | 2 +-
 mm/mmap.c                                         | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 65552bb7d2f2..e83cb1c09610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -184,7 +184,7 @@ static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	/* read_user_ptr may take the mm->mmap_lock.
 	 * release srbm_mutex to avoid circular dependency between
-	 * srbm_mutex->mm_sem->reservation_ww_class_mutex->srbm_mutex.
+	 * srbm_mutex->mmap_lock->reservation_ww_class_mutex->srbm_mutex.
 	 */
 	release_queue(adev);
 	valid_wptr = read_user_wptr(mm, wptr, wptr_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 9dc5f2a0cc07..870f352837fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -208,7 +208,7 @@ static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	/* read_user_ptr may take the mm->mmap_lock.
 	 * release srbm_mutex to avoid circular dependency between
-	 * srbm_mutex->mm_sem->reservation_ww_class_mutex->srbm_mutex.
+	 * srbm_mutex->mmap_lock->reservation_ww_class_mutex->srbm_mutex.
 	 */
 	release_queue(adev);
 	valid_wptr = read_user_wptr(mm, wptr, wptr_val);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 5b324f245265..38119311284d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -102,7 +102,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
  * @bo: The buffer object
  * @vmf: The fault structure handed to the callback
  *
- * vm callbacks like fault() and *_mkwrite() allow for the mm_sem to be dropped
+ * vm callbacks like fault() and *_mkwrite() allow for the mmap_lock to be dropped
  * during long waits, and after the wait the callback will be restarted. This
  * is to allow other threads using the same virtual memory space concurrent
  * access to map(), unmap() completely unrelated buffer objects. TTM buffer
diff --git a/mm/mmap.c b/mm/mmap.c
index d7e120ad5825..7f7d982721b9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1285,7 +1285,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
  * the same as 'old', the other will be the new one that is trying
  * to share the anon_vma.
  *
- * NOTE! This runs with mm_sem held for reading, so it is possible that
+ * NOTE! This runs with mmap_lock held for reading, so it is possible that
  * the anon_vma of 'old' is concurrently in the process of being set up
  * by another page fault trying to merge _that_. But that's ok: if it
  * is being set up, that automatically means that it will be a singleton
@@ -1299,7 +1299,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
  *
  * We also make sure that the two vma's are compatible (adjacent,
  * and with the same memory policies). That's all stable, even with just
- * a read lock on the mm_sem.
+ * a read lock on the mmap_lock.
  */
 static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_area_struct *a, struct vm_area_struct *b)
 {
-- 
2.36.0

