Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C84BBEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiBRRva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiBRRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:51:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E0251E71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:51:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso6962090wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jE4Xp1Su1BAg5kbbWTHG1FN0oJ9hDn50nQE95kDMcIE=;
        b=MxLJUtFlCRDP8c5O9j7qn9H/9WVcYL4FTz/wJsj1nBC+8Eo7be0XNzCcMG7IFYF04X
         wfSyyZYpZtYVyyzKGH155eXDDEch6z2ZoqVYBAA3SNjeyUkC4u+Z5QXEW7dRRNTB7wpO
         83YVexXJl0rD3c9EOSiO9DqUX53R0VSvbjAmJwKK2eZ0Tk+ckvUOAB97JrBBXmlVYZ8C
         09uaJvKoUc721Z66ZJI17FbTVzKUlB70k1OuxB5g3t+2i3ZP6ETNDB3AQe1n/CVWhvIH
         k+/fbSZNULkJiP0rWzkJS+3+Q338dbHCs3yc4DyQviIXL1hYhDOe5uSZagoCIhgJ4Gvt
         Kbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jE4Xp1Su1BAg5kbbWTHG1FN0oJ9hDn50nQE95kDMcIE=;
        b=n5a+GwoYNGbwTNYmolunAyv3YuCO0Ze86iIVZs8L2bh1N3wUN+8HkWZkKL203Tisdf
         m8YXWVi2E/Pce5ZAK4ccf1DUw2OEwM26wRW4qAA87TvWe9gl0ECBi5E8Pi2EeLyWj1Aw
         geT7UT1/OYVCGc1xD7LXT0diBiGVWjH7dLiooLAd1xgfWuLY0riCBWVBsu2tgN3H/Sfz
         us2TNT0WgIwYzps+1gDwP4PCUfD8M2pNlxwfcIPJNJOz+0pJz7XjA6NZodzIP8xWMZqZ
         f/70DT45AydW46oLtOT2kvXDyglJnqHl6I+xS34n+T86EsjzmFbQPYlfYM/1MwTxMiEj
         4uMw==
X-Gm-Message-State: AOAM533VPmJR5d+IdsWtnv9JaCHwk7N/jV8+SP7uKIqIv/sn2MsCk+ki
        Y5vqSQepVBqkwsvU2lvrJncyXINCQvlIWG3FDew=
X-Google-Smtp-Source: ABdhPJx24uWpNh4PfLwgQ+xUx/EoND/HPGkbbfmZDRMurF3pbX/iA/d2w1P971ubT+7wz+S9OWfwFAODyX9SZVdqpFI=
X-Received: by 2002:a7b:c409:0:b0:34d:4775:4961 with SMTP id
 k9-20020a7bc409000000b0034d47754961mr11458478wmi.44.1645206665172; Fri, 18
 Feb 2022 09:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20220218155725.487785-1-robdclark@gmail.com> <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
In-Reply-To: <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 18 Feb 2022 09:51:25 -0800
Message-ID: <CAF6AEGtrQ7rcK6sEbiaHa72cebGbrdS0RNS22T07XQwCM2sQ0g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 8:42 AM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Fri, Feb 18, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > With native userspace drivers in guest, a lot of GEM objects need to be
> > neither shared nor mappable.  And in fact making everything mappable
> > and/or sharable results in unreasonably high fd usage in host VMM.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > This is for a thing I'm working on, a new virtgpu context type that
> > allows for running native userspace driver in the guest, with a
> > thin shim in the host VMM.  In this case, the guest has a lot of
> > GEM buffer objects which need to be neither shared nor mappable.
> >
> > Alternative idea is to just drop the restriction that blob_flags
> > be non-zero.  I'm ok with either approach.
> Dropping the restriction sounds better to me.
>
> What is the use case for such a resource?  Does the host need to know
> such a resource exists?

There are a bunch of use cases, some internal (like visibility stream
buffers filled during binning pass and consumed during draw pass),
some external (tiled and/or UBWC buffers are never accessed on the
CPU).

In theory, at least currently, drm/virtgpu does not need to know about
them, but there are a lot of places in userspace that expect to have a
gem handle.  Longer term, I think I want to extend virtgpu with
MADVISE ioctl so we can track DONTNEED state in guest and only release
buffers when host and/or guest is under memory pressure.  For that we
will defn need guest side gem handles

BR,
-R

> >
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
> >  include/uapi/drm/virtgpu_drm.h         | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index 69f1952f3144..92e1ba6b8078 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -36,7 +36,8 @@
> >
> >  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
> >                                     VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> > -                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> > +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> > +                                   VIRTGPU_BLOB_FLAG_USE_INTERNAL)
> >
> >  static int virtio_gpu_fence_event_create(struct drm_device *dev,
> >                                          struct drm_file *file,
> > @@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
> >         params->size = rc_blob->size;
> >         params->blob = true;
> >         params->blob_flags = rc_blob->blob_flags;
> > +
> > +       /* USE_INTERNAL is local to guest kernel, don't past to host: */
> > +       params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
> > +
> >         return 0;
> >  }
> >
> > diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> > index 0512fde5e697..62b7483e5c60 100644
> > --- a/include/uapi/drm/virtgpu_drm.h
> > +++ b/include/uapi/drm/virtgpu_drm.h
> > @@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
> >  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
> >  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
> >  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> > +#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
> >         /* zero is invalid blob_mem */
> >         __u32 blob_mem;
> >         __u32 blob_flags;
> > --
> > 2.34.1
> >
