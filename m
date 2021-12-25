Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9047F48F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhLYWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 17:06:41 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:38276 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhLYWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 17:06:41 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Dec 2021 17:06:40 EST
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 7E1447A0156;
        Sat, 25 Dec 2021 22:59:07 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bttv: fix WARNING regression on tunerless devices
Date:   Sat, 25 Dec 2021 22:58:44 +0100
Message-Id: <20211225215844.24189-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2161536516ed ("media: media/pci: set device_caps in struct video_device")
introduced a regression: V4L2_CAP_TUNER is always present in device_caps,
even when the device has no tuner.

This causes a warning:
WARNING: CPU: 0 PID: 249 at drivers/media/v4l2-core/v4l2-ioctl.c:1102 v4l_querycap+0xa0/0xb0 [videodev]

Fixes: 2161536516ed ("media: media/pci: set device_caps in struct video_device")
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 0e9df8b35ac6..661ebfa7bf3f 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -3890,7 +3890,7 @@ static int bttv_register_video(struct bttv *btv)
 
 	/* video */
 	vdev_init(btv, &btv->video_dev, &bttv_video_template, "video");
-	btv->video_dev.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
+	btv->video_dev.device_caps = V4L2_CAP_VIDEO_CAPTURE |
 				     V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
 	if (btv->tuner_type != TUNER_ABSENT)
 		btv->video_dev.device_caps |= V4L2_CAP_TUNER;
@@ -3911,7 +3911,7 @@ static int bttv_register_video(struct bttv *btv)
 	/* vbi */
 	vdev_init(btv, &btv->vbi_dev, &bttv_video_template, "vbi");
 	btv->vbi_dev.device_caps = V4L2_CAP_VBI_CAPTURE | V4L2_CAP_READWRITE |
-				   V4L2_CAP_STREAMING | V4L2_CAP_TUNER;
+				   V4L2_CAP_STREAMING;
 	if (btv->tuner_type != TUNER_ABSENT)
 		btv->vbi_dev.device_caps |= V4L2_CAP_TUNER;
 
-- 
Ondrej Zary

