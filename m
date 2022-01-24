Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B0497BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiAXJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiAXJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:30:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91728C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Cbhoao8YGSMbLhLMvHmRWGSewCaoxDNcEjjCdUssKY=; b=G6sqF+8Q7cLOd4wGmirGsKPswL
        BKg/uDXdGa8RZ7jTwvJQGtb8iZbh2HLDi1ClyvRjkik/iLL3N6JAgQjzmEaO+Yh/N4sfcg1BjnDW+
        RARriawQ3akmmVWqwsSY/3T2waQE8FudFuiGrHIW29RUVY66Y+oWfDx9Yl5Mawrn/FuI8yj+/PpIu
        dEz1meLry+wtMTDeLqG+lW5wIWkD8WHEbOU9y1vYHfyFMQmTwuepUmQseiMWXnJwcyBHvvBIjtM+A
        3SrECgTgN19wA0OlVKDbz4RmoZ7PjLEBBTHLZHZDLhEXZ8i08ZdJvedeS4fQG5qbQ6eCM6G0r9vGH
        Tvscrkpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvfh-002nXX-9U; Mon, 24 Jan 2022 09:29:57 +0000
Date:   Mon, 24 Jan 2022 01:29:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Message-ID: <Ye5xlSbwAw5JJ8k2@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-6-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:00PM +0800, Lu Baolu wrote:
> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
> field. Retrieve the value from the right place.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Wouldn't it mke sense to remove the pgsize_bitmap in struct iommu_ops
and initialize the domain field in the domain_alloc methods?  Or am I
missing something?
