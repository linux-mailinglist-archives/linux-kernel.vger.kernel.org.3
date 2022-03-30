Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E111C4EBADE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiC3Gh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbiC3Ghr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF7E522E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648622162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++Hp64PybgFHOZx21HiH2lviwBio7CAIQp9pPc7sk78=;
        b=Fjs8otfnIUVgjXYBGnLoEO9srLDN2cjimLLF3Ri723BRRdSIsNjKftewhnfKzhUetXG97u
        R7IwbHZ5nkSp+FvU6QHa6cQrVwAdEgrVVa3NjPYSverscK6ymqE21AddXlligZkQquzQbO
        aYMQg5P93WYPsFNWvY8AM9yX60OewmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-9X6f7lutM2idVzCgqIJAOA-1; Wed, 30 Mar 2022 02:36:00 -0400
X-MC-Unique: 9X6f7lutM2idVzCgqIJAOA-1
Received: by mail-wm1-f69.google.com with SMTP id 12-20020a05600c24cc00b0038c6caa95f7so2184254wmu.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++Hp64PybgFHOZx21HiH2lviwBio7CAIQp9pPc7sk78=;
        b=tJ1UizM6QwCRG7/x7tMZOTC0mc37jq5rwiFTpFfPM7hN607iigb1vGXme3XAyURPPM
         zv6zd1pOQDHc3GoftiUG0zVb3Qrjp0M1trPo4Y3tcHa0oIwrLKi1LIdld5/S/fKemoPD
         Ow/AonCCV9b4LEhMBoeK+Sk1GRHYytUhusCuisE2CPiCrcsj2t/UyXt5DhoZeARVPzQ0
         gQkLmzV2BPL9rTmPpJUu8NmHNnKgZM0MM11XQVI/wPXkBOBpPf776vCegtagU6K0xpI2
         4fw0xho9LjFt8swhpNZnYL6sk3QSuKbI7EOkKag/EbCh1uQLRWLwVLEOJ7VxirJnV3B7
         UbMQ==
X-Gm-Message-State: AOAM53314VglfJSXZAhIsnBT3NtLfl0DNh1D4jfT0UIJuECqCRvC9jKa
        P6Fzy1HTtbk8dJqPDfbMprS3uQV90b/3PW1Jy/CRi8N0GKY4GL0YW2jg3kFs5nvdmGLNvskTaMd
        kOGfGRBa/YDVHs+rOaOnxJP0W
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id n4-20020a056000170400b00203d857aa7amr33695858wrc.513.1648622159483;
        Tue, 29 Mar 2022 23:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMq/58RiltkrfV05P9P3GIe5dhwGOq9d4jVe60HJGdNlzdiCwBkYGFCnQi5Se1rEvBCFKBQ==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id n4-20020a056000170400b00203d857aa7amr33695842wrc.513.1648622159221;
        Tue, 29 Mar 2022 23:35:59 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b00203fbd39059sm16698312wru.42.2022.03.29.23.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:35:58 -0700 (PDT)
Date:   Wed, 30 Mar 2022 02:35:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Keir Fraser <keirf@google.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] virtio: pci: check bar values read from virtio config
 space
Message-ID: <20220330023536-mutt-send-email-mst@kernel.org>
References: <20220323140727.3499235-1-keirf@google.com>
 <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuagKHAiXKNnB22wvcRL2=Qz9u9dKiaNnbMC91_=11J6w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:43:40AM +0800, Jason Wang wrote:
> On Wed, Mar 23, 2022 at 10:07 PM Keir Fraser <keirf@google.com> wrote:
> >
> > virtio pci config structures may in future have non-standard bar
> > values in the bar field. We should anticipate this by skipping any
> > structures containing such a reserved value.
> >
> > The bar value should never change: check for harmful modified values
> > we re-read it from the config space in vp_modern_map_capability().
> >
> > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Keir Fraser <keirf@google.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 


Thanks! I don't want to rebase anymore though so not adding this ack.
Sorry!

> >  drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
> >  drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..6adfcd0297a7 100644
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
> > @@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                 if (id != required_id)
> >                         continue;
> >
> > -               /* Type, and ID match, looks good */
> >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > -                                                        bar), bar);
> > +                                                        bar), &res_bar);
> > +               if (res_bar >= PCI_STD_NUM_BARS)
> > +                       continue;
> > +
> > +               /* Type and ID match, and the BAR value isn't reserved.
> > +                * Looks good.
> > +                */
> >
> >                 /* Read the lower 32bit of length and offset */
> >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                                                      length_hi), &tmp32);
> >                 res_length |= ((u64)tmp32) << 32;
> >
> > +               *bar = res_bar;
> >                 *offset = res_offset;
> >                 *len = res_length;
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index e8b3ff2b9fbc..591738ad3d56 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> >                               &length);
> >
> > +       /* Check if the BAR may have changed since we requested the region. */
> > +       if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
> > +               dev_err(&dev->dev,
> > +                       "virtio_pci: bar unexpectedly changed to %u\n", bar);
> > +               return NULL;
> > +       }
> > +
> >         if (length <= start) {
> >                 dev_err(&dev->dev,
> >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > @@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> >                                      &bar);
> >
> >                 /* Ignore structures with reserved BAR values */
> > -               if (bar > 0x5)
> > +               if (bar >= PCI_STD_NUM_BARS)
> >                         continue;
> >
> >                 if (type == cfg_type) {
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >

