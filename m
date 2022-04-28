Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717885136AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348243AbiD1OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiD1OT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:19:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 186CB4EA1C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:16:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7985D1474;
        Thu, 28 Apr 2022 07:16:41 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413FA3F5A1;
        Thu, 28 Apr 2022 07:16:39 -0700 (PDT)
Message-ID: <77195ec7-89e0-c208-f021-70a958347657@arm.com>
Date:   Thu, 28 Apr 2022 15:16:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/14] iommu: Retire bus_set_iommu()
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     jean-philippe@linaro.org, mjrosato@linux.ibm.com,
        sven@svenpeter.dev, zhang.lyra@gmail.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, m.szyprowski@samsung.com
References: <cover.1650890638.git.robin.murphy@arm.com>
In-Reply-To: <cover.1650890638.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 14:18, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-iommu/cover.1649935679.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Just some minor updates for v2, adding a workaround to avoid changing
> VT-d behaviour for now, cleaning up the extra include I missed in
> virtio-iommu, and collecting all the acks so far.

Oh, and I added the proper error handling for bus_iommu_probe() since it 
turned out to be trivial, and applied Krishna's R-b to the wrong patch 
because of course what was patch #2 is now actually patch #3 :(

Apologies, juggling one too many things at the moment...

Robin.

> As before, this is
> based on the AMD IOMMU patch now applied, plus v2 of my
> device_iommu_capable() series here:
> 
> https://lore.kernel.org/linux-iommu/cover.1650878781.git.robin.murphy@arm.com/
> 
> Cheers,
> Robin.
> 
> 
> 
> Robin Murphy (14):
>    iommu/vt-d: Temporarily reject probing non-PCI devices
>    iommu: Always register bus notifiers
>    iommu: Move bus setup to IOMMU device registration
>    iommu/amd: Clean up bus_set_iommu()
>    iommu/arm-smmu: Clean up bus_set_iommu()
>    iommu/arm-smmu-v3: Clean up bus_set_iommu()
>    iommu/dart: Clean up bus_set_iommu()
>    iommu/exynos: Clean up bus_set_iommu()
>    iommu/ipmmu-vmsa: Clean up bus_set_iommu()
>    iommu/mtk: Clean up bus_set_iommu()
>    iommu/omap: Clean up bus_set_iommu()
>    iommu/tegra-smmu: Clean up bus_set_iommu()
>    iommu/virtio: Clean up bus_set_iommu()
>    iommu: Clean up bus_set_iommu()
> 
>   drivers/iommu/amd/amd_iommu.h               |   1 -
>   drivers/iommu/amd/init.c                    |   9 +-
>   drivers/iommu/amd/iommu.c                   |  21 ----
>   drivers/iommu/apple-dart.c                  |  30 +-----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +---------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +--------------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
>   drivers/iommu/exynos-iommu.c                |   9 --
>   drivers/iommu/fsl_pamu_domain.c             |   4 -
>   drivers/iommu/intel/iommu.c                 |   5 +-
>   drivers/iommu/iommu.c                       | 110 +++++++++-----------
>   drivers/iommu/ipmmu-vmsa.c                  |  35 +------
>   drivers/iommu/msm_iommu.c                   |   2 -
>   drivers/iommu/mtk_iommu.c                   |  13 +--
>   drivers/iommu/mtk_iommu_v1.c                |  13 +--
>   drivers/iommu/omap-iommu.c                  |   6 --
>   drivers/iommu/rockchip-iommu.c              |   2 -
>   drivers/iommu/s390-iommu.c                  |   6 --
>   drivers/iommu/sprd-iommu.c                  |   5 -
>   drivers/iommu/sun50i-iommu.c                |   2 -
>   drivers/iommu/tegra-smmu.c                  |  29 ++----
>   drivers/iommu/virtio-iommu.c                |  25 -----
>   include/linux/iommu.h                       |   1 -
>   23 files changed, 67 insertions(+), 402 deletions(-)
> 
