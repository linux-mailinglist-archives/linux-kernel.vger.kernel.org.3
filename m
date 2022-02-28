Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B934C77D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiB1Sdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiB1SdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:33:04 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130B25C5D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YR1/jlTZSQPxD81csOAIAfLa4i4Sxv2/d+YrNe2qW7A=; b=mgQm10fUVc9kgc4Wgk3J5S1tEy
        ZVUa9ujYT89jNZnWgbg+tdJuwBTdMkj+8bNxgSeW+YjGu9U95HEFEiPsVx8HpRRUwXJKpSOQIuBoW
        Jll8UiiMU3grQc+McvEtzRjq+gxZQwFXWQKk+F1tl9rqSj8hyf5GD4cPMgvhm9iVJcAqjWtT16qIh
        3uvZlrB1WXoLyRY4wJ062pjDfnfJNui/VQuor4H3YNeAVf6kD9E0Aneyz0n0VEQmrzILEjCyDsJxU
        T4NJtSeRNjnF+dgUEsd/AyEbPxQjzshS4Zx53VgwcJDLtTjUNv4lLw8QVA9blj3CBzO8FuEXA7XV4
        W9R2PLYg==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nOkaE-0003pp-3P; Mon, 28 Feb 2022 19:17:18 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     Jiawei.Gu@amd.com, andrey.grodzovsky@amd.com,
        christian.koenig@amd.com, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: centralize error handling when init scheduler fails
Date:   Mon, 28 Feb 2022 17:16:47 -0100
Message-Id: <20220228181647.3794298-1-mwen@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant error message (since now it is very similar to what
we do in drm_sched_init) and centralize all error handling in a
unique place, as we follow the same steps in any case of failure.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 40 +++++++++++----------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 39459ae96f30..06238e6d7f5c 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -392,34 +392,24 @@ v3d_sched_init(struct v3d_dev *v3d)
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms), NULL,
 			     NULL, "v3d_bin", v3d->drm.dev);
-	if (ret) {
-		dev_err(v3d->drm.dev, "Failed to create bin scheduler: %d.", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = drm_sched_init(&v3d->queue[V3D_RENDER].sched,
 			     &v3d_render_sched_ops,
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms), NULL,
 			     NULL, "v3d_render", v3d->drm.dev);
-	if (ret) {
-		dev_err(v3d->drm.dev, "Failed to create render scheduler: %d.",
-			ret);
-		v3d_sched_fini(v3d);
-		return ret;
-	}
+	if (ret)
+		goto fail;
 
 	ret = drm_sched_init(&v3d->queue[V3D_TFU].sched,
 			     &v3d_tfu_sched_ops,
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms), NULL,
 			     NULL, "v3d_tfu", v3d->drm.dev);
-	if (ret) {
-		dev_err(v3d->drm.dev, "Failed to create TFU scheduler: %d.",
-			ret);
-		v3d_sched_fini(v3d);
-		return ret;
-	}
+	if (ret)
+		goto fail;
 
 	if (v3d_has_csd(v3d)) {
 		ret = drm_sched_init(&v3d->queue[V3D_CSD].sched,
@@ -427,27 +417,23 @@ v3d_sched_init(struct v3d_dev *v3d)
 				     hw_jobs_limit, job_hang_limit,
 				     msecs_to_jiffies(hang_limit_ms), NULL,
 				     NULL, "v3d_csd", v3d->drm.dev);
-		if (ret) {
-			dev_err(v3d->drm.dev, "Failed to create CSD scheduler: %d.",
-				ret);
-			v3d_sched_fini(v3d);
-			return ret;
-		}
+		if (ret)
+			goto fail;
 
 		ret = drm_sched_init(&v3d->queue[V3D_CACHE_CLEAN].sched,
 				     &v3d_cache_clean_sched_ops,
 				     hw_jobs_limit, job_hang_limit,
 				     msecs_to_jiffies(hang_limit_ms), NULL,
 				     NULL, "v3d_cache_clean", v3d->drm.dev);
-		if (ret) {
-			dev_err(v3d->drm.dev, "Failed to create CACHE_CLEAN scheduler: %d.",
-				ret);
-			v3d_sched_fini(v3d);
-			return ret;
-		}
+		if (ret)
+			goto fail;
 	}
 
 	return 0;
+
+fail:
+	v3d_sched_fini(v3d);
+	return ret;
 }
 
 void
-- 
2.34.1

