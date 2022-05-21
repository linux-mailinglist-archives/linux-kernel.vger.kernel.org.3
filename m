Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5952FCE8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiEUNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiEUNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:35:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163CE6A067
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:35:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i1so9447155plg.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/1JoYU2eaaPdYWTtHptPizgGXOiJfqbRsxQiijvcnU=;
        b=hJ2wZiz43Q7G5xoR7vAK2HSUyHGSdRL6QM5wOn5ffWmh5k2Q9I5pqiRe4xddjEhY8e
         IGx3dW2owdGd6n7HP8V94tSJYcKWxXNF0wiB3hZ5KvoEBtuViuVj3SRjC1qO0uau/WCB
         S30vyXiWvOWLqj/mj66JfAe6myrcD66UJh/gEwv1GpzVDZJ+SsT3VdoObIg7449Qjasc
         yipS888I4w66zXrKuPCsk6JY9czhevexTSnd7nwSpnYuKonJ5ncBXahUxoxsgLX4Jtnu
         QYIAmB1QvxnvWoxkCg9VBammHApWcTg8J1eP7nWuRnLEYPtoqB5MFCQkxkBLn2i3M7XI
         CfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/1JoYU2eaaPdYWTtHptPizgGXOiJfqbRsxQiijvcnU=;
        b=sy1AkjUpwmPapaazJFq/Sbo311lg2/Lpqm01Lv8HpVm3+SFJ8471kkUmcS29EWrZZB
         CR62VWFOZ05XsJcX4f/4z29oTYHmL6OKCReNdRErFZBbeHcwkXlfKqwlSZ7Usk+lzmlb
         NGFm9obR1q8YTI2vktdRsKzf6XFcoFMkts0lqCH+z5RUnqfE5Q1EG6Z9e1aEllRytIkp
         H4BLlzQ9fno6jJE1x05TNRwKvDZ0eXdUToJ799o6xIpPTGdVrNl7L9RLNg+eAsEUB6eN
         OB8c3K0/pLDSemq7yx+Mr1/GeDDpxCsjVd5PX6CSLctTpTOBuioyPq4cKnhtD+BYk1pq
         l+4Q==
X-Gm-Message-State: AOAM533/ehYNGSg1ljfyMhb9MZTJTMXEcKI8irY2Lz7vaGpHHWJCma8a
        PqARWxm6b+7D0XOqdoZTxjREyEFFv7v71rau
X-Google-Smtp-Source: ABdhPJx0zCLwUiyeASotOlJEzSqtjfEA3r1zvU8fue4LcCU1odSzkqoq62UrwvZajtLu0Z/RriA9jA==
X-Received: by 2002:a17:90b:3889:b0:1dc:cac6:f03e with SMTP id mu9-20020a17090b388900b001dccac6f03emr16537918pjb.23.1653140102261;
        Sat, 21 May 2022 06:35:02 -0700 (PDT)
Received: from benly-pc.localdomain ([58.100.171.250])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b0015e8d4eb256sm1597765plb.160.2022.05.21.06.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:35:02 -0700 (PDT)
From:   Genfu Pan <benlypan@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Genfu Pan <benlypan@gmail.com>
Subject: [PATCH] drm/sun4i: mixer: fix scanline for V3s and D1
Date:   Sat, 21 May 2022 21:34:43 +0800
Message-Id: <20220521133443.1114749-1-benlypan@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accrording the SDK from Allwinner, the scanline value of yuv and rgb for
V3s are both 1024. The is also the same for mixer 1 of D1. Currently the
scanline value of rgb is hardcoded to 2048 for all SOCs.

Change the scanline_yuv property of V3s to 1024. Add the scanline_rgb
property to the mixer config and replace the hardcoded value with it before
scaling.

Signed-off-by: Genfu Pan <benlypan@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 13 ++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  1 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  3 +--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 875a1156c..e64e08207 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -567,6 +567,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -575,6 +576,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -584,6 +586,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.mod_rate	= 432000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -593,6 +596,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -602,6 +606,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -610,7 +615,8 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
 	.scaler_mask = 0x3,
-	.scanline_yuv = 2048,
+	.scanline_yuv = 1024,
+	.scanline_rgb = 1024,
 	.ccsc = CCSC_MIXER0_LAYOUT,
 	.mod_rate = 150000000,
 };
@@ -620,6 +626,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -629,6 +636,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x1,
 	.scanline_yuv	= 1024,
+	.scanline_rgb	= 1024,
 	.ui_num		= 0,
 	.vi_num		= 1,
 };
@@ -638,6 +646,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
+	.scanline_rgb	= 2048,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -647,6 +656,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
+	.scanline_rgb	= 2048,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -657,6 +667,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
+	.scanline_rgb	= 2048,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 85c94884f..c01b3e9d6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -172,6 +172,7 @@ struct sun8i_mixer_cfg {
 	unsigned long	mod_rate;
 	unsigned int	is_de3 : 1;
 	unsigned int	scanline_yuv;
+	unsigned int	scanline_rgb;
 };
 
 struct sun8i_mixer {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index f7d0b082d..30e6bde92 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -188,8 +188,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 			src_h = vn;
 		}
 
-		/* it seems that every RGB scaler has buffer for 2048 pixels */
-		scanline = subsampled ? mixer->cfg->scanline_yuv : 2048;
+		scanline = subsampled ? mixer->cfg->scanline_yuv : mixer->cfg->scanline_rgb;
 
 		if (src_w > scanline) {
 			DRM_DEBUG_DRIVER("Using horizontal coarse scaling\n");
-- 
2.36.0

