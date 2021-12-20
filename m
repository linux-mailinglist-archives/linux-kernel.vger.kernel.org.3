Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7347A889
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhLTLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:23:01 -0500
Received: from foss.arm.com ([217.140.110.172]:52604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhLTLXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:23:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21E8E11FB;
        Mon, 20 Dec 2021 03:23:00 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481643F718;
        Mon, 20 Dec 2021 03:22:58 -0800 (PST)
Message-ID: <1d3d4486-1fe0-372c-f702-30da7cf86b5a@arm.com>
Date:   Mon, 20 Dec 2021 11:22:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20211218074546.1772553-1-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211218074546.1772553-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-18 07:45, Lu Baolu wrote:
> The suported page sizes of an iommu_domain are saved in the pgsize_bitmap
> field. Retrieve the value from the right place.
> 
> Fixes: 58fd9375c2c534 ("drm/nouveau/platform: probe IOMMU if present")

...except domain->pgsize_bitmap was introduced more than a year after 
that commit ;)

As an improvement rather than a fix, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index d0d52c1d4aee..992cc285f2fe 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -133,7 +133,7 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
>   		 * or equal to the system's PAGE_SIZE, with a preference if
>   		 * both are equal.
>   		 */
> -		pgsize_bitmap = tdev->iommu.domain->ops->pgsize_bitmap;
> +		pgsize_bitmap = tdev->iommu.domain->pgsize_bitmap;
>   		if (pgsize_bitmap & PAGE_SIZE) {
>   			tdev->iommu.pgshift = PAGE_SHIFT;
>   		} else {
