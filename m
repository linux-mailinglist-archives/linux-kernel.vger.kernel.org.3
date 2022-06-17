Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780254F6F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381926AbiFQLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381924AbiFQLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A19B6CF48
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655466397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJxPwhoLbaKs+wOSU5jOxy6yO7pPmPyKxZbTAbJ5Bhs=;
        b=heYdIgIbnXFyXXaM7Adwb2oe/4qb12/4pi1Wxllr4i1OKZ2G2E7aOqM19QU8ZNjMCZNrM0
        328vLC0Dr7kHSkUlSc5Bh7g3fXF0inmPNwSVAhfuG7Oaw5e0NEMUmIk1RB6LlevLz3Ibm7
        caNy2xLBehLTm8Q5tJ0bz6V/4PxRSxY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-tu3qtt3MPjKC_8jAtM8m_A-1; Fri, 17 Jun 2022 07:46:36 -0400
X-MC-Unique: tu3qtt3MPjKC_8jAtM8m_A-1
Received: by mail-lf1-f72.google.com with SMTP id bi42-20020a0565120eaa00b0047dc53b46edso2249505lfb.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJxPwhoLbaKs+wOSU5jOxy6yO7pPmPyKxZbTAbJ5Bhs=;
        b=pGEWnhNkhR201PBbV4rtWgbWvE2NzK6yy5NaS3pIap/QkdHHC75bzui5sRVBtiXaVd
         B712YJvY8XwsU88sCNbsSvejRtJOQ5L4qJDrbRDpWG2eBVuY7vEFNIM+b28PkQQqjQVJ
         fYQvEwZoILy8xtMmVho6edf49TWYyXEBTFpkI2vN/Mb22lHOo3Dao+1jBMhBRR+NJpMo
         dn4KSHo9tSxRC3un69RNkv/xQgHk9lW4beYz4UI/iBwR4LWgZqcfvrVipBnOpfR49XvK
         XjGHhW/HO2Tf6NXpMXUU/R7ZJ1OKz0TRxQqpvl+g82KdgarUAcMNXRsbuXCT5JRWe8nj
         SGZg==
X-Gm-Message-State: AJIora/IR8tj1dN7yXQc5INbNpCz+3OOGk1+Lt9TwjNv1HisYQzCjaMl
        Rl5QnxlbzfASr3t9qVqZ0vTZWknwBXqBJ0WGUGSBnuOo51Y3kHGDwW4aEfL8/Rb/ysm8BhME4Iu
        XKqtmZNOk7FI1Z7XeS01Knw0gBNPLZa/efe9GnIBo
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id h22-20020a2e3a16000000b0025578112827mr4795104lja.130.1655466394857;
        Fri, 17 Jun 2022 04:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usiehNBiJgZQo1bsGFNg6l50ktCIvyeJlM0jBKDnmj4hJgsSR+BG5DO/5SLPoPh0QWt9BnTFShfMemRsCNrzY=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr4795094lja.130.1655466394657; Fri, 17
 Jun 2022 04:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072949.30734-1-jasowang@redhat.com> <20220617060632-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220617060632-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Jun 2022 19:46:23 +0800
Message-ID: <CACGkMEtTVs5W+qqt9Z6BcorJ6wcqcnSVuCBrHrLZbbKzG-7ULQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and virtio_device_ready()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 6:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 17, 2022 at 03:29:49PM +0800, Jason Wang wrote:
> > We used to call virtio_device_ready() after netdev registration. This
> > cause a race between ndo_open() and virtio_device_ready(): if
> > ndo_open() is called before virtio_device_ready(), the driver may
> > start to use the device before DRIVER_OK which violates the spec.
> >
> > Fixing this by switching to use register_netdevice() and protect the
> > virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> > only be called after virtio_device_ready().
> >
> > Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index db05b5e930be..8a5810bcb839 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       if (vi->has_rss || vi->has_rss_hash_report)
> >               virtnet_init_default_rss(vi);
> >
> > -     err = register_netdev(dev);
> > +     /* serialize netdev register + virtio_device_ready() with ndo_open() */
> > +     rtnl_lock();
> > +
> > +     err = register_netdevice(dev);
> >       if (err) {
> >               pr_debug("virtio_net: registering device failed\n");
> > +             rtnl_unlock();
> >               goto free_failover;
> >       }
> >
> >       virtio_device_ready(vdev);
> >
> > +     rtnl_unlock();
> > +
> >       err = virtnet_cpu_notif_add(vi);
> >       if (err) {
> >               pr_debug("virtio_net: registering cpu notifier failed\n");
>
>
> Looks good but then don't we have the same issue when removing the
> device?
>
> Actually I looked at  virtnet_remove and I see
>         unregister_netdev(vi->dev);
>
>         net_failover_destroy(vi->failover);
>
>         remove_vq_common(vi); <- this will reset the device
>
> a window here?

Probably. For safety, we probably need to reset before unregistering.

>
>
> Really, I think what we had originally was a better idea -
> instead of dropping interrupts they were delayed and
> when driver is ready to accept them it just enables them.

The problem is that it works only on some specific setup:

- doesn't work on shared IRQ
- doesn't work on some specific driver e.g virtio-blk

> We just need to make sure driver does not wait for
> interrupts before enabling them.
>
> And I suspect we need to make this opt-in on a per driver
> basis.

Exactly.

Thanks

>
>
>
> > --
> > 2.25.1
>

