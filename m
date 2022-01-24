Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB8497C00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiAXJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiAXJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:32:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F555C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apuUXH+60n6hljRak/UVGWlJLkn1KcaMbpnLlafoj9s=; b=hVSTPrEcrShyI50dK3OBPQnhac
        maUZoKQh8S9+L4HSCfX2bpnHFRylBiAFnpnySwK8VANInwz9+Q3PQczTrtReo2Z71IhkalEjU9IrX
        zp1orRmwMunA4S4gWCFQy//JLgYjB6uZgjzVtCH2nptqNpe2886yBsOy4RWYBPvcmxqM1/R+gakd3
        CfRiiJDFzOnXcLZn4FAILBTaqCOcC0/GZUvlwNJRwVmulvcGydFJWZDE90TGJEdgn6HbZB8wIVBk0
        KVLzMKAeJE9URH+f89yX5NaN7ayeFp1EowP4ZeaXe80w9FRuO83rSHt1owTqL7Kz0QWEZSsJD7HP4
        7zCyL4MQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvht-002nqj-Nq; Mon, 24 Jan 2022 09:32:13 +0000
Date:   Mon, 24 Jan 2022 01:32:13 -0800
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
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Message-ID: <Ye5yHejpaAnJQYeR@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-7-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
> The common iommu_ops is hooked to both device and domain. When a helper
> has both device and domain pointer, the way to get the iommu_ops looks
> messy in iommu core. This sorts out the way to get iommu_ops. The device
> related helpers go through device pointer, while the domain related ones
> go through domain pointer.

Ugg. This really sounds like we should have a different structures for
each set of ops?
