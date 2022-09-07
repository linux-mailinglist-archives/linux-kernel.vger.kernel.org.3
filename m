Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98915AFCE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIGGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIGGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3512FFF9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662533612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5bAvksPKLrdgVN4e/5QNhWQHloHMa0JMC3CFrEBk7Q=;
        b=RRkiIXbl5R1wRP392Iit3uEKxrMBA2UCmgyRuz12MCMKYHE2iZKCxVZl5sJQhpjaRxiSED
        hfxw8qvbLAoBty1CTQst0tXZ4a8/7fkaZ4buBLBlWIBZshUVTFn1q2vZFhtfFDUY9c+JI9
        h4rYDzEm8QsALGCrQqZOYIdpgyqsobs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-gT9RyLA3OcyHzYgWeA4tUw-1; Wed, 07 Sep 2022 02:53:31 -0400
X-MC-Unique: gT9RyLA3OcyHzYgWeA4tUw-1
Received: by mail-ua1-f72.google.com with SMTP id b4-20020ab04804000000b0038498ad744bso2646002uad.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 23:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W5bAvksPKLrdgVN4e/5QNhWQHloHMa0JMC3CFrEBk7Q=;
        b=2ya6FPDw8yXKC24gflkQ3e47wNEdkIOr86B0OYA7VfmA2gYj7daIeSVuDv8efFYuT3
         zrcN8TQ3GE//OYsQ2qEprdTDnE8nTGE5X1uyhjuDcpKRTQCd7NES63bRLVoYNEKKciI6
         Lad12OpanrS1h/7SPfOPcOYPJwHO0tVPS5E2/59Wl+O8L+IIgDXCUokl3PG/Cd7+XRqs
         qMcYgm5cbT1wxl+0SZtoiu5WUdPv7ls8Cu7u50QcZrpKIINHijHgjv8iQ9P8WpZ0XW2M
         Unh9/OmoNkyD5G7KZ3ZFsZVJ3VJX6j/JYftuExG8cfr0wS393DKq1DyEtHABtdTPLXKL
         9iuw==
X-Gm-Message-State: ACgBeo1VVfvL5tPFDiL2Dv/FG9gOaB+P3TiZPieoD8h+R3smQMMg6quj
        f1DHTh9gKtzZdITvNB+Y1/i+/UvcDpaJ3S/xo2fGss/amCdqnX3tGQXFZxPF6SXK3HsU56+1axl
        t3gDsahHCzFd6U1XxmKEBuIexB0qW8RcQv8aOYi2U
X-Received: by 2002:a05:6102:fa5:b0:390:d814:d6d7 with SMTP id e37-20020a0561020fa500b00390d814d6d7mr618675vsv.4.1662533611002;
        Tue, 06 Sep 2022 23:53:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FbL6e/AWOk14APVaDLNoldSpD/ONXWmJIFKefHXYftZCmw0UrSHde+x+r5ao9C04Kp4d7MHC7tPpo2ffYND4=
X-Received: by 2002:a05:6102:fa5:b0:390:d814:d6d7 with SMTP id
 e37-20020a0561020fa500b00390d814d6d7mr618670vsv.4.1662533610842; Tue, 06 Sep
 2022 23:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220907060110.4511-1-jasowang@redhat.com> <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 7 Sep 2022 14:53:19 +0800
Message-ID: <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 7 September 2022 9:01
> > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen <elic@nvidia.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> >
> > For the device without multiqueue feature, we will read 0 as
> > max_virtqueue_pairs from the config.
> If this is the case for other vdpa vendor drivers, shouldn't we fix it there? After all,
> config->max_virtqueue_pairs should always show valid values.

Not for the case when the device doesn't offer MQ. According to the
spec, the max_virtqueue_pairs doesn't exist in this case.

>
> > So if we fill
> > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > config
> > we will confuse the user.
> >
> > Fixing this by only filling the value when multiqueue is offered by
> > the device so userspace can assume 1 when the attr is not provided.
> >
> > Fixes: 13b00b135665c("vdpa: Add support for querying vendor statistics")
> > Cc: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index c06c02704461..bc328197263f 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > *vdev, struct sk_buff *msg,
> >  {
> >       struct virtio_net_config config = {};
> >       u64 features;
> > -     u16 max_vqp;
> >       u8 status;
> >       int err;
> >
> > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > *vdev, struct sk_buff *msg,
> >       }
> >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> >
> > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > max_vqp))
> > -             return -EMSGSIZE;
> > -
> >       features = vdev->config->get_driver_features(vdev);
> >       if (nla_put_u64_64bit(msg,
> > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> >                             features, VDPA_ATTR_PAD))
> >               return -EMSGSIZE;
> >
> > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > +     if (err)
> > +             return err;
> > +
>
> So that means that you can't read statistics when MQ is not supported. Is this worth sacrificing?

vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
should still work.

Thanks


>
> >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> >               return -EMSGSIZE;
> >
> > --
> > 2.25.1
>

