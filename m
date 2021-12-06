Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E078C469521
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhLFLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:43:43 -0500
Received: from 8bytes.org ([81.169.241.247]:40074 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241994AbhLFLnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:43:42 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DAB2A37E; Mon,  6 Dec 2021 12:40:12 +0100 (CET)
Date:   Mon, 6 Dec 2021 12:40:11 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com,
        ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Extend mutex lock scope in
 iommu_probe_device()
Message-ID: <Ya32m0n4r4jeI+46@8bytes.org>
References: <20211108061349.1985579-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108061349.1985579-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 02:13:49PM +0800, Lu Baolu wrote:
> Extend the scope of holding group->mutex so that it can cover the default
> domain check/attachment and direct mappings of reserved regions.
> 
> Cc: Ashish Mhetre <amhetre@nvidia.com>
> Fixes: 211ff31b3d33b ("iommu: Fix race condition during default domain allocation")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks. The __iommu_attach_device() function is called under
group->mutex everywhere else, so it makes here too.

Regards,

	Joerg
