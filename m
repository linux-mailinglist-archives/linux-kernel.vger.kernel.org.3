Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8D53574C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiE0BZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiE0BZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:25:46 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503D517EE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:25:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-304ddb9b42cso16238457b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOB8pdz5YMawh+tE4HzeA8+mu9Tju2B2ZXIXRpGMpRw=;
        b=HDF2wYgtuU9Zw5wHJkW/PUAU89NXp/Cxl6BPYcfMd9izTtaGCSXBDvOlCoV0vgy8S+
         G/mYwHmzudfV/hPQFS3w4rjQ40EGbQajpQG/PsZTt9J2urxzEPM7ZGsHqv4b9R81F8Eg
         BV5GFD9nU7xKKO08afjDufFWRvZwPWiKYSVpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOB8pdz5YMawh+tE4HzeA8+mu9Tju2B2ZXIXRpGMpRw=;
        b=qLrzSVq8NC29vrLrLuzbWOJDO8e2/AjmT5siLJlD6m1n+nDQYila3XHo90HeA8i1mg
         qd5mm3Xrb8gb7J19XnIA5svmGNYCgMRJQ1Ku48kV3i+WhN14aRhknvgbR/cNwVViicdF
         CbRBqXomf9+zyd0dtzJ1I3e27c6Jhm94NcZIhOGQj3bIZx/bzVe3PDQlcHvF0xRHCEY8
         Q4DQ+dxUmU4eZ8CkhaL45FP0v6UzDwb3UNSyd13pQbKBSYooZLx2JYSY1Bo5S7r9x2gr
         MMdSpR6Twt5oQqpY7qN/lqbE36qJHMgeyuN8ffHJEHV8PTPZoQzRBoD/umuM4c/vlmMO
         Re9A==
X-Gm-Message-State: AOAM5320hDw/g9o8Xpf9M0RBqFRPu4/MpJ45tItD3OVQOKU2W/CtDoDm
        GYFa6t01V6VXRosbe1JW13LjXp2vGzyTlNMd8hYLqg==
X-Google-Smtp-Source: ABdhPJyhsnVAPLaMcmgCWDAhzi1PgucWk5A9KwG/Q2umXETsbwwzIiu1bfGanEPnbdip2vtnovjMl2T+wtjSv79nkes=
X-Received: by 2002:a81:802:0:b0:2f7:cd12:9d53 with SMTP id
 2-20020a810802000000b002f7cd129d53mr39479699ywi.197.1653614744913; Thu, 26
 May 2022 18:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210806103423.3341285-1-stevensd@google.com> <48f72bbddb099b474d7917ff0e7c14a271d31350.camel@linux.ibm.com>
In-Reply-To: <48f72bbddb099b474d7917ff0e7c14a271d31350.camel@linux.ibm.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 27 May 2022 10:25:34 +0900
Message-ID: <CAD=HUj62m_P53nr-Zz4bO4Bsn_tgauWX3a28MgRgsB2xShB4Hg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add dynamic iommu backed bounce buffers
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 9:27 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Fri, 2021-08-06 at 19:34 +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > This patch series adds support for per-domain dynamic pools of iommu
> > bounce buffers to the dma-iommu API. This allows iommu mappings to be
> > reused while still maintaining strict iommu protection.
> >
> > This bounce buffer support is used to add a new config option that, when
> > enabled, causes all non-direct streaming mappings below a configurable
> > size to go through the bounce buffers. This serves as an optimization on
> > systems where manipulating iommu mappings is very expensive. For
> > example, virtio-iommu operations in a guest on a linux host require a
> > vmexit, involvement the VMM, and a VFIO syscall. For relatively small
> > DMA operations, memcpy can be significantly faster.
> >
> > As a performance comparison, on a device with an i5-10210U, I ran fio
> > with a VFIO passthrough NVMe drive and virtio-iommu with '--direct=1
> > --rw=read --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k,
> > and 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> > spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> > 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> > by >99%, as bounce buffers don't require syncing here in the read case.
> > Running with multiple jobs doesn't serve as a useful performance
> > comparison because virtio-iommu and vfio_iommu_type1 both have big
> > locks that significantly limit mulithreaded DMA performance.
> >
> > These pooled bounce buffers are also used for subgranule mappings with
> > untrusted devices, replacing the single use bounce buffers used
> > currently. The biggest difference here is that the new implementation
> > maps a whole sglist using a single bounce buffer. The new implementation
> > does not support using bounce buffers for only some segments of the
> > sglist, so it may require more copying. However, the current
> > implementation requires per-segment iommu map/unmap operations for all
> > untrusted sglist mappings (fully aligned sglists included). On a
> > i5-10210U laptop with the internal NVMe drive made to appear untrusted,
> > fio --direct=1 --rw=read --ioengine=libaio --iodepth=64 --bs=64k showed
> > a statistically significant decrease in CPU load from 2.28% -> 2.17%
> > with the new iommu bounce buffer optimization enabled.
> >
> > Each domain's buffer pool is split into multiple power-of-2 size
> > classes. Each class allocates a fixed number of buffer slot metadata. A
> > large iova range is allocated, and each slot is assigned an iova from
> > the range. This allows the iova to be easily mapped back to the slot,
> > and allows the critical section of most pool operations to be constant
> > time. The one exception is finding a cached buffer to reuse. These are
> > only separated according to R/W permissions - the use of other
> > permissions such as IOMMU_PRIV may require a linear search through the
> > cache. However, these other permissions are rare and likely exhibit high
> > locality, so the should not be a bottleneck in practice.
> >
> > Since untrusted devices may require bounce buffers, each domain has a
> > fallback rbtree to manage single use buffers. This may be necessary if a
> > very large number of DMA operations are simultaneously in-flight, or for
> > very large individual DMA operations.
> >
> > This patch set does not use swiotlb. There are two primary ways in which
> > swiotlb isn't compatible with per-domain buffer pools. First, swiotlb
> > allocates buffers to be compatible with a single device, whereas
> > per-domain buffer pools don't handle that during buffer allocation as a
> > single buffer may end up being used by multiple devices. Second, swiotlb
> > allocation establishes the original to bounce buffer mapping, which
> > again doesn't work if buffers can be reused. Effectively the only code
> > that can be shared between the two use cases is allocating slots from
> > the swiotlb's memory. However, given that we're going to be allocating
> > memory for use with an iommu, allocating memory from a block of memory
> > explicitly set aside to deal with a lack of iommu seems kind of
> > contradictory. At best there might be a small performance improvement if
> > wiotlb allocation is faster than regular page allocation, but buffer
> > allocation isn't on the hot path anyway.
> >
> > Not using the swiotlb has the benefit that memory doesn't have to be
> > preallocated. Instead, bounce buffers consume memory only for in-flight
> > dma transactions (ignoring temporarily cached buffers), which is the
> > smallest amount possible. This makes it easier to use bounce buffers as
> > an optimization on systems with large numbers of devices or in
> > situations where devices are unknown, since it is not necessary to try
> > to tune how much memory needs to be set aside to achieve good
> > performance without costing too much memory.
> >
> > Finally, this series adds a new DMA_ATTR_PERSISTENT_STREAMING flag. This
> > is meant to address devices which create long lived streaming mappings
> > but manage CPU cache coherency without using the dma_sync_* APIs.
> > Currently, these devices don't function properly with swiotlb=force. The
> > new flag is used to bypass bounce buffers so such devices will function
> > when the new bounce buffer optimization is enabled. The flag is added to
> > the i915 driver, which creates such mappings. It can also be added to
> > various dma-buf implementations as an optimization, although that is not
> > done here.
> >
> > v1 -> v2:
> >  - Replace existing untrusted bounce buffers with new bounce
> >    buffer pools. This includes significant rework to account for
> >    untrusted bounce buffers being required instead of an
> >    optimization.
> >  - Add flag for persistent streaming mappings.
> >
>
> Hi David,
>
> I'm currently looking into converting s390 from our custom IOMMU based
> DMA API implementation to using dma-iommu.c. We're always using an
> IOMMU for PCI devices even when doing pass-through to guests (under
> both the KVM and z/VM hypervisors). In this case I/O TLB flushes, which
> we use to do the shadowing of the guest I/O translations, are
> relatively expensive I'm thus very interested in your work. I've tried
> rebasing it on v5.18 and got it to compile but didn't get DMA to work
> though it seems to partially work as I don't get probe failures unlike
> with a completely broken DMA API. Since I might have very well screwed
> up the rebase and my DMA API conversion is experimental too I was
> wondering if you're still working on this and might have a current
> version I could experiment with?

Unfortunately I don't have anything more recent to share. I've come
across some performance issues caused by pathological usage patterns
in internal usage, but I haven't seen any correctness issues. I'm
hoping that I'll be able to address the performance issues and send a
rebased series within the next month or so.

It's definitely possible that this series has some bugs. I've tested
it on a range of chromebooks and their various hardware and drivers,
but that's still all relatively normal x86_64/arm64. If your hardware
is more particular about its DMA, this series might be missing
something.

-David
