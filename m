Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848CD4DC43F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiCQKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCQKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:50:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DE171ECC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:49:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so4739889wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=u68S3XKSCZAMP62m3aNQ/j4jRRcnjMgWixQrjLmtpDw=;
        b=YlAQwBJxPiG/VXPkVpppT1k9Odb0GLO5SH77/VCll+er9qw7gLViZ882/nb39B/ltK
         oIOu+0XFogHAx3EcDK3qXjo0N/CgackhvDEbJnZ3Q3BPdF8TAjFJRO0Bzg6S58desIIq
         E3NXPvzU4QIFqbIqGE4bE5+VXbA9j8HRMuhws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=u68S3XKSCZAMP62m3aNQ/j4jRRcnjMgWixQrjLmtpDw=;
        b=fYypgXBXXb7vx87AM8u9z/0gKQ9/aPpB0KEkBSCEtRJKKpuv1JnQJ9LnAWp02mub0E
         YZQNr1ytyFlVMC2cbqV/Vrs2lbFZTQZhNPhYKZJ4k4DGPcutmqRhP+nlDIRWZmN4DEP1
         XijJxZ59apIvbsktSXz3r8Byt/RAHdV8JAZUwpG72jgmyyeYWle2jSxZLc1dfiRPH+u6
         skm9lH3T58aLM6Gf0eqPEpQj9uEASq8hdHgO+FP7tSfbg0VRpwQJDFUTFHWgVneBV5dO
         fREiDDuxDOQ1Xehe9KSNqIf/TemYkOac1mfinjwcnel5igusiB6T9ITresKeukb0VmUl
         rZqg==
X-Gm-Message-State: AOAM5325IllVf0083oKaKrHY0WC25ewvJPURzXtz4uOrUi6gplF4WJFP
        pDv+cubX/5Gx6VIXjU4GWw8ZAw==
X-Google-Smtp-Source: ABdhPJzhQ1kqm4iylqrPFAuFVextJ5iiugEB6SMDkQIya6R32kfH/2J59AU4VzEDcOHoG6pKAfV8cA==
X-Received: by 2002:a1c:1941:0:b0:38b:4af1:49f8 with SMTP id 62-20020a1c1941000000b0038b4af149f8mr10937295wmz.156.1647514162494;
        Thu, 17 Mar 2022 03:49:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm3827570wrt.40.2022.03.17.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:49:21 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:49:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: drm_bufs: Error out if 'dev->agp' is a null pointer
Message-ID: <YjMSMIrbsVZjEw8W@phenom.ffwll.local>
Mail-Followup-To: Zheyu Ma <zheyuma97@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1646983382-30036-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646983382-30036-1-git-send-email-zheyuma97@gmail.com>
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

On Fri, Mar 11, 2022 at 07:23:02AM +0000, Zheyu Ma wrote:
> The user program can control the 'drm_buf_desc::flags' via ioctl system
> call and enter the function drm_legacy_addbufs_agp(). If the driver
> doesn't initialize the agp resources, the driver will cause a null
> pointer dereference.
> 
> The following log reveals it:
>     general protection fault, probably for non-canonical address
>     0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN PTI
>     KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
>     Call Trace:
>      <TASK>
>      drm_ioctl_kernel+0x342/0x450 drivers/gpu/drm/drm_ioctl.c:785
>      drm_ioctl+0x592/0x940 drivers/gpu/drm/drm_ioctl.c:885
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:874 [inline]
>      __se_sys_ioctl+0xaa/0xf0 fs/ioctl.c:860
>      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      do_syscall_64+0x43/0x90 arch/x86/entry/common.c:80
>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fix this bug by adding a check.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

You can only hit this if you enabled a DRIVER_LEGACY drm driver, which
opens you up to tons of other CVEs and issues. What's your .config?
-Daniel

> ---
>  drivers/gpu/drm/drm_bufs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index fcca21e8efac..4fe2363b1e34 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -734,7 +734,7 @@ int drm_legacy_addbufs_agp(struct drm_device *dev,
>  	int i, valid;
>  	struct drm_buf **temp_buflist;
>  
> -	if (!dma)
> +	if (!dma || !dev->agp)
>  		return -EINVAL;
>  
>  	count = request->count;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
