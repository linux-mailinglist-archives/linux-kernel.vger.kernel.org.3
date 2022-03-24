Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C64E6074
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348968AbiCXIii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCXIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:38:37 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D689BBA4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648111021;
        bh=PdI9M8lLoPowcX452EcX6k9LkvHzZyFe5xCg2aOT5z4=;
        h=From:To:Cc:Subject:Date;
        b=uAm3f1PpNwAXNIu1B3NhmmPeEKikVrfse3dGm7mM9ns70KSv9hXo1upo6Djw6makO
         nKiHvtSr3lJErg2uoD8xZKBg8ONEcsLAOAEsap3FjQPU63FhEf6UexzQCIZdqIyOVn
         wGCXVSqwGIBgUF8ZhXXKY4cs3DuM/T/YR3Yg9UTI=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 9378DC37; Thu, 24 Mar 2022 16:36:55 +0800
X-QQ-mid: xmsmtpt1648111015tha0g0i7j
Message-ID: <tencent_F71D40EE9851737338A6289EC3A3942EFE09@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieiszZ2O+QJKzXzwRb+Wv/lEVxDjwkYxMewJHYJdFQoHsoWu9iam
         ajhSQ1Eh+e59SwWAJQNIolA9hH/lQO4f1IuiJrqh01QGQQ8ynx0vMZGFAxTrWV/nL4TZ50nEHhCA
         PfT6P9/3oSVTf0oUQNZhJhUqNJubqPtVBrsJxit3KUIEdtGymqR2GqkLJrTUzGoAP64J8TY8yV9p
         9T0ViPj0BviZ2jvNNEeO4NHAnnxVRGooB5Smg4EQfAXjHZ+U7NXD9DeDsulbB2O3WsjEMUwmbUX/
         ADBjSHLTH7MBY41RUYPX9dQAZ2Nf+IQGfr4sqwcHe+VpytsaAIb0l8FZdedLnu7owihH7/bB0v9w
         v3e1RXil9eAuCmyr3rNX5QpjaiLmjhYRpbRUNFtpKlT2xwQQxsCDC/myDcvfbciwVlDxBk0aXiIQ
         6QghgDCatQm7ZwMb0INN9vCio1kfph/qKCCfq+BUMpXVtNXVwrPK680hWRBfVJCqkw7acP3mMia3
         Bz+5wCSRUSHuDffpafV3/gPepA0ROFJef9Gsx7s+nxaKpeyIQFRfV0LFUVVYToudcy+3otN+loGR
         TV2OGBWjWfMWM+f8XV5kH6wAGlVxKwqe1uFxN+gqf1S6P+yl890qVRqvI7FjqqQVN/fbXiMgnYpA
         dL+SUIo8JEJqMcDJYmMpiSylhXfa94+qdeFiHGHkpsTgSA1PD9TvU5C9e+4MnNBOolUOFy1IgNT6
         qToKziTVG5vtvfM+IMUbXgPDclAYlMtEC9omhpL+vIOMcjZpQnTE2X8QzS/JTU4yt4gJSPLOaaIG
         zfCgezFDJ2hrNk3bmb9cBHRKhm+JXn48gMqMCAUX9W7Ns4xzoJFz+KnndZsd0gAL886EkEk6H95v
         L5nGvh0HYjfeqSczSXqrYSc2ynJYrR+aWjFCZIHMGI4x4PVR9+kQHOwcZuktExV5xkpTnsxCMYqi
         hfz6C6jwuNs/O3Y468qg==
From:   xkernel.wang@foxmail.com
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] drm/msm/mdp5: check the return of kzalloc()
Date:   Thu, 24 Mar 2022 16:36:44 +0800
X-OQ-MSGID: <20220324083644.2666-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index c6b69af..5f914cc 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -90,15 +90,18 @@ static void mdp5_plane_reset(struct drm_plane *plane)
 		__drm_atomic_helper_plane_destroy_state(plane->state);
 
 	kfree(to_mdp5_plane_state(plane->state));
-	mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
+	plane->state = NULL;
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
-		mdp5_state->base.zpos = STAGE_BASE;
-	else
-		mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
-	mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
+	mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
+	if (mdp5_state) {
+		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
+			mdp5_state->base.zpos = STAGE_BASE;
+		else
+			mdp5_state->base.zpos = STAGE0 + drm_plane_index(plane);
+		mdp5_state->base.normalized_zpos = mdp5_state->base.zpos;
 
-	__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
+		__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
+	}
 }
 
 static struct drm_plane_state *
-- 
