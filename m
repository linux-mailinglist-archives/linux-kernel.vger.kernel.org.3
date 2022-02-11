Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1C4B1F07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiBKHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:09:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiBKHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBEDE1095
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644563390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ouvEgmpHPvkcz1CBibgw4xI0LETLRKvIkcsiMvXvtnI=;
        b=OiVQzIDKEWNlCDlJKpcUR9mIvI/5EybB7WGxeF1VGgSsTFrOTOcM+StmZShnblPe2FBj0m
        cDn0eWfe4DFbvtj/NWfcKEHbjCiDbjSxJfCM18qNBgGujhDZfJ6lh7dVCxAk3uLeeVOq2p
        U07/icoFsqJ1NPjb9cM5shkDEDp0t5g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-i8kttQoANp2pz7xhdmNTiw-1; Fri, 11 Feb 2022 02:09:48 -0500
X-MC-Unique: i8kttQoANp2pz7xhdmNTiw-1
Received: by mail-lj1-f200.google.com with SMTP id n9-20020a2e82c9000000b002435af2e8b9so3686535ljh.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouvEgmpHPvkcz1CBibgw4xI0LETLRKvIkcsiMvXvtnI=;
        b=q3JgLl2JKIq8UqMtw93kop+nkIACp2DFPXCVikMdga5DC0TxBvUpSLZF9hjFhCQMvu
         o/exazG/PYZDEWTCcVIcaqZTM2kZ8Sc1jXYFe/Zgo0yLT0iHSS02qgbnoprSeILKt9QJ
         Ur52BQ/hXcoSzWZ6i1JtOWzuWdWqXL7YSrcgR+t3UpGbwMW6HNefWeGDGXVRWDcbSgze
         AQaa6YFz092+8Tq5ERTBzFWNytc+2sV/sFOj7uqc35N3gjpy+xqiokLfFiJYFFptQb0h
         jDtG5zNgAaZR3I6aN1urzPn1OGgA+N1wuke864w+xZAgZAKfnCY+xc8o5ryGGGPkPDzo
         POQg==
X-Gm-Message-State: AOAM530gVSQEeOmeamRRg3mJouxzMFaIl6tmE6gUl6bReoUeLuno1IDH
        6nQsfa8VizqEe0MnBKirZEF8hkR3cWxKr7/xNI0A7Y+FaiMlFK8YTBJMJ1kii9uMYACVKBSWLdl
        yzgSoZKjCdi2tsZzfE6JyPeMYHSlAWJ+o2eWE04Fb
X-Received: by 2002:a19:610e:: with SMTP id v14mr281131lfb.348.1644563386870;
        Thu, 10 Feb 2022 23:09:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7T0pNUkYHnBgdtsf+7u3obLYe2WN2VJUUG3OUT7y/TCDIwEor31Qs1dvfrLHmaIulCGKDS/nysYgDt3PruBA=
X-Received: by 2002:a19:610e:: with SMTP id v14mr281119lfb.348.1644563386644;
 Thu, 10 Feb 2022 23:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com> <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Feb 2022 15:09:35 +0800
Message-ID: <CACGkMEv0C_y4BDa0UqO_mB90jy_BEftM7QYpZM8yhfPKM0v=Ew@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 2:34 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Fri, 11 Feb 2022 13:40:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > The virtio spec already supports the virtio queue reset function. This patch set
> > > is to add this function to the kernel. The relevant virtio spec information is
> > > here:
> > >
> > >     https://github.com/oasis-tcs/virtio-spec/issues/124
> > >
> > > Also regarding MMIO support for queue reset, I plan to support it after this
> > > patch is passed.
> >
> > So I had an idea, we can implement ethtool_set_ringparam() in this
> > series to get one real users.
>
> I agree, in fact my local test is using this feature.

Right.

>
> >
> > But this came into another question: it looks to me current virito-net
> > just uses the maximum ring size, so it basically means we just can
> > decrease the number from startup, so I wonder how much value if we
> > don't limit the startup queue size to a dedicated value.
>
> I also have this consideration, so I want to add a virtio-net module parameter
> to specify an initial value.

But module parameters are not user friendly. Let it be changed via
ethtool should be sufficient.

>
> This initial value also has another meaning. In order to achieve high
> performance, the backend can provide a large ring size capability, but we also
> hope that the ring size can only be increased through ethtool -G when the user
> needs it.
>
> To implement this function, we need to add a new parameter to find_vqs().
>
> If there is no problem, I will bring this function in the next version.

I think so, and we need to choose a sane default value. I guess
something up to 1024 should be sufficient.

Thanks

>
> Thannks.
>
>
> >
> > Thanks
> >
> > >
> > > Please review. Thanks.
> > >
> > > v4:
> > >   1. just the code of virtio, without virtio-net
> > >   2. Performing reset on a queue is divided into these steps:
> > >     1. reset_vq: reset one vq
> > >     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > >     3. release the ring of the vq by vring_release_virtqueue()
> > >     4. enable_reset_vq: re-enable the reset queue
> > >   3. Simplify the parameters of enable_reset_vq()
> > >   4. add container structures for virtio_pci_common_cfg
> > >
> > > v3:
> > >   1. keep vq, irq unreleased
> > >
> > > Xuan Zhuo (14):
> > >   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> > >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> > >   virtio_ring: queue_reset: add function vring_setup_virtqueue()
> > >   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
> > >   virtio_ring: queue_reset: split: support enable reset queue
> > >   virtio_ring: queue_reset: packed: support enable reset queue
> > >   virtio_ring: queue_reset: extract the release function of the vq ring
> > >   virtio_ring: queue_reset: add vring_release_virtqueue()
> > >   virtio: queue_reset: struct virtio_config_ops add callbacks for
> > >     queue_reset
> > >   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> > >     option functions
> > >   virtio_pci: queue_reset: release vq by vp_dev->vqs
> > >   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
> > >   virtio_pci: queue_reset: vp_setup_vq() support ring_num
> > >   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> > >
> > >  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
> > >  drivers/virtio/virtio_pci_common.h     |  11 +-
> > >  drivers/virtio/virtio_pci_legacy.c     |   5 +-
> > >  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
> > >  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
> > >  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
> > >  include/linux/virtio.h                 |   6 +
> > >  include/linux/virtio_config.h          |  13 ++
> > >  include/linux/virtio_pci_modern.h      |   2 +
> > >  include/linux/virtio_ring.h            |  37 ++++--
> > >  include/uapi/linux/virtio_config.h     |   7 +-
> > >  include/uapi/linux/virtio_pci.h        |  14 ++
> > >  12 files changed, 375 insertions(+), 93 deletions(-)
> > >
> > > --
> > > 2.31.0
> > >
> >
>

