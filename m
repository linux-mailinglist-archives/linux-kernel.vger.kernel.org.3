Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0DB48E4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiANHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiANHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:40:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:40:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso12285519pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EI6TVgd30tF1viMoRS7X9CLLIp4oh9sWJRBeqJ6vOEs=;
        b=dJtwix545BgyqpGmuYhlM59DrUTSfFr4JBF2rTd97bZ2wvRA+ehYAsWMjHCkdTNPS5
         Q8uleh7MqoEq2eYMGp4TTU7cYVRQupTMStIR8wYuOlNB+46IsL4XzIBBtk15KodOewS/
         3AvXU8JgZR8zP6U8TVmojq/c2wPZgf1ZaZlAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EI6TVgd30tF1viMoRS7X9CLLIp4oh9sWJRBeqJ6vOEs=;
        b=4XSUXV6hBUWsmikI6fJvw8cHquehcujm9tKKX/BYy2aGpNhQ1JIbuRF5G0GywvFMpg
         rUH9QZa4yEXH+0lXzAPShYzsjncW3kQ/zf1/t1vaLyv9uKm+5Bk9UjMhrCvMBLeWmUcK
         EcJ5+UFWeziWIcZQo/9R92orP0P9qr1emfiN5y/4kg12MROk0cEAR9t1prxvOqdyoQsp
         U1R1jFEAg+hw4faX78TibhyHqkr2DU5mDPUaNM2cBDFBvlaRUW9UORBfwLzU1/oQI0nm
         c63UWK9GnnGh5vQUOjq3s/B+ah0SEK7sTKmIJl5Xa1nB8kOGdhfbS3jSZkFdUfXGMS/s
         89fQ==
X-Gm-Message-State: AOAM531ge4IV3au/x3Rk8PyeQTS5ksaEgaPAgHAN3SeNsdLj3Gy+hdlm
        lv88q733kBUB5Swn7yrao3XkXQ==
X-Google-Smtp-Source: ABdhPJyvVORg9pEv7zdC5lqN5kgYrK/wPIL/+XApB8HBIAg6uDXXKDS5BM7pCAQ4eBFY4dCiNDJaOw==
X-Received: by 2002:a17:90a:df10:: with SMTP id gp16mr9308813pjb.69.1642146043403;
        Thu, 13 Jan 2022 23:40:43 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40e5:515f:fd6e:aa97])
        by smtp.gmail.com with ESMTPSA id o15sm1205700pfg.176.2022.01.13.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 23:40:42 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: Support YUV formats with U/V swapped
Date:   Fri, 14 Jan 2022 15:40:38 +0800
Message-Id: <20220114074038.2633848-1-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VOP in Rockchip SoCs that support YUV planes also support swapping
of the U and V elements. Supporting the swapped variants, especially
NV21, would be beneficial for multimedia applications, as the hardware
video decoders only output NV21, and supporting this pixel format in
the display pipeline would allow the decoded video frames to be output
directly.

Add support for this to support the various formats that have U/V
swapped.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

This was tested on an ROC-RK3399-PC with modetest only. Changes to all
other SoC platforms were based on their respective TRMs.

---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 11 +++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3e8d9e2d1b67..c75b39474977 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -262,6 +262,18 @@ static bool has_rb_swapped(uint32_t format)
 	}
 }
 
+static bool has_uv_swapped(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_NV42:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static enum vop_data_format vop_convert_format(uint32_t format)
 {
 	switch (format) {
@@ -277,10 +289,13 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	case DRM_FORMAT_BGR565:
 		return VOP_FMT_RGB565;
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
 		return VOP_FMT_YUV420SP;
 	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
 		return VOP_FMT_YUV422SP;
 	case DRM_FORMAT_NV24:
+	case DRM_FORMAT_NV42:
 		return VOP_FMT_YUV444SP;
 	default:
 		DRM_ERROR("unsupported format[%08x]\n", format);
@@ -899,7 +914,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	unsigned long offset;
 	dma_addr_t dma_addr;
 	uint32_t val;
-	bool rb_swap;
+	bool rb_swap, uv_swap;
 	int win_index = VOP_WIN_TO_INDEX(vop_win);
 	int format;
 	int is_yuv = fb->format->is_yuv;
@@ -988,6 +1003,9 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 							y2r_coefficients[i],
 							bt601_yuv2rgb[i]);
 		}
+
+		uv_swap = has_uv_swapped(fb->format->format);
+		VOP_WIN_SET(vop, win, uv_swap, uv_swap);
 	}
 
 	if (win->phy->scl)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 857d97cdc67c..3aa95fdd427d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -166,6 +166,7 @@ struct vop_win_phy {
 	struct vop_reg gate;
 	struct vop_reg format;
 	struct vop_reg rb_swap;
+	struct vop_reg uv_swap;
 	struct vop_reg act_info;
 	struct vop_reg dsp_info;
 	struct vop_reg dsp_st;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 1f7353f0684a..af2b07fafadf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -46,8 +46,11 @@ static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
 	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
 	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV42,
 };
 
 static const uint64_t format_modifiers_win_full[] = {
@@ -272,6 +275,7 @@ static const struct vop_win_phy px30_win0_data = {
 	.enable = VOP_REG(PX30_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(PX30_WIN0_CTRL0, 0x7, 1),
 	.rb_swap = VOP_REG(PX30_WIN0_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(PX30_WIN0_CTRL0, 0x1, 15),
 	.act_info = VOP_REG(PX30_WIN0_ACT_INFO, 0xffffffff, 0),
 	.dsp_info = VOP_REG(PX30_WIN0_DSP_INFO, 0xffffffff, 0),
 	.dsp_st = VOP_REG(PX30_WIN0_DSP_ST, 0xffffffff, 0),
@@ -291,6 +295,7 @@ static const struct vop_win_phy px30_win1_data = {
 	.enable = VOP_REG(PX30_WIN1_CTRL0, 0x1, 0),
 	.format = VOP_REG(PX30_WIN1_CTRL0, 0x7, 4),
 	.rb_swap = VOP_REG(PX30_WIN1_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(PX30_WIN1_CTRL0, 0x1, 15),
 	.dsp_info = VOP_REG(PX30_WIN1_DSP_INFO, 0xffffffff, 0),
 	.dsp_st = VOP_REG(PX30_WIN1_DSP_ST, 0xffffffff, 0),
 	.yrgb_mst = VOP_REG(PX30_WIN1_MST, 0xffffffff, 0),
@@ -368,6 +373,7 @@ static const struct vop_win_phy rk3066_win0_data = {
 	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 0),
 	.format = VOP_REG(RK3066_SYS_CTRL1, 0x7, 4),
 	.rb_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 19),
+	.uv_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 22),
 	.act_info = VOP_REG(RK3066_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3066_WIN0_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3066_WIN0_DSP_ST, 0x1fff1fff, 0),
@@ -386,6 +392,7 @@ static const struct vop_win_phy rk3066_win1_data = {
 	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 1),
 	.format = VOP_REG(RK3066_SYS_CTRL1, 0x7, 7),
 	.rb_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 23),
+	.uv_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 26),
 	.act_info = VOP_REG(RK3066_WIN1_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3066_WIN1_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3066_WIN1_DSP_ST, 0x1fff1fff, 0),
@@ -489,6 +496,7 @@ static const struct vop_win_phy rk3188_win0_data = {
 	.enable = VOP_REG(RK3188_SYS_CTRL, 0x1, 0),
 	.format = VOP_REG(RK3188_SYS_CTRL, 0x7, 3),
 	.rb_swap = VOP_REG(RK3188_SYS_CTRL, 0x1, 15),
+	.uv_swap = VOP_REG(RK3188_SYS_CTRL, 0x1, 18),
 	.act_info = VOP_REG(RK3188_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3188_WIN0_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3188_WIN0_DSP_ST, 0x1fff1fff, 0),
@@ -619,6 +627,7 @@ static const struct vop_win_phy rk3288_win01_data = {
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 15),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3288_WIN0_DSP_ST, 0x1fff1fff, 0),
@@ -753,6 +762,7 @@ static const struct vop_win_phy rk3368_win01_data = {
 	.enable = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3368_WIN0_CTRL0, 0x7, 1),
 	.rb_swap = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 15),
 	.x_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 21),
 	.y_mir_en = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 22),
 	.act_info = VOP_REG(RK3368_WIN0_ACT_INFO, 0x1fff1fff, 0),
@@ -902,6 +912,7 @@ static const struct vop_win_phy rk3399_win01_data = {
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
+	.uv_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 15),
 	.y_mir_en = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 22),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
-- 
2.34.1.703.g22d0c6ccf7-goog

