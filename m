Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5B4A4A81
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbiAaP0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiAaP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:26:00 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C538C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:26:00 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E3CD84DC; Mon, 31 Jan 2022 16:25:57 +0100 (CET)
Date:   Mon, 31 Jan 2022 16:25:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: Fix missing put_device() call in
 tegra_smmu_find
Message-ID: <Yff/hImeZQiQ9iYV@8bytes.org>
References: <20220107080915.12686-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107080915.12686-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry,

does this look correct to you?

Thanks,

	Joerg

On Fri, Jan 07, 2022 at 08:09:11AM +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
> 
> Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..2561ce8a2ce8 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -808,8 +808,10 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
>  		return NULL;
>  
>  	mc = platform_get_drvdata(pdev);
> -	if (!mc)
> +	if (!mc) {
> +		put_device(&pdev->dev);
>  		return NULL;
> +	}
>  
>  	return mc->smmu;
>  }
> -- 
> 2.17.1
