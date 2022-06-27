Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6355C725
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiF0ISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiF0ISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A15C7C76
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656317888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPtn4J82OzWsDsVXNRibX7f2Ro4efWlqotHQQJeFEvk=;
        b=R3U8/EvmMWizRkCBzv/ew+E1T7qmsPuOSukCFtmGQp0u8AE0tVCrxgqkaZgGB80YDbBGCq
        +wrwISe4GqvCt+UxhhPxwle60jLTflfnPZulwCpMk4rG+QjVY5MmvTfxwiZC2LtYk36zkG
        toGD4Zk2ll5uZiNv0weiSmWOC+wQRRQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-FAs2RuA2MAuFRDgrwP4nGA-1; Mon, 27 Jun 2022 04:18:07 -0400
X-MC-Unique: FAs2RuA2MAuFRDgrwP4nGA-1
Received: by mail-lf1-f70.google.com with SMTP id p36-20020a05651213a400b004779d806c13so4354934lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPtn4J82OzWsDsVXNRibX7f2Ro4efWlqotHQQJeFEvk=;
        b=LjLZbDBWbZvcGJfybl2GNoOGnZuycVqZIhi+kxvszeuAmRXq9Ik/X8fGY8bHDbQLnh
         AfFDu7kXDQtILV9UjacL/lin4tDCYTlqeTrtjb2gHECf9VWUf49oFVLG0F7+rL8xcdlD
         yoyunZRv6DU3jOI9mGTp7zLZtoNiPCm4ElWoBa/xeCk5AGUzNeo/FxXd1xUnztOWp762
         WWt3ZFfKH3fqHGhgNf/lQaLPJHEFd390yYdRrY0qA+Q6xR1VNSk91xVLH2jmPQwyxdyr
         OkDRA180Q104nIHCEAJy1B2BgqD+4rjVtEBNWfuCzUtB8wRFc+JMctS7foDcnkth1Wcg
         posg==
X-Gm-Message-State: AJIora8RhW6CYGL8Ik0S6SJBw0Of1HEjZ6q3fouslCsfZMy6nlybIvZe
        EZK9GJeh/yn+SqlEljlXTqOqDpaBoK8TGfLx6eFAhrOdzo5tLyaZLsQYxMBYDNkmhkYkf/zSm9F
        HNxO06Zp5YqHrEc5nQEuXpbdIoGXOVWF4J+95D1I9
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id f5-20020ac251a5000000b0047f79a15c02mr7378514lfk.575.1656317885576;
        Mon, 27 Jun 2022 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ud5rlcp28+Fmhb5gpV7n5UDaClclIIoV1luhzWBK2LZrI8iuHqy4DEqfW17VF71T1X3oIofm19Bk+5PrzQAPI=
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr7378505lfk.575.1656317885391; Mon, 27
 Jun 2022 01:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220627063656.52397-1-jasowang@redhat.com> <20220627033422-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627033422-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Jun 2022 16:17:54 +0800
Message-ID: <CACGkMEvhk1UmcMNhYFb8dceoLnNs5Jr4WmKaQ++ZVgR2sOu1QQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between ndo_open() and virtio_device_ready()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 3:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 02:36:56PM +0800, Jason Wang wrote:
> > We used to call virtio_device_ready() after netdev registration.
>
> s/used to call/currently call/
>
> > This
> > cause
>
> s/This cause/Since ndo_open can be called immediately
> after register_netdev, this means there exists/
>
> > a race between ndo_open() and virtio_device_ready(): if
> > ndo_open() is called before virtio_device_ready(), the driver may
> > start to use the device before DRIVER_OK which violates the spec.
> >
> > Fixing
>
> s/Fixing/Fix/
>
> > this by switching to use register_netdevice() and protect the
> > virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> > only be called after virtio_device_ready().
> >
> > Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
>
> it's an unusual use of Fixes - the patch in question does not
> introduce the problem, it just does not fix it completely.

Yes, but I couldn't find a better commit.

> But OK I guess.
>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> With commit log changes:

Will post a new version with the above fixed.

Thanks

>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
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
> > --
> > 2.25.1
>

