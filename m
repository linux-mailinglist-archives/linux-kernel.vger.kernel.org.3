Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9440D4C036A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiBVUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiBVUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:55:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFC1A2F15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:54:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m3so33934795eda.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPRBbHRt1jN0bCazBjflxzkMQpBKCrhFsjWbB/Pd2ho=;
        b=d8byAmakXv8TUEk2D3GwlOKX2veEXZG3SWc2Oaanly7GJmSflwIsHiwmAW1Aa2txaX
         AKK3+3n03VecgUvTM1Mi6rNS8aDHCmfVQUJmMiUpE3pmhqDMi+B2xRts9mbJUecdnSbG
         KGIw6911dhsDhVjGLJH1evW17Ycoey+JUh5TO5i48ZRTiLmNOEyzz+TLFuAFVvZ2Enru
         kcmQF9MsPyqrsrMAJOYwyxeyvnskKlFZOzZDgvFJ3RCeQgzMJDZq/ERMFqADAO/5UoLh
         /E8cANGceNrsLPHdXEmGExgir+nUUx1gz+ICKFUCpYPEkJmMkDm7rtspo1sVW7ettc9Q
         y5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPRBbHRt1jN0bCazBjflxzkMQpBKCrhFsjWbB/Pd2ho=;
        b=0tjJMvADARHhR467Xqc7i0SNlPHcjPm5u/MCqmI18AA+yRERgJ1mcjS9nZQDsNprhP
         boAd0RLw1X7OsSli919TQHkx5vUb3Gr9ps4+w6PQ808JTexZrI0t95NL7omTnwnXoRDi
         tAkA+59ExsqfN2FKA5fS0t2CS1VtfaavagEBSnpPtUgrw34A8CmwOUsuUgOj/LY+pji9
         S6BuAceaXKbtdIPsXgP9Ns+Lmnm8AShMVyWiXo9K27BSTwMwroy8XQpuZ5rFFVDpVsM9
         5EjVFCobilptEVoEUfsKyywhO9UOULqycjiUAvRpG64s3RBp+UJyQj60hPg5mbhNKb6V
         dG8g==
X-Gm-Message-State: AOAM531TTsZh7C9rYfg38ELLaGxzewdLlU8nPMx9+8QO7VQ7FbbGIwXL
        CoImc+neWPnbo5UWkRdJdSkKOob+QAzjzYueDMk=
X-Google-Smtp-Source: ABdhPJwdHuLXrwIwpdBJAf4/39epc/M85MPWl0qEVJog5KwT3yV9aX9Lv1vppSRgkpo7O6i4fZ7LtUt34SnQcTuhQQI=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3663984edb.118.1645563285075; Tue, 22
 Feb 2022 12:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20220218155725.487785-1-robdclark@gmail.com> <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
 <CAF6AEGtrQ7rcK6sEbiaHa72cebGbrdS0RNS22T07XQwCM2sQ0g@mail.gmail.com>
In-Reply-To: <CAF6AEGtrQ7rcK6sEbiaHa72cebGbrdS0RNS22T07XQwCM2sQ0g@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 22 Feb 2022 12:54:34 -0800
Message-ID: <CAPaKu7TqRBQ6_v2nKCTsc4OySOSeK9_kzKK=HfALL_42qU2WnQ@mail.gmail.com>
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

On Fri, Feb 18, 2022 at 9:51 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Feb 18, 2022 at 8:42 AM Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > On Fri, Feb 18, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > With native userspace drivers in guest, a lot of GEM objects need to be
> > > neither shared nor mappable.  And in fact making everything mappable
> > > and/or sharable results in unreasonably high fd usage in host VMM.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > This is for a thing I'm working on, a new virtgpu context type that
> > > allows for running native userspace driver in the guest, with a
> > > thin shim in the host VMM.  In this case, the guest has a lot of
> > > GEM buffer objects which need to be neither shared nor mappable.
> > >
> > > Alternative idea is to just drop the restriction that blob_flags
> > > be non-zero.  I'm ok with either approach.
> > Dropping the restriction sounds better to me.
> >
> > What is the use case for such a resource?  Does the host need to know
> > such a resource exists?
>
> There are a bunch of use cases, some internal (like visibility stream
> buffers filled during binning pass and consumed during draw pass),
> some external (tiled and/or UBWC buffers are never accessed on the
> CPU).
For these use cases, it's true that userspace might want internal bos,
and serialize them as res_ids which the host maps to host gem_handles.
But userspace can also skip the internal bos and encode host
gem_handles directly.

But the kernel probably should not dictate what the userspace should
do by requiring non-zero blob flags.

>
> In theory, at least currently, drm/virtgpu does not need to know about
> them, but there are a lot of places in userspace that expect to have a
> gem handle.  Longer term, I think I want to extend virtgpu with
> MADVISE ioctl so we can track DONTNEED state in guest and only release
> buffers when host and/or guest is under memory pressure.  For that we
> will defn need guest side gem handles
MADVICE is a hint that userspace sets and is not based on memory
pressure.  It is the receivers of the hint who take actions when under
memory pressure.  I think it can be between the guest userspace and
the host?


>
> BR,
> -R
>
> > >
> > >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
> > >  include/uapi/drm/virtgpu_drm.h         | 1 +
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > index 69f1952f3144..92e1ba6b8078 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > @@ -36,7 +36,8 @@
> > >
> > >  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
> > >                                     VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> > > -                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> > > +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> > > +                                   VIRTGPU_BLOB_FLAG_USE_INTERNAL)
> > >
> > >  static int virtio_gpu_fence_event_create(struct drm_device *dev,
> > >                                          struct drm_file *file,
> > > @@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
> > >         params->size = rc_blob->size;
> > >         params->blob = true;
> > >         params->blob_flags = rc_blob->blob_flags;
> > > +
> > > +       /* USE_INTERNAL is local to guest kernel, don't past to host: */
> > > +       params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> > > index 0512fde5e697..62b7483e5c60 100644
> > > --- a/include/uapi/drm/virtgpu_drm.h
> > > +++ b/include/uapi/drm/virtgpu_drm.h
> > > @@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
> > >  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
> > >  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
> > >  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> > > +#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
> > >         /* zero is invalid blob_mem */
> > >         __u32 blob_mem;
> > >         __u32 blob_flags;
> > > --
> > > 2.34.1
> > >
