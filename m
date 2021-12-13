Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C24721E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhLMHr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:47:26 -0500
Received: from verein.lst.de ([213.95.11.211]:46472 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLMHr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:47:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D9C468AA6; Mon, 13 Dec 2021 08:47:22 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:47:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213074721.GB20758@lst.de>
References: <20211207030750.30824-1-bhe@redhat.com> <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:05:26AM +0100, Christoph Lameter wrote:
> On Tue, 7 Dec 2021, Baoquan He wrote:
> 
> > into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
> > take care of antique ISA devices. In fact, on 64bit system, it rarely
> > need ZONE_DMA (which is low 16M) to support almost extinct ISA devices.
> > However, some components treat DMA as a generic concept, e.g
> > kmalloc-dma, slab allocator initializes it for later any DMA related
> > buffer allocation, but not limited to ISA DMA.
> 
> The idea of the slab allocator DMA support is to have memory available
> for devices that can only support a limited range of physical addresses.
> These are only to be enabled for platforms that have such requirements.
> 
> The slab allocators guarantee that all kmalloc allocations are DMA able
> indepent of specifying ZONE_DMA/ZONE_DMA32

Yes.  And we never supported slab for ZONE_DMA32 and should work on
getting rid of it for ZONE_DMA as well.  The only thing that guarantees
device addressability is the DMA API.  The DMA API needs ZONE_DMA/DMA32
to back its page allocations, but supporting this in slab is a bad idea
only explained by historic reasons from before when we had a DMA API.

> > On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> > are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
> > empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
> > then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
> > the 32-bit addressable memory.
> 
> ZONE_NORMAL should cover all memory. ARM does not need ZONE_DMA32.

arm32 not, arm64 does.  And the Pi 4 is an arm64 device.

> > I am wondering if we can also change the size of DMA and DMA32 ZONE as
> > dynamically adjusted, just as arm64 is doing? On x86_64, we can make
> > zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
> > default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
> > low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
> > (I am not familiar with ISA_DMA_API, will it require 24-bit addressable
> > memory when enabled?)
> 
> The size of ZONE_DMA is traditionally depending on the platform. On some
> it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> only be used if ZONE_DMA has already been used.

ZONE32 should be (and generally is) used whenever there is zone covering
the 32-bit CPU physical address limit.

> 
> ZONE_DMA is dynamic in the sense of being different on different
> platforms.

Agreed.
