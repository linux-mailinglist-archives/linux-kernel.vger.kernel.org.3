Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675794E4F32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbiCWJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiCWJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BD3275C30
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648027281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBYkM0rtMkD7czk830JnwZ6fzXDNz3tWd/U/7zjOmJc=;
        b=VDVtIyroArQqgwEYMqcMoqeEvBZ3OI1jZCa3h6Aw5D/kU17PQtgpuTnLVz91TXk2XOA3tJ
        BF73SNlJPDTarJSwZRZ52bK7mi5VJoLH2tvF9IP8J27rVt8uD5gVEhF/B78MgxPQ0+ZWQr
        wzV3Yn1VAAv0MdJWh5sa8OUzXX6Z/qc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-ksI4ecbTPMGxJFxxTLKI0w-1; Wed, 23 Mar 2022 05:21:19 -0400
X-MC-Unique: ksI4ecbTPMGxJFxxTLKI0w-1
Received: by mail-lf1-f72.google.com with SMTP id w13-20020ac25d4d000000b004488cf80eb1so387313lfd.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBYkM0rtMkD7czk830JnwZ6fzXDNz3tWd/U/7zjOmJc=;
        b=UNm3XiBQh/0Ic4iQ9e8I2t8yUyUA8RikvjaYvk2dDrNIUOBsbMT2VKHQSp9hD9nV+Z
         sdDZOwjB563WzhY9d0pRN1ez1DJY5zUbrHO3UyVsADVnclX9zs8A9P4abwWFhdAtd4YR
         IGYZQti2/0rPNrM203joTETpriA6OaUXmjcOh1h/xwrN/Nji42KDUMUbYQxlUqH1tr4R
         C44PkAZSpF9LjqU2s6l5dYbWUJZ63ezdKu3+lYA5BfeDl1ZhttE6fZ6breOiNMFBFpid
         aU7gMvsw+CQZKOW3vV8zU4e3Hpula/KIOqQgr9c9EI3dnbogz8Kio0tAUYQ3yyIecdxE
         V0Pw==
X-Gm-Message-State: AOAM531bo9YRXzSYjWve6RYC5C2Zdi5HOx+GqUXX5cYMqujPO5I+HEDo
        W8Zfysx8jt0JnvTfOjY1zhqHP1pd9z2HBukYKKHuQ4a5AFYdfAkyu3rY6QMPcJ5z8j9tVvDQIjd
        tE7ALyrAWm7PXRV0cf7eBmmEGZgkvHFkinX7uhHU/
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr21065913lfd.190.1648027277455;
        Wed, 23 Mar 2022 02:21:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlKIpKMCHsHpNFxAPW0LOjLsecKFsixZILeSSjEm36ZGhM07eqBvMg43ujyUQQFUctG2VOVuH/6QDI6dXFafI=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr21065888lfd.190.1648027277133; Wed, 23
 Mar 2022 02:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322151952.2950143-1-keirf@google.com> <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
 <YjrknlVIlB4QuwtZ@google.com>
In-Reply-To: <YjrknlVIlB4QuwtZ@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Mar 2022 17:21:05 +0800
Message-ID: <CACGkMEsEe=vkpY-xxZM0_F2cN6Mx0Nn9CDzH-1-Tb9XEU6Px-Q@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
To:     Keir Fraser <keirf@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 5:13 PM Keir Fraser <keirf@google.com> wrote:
>
> On Wed, Mar 23, 2022 at 03:57:59PM +0800, Jason Wang wrote:
> > On Tue, Mar 22, 2022 at 11:20 PM Keir Fraser <keirf@google.com> wrote:
> > >
> > > The bar index is used as an index into the device's resource list
> > > and should be checked as within range for a standard bar.
> > >
> > > Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> > >
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
> > >  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
> > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index 5455bc041fb6..84bace98dff5 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >
> > >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> > >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > > -               u8 type, cap_len, id;
> > > +               u8 type, cap_len, id, res_bar;
> > >                 u32 tmp32;
> > >                 u64 res_offset, res_length;
> > >
> > > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >
> > >                 /* Type, and ID match, looks good */
> > >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > -                                                        bar), bar);
> > > +                                                        bar), &res_bar);
> > > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > > +                               __func__, res_bar);
> > > +                       continue;
> > > +               }
> > >
> > >                 /* Read the lower 32bit of length and offset */
> > >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> > >                                                      length_hi), &tmp32);
> > >                 res_length |= ((u64)tmp32) << 32;
> > >
> > > +               *bar = res_bar;
> > >                 *offset = res_offset;
> > >                 *len = res_length;
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index e8b3ff2b9fbc..a6911d1e212a 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
> > >         pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> > >                               &length);
> > >
> > > +       if (bar >= PCI_STD_NUM_BARS) {
> > > +               dev_err(&dev->dev,
> > > +                       "virtio_pci: bad capability bar %u\n", bar);
> > > +               return NULL;
> > > +       }
> > > +
> > >         if (length <= start) {
> > >                 dev_err(&dev->dev,
> > >                         "virtio_pci: bad capability len %u (>%u expected)\n",
> > > @@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> > >                                      &bar);
> > >
> > >                 /* Ignore structures with reserved BAR values */
> > > -               if (bar > 0x5)
> > > +               if (bar >= PCI_STD_NUM_BARS)
> > >                         continue;
> >
> > Just notice that the spec said:
> >
> > "
> > values 0x0 to 0x5 specify a Base Address register (BAR) belonging to
> > the function located beginning at 10h in PCI Configuration Space and
> > used to map the structure into Memory or I/O Space. The BAR is
> > permitted to be either 32-bit or 64-bit, it can map Memory Space or
> > I/O Space.
> >
> > Any other value is reserved for future use.
> > "
> >
> > So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> > this and other places.
>
> The comparison(s) are changed to greater-or-equal, so they are logically
> equivalent to the old check against naked 0x5 while documenting the intent
> better.

You're right, So:

Acked-by: Jason Wang <jasowang@redhat.com>

>
> > Thanks
> >
> > >
> > >                 if (type == cfg_type) {
> > > --
> > > 2.35.1.894.gb6a874cedc-goog
> > >
> >
>

