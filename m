Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F52E7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347276AbiETIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiETIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:45:32 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E598F9E9EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:45:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C6EE91E9; Fri, 20 May 2022 10:45:28 +0200 (CEST)
Date:   Fri, 20 May 2022 10:45:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <YodVJ7ervpIdWfg+@8bytes.org>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516015759.2952771-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
>  	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *blocking_domain_ops;

I don't understand why extra domain-ops are needed for this. I think it
would be more straight-forward to implement allocation of
IOMMU_DOMAIN_BLOCKED domains in each driver and let the details be
handled in the set_dev() call-back. The IOMMU driver can make sure DMA
is blocked for a device when it encounters a IOMMU_DOMAIN_BLOCKED
domain.

For IOMMUs that have no explicit way to block DMA could just use an
unmanaged domain with an empty page-table.

Regards,

	Joerg
