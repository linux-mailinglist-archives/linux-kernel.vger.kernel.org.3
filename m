Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69463518A53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiECQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbiECQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C032E6B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651596381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TrllH04Z0FbJPqB+LsRh6m4pc02+JciRd8et3EmsDus=;
        b=e52gLVeXFX7zxkUjpZDVVvpbJbfwi262wwrPT78Jm5BSQ4q9ZVJ33ZAS8iojdV6nghJjQW
        JMvZAZsmtQaJe1kOQBNSqnvDvdF26T3HWWW80hSiEEHpXawVpvKXYIg8FiijtD4Ej8wNxq
        VahFy6Di7VoNoZRU1ICzKVkFP2r2aJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341--lX_ItTLPp-welrokSauuw-1; Tue, 03 May 2022 12:46:24 -0400
X-MC-Unique: -lX_ItTLPp-welrokSauuw-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso1596929wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrllH04Z0FbJPqB+LsRh6m4pc02+JciRd8et3EmsDus=;
        b=K4vRX62T5gJl5426XJcJWlRt28f7KX+M0MygcQN90G1vVrBOsAGkoFkhgnSkBjI+Zz
         2NBCbgJUi1gAk+8xPwEZeu6AZZK3OFAt3/Mcw+n5nIACSwc8p2uElOdaJ3u8QvoI3hUF
         evvtPM5gQu7oYgxP0AqxbeyYj4b/DfMcxj/JKZc7GMpywYT5ETFrB/xXI4RGQD1sExqN
         yxqYctMXhl5LHwuzb0OXmUvF4A/scKnEGVV6O8Dx/1guqFKIckAAe8ZPDlrg0eKQiVOd
         pI3GWBw6mviTwYG9iBVTRgpYseKW/dTIeHsLobGctJGvr0BFMWNAv1s/60J9ytgAmdI8
         ZEbw==
X-Gm-Message-State: AOAM533fsFfFZuNWr7RNjJRwGQqPnwECnX1zZunlFcJbxYose061jbnk
        zfGhCg9new3vUEeIBKQL9OKHRjJJNBbOMKMiv7kXpEO4aMjwx/eLiEsyy/z5+LNdqEe9WrGTFfD
        5AuAMbdvHRVM8uaTjnz/DJGiIyyXYkh14oaXgABQh/KRVlFWt+A4ADvM6lG7Hqiel9miU1bDYU8
        c=
X-Received: by 2002:a05:6000:381:b0:20c:6911:f85b with SMTP id u1-20020a056000038100b0020c6911f85bmr6156742wrf.406.1651596382439;
        Tue, 03 May 2022 09:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkoJMsy81rmxcDC++KPTzOsGoeFw5o8PT1mfBlyxN/nPJryyfAclRKStt6h+SOtC5xpxk/lw==
X-Received: by 2002:a05:6000:381:b0:20c:6911:f85b with SMTP id u1-20020a056000038100b0020c6911f85bmr6156722wrf.406.1651596382079;
        Tue, 03 May 2022 09:46:22 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f11-20020adfc98b000000b0020c5253d910sm10464327wrh.92.2022.05.03.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:46:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: Use helper to get fb_info in all file operations
Date:   Tue,  3 May 2022 18:46:16 +0200
Message-Id: <20220503164616.663796-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reference to the framebuffer device struct fb_info is stored in the file
private data, but this reference could no longer be valid and must not be
accessed directly. Instead, the file_fb_info() accessor function must be
used since it does sanity checking to make sure that the fb_info is valid.

This can happen for example if the registered framebuffer device is for a
driver that just uses a framebuffer provided by the system firmware. In
that case, the fbdev core would unregister the framebuffer device when a
real video driver is probed and ask to remove conflicting framebuffers.

Most fbdev file operations already use the helper to get the fb_info but
get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.

Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
exported. Rename it and add a fb_ prefix to denote that is public now.

Reported-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fb_defio.c |  5 ++++-
 drivers/video/fbdev/core/fbmem.c    | 24 +++++++++++++++---------
 include/linux/fb.h                  |  1 +
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 842c66b3e33d..ac1c88b3fbb5 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -68,12 +68,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fb_info *info = file->private_data;
+	struct fb_info *info = fb_file_fb_info(file->private_data);
 	struct inode *inode = file_inode(file);
 	int err = file_write_and_wait_range(file, start, end);
 	if (err)
 		return err;
 
+	if (!info)
+		return -ENODEV;
+
 	/* Skip if deferred io is compiled-in but disabled on this fbdev */
 	if (!info->fbdefio)
 		return 0;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..f924fda89dd5 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -745,7 +745,7 @@ static const struct seq_operations __maybe_unused proc_fb_seq_ops = {
  * So look up the fb_info using the inode minor number,
  * and just verify it against the reference we have.
  */
-static struct fb_info *file_fb_info(struct file *file)
+struct fb_info *fb_file_fb_info(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	int fbidx = iminor(inode);
@@ -755,12 +755,13 @@ static struct fb_info *file_fb_info(struct file *file)
 		info = NULL;
 	return info;
 }
+EXPORT_SYMBOL(fb_file_fb_info);
 
 static ssize_t
 fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	u8 *buffer, *dst;
 	u8 __iomem *src;
 	int c, cnt = 0, err = 0;
@@ -825,7 +826,7 @@ static ssize_t
 fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	u8 *buffer, *src;
 	u8 __iomem *dst;
 	int c, cnt = 0, err = 0;
@@ -1181,7 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 static long fb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 
 	if (!info)
 		return -ENODEV;
@@ -1293,7 +1294,7 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	const struct fb_ops *fb;
 	long ret = -ENOIOCTLCMD;
 
@@ -1333,7 +1334,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
-	struct fb_info *info = file_fb_info(file);
+	struct fb_info *info = fb_file_fb_info(file);
 	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);
 	unsigned long mmio_pgoff;
 	unsigned long start;
@@ -1434,7 +1435,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
+	struct fb_info * const info = fb_file_fb_info(file);
 
 	if (!info)
 		return -ENODEV;
@@ -1453,8 +1454,13 @@ unsigned long get_fb_unmapped_area(struct file *filp,
 				   unsigned long addr, unsigned long len,
 				   unsigned long pgoff, unsigned long flags)
 {
-	struct fb_info * const info = filp->private_data;
-	unsigned long fb_size = PAGE_ALIGN(info->fix.smem_len);
+	struct fb_info * const info = fb_file_fb_info(filp->private_data);
+	unsigned long fb_size;
+
+	if (!info)
+		return -ENODEV;
+
+	fb_size = PAGE_ALIGN(info->fix.smem_len);
 
 	if (pgoff > fb_size || len > fb_size - pgoff)
 		return -EINVAL;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 9a77ab615c36..3004b8b8c5c2 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -624,6 +624,7 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
+extern struct fb_info *fb_file_fb_info(struct file *file);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
-- 
2.35.1

