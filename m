Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59A59A93E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiHSXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiHSXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87263C7B94
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLZfq6WypLg+PIKaSCfWFhdUOS8zDvxPUxnHNhKzURQ=;
        b=JJckpCDRtd3eAtZcJTCcnMblUOLi2J8IBG6t2DpM6DqiQPLiVz1fkoAJlESEzxEBuChExQ
        eHBgh2X/YQg5+7C/BE1bHzlUNM4H7eopd5LUXkjMjhtrWMY2rM1CrSHwF2MeWuTlsK9h+w
        TuUlbZQkArHDIVeQ1vxCp0AIExvmi9c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-dJKUwvnHP9S9DVqZcY_fUw-1; Fri, 19 Aug 2022 19:11:18 -0400
X-MC-Unique: dJKUwvnHP9S9DVqZcY_fUw-1
Received: by mail-ej1-f69.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so1952387ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dLZfq6WypLg+PIKaSCfWFhdUOS8zDvxPUxnHNhKzURQ=;
        b=5/hjeMu9/5Cm7SCTcuR7j18W2kTgyaoXd1wK3GiURCTBsPDTaa2rq9luPqGD4SZoU5
         1SlJykxBbQZCoOA89cU7cBo0m1yG0kSHvZf0CguJ6WWj0lYk9zqGyYK+z16q133JV6G5
         315yZC0wOU2YtYsaCS3d3Gt82XxzEwZ+H1/7V9Z9Dm24gVKYodnNvhtFwAHF8pP1MR8I
         LZjliRoKB1CBg4ZSitz3+FbxkDbHwBTFqtYhBFWaMFDu+OnkmAY/y6/pkpFmcHcWmBm9
         aMOzadPOcndwXSg7l398mXIySoJj49VJS2FyDz1jC0+Mhjk0gZMNB3wYMsjgTOvuRK4v
         2npA==
X-Gm-Message-State: ACgBeo0nibkAs1KE2NJ5Y6D9ZTt2lqLGeqMs7lVCLVohcSBMrf4glc/7
        E2x/v5cC1eIxyXqmkPNc5JXRxWsmx5E+8JCZofuaDWaPXJZOawLBbO8oKvqLuqaOVTiot7QsMoD
        HUl0DeY4F+XYtZn7hQo4iRssz
X-Received: by 2002:a05:6402:e86:b0:440:d1be:20c7 with SMTP id h6-20020a0564020e8600b00440d1be20c7mr7754762eda.349.1660950677278;
        Fri, 19 Aug 2022 16:11:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7JSK2TMkoebbHT5LMUu2crmMcWGvQOKm5f0GW7UmQ4oCu69y9RiVIrSgGRUCD1OxOpCrbX3g==
X-Received: by 2002:a05:6402:e86:b0:440:d1be:20c7 with SMTP id h6-20020a0564020e8600b00440d1be20c7mr7754751eda.349.1660950677134;
        Fri, 19 Aug 2022 16:11:17 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090694c500b00734bfab4d59sm2923078ejy.170.2022.08.19.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:16 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 6/7] drm/arm/hdlcd: crtc: protect device resources after removal
Date:   Sat, 20 Aug 2022 01:10:57 +0200
Message-Id: <20220819231058.647658-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 49 ++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 17d3ccf12245..bfc42d4a53c2 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -18,6 +18,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
@@ -39,27 +40,47 @@
 static void hdlcd_crtc_cleanup(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
 
 	/* stop the controller on cleanup */
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
+
+	drm_dev_exit(idx);
 }
 
 static int hdlcd_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+	unsigned int mask;
+	int idx;
 
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return -ENODEV;
+
+	mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
 	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask | HDLCD_INTERRUPT_VSYNC);
 
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
 static void hdlcd_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+	unsigned int mask;
+	int idx;
 
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
 	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask & ~HDLCD_INTERRUPT_VSYNC);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_funcs hdlcd_crtc_funcs = {
@@ -170,21 +191,33 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_atomic_state *state)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
 
 	clk_prepare_enable(hdlcd->clk);
 	hdlcd_crtc_mode_set_nofb(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
 	drm_crtc_vblank_on(crtc);
+
+	drm_dev_exit(idx);
 }
 
 static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
 				      struct drm_atomic_state *state)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
 
 	drm_crtc_vblank_off(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
 	clk_disable_unprepare(hdlcd->clk);
+
+	drm_dev_exit(idx);
 }
 
 static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
@@ -192,6 +225,10 @@ static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 	long rate, clk_rate = mode->clock * 1000;
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return MODE_NOCLOCK;
 
 	rate = clk_round_rate(hdlcd->clk, clk_rate);
 	/* 0.1% seems a close enough tolerance for the TDA19988 on Juno */
@@ -200,6 +237,8 @@ static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
 		return MODE_NOCLOCK;
 	}
 
+	drm_dev_exit(idx);
+
 	return MODE_OK;
 }
 
@@ -267,6 +306,10 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	struct hdlcd_drm_private *hdlcd;
 	u32 dest_h;
 	dma_addr_t scanout_start;
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	if (!fb)
 		return;
@@ -279,6 +322,8 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_PITCH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_COUNT, dest_h - 1);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_BASE, scanout_start);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
-- 
2.37.2

