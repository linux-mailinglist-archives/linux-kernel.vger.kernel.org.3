Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806E589788
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiHDFui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiHDFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFBEA564DF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659592234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cev55DyzC4odc+3YqhUlZqMO2fmB6uB34qSnSGdGLMo=;
        b=g+7HwM+wLY02k+xOf7EyLCNvMFrsjdRUjPe5oW85lwe1pqPTmtOmMVRejid+nI42srxiAs
        PsiqfrhG8oUoqgBzudzwSIfzrXEaPOoWPHmixtywohINhwPio30VWOYl0PKtPyUMcvVMjG
        B9c+D86PIDl0s8NVMUBdchZsMhdzGyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-xLw5-T0PN7S3FRc7P6Pr9g-1; Thu, 04 Aug 2022 01:50:25 -0400
X-MC-Unique: xLw5-T0PN7S3FRc7P6Pr9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D74F101A54E;
        Thu,  4 Aug 2022 05:50:24 +0000 (UTC)
Received: from dreadlord.bne.redhat.com (fdacunha.bne.redhat.com [10.64.0.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD38B2166B26;
        Thu,  4 Aug 2022 05:50:22 +0000 (UTC)
From:   Dave Airlie <airlied@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.sf.net,
        Rodrigo.Siqueira@amd.com, Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drm/amd/display: restore plane with no modifiers code.
Date:   Thu,  4 Aug 2022 15:50:20 +1000
Message-Id: <20220804055020.691656-1-airlied@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

