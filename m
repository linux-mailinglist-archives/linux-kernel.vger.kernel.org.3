Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2394D6072
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348188AbiCKLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiCKLRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:17:24 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997341B65F0;
        Fri, 11 Mar 2022 03:16:19 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so10121257ooa.10;
        Fri, 11 Mar 2022 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6byhpEWKN3shk+yCqnEMa97EHiol0IXfC7Y+/Yki8ow=;
        b=FPIcmsv3zeDMV8Hr00b3wmMxG8j4bAoX3qE693KClSRav4/TZHiTgr4mwDEY/44WxH
         qf4142jJr8io0ixkQCrgCuKsPzar4Ad/1mT9Us2MDF14HIp2UWN5dwN0qLMx5N8KzbND
         TDapLNX/otNTxfasVb1szLz9u2Zwyxlm1lb2Z3Hmz3V9rj9DhZKB2Z+hx/krXsL+yl2A
         qqTIsWlco7jozr0G2h2CYw0aeT5ldeJzPZ23RiGpeE/zz80QulnmbNghXW+QUwpnLtCM
         xyTtslqXUk8O3bEKJ7DfGAx3sgjOYbX9XkLds7kAz2iluDmh6iSMhU/m9YYwRby3J6wH
         deBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6byhpEWKN3shk+yCqnEMa97EHiol0IXfC7Y+/Yki8ow=;
        b=NDle0ngJ+c+NaJDjFo3Xq6IlT+AkmlmfgGDdRx6folhs6sFRX3uDa8GwyuIPejXpMS
         xkYOsHsyYCvazAEz5qzwk2JRKqloCcSbgywj98pGmJYHArXEDyUjMb1FjHSExCs0ZbVJ
         VYkx/FWpFn3o7kfhXG7PJYLZg1K0AS6kF2jXiIkyXTexPPqK8r4vOdAfGDVsPxaMvpcy
         2kVqMBPkyQZRtAx2Fp6AMy0Y18J7+ZKCPM8f6nUqnSQoSMfEXrS9wBtw/ifi3/BuT51m
         /8GPIx5CfwpRTjY+XDcAKT2jE2X8jSUJD4Un2XYHvfqmt2VFr+K1xc/vnT5sLsXqZx0V
         kycw==
X-Gm-Message-State: AOAM533kAFz1pfgrv2d/Rs4BA2/3KMs/O25aMwI8sKqiAZ1a0WSomMcZ
        xK0ZGAndmmUW3kixPUjXaTE=
X-Google-Smtp-Source: ABdhPJzoKj4N0SKZ/VeU/LYMwd+rI0B+mpf1limNe56i2WDFhtT4sEOHgpWdeQBPO21g8VI8Tu+1kQ==
X-Received: by 2002:a05:6870:a18a:b0:da:b3f:3244 with SMTP id a10-20020a056870a18a00b000da0b3f3244mr5145593oaf.244.1646997378719;
        Fri, 11 Mar 2022 03:16:18 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7f1:1baa:c5b3:a58c:be68:495f])
        by smtp.gmail.com with ESMTPSA id a20-20020a056870001400b000daad453cdfsm2194719oaa.49.2022.03.11.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 03:16:18 -0800 (PST)
From:   "Carlos E. C. Barbosa" <climacobarbosacee@gmail.com>
X-Google-Original-From: "Carlos E. C. Barbosa" <barbosa.carlos.ec@gmail.com>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] media: vimc: get pixformat info from v4l2_format_info
Date:   Fri, 11 Mar 2022 08:16:57 -0300
Message-Id: <20220311111657.56038-1-barbosa.carlos.ec@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Removes overlapping structures

Repurposes vimc_pix_map to strictly mapping formats, making it
a local structure.

Replaces all of its functions and remaps the calls to the matching
v4l2_format_info.

---

Changes in v6:
- replace all vimc_pix_map returning functions with v4l2_format_info
  ones (as previously suggested by Dafna)
- adds is_on_table functions to verify support (to be used only when
  no other info is required)

Changes in v5:
- .bayer member was removed and replaced by v4l2 functions calls

Changes in v4:
- Unused variables were removed

Changes in v3:
- Change declaration order of variables and some minor style changes

Changes in v2:
- Const qualifiers are not removed
- Bayer flag is kept
- Unnecessary changes are not made anymore

v4l2-compliance -m /dev/media0 output:
https://pastebin.com/BRjMP3wP

Signed-off-by: Carlos E. C. Barbosa <barbosa.carlos.ec@gmail.com>
---
 .../media/test-drivers/vimc/vimc-capture.c    | 37 +++++----
 drivers/media/test-drivers/vimc/vimc-common.c | 81 ++++++-------------
 drivers/media/test-drivers/vimc/vimc-common.h | 37 ++++++---
 .../media/test-drivers/vimc/vimc-debayer.c    | 16 ++--
 drivers/media/test-drivers/vimc/vimc-scaler.c | 30 ++++---
 drivers/media/test-drivers/vimc/vimc-sensor.c | 27 ++++---
 6 files changed, 108 insertions(+), 120 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index d1e2d0739c00..985eaddf9e4a 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -85,8 +85,9 @@ static int vimc_cap_g_fmt_vid_cap(struct file *file, void *priv,
 static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
 				    struct v4l2_format *f)
 {
+	bool is_on_vmap_table;
 	struct v4l2_pix_format *format = &f->fmt.pix;
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 
 	format->width = clamp_t(u32, format->width, VIMC_FRAME_MIN_WIDTH,
 				VIMC_FRAME_MAX_WIDTH) & ~1;
@@ -94,13 +95,15 @@ static int vimc_cap_try_fmt_vid_cap(struct file *file, void *priv,
 				 VIMC_FRAME_MAX_HEIGHT) & ~1;
 
 	/* Don't accept a pixelformat that is not on the table */
-	vpix = vimc_pix_map_by_pixelformat(format->pixelformat);
-	if (!vpix) {
+	is_on_vmap_table = vimc_pixelformat_is_on_table(format->pixelformat);
+
+	if (!is_on_vmap_table)
 		format->pixelformat = fmt_default.pixelformat;
-		vpix = vimc_pix_map_by_pixelformat(format->pixelformat);
-	}
+
+	vinfo = v4l2_format_info(format->pixelformat);
+
 	/* TODO: Add support for custom bytesperline values */
-	format->bytesperline = format->width * vpix->bpp;
+	format->bytesperline = format->width * vinfo->bpp[0];
 	format->sizeimage = format->bytesperline * format->height;
 
 	if (format->field == V4L2_FIELD_ANY)
@@ -150,21 +153,21 @@ static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
 static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
 				     struct v4l2_fmtdesc *f)
 {
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 
 	if (f->mbus_code) {
 		if (f->index > 0)
 			return -EINVAL;
 
-		vpix = vimc_pix_map_by_code(f->mbus_code);
+		vinfo = vimc_format_info_by_mbus_code(f->mbus_code);
 	} else {
-		vpix = vimc_pix_map_by_index(f->index);
+		vinfo = vimc_format_info_by_vmap_index(f->index);
 	}
 
-	if (!vpix)
+	if (!vinfo)
 		return -EINVAL;
 
-	f->pixelformat = vpix->pixelformat;
+	f->pixelformat = vinfo->format;
 
 	return 0;
 }
@@ -172,14 +175,14 @@ static int vimc_cap_enum_fmt_vid_cap(struct file *file, void *priv,
 static int vimc_cap_enum_framesizes(struct file *file, void *fh,
 				    struct v4l2_frmsizeenum *fsize)
 {
-	const struct vimc_pix_map *vpix;
+	bool is_on_vmap_table;
 
 	if (fsize->index)
 		return -EINVAL;
 
 	/* Only accept code in the pix map table */
-	vpix = vimc_pix_map_by_code(fsize->pixel_format);
-	if (!vpix)
+	is_on_vmap_table = vimc_pixelformat_is_on_table(fsize->pixel_format);
+	if (!is_on_vmap_table)
 		return -EINVAL;
 
 	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
@@ -398,7 +401,7 @@ static struct vimc_ent_device *vimc_cap_add(struct vimc_device *vimc,
 					    const char *vcfg_name)
 {
 	struct v4l2_device *v4l2_dev = &vimc->v4l2_dev;
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 	struct vimc_cap_device *vcap;
 	struct video_device *vdev;
 	struct vb2_queue *q;
@@ -450,8 +453,8 @@ static struct vimc_ent_device *vimc_cap_add(struct vimc_device *vimc,
 
 	/* Set default frame format */
 	vcap->format = fmt_default;
-	vpix = vimc_pix_map_by_pixelformat(vcap->format.pixelformat);
-	vcap->format.bytesperline = vcap->format.width * vpix->bpp;
+	vinfo = v4l2_format_info(vcap->format.pixelformat);
+	vcap->format.bytesperline = vcap->format.width * vinfo->bpp[0];
 	vcap->format.sizeimage = vcap->format.bytesperline *
 				 vcap->format.height;
 
diff --git a/drivers/media/test-drivers/vimc/vimc-common.c b/drivers/media/test-drivers/vimc/vimc-common.c
index 7b27153c0728..9e569df0197e 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.c
+++ b/drivers/media/test-drivers/vimc/vimc-common.c
@@ -24,8 +24,6 @@ static const struct vimc_pix_map vimc_pix_map_list[] = {
 			MEDIA_BUS_FMT_BGR888_3X8
 		},
 		.pixelformat = V4L2_PIX_FMT_BGR24,
-		.bpp = 3,
-		.bayer = false,
 	},
 	{
 		.code = {
@@ -39,140 +37,96 @@ static const struct vimc_pix_map vimc_pix_map_list[] = {
 			MEDIA_BUS_FMT_GBR888_1X24
 		},
 		.pixelformat = V4L2_PIX_FMT_RGB24,
-		.bpp = 3,
-		.bayer = false,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_ARGB8888_1X32 },
 		.pixelformat = V4L2_PIX_FMT_ARGB32,
-		.bpp = 4,
-		.bayer = false,
 	},
 
 	/* Bayer formats */
 	{
 		.code = { MEDIA_BUS_FMT_SBGGR8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SBGGR8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGBRG8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGBRG8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGRBG8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGRBG8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SRGGB8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SRGGB8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SBGGR10_1X10 },
 		.pixelformat = V4L2_PIX_FMT_SBGGR10,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGBRG10_1X10 },
 		.pixelformat = V4L2_PIX_FMT_SGBRG10,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGRBG10_1X10 },
 		.pixelformat = V4L2_PIX_FMT_SGRBG10,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SRGGB10_1X10 },
 		.pixelformat = V4L2_PIX_FMT_SRGGB10,
-		.bpp = 2,
-		.bayer = true,
 	},
 
 	/* 10bit raw bayer a-law compressed to 8 bits */
 	{
 		.code = { MEDIA_BUS_FMT_SBGGR10_ALAW8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SBGGR10ALAW8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGBRG10_ALAW8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGBRG10ALAW8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGRBG10_ALAW8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGRBG10ALAW8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SRGGB10_ALAW8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SRGGB10ALAW8,
-		.bpp = 1,
-		.bayer = true,
 	},
 
 	/* 10bit raw bayer DPCM compressed to 8 bits */
 	{
 		.code = { MEDIA_BUS_FMT_SBGGR10_DPCM8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SBGGR10DPCM8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGBRG10_DPCM8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGBRG10DPCM8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SGRBG10DPCM8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SRGGB10_DPCM8_1X8 },
 		.pixelformat = V4L2_PIX_FMT_SRGGB10DPCM8,
-		.bpp = 1,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SBGGR12_1X12 },
 		.pixelformat = V4L2_PIX_FMT_SBGGR12,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGBRG12_1X12 },
 		.pixelformat = V4L2_PIX_FMT_SGBRG12,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SGRBG12_1X12 },
 		.pixelformat = V4L2_PIX_FMT_SGRBG12,
-		.bpp = 2,
-		.bayer = true,
 	},
 	{
 		.code = { MEDIA_BUS_FMT_SRGGB12_1X12 },
 		.pixelformat = V4L2_PIX_FMT_SRGGB12,
-		.bpp = 2,
-		.bayer = true,
 	},
 };
 
@@ -186,12 +140,12 @@ bool vimc_is_source(struct media_entity *ent)
 	return true;
 }
 
-const struct vimc_pix_map *vimc_pix_map_by_index(unsigned int i)
+const struct v4l2_format_info *vimc_format_info_by_vmap_index(unsigned int i)
 {
 	if (i >= ARRAY_SIZE(vimc_pix_map_list))
 		return NULL;
 
-	return &vimc_pix_map_list[i];
+	return v4l2_format_info(vimc_pix_map_list[i].pixelformat);
 }
 
 u32 vimc_mbus_code_by_index(unsigned int index)
@@ -211,28 +165,41 @@ u32 vimc_mbus_code_by_index(unsigned int index)
 	return 0;
 }
 
-const struct vimc_pix_map *vimc_pix_map_by_code(u32 code)
+const struct v4l2_format_info *vimc_format_info_by_mbus_code(u32 code)
 {
 	unsigned int i, j;
 
 	for (i = 0; i < ARRAY_SIZE(vimc_pix_map_list); i++) {
 		for (j = 0; j < ARRAY_SIZE(vimc_pix_map_list[i].code); j++) {
 			if (vimc_pix_map_list[i].code[j] == code)
-				return &vimc_pix_map_list[i];
+				return v4l2_format_info(vimc_pix_map_list[i].pixelformat);
 		}
 	}
 	return NULL;
 }
 
-const struct vimc_pix_map *vimc_pix_map_by_pixelformat(u32 pixelformat)
+bool vimc_pixelformat_is_on_table(u32 format)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(vimc_pix_map_list); i++) {
-		if (vimc_pix_map_list[i].pixelformat == pixelformat)
-			return &vimc_pix_map_list[i];
+		if (vimc_pix_map_list[i].pixelformat == format)
+			return true;
 	}
-	return NULL;
+	return false;
+}
+
+bool vimc_mbus_code_is_on_table(u32 code)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(vimc_pix_map_list); i++) {
+		for (j = 0; j < ARRAY_SIZE(vimc_pix_map_list[i].code); j++) {
+			if (vimc_pix_map_list[i].code[j] == code)
+				return true;
+		}
+	}
+	return false;
 }
 
 static int vimc_get_pix_format(struct media_pad *pad,
@@ -242,7 +209,7 @@ static int vimc_get_pix_format(struct media_pad *pad,
 		struct v4l2_subdev *sd =
 			media_entity_to_v4l2_subdev(pad->entity);
 		struct v4l2_subdev_format sd_fmt;
-		const struct vimc_pix_map *pix_map;
+		const struct v4l2_format_info *vinfo;
 		int ret;
 
 		sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
@@ -253,8 +220,8 @@ static int vimc_get_pix_format(struct media_pad *pad,
 			return ret;
 
 		v4l2_fill_pix_format(fmt, &sd_fmt.format);
-		pix_map = vimc_pix_map_by_code(sd_fmt.format.code);
-		fmt->pixelformat = pix_map->pixelformat;
+		vinfo = vimc_format_info_by_mbus_code(sd_fmt.format.code);
+		fmt->pixelformat = vinfo->format;
 	} else if (is_media_entity_v4l2_video_device(pad->entity)) {
 		struct video_device *vdev = container_of(pad->entity,
 							 struct video_device,
diff --git a/drivers/media/test-drivers/vimc/vimc-common.h b/drivers/media/test-drivers/vimc/vimc-common.h
index ba1930772589..5f7f63fda779 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.h
+++ b/drivers/media/test-drivers/vimc/vimc-common.h
@@ -72,18 +72,14 @@ do {									\
  * struct vimc_pix_map - maps media bus code with v4l2 pixel format
  *
  * @code:		media bus format code defined by MEDIA_BUS_FMT_* macros
- * @bpp:		number of bytes each pixel occupies
  * @pixelformat:	pixel format defined by V4L2_PIX_FMT_* macros
- * @bayer:		true if this is a bayer format
  *
  * Struct which matches the MEDIA_BUS_FMT_* codes with the corresponding
  * V4L2_PIX_FMT_* fourcc pixelformat and its bytes per pixel (bpp)
  */
 struct vimc_pix_map {
 	unsigned int code[VIMC_PIX_FMT_MAX_CODES];
-	unsigned int bpp;
 	u32 pixelformat;
-	bool bayer;
 };
 
 /**
@@ -173,34 +169,49 @@ extern struct vimc_ent_type vimc_sca_type;
 extern struct vimc_ent_type vimc_cap_type;
 
 /**
- * vimc_pix_map_by_index - get vimc_pix_map struct by its index
+ * vimc_format_info_by_vmap_index - get v4l2_format_info struct by its vmap's index
  *
- * @i:			index of the vimc_pix_map struct in vimc_pix_map_list
+ * @i:			index of format containing struct in vimc_pix_map_list
  */
-const struct vimc_pix_map *vimc_pix_map_by_index(unsigned int i);
+const struct v4l2_format_info *vimc_format_info_by_vmap_index(unsigned int i);
 
 /**
  * vimc_mbus_code_by_index - get mbus code by its index
  *
- * @index:		index of the mbus code in vimc_pix_map_list
+ * @index:		index of mbus code containing struct in vimc_pix_map_list
  *
  * Returns 0 if no mbus code is found for the given index.
  */
 u32 vimc_mbus_code_by_index(unsigned int index);
 
 /**
- * vimc_pix_map_by_code - get vimc_pix_map struct by media bus code
+ * vimc_format_info_by_mbus_code - get v4l2_format_info struct by media bus code
  *
  * @code:		media bus format code defined by MEDIA_BUS_FMT_* macros
  */
-const struct vimc_pix_map *vimc_pix_map_by_code(u32 code);
+const struct v4l2_format_info *vimc_format_info_by_mbus_code(u32 code);
 
 /**
- * vimc_pix_map_by_pixelformat - get vimc_pix_map struct by v4l2 pixel format
+ * vimc_pixelformat_is_on_table - verify if pixel format is supported
+ * (i.e. contained in vimc pix map table)
  *
- * @pixelformat:	pixel format defined by V4L2_PIX_FMT_* macros
+ * @format:		V4l2 pixel format identifier defined by V4L2_PIX_FMT* macros
+ *
+ * Should only be used when no more info is required
+ */
+
+bool vimc_pixelformat_is_on_table(u32 format);
+
+/**
+ * vimc_pixelformat_is_on_table - verify if pixel format is supported
+ * (i.e. contained in vimc pix map table)
+ *
+ * @code:		media bus format code defined by MEDIA_BUS_FMT_* macros
+ *
+ * Should only be used when no more info is required
  */
-const struct vimc_pix_map *vimc_pix_map_by_pixelformat(u32 pixelformat);
+
+bool vimc_mbus_code_is_on_table(u32 code);
 
 /**
  * vimc_ent_sd_register - initialize and register a subdev node
diff --git a/drivers/media/test-drivers/vimc/vimc-debayer.c b/drivers/media/test-drivers/vimc/vimc-debayer.c
index 2d06cdbacc76..31d599ba54d0 100644
--- a/drivers/media/test-drivers/vimc/vimc-debayer.c
+++ b/drivers/media/test-drivers/vimc/vimc-debayer.c
@@ -318,13 +318,13 @@ static void vimc_deb_process_rgb_frame(struct vimc_deb_device *vdeb,
 				       unsigned int col,
 				       unsigned int rgb[3])
 {
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 	unsigned int i, index;
 
-	vpix = vimc_pix_map_by_code(vdeb->src_code);
+	vinfo = vimc_format_info_by_mbus_code(vdeb->src_code);
 	index = VIMC_FRAME_INDEX(lin, col, vdeb->sink_fmt.width, 3);
 	for (i = 0; i < 3; i++) {
-		switch (vpix->pixelformat) {
+		switch (vinfo->format) {
 		case V4L2_PIX_FMT_RGB24:
 			vdeb->src_frame[index + i] = rgb[i];
 			break;
@@ -340,20 +340,20 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 	struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
 
 	if (enable) {
-		const struct vimc_pix_map *vpix;
+		const struct v4l2_format_info *vinfo;
 		unsigned int frame_size;
 
 		if (vdeb->src_frame)
 			return 0;
 
 		/* Calculate the frame size of the source pad */
-		vpix = vimc_pix_map_by_code(vdeb->src_code);
+		vinfo = vimc_format_info_by_mbus_code(vdeb->src_code);
 		frame_size = vdeb->sink_fmt.width * vdeb->sink_fmt.height *
-				vpix->bpp;
+				vinfo->bpp[0];
 
 		/* Save the bytes per pixel of the sink */
-		vpix = vimc_pix_map_by_code(vdeb->sink_fmt.code);
-		vdeb->sink_bpp = vpix->bpp;
+		vinfo = vimc_format_info_by_mbus_code(vdeb->sink_fmt.code);
+		vdeb->sink_bpp = vinfo->bpp[0];
 
 		/* Get the corresponding pixel map from the table */
 		vdeb->sink_pix_map =
diff --git a/drivers/media/test-drivers/vimc/vimc-scaler.c b/drivers/media/test-drivers/vimc/vimc-scaler.c
index 820b8f5b502f..006506f84a6e 100644
--- a/drivers/media/test-drivers/vimc/vimc-scaler.c
+++ b/drivers/media/test-drivers/vimc/vimc-scaler.c
@@ -93,15 +93,17 @@ static int vimc_sca_enum_mbus_code(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_mbus_code_enum *code)
 {
 	u32 mbus_code = vimc_mbus_code_by_index(code->index);
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 
 	if (!mbus_code)
 		return -EINVAL;
 
-	vpix = vimc_pix_map_by_code(mbus_code);
+	vinfo = vimc_format_info_by_mbus_code(mbus_code);
+	if (!vinfo)
+		return -EINVAL;
 
 	/* We don't support bayer format */
-	if (!vpix || vpix->bayer)
+	if (v4l2_is_format_bayer(vinfo))
 		return -EINVAL;
 
 	code->code = mbus_code;
@@ -113,14 +115,18 @@ static int vimc_sca_enum_frame_size(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *sd_state,
 				    struct v4l2_subdev_frame_size_enum *fse)
 {
-	const struct vimc_pix_map *vpix;
+	const struct v4l2_format_info *vinfo;
 
 	if (fse->index)
 		return -EINVAL;
 
 	/* Only accept code in the pix map table in non bayer format */
-	vpix = vimc_pix_map_by_code(fse->code);
-	if (!vpix || vpix->bayer)
+	vinfo = vimc_format_info_by_mbus_code(fse->code);
+
+	if (!vinfo)
+		return -EINVAL;
+
+	if (v4l2_is_format_bayer(vinfo))
 		return -EINVAL;
 
 	fse->min_width = VIMC_FRAME_MIN_WIDTH;
@@ -184,11 +190,11 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 	 * pad, the source pad only follows.
 	 */
 	if (format->pad == VIMC_SCA_SINK) {
-		const struct vimc_pix_map *vpix;
+		const struct v4l2_format_info *vinfo;
 
 		/* Only accept code in the pix map table in non bayer format. */
-		vpix = vimc_pix_map_by_code(format->format.code);
-		if (vpix && !vpix->bayer)
+		vinfo = vimc_format_info_by_mbus_code(format->format.code);
+		if (vinfo && !v4l2_is_format_bayer(vinfo))
 			fmt->code = format->format.code;
 		else
 			fmt->code = fmt_default.code;
@@ -307,15 +313,15 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 	struct vimc_sca_device *vsca = v4l2_get_subdevdata(sd);
 
 	if (enable) {
-		const struct vimc_pix_map *vpix;
+		const struct v4l2_format_info *vinfo;
 		unsigned int frame_size;
 
 		if (vsca->src_frame)
 			return 0;
 
 		/* Save the bytes per pixel of the sink */
-		vpix = vimc_pix_map_by_code(vsca->fmt[VIMC_SCA_SINK].code);
-		vsca->bpp = vpix->bpp;
+		vinfo = vimc_format_info_by_mbus_code(vsca->fmt[VIMC_SCA_SINK].code);
+		vsca->bpp = vinfo->bpp[0];
 
 		/* Calculate the frame size of the source pad */
 		frame_size = vsca->fmt[VIMC_SCA_SRC].width
diff --git a/drivers/media/test-drivers/vimc/vimc-sensor.c b/drivers/media/test-drivers/vimc/vimc-sensor.c
index 74ab79cadb5d..159b39498996 100644
--- a/drivers/media/test-drivers/vimc/vimc-sensor.c
+++ b/drivers/media/test-drivers/vimc/vimc-sensor.c
@@ -74,14 +74,14 @@ static int vimc_sen_enum_frame_size(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *sd_state,
 				    struct v4l2_subdev_frame_size_enum *fse)
 {
-	const struct vimc_pix_map *vpix;
+	bool is_on_vmap_table;
 
 	if (fse->index)
 		return -EINVAL;
 
 	/* Only accept code in the pix map table */
-	vpix = vimc_pix_map_by_code(fse->code);
-	if (!vpix)
+	is_on_vmap_table = vimc_mbus_code_is_on_table(fse->code);
+	if (!is_on_vmap_table)
 		return -EINVAL;
 
 	fse->min_width = VIMC_FRAME_MIN_WIDTH;
@@ -108,14 +108,15 @@ static int vimc_sen_get_fmt(struct v4l2_subdev *sd,
 
 static void vimc_sen_tpg_s_format(struct vimc_sen_device *vsen)
 {
-	const struct vimc_pix_map *vpix =
-				vimc_pix_map_by_code(vsen->mbus_format.code);
+	const struct v4l2_format_info *vinfo =
+				vimc_format_info_by_mbus_code(vsen->mbus_format.code);
 
 	tpg_reset_source(&vsen->tpg, vsen->mbus_format.width,
 			 vsen->mbus_format.height, vsen->mbus_format.field);
-	tpg_s_bytesperline(&vsen->tpg, 0, vsen->mbus_format.width * vpix->bpp);
+	tpg_s_bytesperline(&vsen->tpg, 0, vsen->mbus_format.width *
+							vinfo->bpp[0]);
 	tpg_s_buf_height(&vsen->tpg, vsen->mbus_format.height);
-	tpg_s_fourcc(&vsen->tpg, vpix->pixelformat);
+	tpg_s_fourcc(&vsen->tpg, vinfo->format);
 	/* TODO: add support for V4L2_FIELD_ALTERNATE */
 	tpg_s_field(&vsen->tpg, vsen->mbus_format.field, false);
 	tpg_s_colorspace(&vsen->tpg, vsen->mbus_format.colorspace);
@@ -126,11 +127,11 @@ static void vimc_sen_tpg_s_format(struct vimc_sen_device *vsen)
 
 static void vimc_sen_adjust_fmt(struct v4l2_mbus_framefmt *fmt)
 {
-	const struct vimc_pix_map *vpix;
+	bool is_on_vmap_table;
 
 	/* Only accept code in the pix map table */
-	vpix = vimc_pix_map_by_code(fmt->code);
-	if (!vpix)
+	is_on_vmap_table = vimc_mbus_code_is_on_table(fmt->code);
+	if (!is_on_vmap_table)
 		fmt->code = fmt_default.code;
 
 	fmt->width = clamp_t(u32, fmt->width, VIMC_FRAME_MIN_WIDTH,
@@ -247,14 +248,14 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 				container_of(sd, struct vimc_sen_device, sd);
 
 	if (enable) {
-		const struct vimc_pix_map *vpix;
+		const struct v4l2_format_info *vinfo;
 		unsigned int frame_size;
 
 		vsen->start_stream_ts = ktime_get_ns();
 
 		/* Calculate the frame size */
-		vpix = vimc_pix_map_by_code(vsen->mbus_format.code);
-		frame_size = vsen->mbus_format.width * vpix->bpp *
+		vinfo = vimc_format_info_by_mbus_code(vsen->mbus_format.code);
+		frame_size = vsen->mbus_format.width * vinfo->bpp[0] *
 			     vsen->mbus_format.height;
 
 		/*
-- 
2.35.1

