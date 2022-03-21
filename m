Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D14E2725
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiCUNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiCUNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:04:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088B139
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q5so3435752plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0+Od+n3mnWlR1TFnZchNIM/GdPKAtnY5SiiOvRmnTM=;
        b=TCPJaBfk/04kAILw2uiGrNaftNH9rQ97oP9XPr+Tw3Np45GpB54yTeD1xVrqeZacs3
         jiy3+GouTv3s3In9ka4KOR2pRXI17ndtyPqDGgIZ9zP+D5AMGAA2NPqGkFvQhIvE5rOK
         NaGaHytUZ3RDlJuD14pxML2uO+2+zW5WLB0dkuGIfGTY3GIOOXq/ey4AsQ5JPbm1UG7M
         J3s8GsvanGd943MBqM5TQZQaJtD9uoV1PaacM6A3eoIC0h0Mc5MERcvdqqcWg/HS6FdC
         aec1GaumZX7AdaaJSV+oUn3zHAwgV4bgOWrDRjVdoU+nr9ZgA2twTijxwBqYPEGGi97q
         KUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0+Od+n3mnWlR1TFnZchNIM/GdPKAtnY5SiiOvRmnTM=;
        b=dxRuchjHwa5grK9L6Tfp3Ve9vBTUNAKBGVehanRYmzPYAsecswZgxwfqs1PCkMAzg1
         n2AVeeVQ9TP6uqTmO5F3H1nFMHmPdF6XUuZpJVw863ZBTuqyLN2VD+NpKVRk80MhM/QS
         X3lDwCBmNrSlJmA+KFk+imwXYba8CxXRPL8llVW7k19heMRp3MGXL6FvEFYjo/izUfg1
         BUPl7ekqBB+IhTvUPb418ATb0EzC3kwA3p58tPe7vFEdpsSy0KQuV26D9y6U/D4NaT1r
         ltcUXodj2/MQE19S4an4I1azdVHcDI+rqWdRWcwsjO7wZaMzJ1TVfus1jJooKt7e8L4T
         w/MA==
X-Gm-Message-State: AOAM530Rm7eS4Ns8NQyMhbtc2RgDd3x3ERIeIsB6tFv4mhzdXiKQVxPp
        s854qJHL3QQK/od4iHVkMOnAzDkqNko7M1F7eg==
X-Google-Smtp-Source: ABdhPJzLokYAQATmpIhBzFgbYbD9l6L/7rTAW/yvbzvu2aqQnL7tbRXM0shHvgx/qEZKeovVUqevpxUyFPhc0O9ZglU=
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id
 lw3-20020a17090b180300b001c724c4ab52mr3894290pjb.240.1647867780606; Mon, 21
 Mar 2022 06:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <1646983382-30036-1-git-send-email-zheyuma97@gmail.com> <YjMSMIrbsVZjEw8W@phenom.ffwll.local>
In-Reply-To: <YjMSMIrbsVZjEw8W@phenom.ffwll.local>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 21 Mar 2022 21:02:47 +0800
Message-ID: <CAMhUBjkohp=-4YZ7x6Yyf4tQr_2zCoR+RVmEZPGLoXTEhNoPFA@mail.gmail.com>
Subject: Re: [PATCH] drm: drm_bufs: Error out if 'dev->agp' is a null pointer
To:     Zheyu Ma <zheyuma97@gmail.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 6:49 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Mar 11, 2022 at 07:23:02AM +0000, Zheyu Ma wrote:
> > The user program can control the 'drm_buf_desc::flags' via ioctl system
> > call and enter the function drm_legacy_addbufs_agp(). If the driver
> > doesn't initialize the agp resources, the driver will cause a null
> > pointer dereference.
> >
> > The following log reveals it:
> >     general protection fault, probably for non-canonical address
> >     0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN PTI
> >     KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> >     Call Trace:
> >      <TASK>
> >      drm_ioctl_kernel+0x342/0x450 drivers/gpu/drm/drm_ioctl.c:785
> >      drm_ioctl+0x592/0x940 drivers/gpu/drm/drm_ioctl.c:885
> >      vfs_ioctl fs/ioctl.c:51 [inline]
> >      __do_sys_ioctl fs/ioctl.c:874 [inline]
> >      __se_sys_ioctl+0xaa/0xf0 fs/ioctl.c:860
> >      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >      do_syscall_64+0x43/0x90 arch/x86/entry/common.c:80
> >      entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Fix this bug by adding a check.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
> You can only hit this if you enabled a DRIVER_LEGACY drm driver, which
> opens you up to tons of other CVEs and issues. What's your .config?

Yes, I enable the DRM_LEGACY option in the config.
I think you mean this is not a normal configuration file? Do you have
a recommended configuration option for when I want to test the GPU
driver?

Actually, I use the following configs related to GPU:

CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y
CONFIG_DRM_RADEON=y
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_GMA500=y
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
CONFIG_DRM_QXL=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_GM12U320=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_GUD=y
CONFIG_DRM_HYPERV=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_R128=y
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

Thanks,
Zheyu Ma
