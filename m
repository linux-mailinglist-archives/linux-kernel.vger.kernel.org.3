Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5856C276
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiGHThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbiGHTha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:37:30 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79956D543
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:37:29 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9tn4oHtmUEhCQ9tn4okZcQ; Fri, 08 Jul 2022 21:37:28 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 21:37:28 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vc4: Use the bitmap API to allocate bitmaps
Date:   Fri,  8 Jul 2022 21:37:25 +0200
Message-Id: <fdc12cbbb573482ce5a4f344b3a31bc9b6ef2ec1.1657309035.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index e315aeb5fef5..d074d2014be4 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -795,9 +795,8 @@ vc4_validate_shader(struct drm_gem_cma_object *shader_obj)
 
 	reset_validation_state(&validation_state);
 
-	validation_state.branch_targets =
-		kcalloc(BITS_TO_LONGS(validation_state.max_ip),
-			sizeof(unsigned long), GFP_KERNEL);
+	validation_state.branch_targets = bitmap_zalloc(validation_state.max_ip,
+							GFP_KERNEL);
 	if (!validation_state.branch_targets)
 		goto fail;
 
@@ -939,12 +938,12 @@ vc4_validate_shader(struct drm_gem_cma_object *shader_obj)
 		(validated_shader->uniforms_size +
 		 4 * validated_shader->num_texture_samples);
 
-	kfree(validation_state.branch_targets);
+	bitmap_free(validation_state.branch_targets);
 
 	return validated_shader;
 
 fail:
-	kfree(validation_state.branch_targets);
+	bitmap_free(validation_state.branch_targets);
 	if (validated_shader) {
 		kfree(validated_shader->uniform_addr_offsets);
 		kfree(validated_shader->texture_samples);
-- 
2.34.1

