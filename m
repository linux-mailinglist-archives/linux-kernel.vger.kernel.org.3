Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489857A904
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiGSVcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiGSVb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B415050701
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658266312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZUhztkXgylP7x29mvXh1lO6FSwsyErGTF/6AoFUmjY=;
        b=YLKquV8KBofeS8w1CioxdJl5SlWfqHQgPEp5r/OkKDtfN3mIUE+nORfVGCOI245YvxAEay
        oCX5SmIBN4ERTxkk9ebvDilUftaq90JWTS34CsCZ3B8ifOC92MqZeTG0bjKIYObjaO7TBO
        ruEeSeeHScrnx9eJP7d7nqJv/Uce2CY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-tEjtEOFWMfyBr0vu97Ddqg-1; Tue, 19 Jul 2022 17:31:51 -0400
X-MC-Unique: tEjtEOFWMfyBr0vu97Ddqg-1
Received: by mail-ed1-f69.google.com with SMTP id bs1-20020a056402304100b0043ad1e84611so10825687edb.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZUhztkXgylP7x29mvXh1lO6FSwsyErGTF/6AoFUmjY=;
        b=IE9N0LUbqO36fmtx38h2h7qBCtNhfd9e69AZT0cqQLmjT5ABR/G0Ud/0hj3yVvqGUs
         yQr5qlw57LeEkCxGdRtdjtpftYjP5WrHCw0Ky0zMrklQc4DMZlPLpnRHhLyKVIxkkOn4
         ODk/JcLjs1VzSB7jfgCEyfBZAMyRuj0PZNfO4qhZm3u5JhQkZYiWflZevlwoKTUpdHcb
         SWodAn1TDURDWNGrU+Psh4I0OiVbcvF3cd4lSfxBUXRs4Z/rWYlUUTh75mIk3u+Sd+eh
         rMD+j1/Eb9xpITiRgbXQfAgq8ZAMpAQlNussHtmDLT/HXzQVWpkOp1fZxdsDVE0Li3wC
         jO/w==
X-Gm-Message-State: AJIora9x1JJvAdOdj2h3v385biDwqEsVx7njJ3i2PnPwmv+BmHGV3Qoj
        zgCAeJAeUT61o8RMf5ojfj3Of+tA0Zb1CBf5f6fDJEigBI4e01Jxd5U2YENi5ndcumThl+bKjs3
        1TBd/8xh6OIK2kUKZcfIz1Yi3
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id sa38-20020a1709076d2600b0072b3a72a117mr31945708ejc.280.1658266310153;
        Tue, 19 Jul 2022 14:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s5iAzLyUDTj2fQ0Ll1zvPxL/U2luYNZUH/ySNV2VfBHAvovv/mA383vCir7H2KGbK6FCcfdQ==
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id sa38-20020a1709076d2600b0072b3a72a117mr31945691ejc.280.1658266309866;
        Tue, 19 Jul 2022 14:31:49 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:f101:7ade:a844:162d:171a])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b00726abf9a32bsm7166887ejm.138.2022.07.19.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:31:49 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:31:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keir Fraser <keirf@google.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220719172607-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <20220719074941-mutt-send-email-mst@kernel.org>
 <Yta6RowkzVbXaSt2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yta6RowkzVbXaSt2@google.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:05:58PM +0000, Keir Fraser wrote:
> On Tue, Jul 19, 2022 at 07:56:09AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> > > If virtio devices are tagged for "restricted-dma-pool", then that
> > > pool should be used for virtio ring setup, via the DMA API.
> > > 
> > > In particular, this fixes virtio_balloon for ARM PKVM, where the usual
> > > workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
> > > doesn't work because the virtio_balloon driver clears the flag. This
> > > seems a more robust fix than fiddling the flag again.
> > > 
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > 
> > 
> > So the reason balloon disables ACCESS_PLATFORM is simply
> > because it passes physical addresses to device and
> > expects device to be able to poke at them.
> > 
> > I worry about modifying DMA semantics yet again - it has as much of a
> > chance to break some legacy configs as it has to fix some.
> > 
> > 
> > And I don't really know much about restricted-dma-pool but
> > I'd like to understand why does it make sense to set it for
> > the balloon since it pokes at all and any system memory.
> 
> So this is set in the device tree by the host, telling it to bounce all DMA
> through a restricted memory window (basically swiotlb). The original reason
> is simply to isolate DMA, to the extent possible, on IOMMU-less systems.
> 
> However it is also useful for PKVM because the host is not trusted to access
> ordinary protected VM memory.

I'll have to read up on pKVM. Will get back to you.

> To allow I/O via the host, restricted-dma-pool
> is used to cause a bounce aperture to be allocated during VM boot, which is
> then explicitly shared with the host. For correct PKVM virtio operation, all
> data *and metadata* (virtio rings and descriptors) must be allocated in or
> bounced through this aperture.
>
> Insofar as virtio device accesses to virtio rings in guest memory essentially
> *are* DMA (from the pov of the guest), I think it makes sense to respect the
> bounce buffer for those rings, if so configured by the device tree.
>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a5ec724c01d8..12be2607c648 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/hrtimer.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/swiotlb.h>
> > >  #include <xen/xen.h>
> > >  
> > >  #ifdef DEBUG
> > > @@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	if (!virtio_has_dma_quirk(vdev))
> > >  		return true;
> > >  
> > > +	/* If the device is configured to use a DMA restricted pool,
> > > +	 * we had better use it.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
> > > +	    is_swiotlb_for_alloc(vdev->dev.parent))
> > > +		return true;
> > > +
> > >  	/* Otherwise, we are left to guess. */
> > >  	/*
> > >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > > -- 
> > > 2.37.0.170.g444d1eabd0-goog
> > 
> > 

