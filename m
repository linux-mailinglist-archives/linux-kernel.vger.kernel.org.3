Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA64BBDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiBRQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiBRQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:42:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EA1954D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:42:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so16372615ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NJFZ3jit1chzQSDay79B6keWsZIR8EarnNGHw6lS5A=;
        b=DHRCvWEUqlZ11SBmiaPTfaEu3Yo1jAIFR55Bv9awW3zHDU8MgB38YYiwE3k1tsP9IM
         HqYXGe1BdnOx8rUHDoZonAC2XarFEFOq4v+c/5lTITz2d4w2dSyXrCk5BKXI1rrD4q1n
         C1tJUzze9zYJQJ54SlFmxZLOcTT0mjNLdJf6M5Z5XvN2S2K5JzW10lrPTXbUXrHFtW/b
         fhxgg8Rmc1ejll3eRtaCBFAqDw0UlRROVgZCHtBBBIsmpUcv4R2LGPHHHx6+Gludoddw
         wJtnSnScemddJo4gD/IItWmvriTj2IS1Kd/r+/FfGDLltEmVRoPQLSdlJvU6O+KX+WQQ
         Iyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NJFZ3jit1chzQSDay79B6keWsZIR8EarnNGHw6lS5A=;
        b=EJeD4MvDvinzQuIsRkwN0W+Iou2pfaqOqo+iia5SbU/RwVxXF6pRm9daWI0pwx2LcO
         OCnEmd+KMtowYr5Wqc7KIIjyVdxk/gQVwHN2vOr1HVue4bk2oePNqPltZizk1ARorvO3
         vo4eAmwy8ZSU6dDAvmiFUTNE2uY0F3bthjIshhkTHufdZ/mJ9U3noJ4D+v+TeU00V0U+
         fuvpDT3KXSZ1YIfEzoQRr1NilcNEaex+nu4WQiXhlJYJppi1N0QpnoWHX1yrH0PTStYn
         WNdrB+7YM0kqcTCm2TKwPebQPpmVZi0jPEQZbvlaVkzOXq9IjVIX3g3ZD0wRalHAL1sv
         LuTA==
X-Gm-Message-State: AOAM533xC6xS3JNIVmyYrsEbO+GmeCxJFmrruTinIu/ZPCNV9zJExcaA
        0FS6m0l/g0jiHJRrReX8u8MpFjwlq7I9OQFwPN9z8sjM
X-Google-Smtp-Source: ABdhPJxMYiQ2RRshnCbmjcn6dcHzICLifg4wwcX0owuwZ4uHR6ntkXXhuxL+HAeJ/wF4RPQrvng6ji7o3qRH97h+mxk=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr7050936eja.493.1645202553886; Fri, 18
 Feb 2022 08:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20220218155725.487785-1-robdclark@gmail.com>
In-Reply-To: <20220218155725.487785-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 18 Feb 2022 08:42:22 -0800
Message-ID: <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
To:     Rob Clark <robdclark@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> With native userspace drivers in guest, a lot of GEM objects need to be
> neither shared nor mappable.  And in fact making everything mappable
> and/or sharable results in unreasonably high fd usage in host VMM.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> This is for a thing I'm working on, a new virtgpu context type that
> allows for running native userspace driver in the guest, with a
> thin shim in the host VMM.  In this case, the guest has a lot of
> GEM buffer objects which need to be neither shared nor mappable.
>
> Alternative idea is to just drop the restriction that blob_flags
> be non-zero.  I'm ok with either approach.
Dropping the restriction sounds better to me.

What is the use case for such a resource?  Does the host need to know
such a resource exists?

>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
>  include/uapi/drm/virtgpu_drm.h         | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 69f1952f3144..92e1ba6b8078 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,8 @@
>
>  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>                                     VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +                                   VIRTGPU_BLOB_FLAG_USE_INTERNAL)
>
>  static int virtio_gpu_fence_event_create(struct drm_device *dev,
>                                          struct drm_file *file,
> @@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>         params->size = rc_blob->size;
>         params->blob = true;
>         params->blob_flags = rc_blob->blob_flags;
> +
> +       /* USE_INTERNAL is local to guest kernel, don't past to host: */
> +       params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
> +
>         return 0;
>  }
>
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..62b7483e5c60 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
>  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
>         /* zero is invalid blob_mem */
>         __u32 blob_mem;
>         __u32 blob_flags;
> --
> 2.34.1
>
