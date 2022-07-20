Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518F57B43A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiGTJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A455F12A84
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658311126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YmCCESdad99/+y0cHmD+1TOj7rDSnAAqAqJlZPlUJxI=;
        b=g6PLTbDlZ9aGr7PBnETtnpINTJcbP1IYZodiRW2UlKyCYM+Mjg34oq3W47h37A+krnfAs4
        jGYnJvkrT3gEkCvE5bH3ofYt8tDwEIyJtvhvxkXBUHZhSIMaPaUCtEPwRBGvVV43R95OuZ
        AUzIoMHZEiW9Lb2zCtISKdVBs0RxsfY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-0wO56rhQM4OXIHQW7LIBGw-1; Wed, 20 Jul 2022 05:58:33 -0400
X-MC-Unique: 0wO56rhQM4OXIHQW7LIBGw-1
Received: by mail-wm1-f72.google.com with SMTP id h189-20020a1c21c6000000b003a2fdf9bd2aso8148794wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmCCESdad99/+y0cHmD+1TOj7rDSnAAqAqJlZPlUJxI=;
        b=c6OmToBMKVP3r19RO4qQrTvFA7DJaiW+oKvaRBQwCN3GfFbIkPaKt5Z574CKsCFNWF
         oA2LtGemXP8TpJf0ffZUNHxU4qkVH6JDZP/EBDPwcKjq20t8QqQL6KTFLOUsNoveCycK
         mOd/0T1UGY67Q9jaKXRUasIHtjL6TcFt/3EBNJEZOSk2t9LfqJjXZIUjhsdsQXQCywkp
         On3eRlEAp8XUgvkP0PjU/OeR70YLpwtIDM+FyQ2CHLuNwsbcJ3mJMJtuagPVOyDT6lx5
         J5+TtkgyVUUBAyP1jP7CGwga5eWA/wSipdMgzeFZ+ymUI5/DmBTLhlKMcT5q5Pjp1UE2
         Bpqw==
X-Gm-Message-State: AJIora/yAZOkLbtdW0gonkJdT8nEsMrunTH1VUdaNTLs/Rk8vjA0pP5n
        mpudJ8KLOFrAPNTNOOuIC1s5tbuU5YuBsn0ALMIEqcTk1ShVL1Kp9TS5xlWrMSVYRVndseeXSkk
        hKJZ8crzVqg+vfRZYNvC9ibNI
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id y14-20020a05600015ce00b0021db177a8f0mr30432543wry.370.1658311112291;
        Wed, 20 Jul 2022 02:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ti/BUqcp+kLfup+ElF6yhzCdwtC3kW8c5fi1qMgoV6FNkQmQ/O1A1ozfiQp9mHTFELrJu6EQ==
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id y14-20020a05600015ce00b0021db177a8f0mr30432527wry.370.1658311112035;
        Wed, 20 Jul 2022 02:58:32 -0700 (PDT)
Received: from redhat.com ([2.55.25.63])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600c038500b003a31b00c216sm1893727wmd.0.2022.07.20.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 02:58:31 -0700 (PDT)
Date:   Wed, 20 Jul 2022 05:58:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keir Fraser <keirf@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220720051351-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
 <YtbXxl8STUtQkacb@google.com>
 <20220720024756-mutt-send-email-mst@kernel.org>
 <Yte8h0wtBZqiBky8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yte8h0wtBZqiBky8@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:27:51AM +0000, Keir Fraser wrote:
> On Wed, Jul 20, 2022 at 02:59:53AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> > > On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > > > > However, if the general idea at least is acceptable, would the
> > > > > implementation be acceptable if I add an explicit API for this to the
> > > > > DMA subsystem, and hide the detail there?
> > > > 
> > > > I don't think so.  The right thing to key off is
> > > > VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> > > > virtio device after all the problems we had with the lack of it.
> > > 
> > > Ok. Certainly the flag description in virtio spec fits the bill.
> > 
> > Maybe. But balloon really isn't a normal device. Yes the rings kind of
> > operate more or less normally. However consider for example free page
> > hinting. We stick a page address in ring for purposes of telling host it
> > can blow it away at any later time unless we write something into the
> > page.  Free page reporting is similar.
> > Sending gigabytes of memory through swiotlb is at minimum not
> > a good idea.
> 
> I don't think any balloon use case needs the page's guest data to be
> made available to the host device. What the device side does with
> reported guest-physical page addresses is somewhat VMM/Hyp specific,
> but I think it's fair to say it will know how to reclaim or track
> pages by guest PA, and bouncing reported/hinted page addresses through
> a SWIOTLB or IOMMU would not be of any use to any use case I can think
> of.
> 
> As far as I can see, the only translation that makes sense at all for
> virtio balloon is in ring management.
> 
> > Conversely, is it even okay security wise that host can blow away any
> > guest page?  Because with balloon GFNs do not go through bounce
> > buffering.
> 
> Ok, I think this is fair and I can address that by describing the use
> case more broadly.
> 
> The short answer is that there will be more patches forthcoming,
> because the balloon driver will need to tell the hypervisor (EL2 Hyp
> in the ARM PKVM case) that is is willingly relinquishing memory
> pages. So, there will be a patch to add a new HVC to PKVM Hyp, and a
> patch to detect and use the new HVC via a new API that hooks into
> Linux's balloon infrastructure.
> 
> So the use case is that virtio_balloon needs to set up its rings and
> descriptors in a shared memory region, as requested via
> dma-restricted-pool and the VIRTIO_F_PALTFORM_ACCESS flag. This is
> required because the host device has no access to regular guest
> memory.
> 
> However, in PKVM, page notifications will notify both the (trusted)
> Hypervisor, via hypercall, and the (untrusted) VMM, via virtio. Guest
> physical addresses are fine here. The VMM understands guest PAs
> perfectly well, it's just not normally allowed to access their
> contents or otherwise map or use those pages itself.

OK ... and I wonder whether this extends the balloon device
in some way? Is there or can there be a new feature bit for this
functionality?


> > 
> > > > > Or a completely different approach would be to revert the patch
> > > > > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > > > > driver. MST: That's back in your court, as it's your patch!
> > > > 
> > > > Which also means this needs to be addresses, but I don't think a
> > > > simple revert is enough.
> > > 
> > > Well here are two possible approaches:
> > > 
> > > 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> > > for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> > > is no longer IOMMU-specific anyway.
> > > 
> > > 2. Continue to clear the flag during virtio_balloon negotiation, but
> > > remember that it was offered, and test for that in vring_use_dma_api()
> > > as well as, or instead of, virtio_has_dma_quirk().
> > > 
> > > Do either of those appeal?
> > 
> > I think the use case needs to be documented better.
> 
> I hope the above is helpful in giving some more context.
> 
> Perhaps it would make more sense to re-submit this patch as part of
> a larger series that includes the rest of the mechanism needed to
> support virtio_balloon on PKVM?
> 
> Thanks,
> Keir

I suspect so, yes.


> > 
> > -- 
> > MST
> > 
> > 

