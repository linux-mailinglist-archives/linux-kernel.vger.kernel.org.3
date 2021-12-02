Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340A946699E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376568AbhLBSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:14:40 -0500
Received: from foss.arm.com ([217.140.110.172]:38962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242332AbhLBSOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:14:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC341435;
        Thu,  2 Dec 2021 10:11:16 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.196.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEB23F766;
        Thu,  2 Dec 2021 10:11:15 -0800 (PST)
Date:   Thu, 2 Dec 2021 18:11:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Calvin Zhang <calvinzhang.cool@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YakMQA1A75ZADeHi@arm.com>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
 <YaLgfYzxFRVamvdI@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaLgfYzxFRVamvdI@debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 09:50:53AM +0800, Calvin Zhang wrote:
> On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
> >On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
> >> Just like this:
> >> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
> >> 
> >> Add kmemleak_ignore_phys() for CMA created from of reserved node.
[...]
> >The 620951e27457 changelog says "Without this, the kernel crashes...". 
> >Does your patch also fix a crash?  If so under what circumstances and
> >should we backport this fix into -stable kernels?
> 
> No crash occurred. 620951e27457 avoids crashes caused by accessing
> highmem and it was fixed later. Now kmemleak_alloc_phys() and
> kmemleak_ignore_phys() skip highmem. This patch is based on the
> point that CMA regions don't contain pointers to other kmemleak
> objects, and ignores CMA regions from reserved memory as what
> 620951e27457 did.

Note that kmemleak_ignore() only works if there was a prior
kmemleak_alloc() on that address range. With the previous commit we get
this via the memblock_alloc_range() but I fail to see one on the
rmem_cma_setup() path.

-- 
Catalin
