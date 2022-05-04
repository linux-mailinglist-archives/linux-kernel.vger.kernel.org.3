Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26820519B11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbiEDJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiEDJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:05:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A981705B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:02:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so948567ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhndyTT3maGZiAt0VIXmk9ojwipHh1tBvR08g6Y8wbY=;
        b=aUdVF4hTZJ2iodKlUTL2ABAvHDQQYds/pov8mu91chnXAOaQB+ec/CHuAPmD7KXQby
         CxVFCCZdiKI1bVwk2GVWLdWhER3xH8r3KRPhjgNvqK78TDf2htH3CpQ55OsPjgIbwkU9
         xpG4dafCFnGawZisCeK50IzGU64GqC61zCh0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nhndyTT3maGZiAt0VIXmk9ojwipHh1tBvR08g6Y8wbY=;
        b=kpfhT815PCKOKqrsZ/H6kDNP28iY0bN231NWRu7AmkO6TlDQ7JQm40oDKmv2831kIW
         6/YRlxZPDyTJhZvBbfImxXGITRmykR5MqNO43H8Ez4zaVmH0vwXSzWuKWkXoej6VWFNr
         +oZhOvhW7SRZXOn3NFdCLPcbbw21saH/vRl2sMGmmW80qlLPCi8WUpnWHj1nJnn6by6j
         +cJwuS4nne4Zn4dYov18ZwjEYMpZknWE6fHzumWSxzJC8N3zHlr2QSkBLFQudNcJvgFJ
         Kl7IW+3cY6OCURfQymShSnekIiuF//4txIJcqRhJXUOE74v7tB3M6j/LAM4r7oEHm7yp
         YoFw==
X-Gm-Message-State: AOAM530ljgsCjHQWjByneqKWJZDkxrdn0gC6GTnMx2HPce0cd5xr4RdL
        l6SgZDqS+2+S3rS2BGMgjcRzhg==
X-Google-Smtp-Source: ABdhPJydbrmVMpMpHUoG6+X4RS7I2ncthUKo2iGYOUga4BWWoLfx7wqzDHR/irWAZjEgHUrnZOQT1A==
X-Received: by 2002:a05:6402:294e:b0:425:f016:24e7 with SMTP id ed14-20020a056402294e00b00425f01624e7mr22012096edb.111.1651654940915;
        Wed, 04 May 2022 02:02:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d2-20020a170907272200b006f3ef214e1esm5494655ejl.132.2022.05.04.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:02:20 -0700 (PDT)
Date:   Wed, 4 May 2022 11:02:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Message-ID: <YnJBGpvlViLV+0/a@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220503201934.681276-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503201934.681276-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 10:19:34PM +0200, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the registered framebuffer device is for a
> driver that just uses a framebuffer provided by the system firmware. In
> that case, the fbdev core would unregister the framebuffer device when a
> real video driver is probed and ask to remove conflicting framebuffers.
> 
> Most fbdev file operations already use the helper to get the fb_info but
> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
> 
> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
> exported. Rename it and add a fb_ prefix to denote that is public now.
> 
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Note that fb_file_info is hilariously racy since there's nothing
preventing a concurrenct framebuffer_unregister. Or at least I'm not
seeing anything. See cf4a3ae4ef33 ("fbdev: lock_fb_info cannot fail") for
context, maybe reference that commit here in your patch.

Either way this doesn't really make anything worse, so
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> ---
> 
> Changes in v2:
> - Fix copy & paste error passing file->private_data instead of file
>   to fb_file_fb_info() function (Sam Ravnborg).
> 
>  drivers/video/fbdev/core/fb_defio.c |  5 ++++-
>  drivers/video/fbdev/core/fbmem.c    | 24 +++++++++++++++---------
>  include/linux/fb.h                  |  1 +
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index 842c66b3e33d..ccdf903c48bd 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -68,12 +68,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
>  
>  int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  {
> -	struct fb_info *info = file->private_data;
> +	struct fb_info *info = fb_file_fb_info(file);
>  	struct inode *inode = file_inode(file);
>  	int err = file_write_and_wait_range(file, start, end);
>  	if (err)
>  		return err;
>  
> +	if (!info)
> +		return -ENODEV;
> +
>  	/* Skip if deferred io is compiled-in but disabled on this fbdev */
>  	if (!info->fbdefio)
>  		return 0;
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 97eb0dee411c..ba2c14a1087d 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -745,7 +745,7 @@ static const struct seq_operations __maybe_unused proc_fb_seq_ops = {
>   * So look up the fb_info using the inode minor number,
>   * and just verify it against the reference we have.
>   */
> -static struct fb_info *file_fb_info(struct file *file)
> +struct fb_info *fb_file_fb_info(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
>  	int fbidx = iminor(inode);
> @@ -755,12 +755,13 @@ static struct fb_info *file_fb_info(struct file *file)
>  		info = NULL;
>  	return info;
>  }
> +EXPORT_SYMBOL(fb_file_fb_info);
>  
>  static ssize_t
>  fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	unsigned long p = *ppos;
> -	struct fb_info *info = file_fb_info(file);
> +	struct fb_info *info = fb_file_fb_info(file);
>  	u8 *buffer, *dst;
>  	u8 __iomem *src;
>  	int c, cnt = 0, err = 0;
> @@ -825,7 +826,7 @@ static ssize_t
>  fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>  {
>  	unsigned long p = *ppos;
> -	struct fb_info *info = file_fb_info(file);
> +	struct fb_info *info = fb_file_fb_info(file);
>  	u8 *buffer, *src;
>  	u8 __iomem *dst;
>  	int c, cnt = 0, err = 0;
> @@ -1181,7 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  
>  static long fb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> -	struct fb_info *info = file_fb_info(file);
> +	struct fb_info *info = fb_file_fb_info(file);
>  
>  	if (!info)
>  		return -ENODEV;
> @@ -1293,7 +1294,7 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
>  static long fb_compat_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
> -	struct fb_info *info = file_fb_info(file);
> +	struct fb_info *info = fb_file_fb_info(file);
>  	const struct fb_ops *fb;
>  	long ret = -ENOIOCTLCMD;
>  
> @@ -1333,7 +1334,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
>  static int
>  fb_mmap(struct file *file, struct vm_area_struct * vma)
>  {
> -	struct fb_info *info = file_fb_info(file);
> +	struct fb_info *info = fb_file_fb_info(file);
>  	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);
>  	unsigned long mmio_pgoff;
>  	unsigned long start;
> @@ -1434,7 +1435,7 @@ fb_release(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
>  __releases(&info->lock)
>  {
> -	struct fb_info * const info = file_fb_info(file);
> +	struct fb_info * const info = fb_file_fb_info(file);
>  
>  	if (!info)
>  		return -ENODEV;
> @@ -1453,8 +1454,13 @@ unsigned long get_fb_unmapped_area(struct file *filp,
>  				   unsigned long addr, unsigned long len,
>  				   unsigned long pgoff, unsigned long flags)
>  {
> -	struct fb_info * const info = filp->private_data;
> -	unsigned long fb_size = PAGE_ALIGN(info->fix.smem_len);
> +	struct fb_info * const info = fb_file_fb_info(filp);
> +	unsigned long fb_size;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	fb_size = PAGE_ALIGN(info->fix.smem_len);
>  
>  	if (pgoff > fb_size || len > fb_size - pgoff)
>  		return -EINVAL;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 9a77ab615c36..3004b8b8c5c2 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -624,6 +624,7 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>  			      struct fb_fix_screeninfo *fix);
>  extern int fb_get_options(const char *name, char **option);
>  extern int fb_new_modelist(struct fb_info *info);
> +extern struct fb_info *fb_file_fb_info(struct file *file);
>  
>  extern struct fb_info *registered_fb[FB_MAX];
>  extern int num_registered_fb;
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
