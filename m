Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2B57B2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiGTI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiGTI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:27:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116FF66AED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:27:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so2325116wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3W0dtR/y1axIe4Mzxh6PMT5ABepdNbZdQ3J9dNAL+s=;
        b=bYF/dYn3f4gBcPsyAzRyXUySbN6n5WeioBKFCXdnzFt9P8D0J108vHTsORd+YiyO8M
         RlGTVexnGb/w/YD0c6W/2GVZnyD5cXSL6hDP4tNdqwe0GQmqAsqk8tX1TF1F70fuGbQe
         9ErkT5xCUe2elAX77VIROyRmK+C2QmmqhLFdgQh+8vO0hDIaik/HA/lUZXte68okIU76
         XV5+/Ytls/U7DRF/vSqg9pjAeiYmoaXTcAUP2iCsTrfhi9yopPtLFHGd67YjVwYk7qzr
         k7cJz+mM5iMffdjiB0AFM3s4YZV98X4bfQ9ad5gqBIaAj6QxklIaVE3P23O5j6QptT1i
         yETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3W0dtR/y1axIe4Mzxh6PMT5ABepdNbZdQ3J9dNAL+s=;
        b=aAtoIe3s+YTfGh5W9KYMdB0vvZBX1bIS5549qkioOAhoh423KaAa7G0/FccW8Jcq97
         Pgfzq0lWEAu1p4mHSW4xb/GomO187fOJ5nvbC4qAIi7UMcLyHFAW3sXhWqEUn26PMCbd
         ELZAy5vdlofJLXJy893dqDc8mhuXC4YDlRUI/s+jPgnGHVym1tkY9+nbyopsQQOCmcrn
         +OYCOeAw0bKuSFl3jjxc6qKsBDE8QEbaG2guGBGL3YMYgTHQx9vKtxaYYbEC32Hv66ql
         xym47HatWwul/KXtMHQZ7qC0LLqZ/L5Mnmz7pfs2TCZ5YWnpAkgw9nFUfZaKyDLrQSO+
         /vrA==
X-Gm-Message-State: AJIora9AIf6JAdD3+xSIAzyMz4C61YGAmQD+8tGq/fZun/LAUAkRIai/
        dJixRnsHxt++B6JMCEOOa43C7w==
X-Google-Smtp-Source: AGRyM1tJvQn5cRk8SaHTv7rsLqRwB0dawtl/1l5wFj1DZ7FmFRkFlmA6QG19na4OFpPsmJ86B16LAA==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr30221498wrz.690.1658305676529;
        Wed, 20 Jul 2022 01:27:56 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id m4-20020a056000024400b0021e4454e643sm3085023wrz.45.2022.07.20.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:27:55 -0700 (PDT)
Date:   Wed, 20 Jul 2022 08:27:51 +0000
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <Yte8h0wtBZqiBky8@google.com>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
 <YtbXxl8STUtQkacb@google.com>
 <20220720024756-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720024756-mutt-send-email-mst@kernel.org>
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

On Wed, Jul 20, 2022 at 02:59:53AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> > On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > > > However, if the general idea at least is acceptable, would the
> > > > implementation be acceptable if I add an explicit API for this to the
> > > > DMA subsystem, and hide the detail there?
> > > 
> > > I don't think so.  The right thing to key off is
> > > VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> > > virtio device after all the problems we had with the lack of it.
> > 
> > Ok. Certainly the flag description in virtio spec fits the bill.
> 
> Maybe. But balloon really isn't a normal device. Yes the rings kind of
> operate more or less normally. However consider for example free page
> hinting. We stick a page address in ring for purposes of telling host it
> can blow it away at any later time unless we write something into the
> page.  Free page reporting is similar.
> Sending gigabytes of memory through swiotlb is at minimum not
> a good idea.

I don't think any balloon use case needs the page's guest data to be
made available to the host device. What the device side does with
reported guest-physical page addresses is somewhat VMM/Hyp specific,
but I think it's fair to say it will know how to reclaim or track
pages by guest PA, and bouncing reported/hinted page addresses through
a SWIOTLB or IOMMU would not be of any use to any use case I can think
of.

As far as I can see, the only translation that makes sense at all for
virtio balloon is in ring management.

> Conversely, is it even okay security wise that host can blow away any
> guest page?  Because with balloon GFNs do not go through bounce
> buffering.

Ok, I think this is fair and I can address that by describing the use
case more broadly.

The short answer is that there will be more patches forthcoming,
because the balloon driver will need to tell the hypervisor (EL2 Hyp
in the ARM PKVM case) that is is willingly relinquishing memory
pages. So, there will be a patch to add a new HVC to PKVM Hyp, and a
patch to detect and use the new HVC via a new API that hooks into
Linux's balloon infrastructure.

So the use case is that virtio_balloon needs to set up its rings and
descriptors in a shared memory region, as requested via
dma-restricted-pool and the VIRTIO_F_PALTFORM_ACCESS flag. This is
required because the host device has no access to regular guest
memory.

However, in PKVM, page notifications will notify both the (trusted)
Hypervisor, via hypercall, and the (untrusted) VMM, via virtio. Guest
physical addresses are fine here. The VMM understands guest PAs
perfectly well, it's just not normally allowed to access their
contents or otherwise map or use those pages itself.

> 
> > > > Or a completely different approach would be to revert the patch
> > > > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > > > driver. MST: That's back in your court, as it's your patch!
> > > 
> > > Which also means this needs to be addresses, but I don't think a
> > > simple revert is enough.
> > 
> > Well here are two possible approaches:
> > 
> > 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> > for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> > is no longer IOMMU-specific anyway.
> > 
> > 2. Continue to clear the flag during virtio_balloon negotiation, but
> > remember that it was offered, and test for that in vring_use_dma_api()
> > as well as, or instead of, virtio_has_dma_quirk().
> > 
> > Do either of those appeal?
> 
> I think the use case needs to be documented better.

I hope the above is helpful in giving some more context.

Perhaps it would make more sense to re-submit this patch as part of
a larger series that includes the rest of the mechanism needed to
support virtio_balloon on PKVM?

Thanks,
Keir

> 
> -- 
> MST
> 
> 
