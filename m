Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787B58978A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiHDFuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiHDFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8840606A8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659592244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cev55DyzC4odc+3YqhUlZqMO2fmB6uB34qSnSGdGLMo=;
        b=iAdopc6NXnL2VLGzaWJN/JqbRKeqEOT6Q2qdwxK+hrg7hpoX9AnimblYjVPJWoG7VcQOPg
        PoeQW6Zz0dT7gs9sc9stV/31KrGkceOm6UZBs8+rRRs0ItOf50HasVjkbK0liQP+xvqi2L
        JQgIh8xGHpNXPyCrbcG6h8GUk0IQYb8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-yscdKHn_MJ6Me-W3PePBzw-1; Thu, 04 Aug 2022 01:50:41 -0400
X-MC-Unique: yscdKHn_MJ6Me-W3PePBzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AB1E1C05AA9;
        Thu,  4 Aug 2022 05:50:41 +0000 (UTC)
Received: from dreadlord.bne.redhat.com (fdacunha.bne.redhat.com [10.64.0.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 505A72166B26;
        Thu,  4 Aug 2022 05:50:39 +0000 (UTC)
From:   Dave Airlie <airlied@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo.Siqueira@amd.com, Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drm/amd/display: restore plane with no modifiers code.
Date:   Thu,  4 Aug 2022 15:50:36 +1000
Message-Id: <20220804055036.691670-1-airlied@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this file was split in

5d945cbcd4b16a29d6470a80dfb19738f9a4319f
Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Date:   Wed Jul 20 15:31:42 2022 -0400

drm/amd/display: Create a file dedicated to planes

This chunk seemed to get dropped. Linus noticed on this
rx580 and I've reproduced on FIJI which makes sense as these
are pre-modifier GPUs.

With this applied, I get gdm back.

Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8cd25b2ea0dc..b841b8b0a9d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1591,6 +1591,9 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
+	if (modifiers == NULL)
+		adev_to_drm(dm->adev)->mode_config.fb_modifiers_not_supported = true;
+
 	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
 				       &dm_plane_funcs, formats, num_formats,
 				       modifiers, plane->type, NULL);
-- 
2.37.1

