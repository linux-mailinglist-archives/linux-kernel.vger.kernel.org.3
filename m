Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92931497C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiAXJhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiAXJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:37:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3986C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/r63EfvVm9RGMh2KAen4T39zB4cnOCdcpB+cKli6kk=; b=44hIObpmhtBGdpXCw/Owm1z15D
        gX3B43MrVba/2WBdQfup9/lzCAMQUm574OPNrXbV9oozMfw5HxE96QnNtc8jdo9JbaFSEQsq69UHq
        xYViMyqTzihvBZAyNoQHnIh39jq5hr7SBtYvZn3S3GW1s3LiVnrPbxdul/P8pIUT5cGDzRuLcyJ6J
        o098rl9sploiMtLIIa/7RPAv8stiyivLwWVQ6wSaI3BMD5kYiYImyma7TCz8XIy9B2+iB8Wc2ODZq
        v9IJe+4PH9SUnn+OHDjjsVrp0A0cctGZf45rGQv1GUhVOYhPAQ5RapGmD/t7d5wsFASILlYgnlSzZ
        1xm7p5YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvmr-002p4d-M0; Mon, 24 Jan 2022 09:37:21 +0000
Date:   Mon, 24 Jan 2022 01:37:21 -0800
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
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <Ye5zUapC/YcZs7kl@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-8-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
> Add a domain specific callback set, domain_ops, for vendor iommu driver
> to provide domain specific operations. Move domain-specific callbacks
> from iommu_ops to the domain_ops and hook them when a domain is allocated.

Ah, that's what I meant earlier.  Perfect!

Nit:  I don't think vendor is the right term here.

Maybe something like:

iommut: split struct iommu_ops

Move the domain specific operations out of struct iommu_ops into a new
structure that only has domain specific operations.  This solves
the problem of needing to know if the method vector for a given
operation needs to be retreived from the device or th domain.

> +struct domain_ops {

This needs to keep an iommu in the name, i.e. iommu_domain_ops.

> +	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);

Overly long line.

> +static inline void iommu_domain_set_ops(struct iommu_domain *domain,
> +					const struct domain_ops *ops)
> +{
> +	domain->ops = ops;
> +}

Do we really need this helper?

> +static const struct domain_ops amd_domain_ops;

Can we avoid these forward declarations or would that cause too much
churn?
