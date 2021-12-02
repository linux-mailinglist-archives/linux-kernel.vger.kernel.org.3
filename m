Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89374660B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356639AbhLBJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:55:52 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:32868 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356695AbhLBJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
        t=1638438675; bh=5f/DPkMqinmPlh73ZX8ZjV8oWSQFvI1Ht0rbZIgEoTU=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=m4xkznXL5BtxZv6snz0bnTbM6TebEMl35MrLAeN0vr4U8KdsbHHIgnEM2z1XXjU1Z
         QK+o1teqMdATJD3pIZTXzYil+JM2TpIewjIV2WVfm7mpZD2bq/JZu6aoPLVYszWnGV
         5HFI+BND1F4LyXz/rK4zwzYvoI5vp/ovZwneV0Uo=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu,  2 Dec 2021 10:51:15 +0100 (CET)
X-EA-Auth: zwDcSDH3gM9QCabbJenKZLmeMYMU/i70KfPag2vOU2PNbUJjENWd7AGNzkzoEKBP35p9gN+5cDv02lWTEFT4Xto9e7cBiGo3
Date:   Thu, 2 Dec 2021 10:51:12 +0100
From:   Claudio Suarez <cssk@net-c.es>
To:     dri-devel@lists.freedesktop.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2] drm: fix error found in some cases after the patch
 d1af5cd86997
Message-ID: <YaiXEARd8z2C463h@gineta.localdomain>
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

The patch d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log
calls in drm core, files drm_a*.c") fails when the drm_device
cannot be found in the parameter plane_state->crtc.
Fix it using plane_state->plane.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log calls in drm core, files drm_a*.c")
Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index aef2fbd676e5..a7a05e1e26bb 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -828,8 +828,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
 	}
 
 	if (!crtc_state->enable && !can_update_disabled) {
-		drm_dbg_kms(plane_state->crtc->dev,
-			       "Cannot update plane of a disabled CRTC.\n");
+		drm_dbg_kms(plane_state->plane->dev,
+			    "Cannot update plane of a disabled CRTC.\n");
 		return -EINVAL;
 	}
 
@@ -839,8 +839,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
 	hscale = drm_rect_calc_hscale(src, dst, min_scale, max_scale);
 	vscale = drm_rect_calc_vscale(src, dst, min_scale, max_scale);
 	if (hscale < 0 || vscale < 0) {
-		drm_dbg_kms(plane_state->crtc->dev,
-			       "Invalid scaling of plane\n");
+		drm_dbg_kms(plane_state->plane->dev,
+			    "Invalid scaling of plane\n");
 		drm_rect_debug_print("src: ", &plane_state->src, true);
 		drm_rect_debug_print("dst: ", &plane_state->dst, false);
 		return -ERANGE;
@@ -864,8 +864,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
 		return 0;
 
 	if (!can_position && !drm_rect_equals(dst, &clip)) {
-		drm_dbg_kms(plane_state->crtc->dev,
-			       "Plane must cover entire CRTC\n");
+		drm_dbg_kms(plane_state->plane->dev,
+			    "Plane must cover entire CRTC\n");
 		drm_rect_debug_print("dst: ", dst, false);
 		drm_rect_debug_print("clip: ", &clip, false);
 		return -EINVAL;
-- 
2.33.0



