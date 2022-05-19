Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5652CCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiESHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiESHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:12:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7B5640D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:11:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C07A368AFE; Thu, 19 May 2022 09:11:46 +0200 (CEST)
Date:   Thu, 19 May 2022 09:11:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        john.garry@huawei.com, hch@lst.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Add config for PCI SAC address trick
Message-ID: <20220519071146.GB22301@lst.de>
References: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 06:36:59PM +0100, Robin Murphy wrote:
> +config IOMMU_DMA_PCI_SAC_OPT
> +	bool "Enable 64-bit legacy PCI optimisation by default"
> +	depends on IOMMU_DMA
> +	default X86
> +	help
> +	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
> +	  wherein the DMA API layer will always first try to allocate a 32-bit
> +	  DMA address suitable for a single address cycle, before falling back
> +	  to allocating from the full usable address range. If your system has
> +	  64-bit legacy PCI devices in 32-bit slots where using dual address
> +	  cycles reduces DMA throughput significantly, this optimisation may be
> +	  beneficial to overall performance.

The config option name sounds odd.  Yes, maybe for actual 64-bit PCI
this actualy is an optimization.  But I'd think of it more as a
workaround. and I'd probably word it as such.  I also would not not
default to true for x86, just allow for that.  There is nothing
fundamental about x86 wanting that, just that people use more crap
drivers on x86.  An the fact that AMD SEV sets the high bit for
encrypted memory has been weeding out at least some of them.

> +bool iommu_dma_forcedac __read_mostly = !IS_ENABLED(CONFIG_IOMMU_DMA_PCI_SAC_OPT);

Overly long line here.
