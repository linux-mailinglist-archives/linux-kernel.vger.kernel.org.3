Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B804721EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhLMHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:49:27 -0500
Received: from verein.lst.de ([213.95.11.211]:46497 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232561AbhLMHtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:49:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0BC3D68AFE; Mon, 13 Dec 2021 08:49:20 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:49:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213074919.GC20758@lst.de>
References: <20211207030750.30824-1-bhe@redhat.com> <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de> <20211209080540.GA3050@MiWiFi-R3L-srv> <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de> <20211213073925.GA29905@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213073925.GA29905@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:39:25PM +0800, Baoquan He wrote:
> > > As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> > > cover low 4G with ZONE_DMA32 alone.
> > 
> > If you do not have devices that are crap and cannot address the full
> > memory then you dont need these special zones.
> 
> I am not a DMA expert, with my understanding, on x86_64 and arm64, we
> have PCIe devices which dma mask is 32bit

Yes, way to many, and they keep getting newly introduce as well.  Also
weirdo masks like 40, 44 or 48 bits.

> , means they can only address
> ZONE_DMA32.

Yes and no.  Offset between cpu physical and device address make this
complicated, even ignoring iommus.
