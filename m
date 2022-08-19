Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70AC59A942
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiHSXLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiHSXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E54B69E8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zE4vp0voY9uQjkQjmHJf9kE7FYAP7kTVaTS+8HIh/tE=;
        b=XZu6COxwMPb7lFW4ZPPzuAuOczMF9uYnfEfvh9PwX6hchVne7kfxpaB6M+f4c8G7IHO45S
        xTYFqBNah7C5kyv8XFyBjLSu+z5OG+yLlvl3w1UxBHNognOE/Q0p8Ls4JUcxZ0SSDnkTMw
        FMwdjuAFOhzjG6N8DZxlPePCe6ovQaE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-245-2CXtklsTMgG1nJA1DBoEMA-1; Fri, 19 Aug 2022 19:11:08 -0400
X-MC-Unique: 2CXtklsTMgG1nJA1DBoEMA-1
Received: by mail-ej1-f72.google.com with SMTP id js11-20020a17090797cb00b00730d73eac83so1943430ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zE4vp0voY9uQjkQjmHJf9kE7FYAP7kTVaTS+8HIh/tE=;
        b=HQRq4e6fZIs1QWX1LXiTNfR9rlJxMeWkHhPE2o+PWxjTFc6UssZrbJC90gfNcDiZHJ
         v7i+0UlmGperE7MzhIWbcRMZOr7fmENOYzxnUU+ngSczVUfvITOst/0/VaYQv5oqiBvv
         75o/qa58gKyQfs24nVTLUo+kMnKq4nbm5M4ODqlMPc7eQXOX3xMHDmmAGM6YUM4y2QF0
         MClJz/jadV66mH0ZDE8HW26XWKqM+ZhNaKbLfjEkPPghIxKY79rCO2FOElkWbXYi9RRW
         wm+BiDdVG+rkIVp+jQtLKlXRtbki5bzt4Csc1TE2T5oGR3hdQRguC479GQ9POEt4G41l
         TivQ==
X-Gm-Message-State: ACgBeo1mSP7/Z1eS/L9mUO1Zt6oks60uAoY3gbSAqIigH4+3zeedRyi7
        oRvrDnbG3V1hb49A7yDDfln8ufX75T30dWHuOlJrWpml27zbapxdkrR5cpssKDw/E9ibRy1wRwU
        Wesfvq/P9XbMdtBNhb7GmT5Ej
X-Received: by 2002:a05:6402:4407:b0:43f:68b8:3358 with SMTP id y7-20020a056402440700b0043f68b83358mr7653912eda.215.1660950667177;
        Fri, 19 Aug 2022 16:11:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7XXSBauExpDyHCPOh+rGZm4yhkBfQtEDjqIJnq8eNLc63PAUAH+xTLtF7VgUFav7SSgkv9Xg==
X-Received: by 2002:a05:6402:4407:b0:43f:68b8:3358 with SMTP id y7-20020a056402440700b0043f68b83358mr7653895eda.215.1660950667040;
        Fri, 19 Aug 2022 16:11:07 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b007303fe58eb2sm2844636ejf.154.2022.08.19.16.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:06 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 2/7] drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
Date:   Sat, 20 Aug 2022 01:10:53 +0200
Message-Id: <20220819231058.647658-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drm_device->dev_private is deprecated. Since we've switched to
devm_drm_dev_alloc(), struct drm_device is now embedded in struct
hdlcd_drm_private, hence we can use container_of() to get the struct
drm_device instance instead.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c |  4 ++--
 drivers/gpu/drm/arm/hdlcd_drv.c  | 10 ++++------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  1 +
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 7030339fa232..4a8959d0b2a6 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -275,7 +275,7 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	dest_h = drm_rect_height(&new_plane_state->dst);
 	scanout_start = drm_fb_dma_get_gem_addr(fb, new_plane_state, 0);
 
-	hdlcd = plane->dev->dev_private;
+	hdlcd = drm_to_hdlcd_priv(plane->dev);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_PITCH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_COUNT, dest_h - 1);
@@ -325,7 +325,7 @@ static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 
 int hdlcd_setup_crtc(struct drm_device *drm)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct drm_plane *primary;
 	int ret;
 
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 463381d11cff..120c87934a91 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -98,7 +98,7 @@ static void hdlcd_irq_uninstall(struct hdlcd_drm_private *hdlcd)
 
 static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct platform_device *pdev = to_platform_device(drm->dev);
 	struct resource *res;
 	u32 version;
@@ -190,7 +190,7 @@ static int hdlcd_show_underrun_count(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
 	seq_printf(m, "underrun : %d\n", atomic_read(&hdlcd->buffer_underrun_count));
 	seq_printf(m, "dma_end  : %d\n", atomic_read(&hdlcd->dma_end_count));
@@ -203,7 +203,7 @@ static int hdlcd_show_pxlclock(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	unsigned long clkrate = clk_get_rate(hdlcd->clk);
 	unsigned long mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
 
@@ -253,7 +253,6 @@ static int hdlcd_drm_bind(struct device *dev)
 
 	drm = &hdlcd->base;
 
-	drm->dev_private = hdlcd;
 	dev_set_drvdata(dev, drm);
 
 	hdlcd_setup_mode_config(drm);
@@ -324,7 +323,7 @@ static int hdlcd_drm_bind(struct device *dev)
 static void hdlcd_drm_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
@@ -339,7 +338,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 		pm_runtime_disable(dev);
 	of_reserved_mem_device_release(dev);
 	drm_mode_config_cleanup(drm);
-	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
 }
 
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index 3892b36767ac..f1c1da2ac2db 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -21,6 +21,7 @@ struct hdlcd_drm_private {
 #endif
 };
 
+#define drm_to_hdlcd_priv(x)	container_of(x, struct hdlcd_drm_private, base)
 #define crtc_to_hdlcd_priv(x)	container_of(x, struct hdlcd_drm_private, crtc)
 
 static inline void hdlcd_write(struct hdlcd_drm_private *hdlcd,
-- 
2.37.2

