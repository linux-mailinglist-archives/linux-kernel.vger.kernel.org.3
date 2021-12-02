Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482724660AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356588AbhLBJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:53:24 -0500
Received: from ip-15.mailobj.net ([213.182.54.15]:41192 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356594AbhLBJxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
        t=1638438591; bh=5AYNye91HG3KM5R+EMOmlge/sMVomiHjXI8zrmoDakw=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=df6zoPRfzA+95fbx/z+lRIh9n4BuoagjWbsmbkF1JOC3gBfQCzzvFckyRTOk07isJ
         HSjx05D7kYqs1jUxqIoKFSQrub9uRs/AXWmXPFPhxFV8x7RiDg51yEPKQNf9zsWN4Y
         v6uO8BYnKAnhaCHmsQHfnkxN4oNtxk30SX7xj9TI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu,  2 Dec 2021 10:49:51 +0100 (CET)
X-EA-Auth: c+1XOhLb9gcbnVkVmhvk2gODT2q6LK/aAjHWCbzvxWcluFkOqADERv6ewRzzTu+WZ3S1hOFFRhCWCuimNz452K4NTJ70jlpB
Date:   Thu, 2 Dec 2021 10:49:49 +0100
From:   Claudio Suarez <cssk@net-c.es>
To:     dri-devel@lists.freedesktop.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH] mock a drm_plane in igt_check_plane_state to make the test
 more robust
Message-ID: <YaiWvQESctDMipjh@gineta.localdomain>
References: <YaC7zXW119tlzfVh@gineta.localdomain>
 <20211128142015.GB5295@xsang-OptiPlex-9020>
 <YaUpsaP7hng6zpFh@gineta.localdomain>
 <YaXi803g7iv9MxWR@phenom.ffwll.local>
 <YaiVfZWNyMkG8uED@gineta.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaiVfZWNyMkG8uED@gineta.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

igt_check_plane_state test crashes in drm_atomic_helper_check_plane_state
when trying to de-reference drm_plane_state->plane->dev
due to the lack of a struct drm_plane in the mock struct drm_plane_state.
Since drm_plane_state always should contain a plane, the mock also
needs a plane to be the test more robust and realistic. Add it.

Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 drivers/gpu/drm/selftests/test-drm_plane_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/selftests/test-drm_plane_helper.c
index 0a9553f51796..ceebeede55ea 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_plane_helper.c
@@ -87,11 +87,15 @@ int igt_check_plane_state(void *ignored)
 				DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
 		},
 	};
+	struct drm_plane plane = {
+		.dev = NULL
+	};
 	struct drm_framebuffer fb = {
 		.width = 2048,
 		.height = 2048
 	};
 	struct drm_plane_state plane_state = {
+		.plane = &plane,
 		.crtc = ZERO_SIZE_PTR,
 		.fb = &fb,
 		.rotation = DRM_MODE_ROTATE_0
-- 
2.33.0



