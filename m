Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC594B5098
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353479AbiBNMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:50:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiBNMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:49:58 -0500
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F144B846
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:49:51 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C068B2FB; Mon, 14 Feb 2022 13:49:49 +0100 (CET)
Date:   Mon, 14 Feb 2022 13:49:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Message-ID: <YgpP7AhY5hd/DX/C@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214015538.2828933-8-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:55:35AM +0800, Lu Baolu wrote:
> +static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> +{
> +	/*
> +	 * Assume that valid ops must be installed if iommu_probe_device()
> +	 * has succeeded. The device ops are essentially for internal use
> +	 * within the IOMMU subsystem itself, so we should be able to trust
> +	 * ourselves not to misuse the helper.
> +	 */
> +	WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
> +		!dev->iommu->iommu_dev->ops);

There is no need for this WARN_ON, the code will oops anyway when one of
the pointers checked here is NULL.

