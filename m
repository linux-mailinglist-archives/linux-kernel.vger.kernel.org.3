Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F76474771
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhLNQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhLNQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:17:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFEC061756
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:17:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 133so14680399wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrJsFtsuhtmLSJTTjlYvfNHYFw/pI3X8Oa33ZAzpSDM=;
        b=kZHKqp9yyvcmhytOSIWGLFtmRf0wd7t8lKKCUbHH3jmUD/6CKDF+dOuwhpDIADAIOC
         VDF+rlH1t0LjkIfDF4qq0jwzZypNZP9Ak7gH1NKrRItJJ7ufpH6Qf7uFxK6Kqh/b+oAc
         XTWW0bizCMjbpGVCtiBrMWt6/nB/rJ68ZWc3+UFdgpoGBX6qQRXKMxtV644Z6lobHftx
         EwYewMz06AGiI97RTHU3CaafXEgJMvCF7hR/Y4iXEYVdgqGs6g0QgP5KCojKvTiYMStd
         guxnjgC+I0eGxpg1849YD0B96QyWj6tewmZHiX0L4s+RDfZRK83mO7zuIuDH1dhfLOYE
         2bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrJsFtsuhtmLSJTTjlYvfNHYFw/pI3X8Oa33ZAzpSDM=;
        b=qi89fSSwaRShP+zz6ENQayCkSuUhl60Euqo7/R91iSp86LKJbBtAH1T53yO7Kw9ziX
         t38+gW82kxJZ41lU4+dGs6LMG9lxl6qjM6kV44inRAGOhq1rb9S98MqVjh+uSMYfNQ9P
         DeDw14+Kw7XkCsiPP00OiLxj+oRxqLX9BDb33XF27sdJ4BCtaZdcVQ5ZnmJ4X3rlfnAj
         4+MOjtksCR/b22wAfW4eMrInjTG31s5F572JuM6J7yvMkTQ7B+oJZ+m8gCYifMcHtPmg
         xnKAnXXEdSYbD4jVrISgJuGSxtr6yVeLVicTe2w90wKHg6TxlccIM8fGKRVAK4eF7wSQ
         +BoA==
X-Gm-Message-State: AOAM530qXYiuFP2sJTowfZnplUKejZnJLUujzhhKZzKeg3VcMb3hAoG4
        yQwiZVyHW5PDDLk6Cf2BjrIwrw==
X-Google-Smtp-Source: ABdhPJyD/VPTazW+yxv00pyfOaW0IYRXn/a0BIPW8dVg9XI/oBl+yweYxgfPwERXa22rX7ifKTGPQw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr8237955wmc.89.1639498620640;
        Tue, 14 Dec 2021 08:17:00 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:17:00 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 18/18] staging: media: zoran: drop read/write support
Date:   Tue, 14 Dec 2021 16:16:36 +0000
Message-Id: <20211214161636.1886900-19-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

This makes no sense for MJPEG formats and it is just easier to
drop support for this altogether.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c   |  2 +-
 drivers/staging/media/zoran/zoran_driver.c | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index e6d3558323a9..59df1e7691f9 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -879,7 +879,7 @@ static int zoran_init_video_device(struct zoran *zr, struct video_device *video_
 	*video_dev = zoran_template;
 	video_dev->v4l2_dev = &zr->v4l2_dev;
 	video_dev->lock = &zr->lock;
-	video_dev->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_READWRITE | dir;
+	video_dev->device_caps = V4L2_CAP_STREAMING | dir;
 
 	strscpy(video_dev->name, ZR_DEVNAME(zr), sizeof(video_dev->name));
 	/*
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 013efdecd582..4304b7e21709 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -734,15 +734,6 @@ static int zoran_s_selection(struct file *file, void *__fh, struct v4l2_selectio
 	return res;
 }
 
-static int zoran_g_parm(struct file *file, void *priv, struct v4l2_streamparm *parm)
-{
-	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
-		return -EINVAL;
-
-	parm->parm.capture.readbuffers = 9;
-	return 0;
-}
-
 /*
  * Output is disabled temporarily
  * Zoran is picky about jpeg data it accepts. At least it seems to unsupport COM and APPn.
@@ -750,7 +741,6 @@ static int zoran_g_parm(struct file *file, void *priv, struct v4l2_streamparm *p
  */
 static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_querycap		    = zoran_querycap,
-	.vidioc_g_parm			    = zoran_g_parm,
 	.vidioc_s_selection		    = zoran_s_selection,
 	.vidioc_g_selection		    = zoran_g_selection,
 	.vidioc_enum_input		    = zoran_enum_input,
@@ -786,8 +776,6 @@ static const struct v4l2_file_operations zoran_fops = {
 	.unlocked_ioctl = video_ioctl2,
 	.open		= v4l2_fh_open,
 	.release	= vb2_fop_release,
-	.read		= vb2_fop_read,
-	.write		= vb2_fop_write,
 	.mmap		= vb2_fop_mmap,
 	.poll		= vb2_fop_poll,
 };
-- 
2.32.0

