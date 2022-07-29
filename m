Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4119584A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiG2DHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiG2DH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:07:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16097B78A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:07:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w63-20020a17090a6bc500b001f3160a6011so5224700pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/bj/HFjlvdzWAwaKGeJWan4W18fyurkPYnx0vp3mPEc=;
        b=nWMmGmdPylDPR6IwAxUJE5pDmDKXWhOIw9zoHac472oCO7QIDV6RjVfcz27GK+rofK
         SgNpPGrbkCa5BFz1jrP1JJRJUShhzePJH3DyJu61IOrA28GDpSQZQRHcDu4wQ60JOKko
         5zxhIQlDUv02hTvArGuYB9cdDfcIobG46VY0FZiizcjf7f2ggxPa6Az4LO17OxzvGRK7
         8HPYmLTtwbzu7P7A5ultruEB+okutnyW60rsc76xDJye6L4bq6svQaBQiBSUj0UInJha
         aRSRSoKk30uLIeIqAXRr0LIqbgQjyX5VXNpbxE3/OPTqMoc/7Y9rqi1J0lQcHA+OcCU9
         FGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/bj/HFjlvdzWAwaKGeJWan4W18fyurkPYnx0vp3mPEc=;
        b=KKGCrLXGvgzSNgWqtAuBl+SSQtTvWXYjYYVONdSfV3K2fwj2jQvWetI3XGrDxR+F1d
         fRpuPlpxjURwtQWZgTqJ6v1HW7r8qJJ8Cxl59i4Vr/hDp+hPQ+HfpJEy1IQVd6re49R7
         HZxCnxF8JZOJO3NGzf7HwFoBlreVtNZ/3FROEmQ5iRQ5SAgu0yje6iblaiFVH/edEwnE
         woUwyJGQxbRE2J99iowGAQ7xuph0fr9zGlbhqRw0k+BlHGJofv1bkj4Ubo/zkd+i30YQ
         zda0lYellU8R7P9VQ59mA5P39oVsMIUw+rVRpueIpD89HvRMAgLIRcfWxm/V6cl90Ylx
         thAA==
X-Gm-Message-State: ACgBeo14LHqcSuPCH7/AQht7IiROV4JpcD57mzpNC4LSAwPn3LS17jrj
        oZXw7DofPrkg1bmu0zyAHrQ=
X-Google-Smtp-Source: AA6agR4ARLUAdHCZKXVTOmkIcL9bCDml33KQaHTIyebmEXYgvCJCxVJrMQOd1kpJMPZ190YyyNQ/Dw==
X-Received: by 2002:a17:902:e78f:b0:16c:8741:fea1 with SMTP id cp15-20020a170902e78f00b0016c8741fea1mr1776411plb.89.1659064045282;
        Thu, 28 Jul 2022 20:07:25 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090ab94b00b001f0097c2fb2sm825062pjw.28.2022.07.28.20.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:07:24 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        laurent.pinchart@ideasonboard.com, maxime@cerno.tech,
        ville.syrjala@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] drm/kmb: fix dereference before NULL check in kmb_plane_atomic_update()
Date:   Fri, 29 Jul 2022 11:07:11 +0800
Message-Id: <20220729030711.2117849-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

The "plane" pointer was access before checking if it was NULL.

The drm_atomic_get_old_plane_state() function will dereference
the pointer "plane".
345	struct drm_plane_state *old_plane_state =
		drm_atomic_get_old_plane_state(state, plane);
346	struct drm_plane_state *new_plane_state =
		drm_atomic_get_new_plane_state(state, plane);

A NULL check for "plane" indicates that it may be NULL
363	if (!plane || !new_plane_state || !old_plane_state)

Fixes: 977697e20b3d ("drm/atomic: Pass the full state to planes atomic disable and update")
Fixes: 37418bf14c13 ("drm: Use state helper instead of the plane state pointer")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 2735b8eb3537..d2bc998b65ce 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -342,10 +342,7 @@ static void kmb_plane_set_alpha(struct kmb_drm_private *kmb,
 static void kmb_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
-										 plane);
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
+	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct drm_framebuffer *fb;
 	struct kmb_drm_private *kmb;
 	unsigned int width;
@@ -360,7 +357,13 @@ static void kmb_plane_atomic_update(struct drm_plane *plane,
 	static dma_addr_t addr[MAX_SUB_PLANES];
 	struct disp_cfg *init_disp_cfg;
 
-	if (!plane || !new_plane_state || !old_plane_state)
+	if (!plane)
+		return;
+
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+
+	if (!new_plane_state || !old_plane_state)
 		return;
 
 	fb = new_plane_state->fb;
-- 
2.27.0

