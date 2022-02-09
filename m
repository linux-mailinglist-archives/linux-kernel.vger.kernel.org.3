Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD07F4AEA8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiBIGpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiBIGou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:44:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FDFC03544F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KmU/3ByFFqL6kVhZO8U+qtBb64MZx4iPb69sQBmFw9s=; b=YWQ1mpOyWmMiA4wGtaJ8yjU7nA
        EzGaeGfEP8xZFRlvZCqQG+8MneA5I1MWrbwEKwVbf56z434AKyBfUxDT0oB2rqJCB0P7Niv/KTcOF
        GRcNJ8eT2JXcH1Nmb9N0MfL8H3NbrU4WPZm4+wYs9qOoKEAM6q16a5t3JyrjkXLf9pFmsaVx4b55u
        c6xcl8NEVs8gbCYHE6BtLFqr78EYama5WrGK5b0oC8jo8C6YqG1XCMVfZoDUklhYgy398GANW1Sx/
        iXtY1taObbswNfyi70UiF+eM+5s2wKhHVMl1y2wahUaiOX428w1qyREnuz4LvLE8gLoo/vXl9uhNA
        aSZxa1+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHgic-00GNnQ-UI; Wed, 09 Feb 2022 06:44:46 +0000
Date:   Tue, 8 Feb 2022 22:44:46 -0800
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
Subject: Re: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Message-ID: <YgNi3unEVewqJtaL@infradead.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-10-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:58AM +0800, Lu Baolu wrote:
> Convert all the feasible instances of dev->bus->iommu_ops to
> dev_iommu_ops() in order to making the operation of obtaining
> iommu_ops from a device consistent.

I'm not a native speaker, but I think this should read ".. in order to
make .."

>  void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	if (ops && ops->get_resv_regions)

dev_iommu_ops warns on a NULL ops, so we either don'tneed the ops check
here or have another problem.

Same in a few more spots.
