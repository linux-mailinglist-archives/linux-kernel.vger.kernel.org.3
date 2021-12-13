Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A884721D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhLMHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhLMHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639381178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8bgL6C9Jmq2/dh2Fy2dZYjJ3Ymjso37o3dth3Pmxw0=;
        b=Mn0PqRWKXDNPJQOzPgrrKnKO6A2rew5LTE0MUJYG03O1CciKPq2b0H8yIva1EDTZFtg49G
        KcpMGUmVaSnwHy21MD4qybHx6q7KQlSLEAAEa+hUYIen1/Gx3ywm7z6IRoBx/RrYXeWmrg
        zrfWFSNpu9n5Rq+1pIsH6t7bYAgfpUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-J6IXeTT9PpSssop9pUXXlg-1; Mon, 13 Dec 2021 02:39:32 -0500
X-MC-Unique: J6IXeTT9PpSssop9pUXXlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0BA4612ED;
        Mon, 13 Dec 2021 07:39:29 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6345F45D61;
        Mon, 13 Dec 2021 07:39:28 +0000 (UTC)
Date:   Mon, 13 Dec 2021 15:39:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213073925.GA29905@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
 <20211209080540.GA3050@MiWiFi-R3L-srv>
 <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/21 at 01:59pm, Christoph Lameter wrote:
> On Thu, 9 Dec 2021, Baoquan He wrote:
> 
> > > The slab allocators guarantee that all kmalloc allocations are DMA able
> > > indepent of specifying ZONE_DMA/ZONE_DMA32
> >
> > Here you mean we guarantee dma-kmalloc will be DMA able independent of
> > specifying ZONE_DMA/DMA32, or the whole sla/ub allocator?
> 
> All memory obtained via kmalloc --independent of "dma-alloc", ZONE_DMA
> etc-- must be dmaable.

This has a prerequisite as you said at below, only if devices can
address full memory, right?


> 
> > With my understanding, isn't the reasonable sequence zone DMA firstly if
> > GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
> > believe device driver developer prefer to see this because most of time,
> > zone DMA and zone DMA32 are both used for dma buffer allocation, if
> > IOMMU is not enabled. However, memory got from zone NORMAL when required
> > with GFP_DMA, and it succeeds, does it mean that the developer doesn't
> > take the GFP_DMA flag seriously, just try to get buffer for allocation?
> 
> ZONE_NORMAL is also used for DMA allocations. ZONE_DMA and ZONE_DMA32 are
> only used if the physical range of memory supported by a device does not
> include all of normal memory.

If devices can address full memory, ZONE_NORMAL can also be used for DMA
allocations. (This covers the systems where IOMMU is provided).

If device has address limit, e.g dma mask is 24bit or 32bit, ZONE_DMA
and ZONE_DMA32 are needed.

> 
> > > The size of ZONE_DMA is traditionally depending on the platform. On some
> > > it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> > > only be used if ZONE_DMA has already been used.
> >
> > As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> > cover low 4G with ZONE_DMA32 alone.
> 
> If you do not have devices that are crap and cannot address the full
> memory then you dont need these special zones.

I am not a DMA expert, with my understanding, on x86_64 and arm64, we
have PCIe devices which dma mask is 32bit, means they can only address
ZONE_DMA32. Supporting to address full memory might be too expensive for
devices, e.g on these two ARCHes, supported memory could be deployed on
Petabyte of address.

> 
> Sorry this subject has caused confusion multiple times over the years and
> there are still arches that are not implementing this in a consistent way.

Seems so.

And by the way, when I read slub code, noticed a strange phenomenon, I
haven't found out why. When create cache with kmem_cache_create(), zone
flag SLAB_CACHE_DMA, SLAB_CACHE_DMA32 can be specified. allocflags will
store them, and will take out to use when allocating new slab.
Meanwhile, we can also specify gfpflags, but it can't be GFP_DMA32,
because of GFP_SLAB_BUG_MASK. I traced back to very old git history,
didn't find out why GFP_DMA32 can't be specified during
kmem_cache_alloc().

We can completely rely on the cache->allocflags to mark the zone which
we will request page from, but we can also specify gfpflags in
kmem_cache_alloc() to change zone. GFP_DMA32 is prohibited. Here I can
only see that kmalloc() might be the reason, since kmalloc_large()
doesn't have created cache, so no ->allocflags to use.

Is this expected? What can we do to clarify or improve this, at
leaset on code readability?

I am going to post v3, will discard the 'Further thinking' in cover
letter according to your comment. Please help point out if anthing need
be done or missed.

Thanks a lot.

Baoquan
Thanks

