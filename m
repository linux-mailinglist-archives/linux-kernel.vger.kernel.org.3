Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE250C405
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiDVWPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiDVWPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:15:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7F23E3F2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:05:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so6034864wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmRkt5N52LVAcW5jIpeF1Nn5yhhAyoF29FUFsd01Fns=;
        b=brYIpV1+gbZnACdgtobiaHYB0nSPaEQY0ScB0C1CEeIsPotvLvC9d7oCAEPCZgA89C
         uxr4XWWt08JrUjRW2taPLwIBI0l08LIQ+tdBDD3Dcvl2N+LHeNiiWLLSiJ/2nAXSmxbW
         5V6Qt8AQIHi92IOyOLysC7CDhQRUu7lZDi7hKcHVobTK+mt9yg3GXLl1gnF6CUN511k8
         2dACgkZB0zdoeD223DTUdfjYRFediBrQ/WkFCx20AwAddSmuDegIlAyVpQMaA+YkJeVl
         i9/jYTuvmZKVUkEHz5l8/VZdcoi46D7lI/zvaAmJgrcM3qXnC1vMcqvjxQtND51sdUpm
         7npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmRkt5N52LVAcW5jIpeF1Nn5yhhAyoF29FUFsd01Fns=;
        b=Mv9TphPu+oSFPk1fFbitWobXuhyUXSDdtoyZHkv1SnMimvK90ilUOHDON/sDvijY25
         MR7qNBSzKG2mT7f0p0XdrRsvdYDGfRPgLFwkf4UDGKw9P+9MjUVRcfmIybBgLas0/aZ3
         Qfwuk02nXuBlUFS9WfOd7jCPyZAgWjh8mn5ixF+h0l4w3ciHEK1slVzFZZkecB0+HQVr
         sQ9dssKWAEEKNF+bg7MWICfY+EQZbSOzll7rOn0MNAkn9Bs6QiEp8nj3+BP971pKWlX3
         2ddNflF+xovKHTUjZTr0C+m70imqHeD9doPe8/YH+20gts2tlYvQQgwf32s89cxyOiKx
         M0IQ==
X-Gm-Message-State: AOAM533A/lBUhU3DFiOzReSyVCwV7CmkQ3qTM0SDlWCdfNk//PdTnCGs
        n6FkLFvzwIuVZgG30uRcKdnFHWLx9/vO5Wr+u9o=
X-Google-Smtp-Source: ABdhPJwKs/6J6K59SHxPCUJVmRs3c/Et02MftfleiTfkZ7qpvT/EN+91VaTZjZn+ojcG4yAIgaCF1NrTLKUqpfpuOBY=
X-Received: by 2002:a05:600c:3011:b0:38e:ba57:8b79 with SMTP id
 j17-20020a05600c301100b0038eba578b79mr14709846wmh.26.1650661503393; Fri, 22
 Apr 2022 14:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220405173918.1000846-1-robdclark@gmail.com> <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
In-Reply-To: <CAPaKu7Tur-_Kf3Lb9U=98Yr_08onxPHNKTPh2anHU6zLPhr5ZQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 22 Apr 2022 14:06:08 -0700
Message-ID: <CAF6AEGsUVDbqYOeDBXBOySfs+7ftVf5_86CiFGOLfY9fmQuEVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
To:     Chia-I Wu <olvaffe@gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 10:57 AM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Tue, Apr 5, 2022 at 10:38 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > It would have been cleaner to have a flag to *request* the fence event.
> > But that ship has sailed.  So add a flag so that userspace which doesn't
> > care about the events can opt-out.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
>
> Might want to wait for Gurchetan to chime in as he added the mechanism.

It turns out this patch is unnecessary.. I can simply not set
VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK instead

so self-nak for this patch ;-)

BR,
-R

> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
> >  include/uapi/drm/virtgpu_drm.h         | 2 ++
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index 3a8078f2ee27..09f1aa263f91 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >                 goto out_unresv;
> >         }
> >
> > -       ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> > -       if (ret)
> > -               goto out_unresv;
> > +       if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
> > +               ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
> > +               if (ret)
> > +                       goto out_unresv;
> > +       }
> >
> >         if (out_fence_fd >= 0) {
> >                 sync_file = sync_file_create(&out_fence->f);
> > diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> > index 0512fde5e697..d06cac3407cc 100644
> > --- a/include/uapi/drm/virtgpu_drm.h
> > +++ b/include/uapi/drm/virtgpu_drm.h
> > @@ -52,10 +52,12 @@ extern "C" {
> >  #define VIRTGPU_EXECBUF_FENCE_FD_IN    0x01
> >  #define VIRTGPU_EXECBUF_FENCE_FD_OUT   0x02
> >  #define VIRTGPU_EXECBUF_RING_IDX       0x04
> > +#define VIRTGPU_EXECBUF_NO_EVENT       0x08
> >  #define VIRTGPU_EXECBUF_FLAGS  (\
> >                 VIRTGPU_EXECBUF_FENCE_FD_IN |\
> >                 VIRTGPU_EXECBUF_FENCE_FD_OUT |\
> >                 VIRTGPU_EXECBUF_RING_IDX |\
> > +               VIRTGPU_EXECBUF_NO_EVENT |\
> >                 0)
> >
> >  struct drm_virtgpu_map {
> > --
> > 2.35.1
> >
