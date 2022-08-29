Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADED5A4E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH2N2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiH2N1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:27:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD4883F7;
        Mon, 29 Aug 2022 06:26:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 76so8181536pfy.3;
        Mon, 29 Aug 2022 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=WG09mAhXQQfAx9IYst4qrimV9OzP+6WFIUz0RFuN5Cs=;
        b=Sg4v28g92GjGFLglKL5FXlD6atfNS+815wMSBDIDkP3bmO6+3HRaRAtegUPWrnfqV7
         z4m7Km8/vk0XlC7pVyGWdaGscHGV0Khj+okBm56CZTbuPagAMHgXJxRJCl/uS4ayUrr1
         oIS9SVUtNBaP4mwBLqQBC003qh857tPtds6C2juZ2Mker3YVXkNVMTMTC/HmK8jH5tR5
         1UsZmWDvGO1uiDFmY6ufuQ+W0Gt621KcmmLWiuMvVwDzLUhhQhNJY1iX5bRPUlfBQVWE
         p5WXOrxRjY/0vdmOFVftBWWrbm5unFunkFYTE3bAD9aOR4TmD0esz5vf9eyFJ+EuOMl4
         OzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WG09mAhXQQfAx9IYst4qrimV9OzP+6WFIUz0RFuN5Cs=;
        b=gbSkMlYq9Q7nvt1YL7qGa6ru9ZURzo1ezaIrPE9TPWBnCWgSwjJ0uU2qPpL5JPzN1O
         3Y4E43U16ffwvomgJ2K0ncppIvlkPzyx1hDzrMOatV0OWPmzM3MzV+MKPiWUOzMxMmtI
         FrXzDDlpPDS5Z6OOjTFiYi+fRxKvxBjBTPJ99Juky1yR16I7vnvcpNSr6Wasiz/P4VvD
         yZO0C3iWrEyyQlT6T0/HLpqeWGFoWSSwoO4/pQy1yrvc57weYxyWYKSrkwhr0cM2lGge
         0wKiMENPZw/hlXfGBO6gxPGq9peJWMK+8sxHkcBYUiijC5QjcFm7SP2O/mMY3Ub48pEc
         9n7Q==
X-Gm-Message-State: ACgBeo00XdMIXZwz6r3rbX4DQ1uhvQW26XDodh6FSpcbS5xD+HYSZJqj
        nbFHpR1ziUD8RvzBkBn+kS+HxtbVy6xyaw==
X-Google-Smtp-Source: AA6agR4iICr0MS6GylHzeQ7syjs6ibXQZYH8UN6xLgOVnE+vPLhhH3u9CZ+A0QdXKknbzZONJVZsDA==
X-Received: by 2002:a63:2b02:0:b0:41d:9b5e:7d69 with SMTP id r2-20020a632b02000000b0041d9b5e7d69mr13499645pgr.165.1661779562545;
        Mon, 29 Aug 2022 06:26:02 -0700 (PDT)
Received: from Negi ([207.151.52.7])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090332c500b0017292073839sm1381370plr.178.2022.08.29.06.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:26:01 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH] media: em28xx: Enable v4l2 file ops at the end of em28xx_v4l2_init()
Date:   Mon, 29 Aug 2022 06:25:48 -0700
Message-Id: <20220829132548.23520-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix syzbot bug KASAN: use-after-free Read in v4l2_fh_open
Syzbot link:
https://syzkaller.appspot.com/bug?id=0e3c97f1c4112e102c9988afd5eff079350eab7f
Repro: https://syzkaller.appspot.com/text?tag=ReproC&x=12663ebdd00000

The bug arises because the em28xx driver registers a v4l2 video
device(struct video_device) with the V4L2 interface in
em28xx_v4l2_init() but the v4l2 extension initialization eventually
fails and the video device is unregistered. v4l2_open() in the V4L2
interface views the device as registered and allows calls to
em28xx_v4l2_open(). Due to race between video_unregister_device() and
v4l2_open(), em28xx_v4l2_open() is accessing video device after it has
been freed(by the release callback) and is passing it on to
v4l2_fh_open().

In em28xx_v4l2_init(), temporarily disable v4l2 file operations on
struct video_device devices(video, vbi, radio) before registering them
and enable the file ops at the end when v4l2 extension initialization
succeeds.

Reported-by: syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-video.c | 45 +++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 8181c0e6a25b..900a1eacb1c7 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2320,6 +2320,19 @@ static int em28xx_v4l2_close(struct file *filp)
 	return 0;
 }
 
+/* Used to temporarily disable file operations on video_device until successful
+ * initialization in em28xx_v4l2_init().
+ */
+static const struct v4l2_file_operations em28xx_v4l_fops_empty = {
+	.owner         = THIS_MODULE,
+	.open          = NULL,
+	.release       = NULL,
+	.read          = NULL,
+	.poll          = NULL,
+	.mmap          = NULL,
+	.unlocked_ioctl = NULL,
+};
+
 static const struct v4l2_file_operations em28xx_v4l_fops = {
 	.owner         = THIS_MODULE,
 	.open          = em28xx_v4l2_open,
@@ -2375,12 +2388,22 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
 };
 
 static const struct video_device em28xx_video_template = {
-	.fops		= &em28xx_v4l_fops,
+	.fops		= &em28xx_v4l_fops_empty,
 	.ioctl_ops	= &video_ioctl_ops,
 	.release	= video_device_release_empty,
 	.tvnorms	= V4L2_STD_ALL,
 };
 
+/* Used to temporarily disable file operations on video_device until successful
+ * initialization in em28xx_v4l2_init().
+ */
+static const struct v4l2_file_operations radio_fops_empty = {
+	.owner         = THIS_MODULE,
+	.open          = NULL,
+	.release       = NULL,
+	.unlocked_ioctl = NULL,
+};
+
 static const struct v4l2_file_operations radio_fops = {
 	.owner         = THIS_MODULE,
 	.open          = em28xx_v4l2_open,
@@ -2404,7 +2427,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
 };
 
 static struct video_device em28xx_radio_template = {
-	.fops		= &radio_fops,
+	.fops		= &radio_fops_empty,
 	.ioctl_ops	= &radio_ioctl_ops,
 	.release	= video_device_release_empty,
 };
@@ -2833,9 +2856,6 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 				"can't register radio device\n");
 			goto unregister_dev;
 		}
-		dev_info(&dev->intf->dev,
-			 "Registered radio device as %s\n",
-			 video_device_node_name(&v4l2->radio_dev));
 	}
 
 	/* Init entities at the Media Controller */
@@ -2851,14 +2871,27 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 	}
 #endif
 
+	/* Enable v4l2 file operations for v4l2 video video_device */
+	v4l2->vdev.fops = &em28xx_v4l_fops;
 	dev_info(&dev->intf->dev,
 		 "V4L2 video device registered as %s\n",
 		 video_device_node_name(&v4l2->vdev));
 
-	if (video_is_registered(&v4l2->vbi_dev))
+	if (video_is_registered(&v4l2->vbi_dev)) {
+		/* Enable v4l2 file operations for v4l2 vbi video_device */
+		v4l2->vbi_dev.fops = &em28xx_v4l_fops;
 		dev_info(&dev->intf->dev,
 			 "V4L2 VBI device registered as %s\n",
 			 video_device_node_name(&v4l2->vbi_dev));
+	}
+
+	if (video_is_registered(&v4l2->radio_dev)) {
+		/* Enable v4l2 file operations for v4l2 radio video_device */
+		v4l2->radio_dev.fops = &radio_fops;
+		dev_info(&dev->intf->dev,
+			 "Registered radio device as %s\n",
+			 video_device_node_name(&v4l2->radio_dev));
+	}
 
 	/* Save some power by putting tuner to sleep */
 	v4l2_device_call_all(&v4l2->v4l2_dev, 0, tuner, standby);
-- 
2.17.1

