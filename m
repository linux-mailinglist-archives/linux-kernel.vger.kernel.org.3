Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217984695D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhLFMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:44:09 -0500
Received: from 8bytes.org ([81.169.241.247]:40234 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243259AbhLFMoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:44:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 23482396; Mon,  6 Dec 2021 13:40:38 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:40:33 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com
Subject: Re: [PATCH 4/9] iommu/amd: Simplify pagetable freeing
Message-ID: <Ya4EwWkvDpuvoEjF@8bytes.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:10:39PM +0000, Robin Murphy wrote:
> For reasons unclear, pagetable freeing is an effectively recursive
> method implemented via an elaborate system of templated functions that
> turns out to account for 25% of the object file size. Implementing it
> using regular straightforward recursion makes the code simpler, and
> seems like a good thing to do before we work on it further. As part of
> that, also fix the types to avoid all the needless casting back and
> forth which just gets in the way.

Nice cleanup! The stack of functions came from the fact that recursion
was pretty much discouraged in the kernel. But in this case it looks
well bounded and should be fine.

> +static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
> +{
> +	u64 *p;
> +	int i;
> +
> +	for (i = 0; i < 512; ++i) {
> +		/* PTE present? */
> +		if (!IOMMU_PTE_PRESENT(pt[i]))
> +			continue;
> +
> +		/* Large PTE? */
> +		if (PM_PTE_LEVEL(pt[i]) == 0 ||
> +		    PM_PTE_LEVEL(pt[i]) == 7)
> +			continue;
> +
> +		p = IOMMU_PTE_PAGE(pt[i]);
> +		if (lvl > 2)

I thinkt this function deserves a couple of comments. It took me a while
to make sense of the 'lvl > 2' comparision. I think it is right, but if
I have think again I'd appreciate a comment :)

Regards,

	Joerg
