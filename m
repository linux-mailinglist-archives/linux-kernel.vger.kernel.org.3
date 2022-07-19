Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266A5797D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGSKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiGSKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:40:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EBA2315B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:40:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 4FA0340D403D;
        Tue, 19 Jul 2022 10:40:24 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Surbhi Kakarya <surbhi.kakarya@amd.com>,
        Jack Zhang <Jack.Zhang1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] drm/amdgpu: remove useless condition in amdgpu_job_stop_all_jobs_on_sched()
Date:   Tue, 19 Jul 2022 13:39:54 +0300
Message-Id: <20220719103954.6737-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'rq' is initialized by an address
of field of drm_sched_job, so it does not make
sense to compare 'rq' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 7c6e68c777f1 ("drm/amdgpu: Avoid HW GPU reset for RAS.")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 67f66f2f1809..600401f2a98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -285,10 +285,6 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 	/* Signal all jobs not yet scheduled */
 	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
 		struct drm_sched_rq *rq = &sched->sched_rq[i];
-
-		if (!rq)
-			continue;
-
 		spin_lock(&rq->lock);
 		list_for_each_entry(s_entity, &rq->entities, list) {
 			while ((s_job = to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
-- 
2.25.1

