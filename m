Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A065846B516
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhLGIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLGII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:08:59 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E281C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:05:29 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 51ECDB00436; Tue,  7 Dec 2021 09:05:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 50481B002EA;
        Tue,  7 Dec 2021 09:05:26 +0100 (CET)
Date:   Tue, 7 Dec 2021 09:05:26 +0100 (CET)
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
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
References: <20211207030750.30824-1-bhe@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021, Baoquan He wrote:

> into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
> take care of antique ISA devices. In fact, on 64bit system, it rarely
> need ZONE_DMA (which is low 16M) to support almost extinct ISA devices.
> However, some components treat DMA as a generic concept, e.g
> kmalloc-dma, slab allocator initializes it for later any DMA related
> buffer allocation, but not limited to ISA DMA.

The idea of the slab allocator DMA support is to have memory available
for devices that can only support a limited range of physical addresses.
These are only to be enabled for platforms that have such requirements.

The slab allocators guarantee that all kmalloc allocations are DMA able
indepent of specifying ZONE_DMA/ZONE_DMA32

> On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
> empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
> then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
> the 32-bit addressable memory.

ZONE_NORMAL should cover all memory. ARM does not need ZONE_DMA32.

> I am wondering if we can also change the size of DMA and DMA32 ZONE as
> dynamically adjusted, just as arm64 is doing? On x86_64, we can make
> zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
> default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
> low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
> (I am not familiar with ISA_DMA_API, will it require 24-bit addressable
> memory when enabled?)

The size of ZONE_DMA is traditionally depending on the platform. On some
it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
only be used if ZONE_DMA has already been used.

ZONE_DMA is dynamic in the sense of being different on different
platforms.

Generally I guess it would be possible to use ZONE_DMA for generic tagging
of special memory that can be configured to have a dynamic size but that is
not what it was designed to do.
