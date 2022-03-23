Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53764E51CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbiCWMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiCWMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44CA7A99B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648036909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06IKLeK1HPa8EqbWxS+T+9EJyp3Gy0v+dNMgxkBuw9M=;
        b=afrBe2334W9R8YqKZZYv0g/Sh8EN7zslyV4PO8VrtP3SF1Qo2MwMQ8moAD5lTjYcAn9F6P
        +xbQCHFvq7sId/dUMwGiPFooORacBSga3pvDINcktDrzcn1lYfNpPY1d1weRLgH5i4etpF
        5TR8U/dMJZ64rm+twXGd0f8BoFnqpGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-FI4l3HsjOmuLVkLX1zjGWg-1; Wed, 23 Mar 2022 08:01:48 -0400
X-MC-Unique: FI4l3HsjOmuLVkLX1zjGWg-1
Received: by mail-wr1-f69.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so433632wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06IKLeK1HPa8EqbWxS+T+9EJyp3Gy0v+dNMgxkBuw9M=;
        b=s45H229phKE99SWhwzw4/sj8qgMw6P1V5LpkyOc6MfBI496aGyhXNDFqIcdAVgd2tR
         OvsYa8yDD+XVF81bdGZlzc5QH7PT9y9MJNKV0WKPYEgEtO3EW0k2vk8p24rW6oCp4g1m
         qqP/jfxiz9Fq2Km8Nc36wQPT7iyTLc89d8Lp4Q2Z9MgDN8wMw8HpTo6/SYNL6td47mRT
         JI+56waz7AN7GKllKNA97XhaJVJ1L6k1B0Y+Y2hKziiss4zfQPII+IPSTYxFiaP6gbtw
         qNQS1dK3iuTn8cOCRj+tqm65MxgZX3GBRYG/wXDKmZtgG2wtl6BIDYdfhlyIDu1x44A2
         zJaQ==
X-Gm-Message-State: AOAM530aXXwMS7yH0jaagx6JXYRanSD/nw3gSE7nSs3QNccwzDZjwxRF
        Bjf/3b1kC84ogpBASl8M7yGoCumWlfxR9XlLJw6nPwkBRJ7wnlp4V48vagBFX0UmoYRgO8beeyK
        YK5SGga1Jm2CMVUhgE+FDvFyI
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id l16-20020a5d6750000000b00203efaf9fc1mr23869457wrw.252.1648036907616;
        Wed, 23 Mar 2022 05:01:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynjLJRb91b0j7OuTthwiOqxaUOL6Ex8tKvWylL7WSkMnM9JIzW97AzFCAg5VkEOFL8tDHc5w==
X-Received: by 2002:a5d:6750:0:b0:203:efaf:9fc1 with SMTP id l16-20020a5d6750000000b00203efaf9fc1mr23869390wrw.252.1648036906938;
        Wed, 23 Mar 2022 05:01:46 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm26224455wri.0.2022.03.23.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:01:45 -0700 (PDT)
Date:   Wed, 23 Mar 2022 08:01:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Keir Fraser <keirf@google.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
Message-ID: <20220323075030-mutt-send-email-mst@kernel.org>
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 03:57:59PM +0800, Jason Wang wrote:
> On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
> >
> > The bar index is used as an index into the device's resource list
> > and should be checked as within range for a standard bar.
> >
> > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Keir Fraser <keirf@google.com>
> > ---
> >  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
> >  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..84bace98dff5 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > -               u8 type, cap_len, id;
> > +               u8 type, cap_len, id, res_bar;
> >                 u32 tmp32;
> >                 u64 res_offset, res_length;
> >
> > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >                 /* Type, and ID match, looks good */
> >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > -                                                        bar), bar);
> > +                                                        bar), &res_bar);
> > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > +                               __func__, res_bar);
> > +                       continue;
> > +               }
> >
> >                 /* Read the lower 32bit of length and offset */
> >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,

In fact, the spec says such BAR values are reserved, not bad, so
the capabiluty should be ignored, they should not cause the driver to error out
or print errors.

> > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                                                      length_hi), &tmp32);
> >                 res_length |= ((u64)tmp32) << 32;
> >
> > +               *bar = res_bar;
> >                 *offset = res_offset;
> >                 *len = res_length;
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index e8b3ff2b9fbc..a6911d1e212a 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> >                               &length);
> >
> > +       if (bar >= PCI_STD_NUM_BARS) {
> > +               dev_err(&dev->dev,
> > +                       "virtio_pci: bad capability bar %u\n", bar);

In fact, I would say the issue is less that bar is reserved.
The real issue is that the value apparently changed since
we read it the first time. I think it's a good idea to
reflect that in the message. Maybe find_capability should return
the capability structure so we don't need to re-read it from
the device?

> > +               return NULL;
> > +       }
> > +
> >         if (length <= start) {
> >                 dev_err(&dev->dev,
> >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> >                                      &bar);
> >
> >                 /* Ignore structures with reserved BAR values */
> > -               if (bar > 0x5)
> > +               if (bar >= PCI_STD_NUM_BARS)
> >                         continue;
> 
> Just notice that the spec said:
> 
> "
> values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
> the function located beginning at 10h in PCI Configuration Space and
> used to map the structure into Memory or I/O Space. The BAR is
> permitted to be either 32-bit or 64-bit, it can map Memory Space or
> I/O Space.
> 
> Any other value is reserved for future use.
> "
> So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> this and other places.
> 
> Thanks

It does not matter much IMHO, the reason spec uses 0 to 0x5 is precisely
because that's the standard number of BARs. Both ways work as long as we
are consistent, and I guess PCI_STD_NUM_BARS might be preferable since
people tend to copy paste values.


> >
> >                 if (type == cfg_type) {
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >

