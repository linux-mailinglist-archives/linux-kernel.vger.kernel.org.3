Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C04E4F01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiCWJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiCWJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:14:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F552E42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:13:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso2986103wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZOt2Slux4j4Zzx0SttHsQl/a6tb4zfC8Im0t8pohdE=;
        b=rsTMEeaSHlVmSJxdAyuYYHyVFUUO3jQmVV/LjGvocyj6wrTL/GQUKtQJ+KbrpsA8+/
         T7PWW3NbeNx/zkSXLORyUreEgbneuwkxcGq7FDg5BfUzsSUVpLMq1TYOMpdGFj6Eh+Il
         w0otIDGIhI1bWV2twFXEmnL/GMzTaAQj6eh4y2GjDomyYACtusA4JnIMVjl6V42Pv7FK
         nURuKS+9iuYt5F4p4FAspcycS/xJB++EdA47lknnawHLBgbKz/X446LXmQoe+LHKaui6
         bij9qXQesrQZMiULccwYamdI6XcCPBnrgGoucI0XnQVPkMZHu5nOPCY5ZoGuNXj+cbTO
         Znpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZOt2Slux4j4Zzx0SttHsQl/a6tb4zfC8Im0t8pohdE=;
        b=sbe1opHIRj/rH18OhXKbDrSP8NmXsurCc1h/CH/iE2MZTP2jydCYh/XaH/QIa8enEK
         SEpCQXIoOBALT29LckX7Nr7ADJMykm8P6z7B+KEi05UVgqhfkVmNjihfG461vncRhYex
         wk0b+Lz4KHMbZFfTr/kissvZAJyVBV8uITVf7iF72qeo3jmr/X9k/PtxYcgsqY/UgLOU
         eLABC7BtG/06RV3xt1e+2uVsWV0kc2CDF6s0mNZ8HH7FSYql2A9wKtBqxqNf+4M1tHA3
         WbbkjaKkiGrbIcJNUPieSmpbwipAKU2XTjEgoee/7YhkONhql8Dnl5CcfPUwQRg64iJl
         HLkg==
X-Gm-Message-State: AOAM530vCrux3nLYFoVXEE7sd89pCmZMjJfUr5dGRA7F4XyYb3S0scip
        fcvY4X0MlB2mmdlz2PZkez/1mq5mG0aua5V2
X-Google-Smtp-Source: ABdhPJxwH/LcF+LMOa6o5Yn8/BFxmc8P1o5RmhgpdQ2MRLB20sIsCu4IWcabYpzMzbYfDViEdhPAeA==
X-Received: by 2002:a05:600c:3c9b:b0:380:be98:6204 with SMTP id bg27-20020a05600c3c9b00b00380be986204mr8115187wmb.121.1648026786655;
        Wed, 23 Mar 2022 02:13:06 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id bk25-20020a0560001d9900b0020589956916sm641368wrb.78.2022.03.23.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 02:13:06 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:13:02 +0000
From:   Keir Fraser <keirf@google.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
Message-ID: <YjrknlVIlB4QuwtZ@google.com>
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
> 
> So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> this and other places.

The comparison(s) are changed to greater-or-equal, so they are logically
equivalent to the old check against naked 0x5 while documenting the intent
better.

> Thanks
> 
> >
> >                 if (type == cfg_type) {
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >
> 
