Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DA49385C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353647AbiASKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353616AbiASKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:24:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC39C061574;
        Wed, 19 Jan 2022 02:24:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j2so8902592edj.8;
        Wed, 19 Jan 2022 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkuGN1Vnj60Rd4SqRXwo3p9yx1/wd6axZJItw3JdV2k=;
        b=QjRCQfkITJNswVCv4WP2utOD+TASiUHrDW4E/0BRSnF2bndoxWm9TG7jcmj/iP//Jb
         oVd1JUi4DlDUDjqrpuBGtr+QnMgOSRewo+UGFuTjxsuRmO0xvC7it630J6+581UJHj0c
         B+km9Wy2X0IQisS1zYMi19G0R6OgKtLBcXeHevadPO+fdhPpsmG1vr97G6PSzPewN10W
         o800vy+MSF1xeb2CrXlTkwWByGu+cn3mrn0vu0TWG84KO2/KWJ/kvWhudeihpiRo+H/u
         BZlRWMln1cqce3hISefkAA1owntSY+M/KxMg01OFdqub83UzFjNyRlBZUE5eRtHNlVRw
         fjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkuGN1Vnj60Rd4SqRXwo3p9yx1/wd6axZJItw3JdV2k=;
        b=zw2dOgBQcqeokwmy6RsmJA1imGuq1H2j0/g9qdBc+KqGAni8V2wxXKQhR+GjK4kbk+
         xhSk6wKMpnn739Lmf7RvNmedUNdhzNsplJPZ6J5fr7Jn7E4c3Oebeh75IDs2PATvP5zF
         iKuruwmW7TAGtW5EAg37DIs/urJEc2QD080mubGkBV/Qmimy3lmdg8Gw1YceLK67Fg9r
         c+NfmdbUGk/2qcBq4ZG+H79onYSnBzWd25lLDf6GaWcPEJzxOTJsmd7OVWU8BCpojKRj
         U9Uu3IyX1NwUaBtnOCwjMUOvZpH0fX+X20BMkiI6KL+3vpGXnQijZx92BjmIqt6J9es6
         Pknw==
X-Gm-Message-State: AOAM533oIM5uN3I/36BQaXFR2J40567AcCQa8/RC1MzgMdv7jEsQJP7d
        CUHP0nAI18ZKLdUQ8KSl4n7YnAYLWSc=
X-Google-Smtp-Source: ABdhPJzz7piW2gj8TZNGzs1Q3d9+NIMTM4qEqQxe1jsFAfModjFtnvfuwrnq6rZOqzTvAH4KspNzLA==
X-Received: by 2002:a17:906:950e:: with SMTP id u14mr1062606ejx.550.1642587841272;
        Wed, 19 Jan 2022 02:24:01 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b4sm3456546ejb.131.2022.01.19.02.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 02:24:00 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through DMM/TILER
Date:   Wed, 19 Jan 2022 12:23:11 +0200
Message-Id: <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On devices with DMM, all allocations are done through either DMM or TILER.
DMM/TILER being a limited resource means that such allocations will start
to fail before actual free memory is exhausted. What is even worse is that
with time DMM/TILER space gets fragmented to the point that even if we have
enough free DMM/TILER space and free memory, allocation fails because there
is no big enough free block in DMM/TILER space.

Such failures can be easily observed with OMAP xorg DDX, for example -
starting few GUI applications (so buffers for their windows are allocated)
and then rotating landscape<->portrait while closing and opening new
windows soon results in allocation failures.

Fix that by mapping buffers through DMM/TILER only when really needed,
like, for scanout buffers.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 41c1a6d..cf57179 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -821,10 +821,12 @@ int omap_gem_pin(struct drm_gem_object *obj, dma_addr_t *dma_addr)
 			if (ret)
 				goto fail;
 
-			if (priv->has_dmm) {
-				ret = omap_gem_pin_tiler(obj);
-				if (ret)
-					goto fail;
+			if (omap_obj->flags & OMAP_BO_SCANOUT) {
+				if (priv->has_dmm) {
+					ret = omap_gem_pin_tiler(obj);
+					if (ret)
+						goto fail;
+				}
 			}
 		} else {
 			refcount_inc(&omap_obj->pin_cnt);
@@ -861,6 +863,8 @@ static void omap_gem_unpin_locked(struct drm_gem_object *obj)
 			kfree(omap_obj->sgt);
 			omap_obj->sgt = NULL;
 		}
+		if (!(omap_obj->flags & OMAP_BO_SCANOUT))
+			return;
 		if (priv->has_dmm) {
 			ret = tiler_unpin(omap_obj->block);
 			if (ret) {
-- 
1.9.1

