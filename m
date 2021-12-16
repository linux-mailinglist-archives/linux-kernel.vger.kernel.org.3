Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3D47685C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhLPCzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhLPCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639623340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHb0FpSfdJrFyMaV6hFgu2fdNBhYpmwh4Vr9EjdXA7I=;
        b=V7fqPzTa+FNC/KA/T5F/6eKRLNu/uANt/jlpw9NPhbhzHm5Tsgx6PxWAhFi3qBsdff4Nga
        oAaqHsCEWKOlwCq/NxUXbcJFqnVdGM8yMczd4BuGcQiU5dlN9hgPb9kwPAjCzme0G77og6
        6o4B3/ONMI+9uS14kF2RW0qjMQG+//4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-tXUM851nNy-e5ljH-AZRUQ-1; Wed, 15 Dec 2021 21:55:38 -0500
X-MC-Unique: tXUM851nNy-e5ljH-AZRUQ-1
Received: by mail-lj1-f198.google.com with SMTP id s16-20020a2ea710000000b0021b674e9347so7921630lje.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHb0FpSfdJrFyMaV6hFgu2fdNBhYpmwh4Vr9EjdXA7I=;
        b=Zgzt2XVah5Jj1xVGq3Jwzp4OXwr6KyDyL7ghupJMoomcp5qDXROvs4mh4YNuS7cn0o
         yqUvIB1vDe+jCaqvOJMrBmKv5DhEi2K088Hs1RcZ6qpq5hjcoUTCr36CtRR1IrLAHyid
         gG2dSfzydmOP55wH2sQ7AkWJiBZvR7kVDn3pcSa6egPgzIBfK8DAZWrXfiNAQBntwWTh
         7FX3B+Zl5I2OMeCF9wzXchqTV1Yj77Hy42ngtmbCg8jUlo//s0TxEO3jDJZ/4b480TDR
         uBlCAmgFbVijzCGStiE9SwdKhDgj1LK0JxdadOIzptbyz2zFugXF/UQKcEt8SO0nNDBk
         BdCQ==
X-Gm-Message-State: AOAM532nTeqnjvTjhcQqTz511648iS1VT5c3fniER63ExWFbMBixr1Xr
        TB0hKCmsrG6NkLU7PxUuOq2BngWbsILIQoie1F6BO6tHtgT805LHLF18qzQb/0SWoDm0diKwEvL
        qRtxqwa/MXmGZ46pEYR4vVNQgXjItHi3KDLAQD2R9
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr13087315lfm.580.1639623337211;
        Wed, 15 Dec 2021 18:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEaePdKwOsy6o2ElaN+kafbYdaIkSCJskpkCCD/qWZS+GwLQO/M7hxc16ufrBlfJopt6w+yPAPlHUPigIX++Q=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr13087306lfm.580.1639623337053;
 Wed, 15 Dec 2021 18:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20211214163249.GA253555@opensynergy.com> <20211214182611-mutt-send-email-mst@kernel.org>
 <20211215172739.GA77225@opensynergy.com>
In-Reply-To: <20211215172739.GA77225@opensynergy.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Dec 2021 10:55:25 +0800
Message-ID: <CACGkMEvLD-qSR4KDSjnq+LJTEaoHoqm1NySUnBvOUGhV9LTxEg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: do not reset stateful devices on resume
To:     Mikhail Golubev <mgo@opensynergy.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:27 AM Mikhail Golubev <mgo@opensynergy.com> wrote:
>
> The 12/14/2021 18:26, Michael S. Tsirkin wrote:
> > On Tue, Dec 14, 2021 at 05:33:05PM +0100, Mikhail Golubev wrote:
> > > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > >
> > > We assume that stateful devices can maintain their state while
> > > suspended. And for this reason they don't have a freeze callback. If
> > > such a device is reset during resume, the device state/context will be
> > > lost on the device side. And the virtual device will stop working.
> > >
> > > Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > > Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>
> >
> > A bit more specific? Which configs does this patch fix?
>
> We had encountered an issue related to 'stateful' GPU 3d (virglrenderer) and
> video (gstreamer) devices.

Adding Gerd and Stefan.

I wonder if we suffer from a similar issue with virtio-fs.

Thanks

>
> BR,
> Mikhail
>
> >
> > > ---
> > >  drivers/virtio/virtio.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 236081afe9a2..defa15b56eb8 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
> > >     struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > >     int ret;
> > >
> > > +   /* Short path for stateful devices. Here we assume that if the device
> > > +    * does not have a freeze callback, its state was not changed when
> > > +    * suspended.
> > > +    */
> > > +   if (drv && !drv->freeze)
> > > +           goto on_config_enable;
> > > +
> > >     /* We always start by resetting the device, in case a previous
> > >      * driver messed it up. */
> > >     dev->config->reset(dev);
> > > @@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
> > >     /* Finally, tell the device we're all set */
> > >     virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > >
> > > +on_config_enable:
> > >     virtio_config_enable(dev);
> > >
> > >     return 0;
> > > --
> > > 2.34.1
> > >
> > >
> > > --
> >
>
> --
>

