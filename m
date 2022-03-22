Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219D34E3F72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiCVNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCVNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0791662116
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647955410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JN8ATPDk4cHWzEEAufgy9h9WUwilvG31Oc3TZ9z83IM=;
        b=McaEbwCU+kQZn7JX1DGlQgbKXWodcm44PCzjgy7du0H9q20wyumpt/jLK6RGbVfS7+SfAf
        /6Sv9pnZunUuvSV+4IrVS+ubw5mBu/3J2/dUQvFN4PNyGfSs+HP2NJbRLzxGpU3s9AWQS5
        CnuqBvHJhdtV4o3Kdo+4G00PRteBq+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-kI0SMzInML-YONzm6JsG1g-1; Tue, 22 Mar 2022 09:23:26 -0400
X-MC-Unique: kI0SMzInML-YONzm6JsG1g-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so907684wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JN8ATPDk4cHWzEEAufgy9h9WUwilvG31Oc3TZ9z83IM=;
        b=FFfr0kgG8Exjxhf//PMnvM+10NlAPJzdrWK+neUcUSB+duqg0nUZMpQswHbOU87KDN
         k4FUgjbQV+BxRWPK32wwAWrgm6D8i29ZRe2jqMkhtg3CKFHRN+GJdxXONyYpDcUshrYv
         SnmZzOXQeo8pHorP1qExjtMMowA8oMxJ0gfmTw3QfBiLIc9+XIgAGpTnzTVyXmC7ujZ9
         klVitunn6ZGtzlhuD2XwayfGpfaYk0BwC73mYa8wnzgvprEM4/zl8MWFPZQRcnT+37lP
         eO1ZYKAkxjKlft8MAWn4z3gEQ9HbZQxwTRXNlYEVSQ/ajfkRkIeis9W1VYPZyucEybTv
         zhHg==
X-Gm-Message-State: AOAM532iJfJxMEqUtdDxUjDALjta8vVxKfd5no1TdasIX+Ewq2TbZ48D
        SoUAsDp7d33JMuHZ1hf+1AynixXMplLylVnVRMGba4CxWQ0EuON4xDRt4PHtjlWvqF1+tI+f0Of
        +GYnlUvys7uVcsbzo5uQP3kDG
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr10216360wrs.38.1647955405629;
        Tue, 22 Mar 2022 06:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyByAs22ZvY5MKHs71gUXwXledIH2kM5TZiQ459vndkLSUuZjSqIZEm1xr9SHTYs19ZsINSjw==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr10216347wrs.38.1647955405389;
        Tue, 22 Mar 2022 06:23:25 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id az26-20020adfe19a000000b00204154a1d1fsm4599514wrb.88.2022.03.22.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:23:24 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:23:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keir Fraser <keirf@google.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
Message-ID: <20220322092255-mutt-send-email-mst@kernel.org>
References: <20220321154931.859511-1-keirf@google.com>
 <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
 <YjmU22PnTLEy58+V@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjmU22PnTLEy58+V@google.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:20:27AM +0000, Keir Fraser wrote:
> On Tue, Mar 22, 2022 at 11:36:23AM +0800, Jason Wang wrote:
> > On Mon, Mar 21, 2022 at 11:49 PM Keir Fraser <keirf@google.com> wrote:
> > >
> > > The bar index is used as an index into the device's resource list
> > > and should be checked as within range for a standard bar.
> > >
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > 
> > Patch looks good, do we need a similar check in vp_modern_map_capability()?
> 
> Yes it looks like we do. Would you like me to fix that also? If so: separate patch, or
> revised version of this patch?

Yes pls. A fixed version is better, less work for everyone.

> > Thanks
> > 
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
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
> > > --
> > > 2.35.1.894.gb6a874cedc-goog
> > >
> > 

