Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8053C022
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiFBVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiFBVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A27735253
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654203670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5MolzJKkbnpxmWaLe/FzIP2Xhwby+9gMYBxVEeA6Pk=;
        b=TRzrReUBEUO/q3FQd2w/neJdn6+mMbZ7cCkB1GjKJsCfRrnHkfbl/3RTNxK9oIRGAaHq+u
        UZBdrFYkffiIgxZ/IEyDqz0tG6ckS31zpMUhwQ6BmeCQUWYm1mTVUyFrX/mDQSXe1u281L
        DixxowpiZ74+AbCMzOSy8+NM0Jjzt7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-3pXaGPQYPyiBfbwExNO2rw-1; Thu, 02 Jun 2022 17:01:06 -0400
X-MC-Unique: 3pXaGPQYPyiBfbwExNO2rw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C03080029D;
        Thu,  2 Jun 2022 21:01:06 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.34.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4CA7140240A;
        Thu,  2 Jun 2022 21:01:04 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Hersen Wu <hersenwu@amd.com>,
        Roman Li <Roman.Li@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/amdgpu/dm/mst: Stop grabbing mst_mgr->lock in compute_mst_dsc_configs_for_state()
Date:   Thu,  2 Jun 2022 17:00:54 -0400
Message-Id: <20220602210056.73316-2-lyude@redhat.com>
In-Reply-To: <20220602210056.73316-1-lyude@redhat.com>
References: <20220602210056.73316-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while trying to update amdgpu for the non-atomic MST removal
changes - for some reason we appear to grab mst_mgr->lock before computing
mst DSC configs. This is wrong though - mst_mgr->lock is only needed while
traversing the actual MST topology state - which is not typically something
that DRM drivers should be doing themselves anyway.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9221b6690a4a..cb3b0e08acc4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1056,13 +1056,10 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (!is_dsc_need_re_compute(state, dc_state, stream->link))
 			continue;
 
-		mutex_lock(&aconnector->mst_mgr.lock);
 		if (!compute_mst_dsc_configs_for_link(state, dc_state, stream->link,
 			vars, &link_vars_start_index)) {
-			mutex_unlock(&aconnector->mst_mgr.lock);
 			return false;
 		}
-		mutex_unlock(&aconnector->mst_mgr.lock);
 
 		for (j = 0; j < dc_state->stream_count; j++) {
 			if (dc_state->streams[j]->link == stream->link)
-- 
2.35.3

