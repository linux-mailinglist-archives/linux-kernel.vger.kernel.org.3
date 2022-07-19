Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EE57A145
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiGSOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiGSOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:22:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC1823A5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:06:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z12so21773456wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0qe6owd79kfOz5QoUGqteEmzoe4NlPyWqmpvHKGleE=;
        b=pYO5/Mvw7qIH5vZ83ilJJa31dMRnizK46IAwV3Go+t+880qk2HDQyUaFJFPRAQ3Rjd
         b15B13+Yx4zJx/rL5Wn0ZbrcFZeDHNRipC8RR6sqBNr951sR1U/oD7LoozRapRn48Tg+
         PQP94K2qx4whKvvBbOEw1HCxzd6jcz29h2E0QcrCOgRf6vmoy03ue6wGMhj16jElmLJX
         l7or7zcD45qEWTuEUHYLBKuOdIKBMrvZhpe41OZFjHuvdQhJBcpzWdmgz4dfGSrMDtWR
         vWo/AIcmAfHVBypKwOFKDNvv8trwzbx8Cgk8NsqeNJ14bBBEy6N898x5+zx8RLT/IWpA
         j00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0qe6owd79kfOz5QoUGqteEmzoe4NlPyWqmpvHKGleE=;
        b=1sbv0uejagRiZxGbh7L/wwzG4tZDSs21NdA5kgIezLUSgCv/3UkLbT2Xfu1V5n8ECN
         wcmrLJ41fYQb4EP36hUn9mFO9AadKjdJC7tmT4swSVMCumz2zRtKu6qmUbWX6BzZt9F3
         3Qc9RFo8bfHaEJfWYXoOZ+y9xGTq1K77jLP7zOqxMxQPI0COtGi4Ah7p2e5SpUSjJDUc
         xNs+CrIus0osRgcBi3bElmxiRRu/TJ48YnRwtiK5Sy0I1dB1Ny3Y0NazbPkIpWtAJwG8
         MRcFL88fb19eoV2+UOiA1fQNDDvVARYhl4wKj8TuntRcacu1SFDqEOkZcipwGPY2kIIT
         DXxg==
X-Gm-Message-State: AJIora+bbxsyd/lplGn9n+Sw9XyLGKS45ws5C6KfE0G2w7cXG1aBxJZU
        4hFvS7zEZDbMvFpSWMc3rfBe2Q==
X-Google-Smtp-Source: AGRyM1v8uuyqVXmxMO8jeNwUlsN1AA8XCphru7gShaxahy8hmO0jGnOrm3RL3pwM+Dc5Y5eznof4hQ==
X-Received: by 2002:a5d:6a09:0:b0:21d:7a73:c48a with SMTP id m9-20020a5d6a09000000b0021d7a73c48amr26290804wru.366.1658239564587;
        Tue, 19 Jul 2022 07:06:04 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm3358241wms.3.2022.07.19.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:06:03 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:05:58 +0000
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <Yta6RowkzVbXaSt2@google.com>
References: <20220719100256.419780-1-keirf@google.com>
 <20220719074941-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719074941-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:56:09AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> > If virtio devices are tagged for "restricted-dma-pool", then that
> > pool should be used for virtio ring setup, via the DMA API.
> > 
> > In particular, this fixes virtio_balloon for ARM PKVM, where the usual
> > workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
> > doesn't work because the virtio_balloon driver clears the flag. This
> > seems a more robust fix than fiddling the flag again.
> > 
> > Signed-off-by: Keir Fraser <keirf@google.com>
> 
> 
> So the reason balloon disables ACCESS_PLATFORM is simply
> because it passes physical addresses to device and
> expects device to be able to poke at them.
> 
> I worry about modifying DMA semantics yet again - it has as much of a
> chance to break some legacy configs as it has to fix some.
> 
> 
> And I don't really know much about restricted-dma-pool but
> I'd like to understand why does it make sense to set it for
> the balloon since it pokes at all and any system memory.

So this is set in the device tree by the host, telling it to bounce all DMA
through a restricted memory window (basically swiotlb). The original reason
is simply to isolate DMA, to the extent possible, on IOMMU-less systems.

However it is also useful for PKVM because the host is not trusted to access
ordinary protected VM memory. To allow I/O via the host, restricted-dma-pool
is used to cause a bounce aperture to be allocated during VM boot, which is
then explicitly shared with the host. For correct PKVM virtio operation, all
data *and metadata* (virtio rings and descriptors) must be allocated in or
bounced through this aperture.

Insofar as virtio device accesses to virtio rings in guest memory essentially
*are* DMA (from the pov of the guest), I think it makes sense to respect the
bounce buffer for those rings, if so configured by the device tree.

> > ---
> >  drivers/virtio/virtio_ring.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index a5ec724c01d8..12be2607c648 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/hrtimer.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/swiotlb.h>
> >  #include <xen/xen.h>
> >  
> >  #ifdef DEBUG
> > @@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	if (!virtio_has_dma_quirk(vdev))
> >  		return true;
> >  
> > +	/* If the device is configured to use a DMA restricted pool,
> > +	 * we had better use it.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
> > +	    is_swiotlb_for_alloc(vdev->dev.parent))
> > +		return true;
> > +
> >  	/* Otherwise, we are left to guess. */
> >  	/*
> >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > -- 
> > 2.37.0.170.g444d1eabd0-goog
> 
> 
