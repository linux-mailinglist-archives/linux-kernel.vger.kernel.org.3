Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FA5B1952
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiIHJwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiIHJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:51:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F7212C489
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:51:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D2401F95E;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662630680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKUXq1jU9fscS0vxvobwVD3laVK0Jy7Al5cuhXXmtfI=;
        b=yjq74h8nwMLjCX9zPVtSvidVKso5T086izRSLJThLbpzx+yK8jsvU/tzW4h21SaDL42zUb
        5GyVWrt7yeyk/+ZHMjCvnTqAMAT1IUe/aw39sI4TcEMYU3FBee24GJI5dT66KjXHLfIbSk
        mnbuiKhpfkUqy/5MSeEOxtaxxIarTVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662630680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKUXq1jU9fscS0vxvobwVD3laVK0Jy7Al5cuhXXmtfI=;
        b=VfkbVJtcyewX9kAP26gH9HfmqMjDzJ7smhLzUpfK52h2LigNtZlr6+ea5wgOeljQcK4trN
        mEx11d0MsUfCf/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C55F13A72;
        Thu,  8 Sep 2022 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EBtzAhi7GWNrUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 09:51:20 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] drm/udl: Pass rectangle directly to udl_handle_damage()
Date:   Thu,  8 Sep 2022 11:51:11 +0200
Message-Id: <20220908095115.23396-9-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908095115.23396-1-tiwai@suse.de>
References: <20220908095115.23396-1-tiwai@suse.de>
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

Just for some code simplification.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index c9b837ac26a7..0142fc6a478a 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -244,14 +244,13 @@ static long udl_log_cpp(unsigned int cpp)
 
 static int udl_handle_damage(struct drm_framebuffer *fb,
 			     const struct iosys_map *map,
-			     int x, int y, int width, int height)
+			     struct drm_rect *clip)
 {
 	struct drm_device *dev = fb->dev;
 	void *vaddr = map->vaddr; /* TODO: Use mapping abstraction properly */
 	int i, ret;
 	char *cmd;
 	struct urb *urb;
-	struct drm_rect clip;
 	int log_bpp;
 
 	ret = udl_log_cpp(fb->format->cpp[0]);
@@ -259,8 +258,6 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 		return ret;
 	log_bpp = ret;
 
-	drm_rect_init(&clip, x, y, width, height);
-
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
 		return ret;
@@ -272,11 +269,11 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 	}
 	cmd = urb->transfer_buffer;
 
-	for (i = clip.y1; i < clip.y2; i++) {
+	for (i = clip->y1; i < clip->y2; i++) {
 		const int line_offset = fb->pitches[0] * i;
-		const int byte_offset = line_offset + (clip.x1 << log_bpp);
-		const int dev_byte_offset = (fb->width * i + clip.x1) << log_bpp;
-		const int byte_width = (clip.x2 - clip.x1) << log_bpp;
+		const int byte_offset = line_offset + (clip->x1 << log_bpp);
+		const int dev_byte_offset = (fb->width * i + clip->x1) << log_bpp;
+		const int byte_width = (clip->x2 - clip->x1) << log_bpp;
 		ret = udl_render_hline(dev, log_bpp, &urb, (char *)vaddr,
 				       &cmd, byte_offset, dev_byte_offset,
 				       byte_width);
@@ -329,6 +326,7 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct udl_device *udl = to_udl(dev);
 	struct drm_display_mode *mode = &crtc_state->mode;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_rect clip;
 	char *buf;
 	char *wrptr;
 	int color_depth = UDL_COLOR_DEPTH_16BPP;
@@ -354,7 +352,8 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	udl->mode_buf_len = wrptr - buf;
 
-	udl_handle_damage(fb, &shadow_plane_state->data[0], 0, 0, fb->width, fb->height);
+	drm_rect_init(&clip, 0, 0, fb->width, fb->height);
+	udl_handle_damage(fb, &shadow_plane_state->data[0], &clip);
 
 	/* enable display */
 	udl_crtc_write_mode_to_hw(crtc);
@@ -396,8 +395,7 @@ udl_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 		return;
 
 	if (drm_atomic_helper_damage_merged(old_plane_state, state, &rect))
-		udl_handle_damage(fb, &shadow_plane_state->data[0], rect.x1, rect.y1,
-				  rect.x2 - rect.x1, rect.y2 - rect.y1);
+		udl_handle_damage(fb, &shadow_plane_state->data[0], &rect);
 }
 
 static const struct drm_simple_display_pipe_funcs udl_simple_display_pipe_funcs = {
-- 
2.35.3

