Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C04B7830
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbiBOQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiBOQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:52:46 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4639D4EA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:52:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by laurent.telenet-ops.be with bizsmtp
        id vUsV2600L18GbK101UsV5W; Tue, 15 Feb 2022 17:52:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-000tUn-TQ; Tue, 15 Feb 2022 17:52:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-00BURk-0u; Tue, 15 Feb 2022 17:52:28 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/8] drm/client: Use actual bpp when allocating frame buffers
Date:   Tue, 15 Feb 2022 17:52:22 +0100
Message-Id: <20220215165226.2738568-5-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215165226.2738568-1-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a frame buffer, the number of bits per pixel needed is
derived from the deprecated drm_format_info.cpp[] field.  While this
works for formats using less than 8 bits per pixel, it does lead to a
large overallocation.

Reduce memory consumption by using the actual number of bits per pixel
instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/drm/drm_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index ce45e380f4a2028f..c6a279e3de95591a 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -264,7 +264,7 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 
 	dumb_args.width = width;
 	dumb_args.height = height;
-	dumb_args.bpp = info->cpp[0] * 8;
+	dumb_args.bpp = drm_format_info_bpp(info, 0);
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		goto err_delete;
@@ -372,7 +372,7 @@ static int drm_client_buffer_addfb(struct drm_client_buffer *buffer,
 	int ret;
 
 	info = drm_format_info(format);
-	fb_req.bpp = info->cpp[0] * 8;
+	fb_req.bpp = drm_format_info_bpp(info, 0);
 	fb_req.depth = info->depth;
 	fb_req.width = width;
 	fb_req.height = height;
-- 
2.25.1

