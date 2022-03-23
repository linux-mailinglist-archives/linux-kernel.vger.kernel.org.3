Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89E4E52F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiCWNXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:23:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0588403E1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so2117699wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tGzfsn7IkUKmHexsutOQcsuKq7L5d/j+OVaScHOdJcc=;
        b=IfUyUzTma+4nremz179BHr4NZNOPwfc2QBuNDW4OS8XtuNMEHGpkvD9oOgtaXhJQ+/
         mzAPIrGQs+0JbBL5xYcEbv34RPPsiBMw3xIFQ/C9BL0gjs6h1n2ep0j3gbyq4Nq4LDwX
         whpc95IKZBqtnctd+Ea+urrA3jedQL1TrH2TmQ7yoUru9a8P44J4/pI2F+Y94/ZWlwpF
         USUWYMvE7+66h5vK47kEZdtL7j8qDxa/Q0Te7nt2Mcj/ryIMyPBV+0lQMgMIMYTHiya/
         DTtd6rfdVq5+PaJnrM3fnZlNte8gasHCdcfgeCSPKpBomUgvdciMri7Yz2Fnjem4mWGb
         Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGzfsn7IkUKmHexsutOQcsuKq7L5d/j+OVaScHOdJcc=;
        b=I0jlWHeDeNC4c5WL2fuysgm1YkNA3upf29WQJOcOkHNh8aq0sMwqS2xlG+GOnqtZpX
         RUhrPsYJd2SO0B6roYhfVi4LH6dWLREjVDzMsbwIVEU5xxeOT2UCRdgBev7SSGOcr32o
         qoaKl3TQITIdHXklMTlekctRKV1nu7e79Gpo3ByxXcHt1tGobPbJSvgP+i9SRAg3Cu1J
         NLpSVyxXDa1bepLAdTgx5U8+vt6BBPt3X0/XLqTI+xjkjLKvUlr+e7lpJN49DRrS5C8L
         /wGFuypgcpgcY9LPmpRJTVY9Thvo5nyvChk6YiTp1xB50o6I0mgjdxoBraRiz1bTeYsr
         3Fww==
X-Gm-Message-State: AOAM531/SDK4qNe51EU+dvKdEp/Gc0y0YclBOlnhogkXYskBqxy2qksa
        aOjMsZNdGLtv0xX0ir1gP3kyEA==
X-Google-Smtp-Source: ABdhPJyPiWf2vuPwSO2VRKmuXTXzfOu+foOhVbZJqYldRzI+lSdIGgR0lt0qwxl4ybOOwJsNg0NlYg==
X-Received: by 2002:a5d:550f:0:b0:203:efaa:fa8b with SMTP id b15-20020a5d550f000000b00203efaafa8bmr25037917wrv.284.1648041720144;
        Wed, 23 Mar 2022 06:22:00 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00203e3ca2701sm23235250wrr.45.2022.03.23.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:21:59 -0700 (PDT)
Date:   Wed, 23 Mar 2022 13:21:55 +0000
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio: pci: sanity check bar indexes
Message-ID: <Yjse870sgpcMGsT6@google.com>
References: <20220322151952.2950143-1-keirf@google.com>
 <CACGkMEubcU4rFVem7neKYb-qT3TQUN802bbLNq7vh+y8gdD5AA@mail.gmail.com>
 <20220323075030-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323075030-mutt-send-email-mst@kernel.org>
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

On Wed, Mar 23, 2022 at 08:01:42AM -0400, Michael S. Tsirkin wrote:
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
> 
> In fact, the spec says such BAR values are reserved, not bad, so
> the capabiluty should be ignored, they should not cause the driver to error out
> or print errors.

Ah yes, so I see. It makes sense then to silently ignore the capability and print nothing.
I will fix it.

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
> 
> In fact, I would say the issue is less that bar is reserved.
> The real issue is that the value apparently changed since
> we read it the first time. I think it's a good idea to
> reflect that in the message. Maybe find_capability should return
> the capability structure so we don't need to re-read it from
> the device?

I will have a look and fix it up one way or the other, and respin
this patch.

 Thanks,
  Keir

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
> > So we probably need to stick 0x5 instead of 0x6 (PCI_STD_NUM_BARS) for
> > this and other places.
> > 
> > Thanks
> 
> It does not matter much IMHO, the reason spec uses 0 to 0x5 is precisely
> because that's the standard number of BARs. Both ways work as long as we
> are consistent, and I guess PCI_STD_NUM_BARS might be preferable since
> people tend to copy paste values.
> 
> > >
> > >                 if (type == cfg_type) {
> > > --
> > > 2.35.1.894.gb6a874cedc-goog
> > >
> 
