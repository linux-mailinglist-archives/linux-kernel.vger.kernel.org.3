Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3C46E8BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhLINDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhLINDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:03:34 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:00:01 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id E7ED2B00229; Thu,  9 Dec 2021 13:59:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id E6A62B0019A;
        Thu,  9 Dec 2021 13:59:58 +0100 (CET)
Date:   Thu, 9 Dec 2021 13:59:58 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
In-Reply-To: <20211209080540.GA3050@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
References: <20211207030750.30824-1-bhe@redhat.com> <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de> <20211209080540.GA3050@MiWiFi-R3L-srv>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021, Baoquan He wrote:

> > The slab allocators guarantee that all kmalloc allocations are DMA able
> > indepent of specifying ZONE_DMA/ZONE_DMA32
>
> Here you mean we guarantee dma-kmalloc will be DMA able independent of
> specifying ZONE_DMA/DMA32, or the whole sla/ub allocator?

All memory obtained via kmalloc --independent of "dma-alloc", ZONE_DMA
etc-- must be dmaable.

> With my understanding, isn't the reasonable sequence zone DMA firstly if
> GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
> believe device driver developer prefer to see this because most of time,
> zone DMA and zone DMA32 are both used for dma buffer allocation, if
> IOMMU is not enabled. However, memory got from zone NORMAL when required
> with GFP_DMA, and it succeeds, does it mean that the developer doesn't
> take the GFP_DMA flag seriously, just try to get buffer for allocation?

ZONE_NORMAL is also used for DMA allocations. ZONE_DMA and ZONE_DMA32 are
only used if the physical range of memory supported by a device does not
include all of normal memory.

> > The size of ZONE_DMA is traditionally depending on the platform. On some
> > it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> > only be used if ZONE_DMA has already been used.
>
> As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> cover low 4G with ZONE_DMA32 alone.

If you do not have devices that are crap and cannot address the full
memory then you dont need these special zones.

Sorry this subject has caused confusion multiple times over the years and
there are still arches that are not implementing this in a consistent way.

