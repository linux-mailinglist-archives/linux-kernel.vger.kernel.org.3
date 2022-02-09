Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995884AF548
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiBIPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiBIPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:31:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7850BC0613CA;
        Wed,  9 Feb 2022 07:31:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i19so298323wmq.5;
        Wed, 09 Feb 2022 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZyAttm7EWbqNG67CUDg8UPYwEYfS+Y2vi8G1ZAG6NcE=;
        b=RDqrhnCrVs2cy1RLpuK6nwaQFgj423rToOLIXbkpypkJM667N2WSwDimCP0mSqPCeQ
         EGTvGluh8N/yHOL5mrdSr6/5y+WgJvk6BJeAneMtafAHX4dN5Jo+hlPJeEroJP46HMaU
         Ckej5RHBnY3v++NS1SvQbCdf8Rx3q0c+rNYsFVa3ncq0bIqmXi7MmOsGi35r9TTFqAuo
         rgm/9AlLh6Qw0lXbvKq8CSp4WIkj/KUeu5GjqydWvyAVHMw/tJqN6ymygtrSkJqm6BuS
         XStOlwNtwE4Z7E7vYJ0gaxrnXORdOeQVDuP4vFQYC1Z69VBMpg6dmzCvbR43jUeXIWt+
         78IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZyAttm7EWbqNG67CUDg8UPYwEYfS+Y2vi8G1ZAG6NcE=;
        b=zDLqg11Mv/IiRyF6/1MaFNW9tEGHvrE/xzCzoXl9QamtYdkNisbPYUaemvq4o8nE+n
         P444PbwfouC6JXoO5XeJrt13xzEOXXeXAOxYElHXKFsZ2uhl6Enwjk+oCJFhzaZAsQio
         8rY/OsYIxeZL2Zp1IBhmZKqyRh9828XK6YaWWNoW1l/Rr4WfGNuFfd4g8us3q1lNA3gU
         lVmJatnpIva5JcCA9Q+ctfjHHm2gQ3S0rUVG6FI3cP48FbMi8BHdAGEqgNxM4zgssNI2
         RGw4+0GRVZh3LAO8+7glvzdDeLmLTFm+HJomF7J5i/lH9W6/I+jqlZH95LXo3xmEz2gc
         0t6g==
X-Gm-Message-State: AOAM5337+/dHEOeDOut0bjuSLwoRRuibk1kEV0B7lLFmJRRKrhcy1pi1
        463Z99jsqc66k+aG6S6v4Gg=
X-Google-Smtp-Source: ABdhPJxG8wN3QTxvyDPuUUetA/tjTXSz97RI/agJ/gioycGkSAkQhODQCe4UpRBeH/mRvSk0Ax2veg==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr2529899wmq.45.1644420714828;
        Wed, 09 Feb 2022 07:31:54 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o125sm2875729wme.37.2022.02.09.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:31:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] drivers: meson: vdec: add VP9 support to GXM
Date:   Wed,  9 Feb 2022 15:31:50 +0000
Message-Id: <20220209153150.30688-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP9 support for GXM appears to have been missed from the original
codec submission [0] but it works well, so let's add support.

[0] https://github.com/torvalds/linux/commit/00c43088aa680989407b6afbda295f67b3f123f1

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Tested with LibreELEC 11 nightly 'AMLGX' dev images for Khadas VIM2
and WeTek Core2 GXM devices which can be found here [1]. The images
combine Linux 5.16.y [2] with Kodi v20 [3] and FFmpeg 4.4 [4] which
notably includes many V4L2 refinements for stability and usability.

[1] https://test.libreelec.tv/
[2] https://github.com/chewitt/linux/commits/amlogic-5.16.y
[3] https://github.com/xbmc/xbmc/
[4] https://github.com/jc-kynesim/rpi-ffmpeg/commits/dev/4.4/rpi_import_1

 drivers/staging/media/meson/vdec/vdec_platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
index eabbebab2da2..88c9d72e1c83 100644
--- a/drivers/staging/media/meson/vdec/vdec_platform.c
+++ b/drivers/staging/media/meson/vdec/vdec_platform.c
@@ -103,6 +103,18 @@ static const struct amvdec_format vdec_formats_gxl[] = {
 
 static const struct amvdec_format vdec_formats_gxm[] = {
 	{
+		.pixfmt = V4L2_PIX_FMT_VP9,
+		.min_buffers = 16,
+		.max_buffers = 24,
+		.max_width = 3840,
+		.max_height = 2160,
+		.vdec_ops = &vdec_hevc_ops,
+		.codec_ops = &codec_vp9_ops,
+		.firmware_path = "meson/vdec/gxl_vp9.bin",
+		.pixfmts_cap = { V4L2_PIX_FMT_NV12M, 0 },
+		.flags = V4L2_FMT_FLAG_COMPRESSED |
+			 V4L2_FMT_FLAG_DYN_RESOLUTION,
+	}, {
 		.pixfmt = V4L2_PIX_FMT_H264,
 		.min_buffers = 2,
 		.max_buffers = 24,
-- 
2.17.1

