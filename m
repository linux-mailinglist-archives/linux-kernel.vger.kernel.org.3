Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1749FE30
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350191AbiA1Qgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:36:55 -0500
Received: from foss.arm.com ([217.140.110.172]:53162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350187AbiA1Qgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC75113E;
        Fri, 28 Jan 2022 08:36:52 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06223F793;
        Fri, 28 Jan 2022 08:36:51 -0800 (PST)
Message-ID: <ed9cb725-334a-ace4-9bae-03b9d310f824@arm.com>
Date:   Fri, 28 Jan 2022 16:36:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu: Fix some W=1 warnings
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 10:44, John Garry wrote:
> The code is mostly free of W=1 warning, so fix the following:
> 
> drivers/iommu/iommu.c:996: warning: expecting prototype for iommu_group_for_each_dev(). Prototype was for __iommu_group_for_each_dev() instead
> drivers/iommu/iommu.c:3048: warning: Function parameter or member 'drvdata' not described in 'iommu_sva_bind_device'
> drivers/iommu/ioasid.c:354: warning: Function parameter or member 'ioasid' not described in 'ioasid_get'
> drivers/iommu/omap-iommu.c:1098: warning: expecting prototype for omap_iommu_suspend_prepare(). Prototype was for omap_iommu_prepare() instead

Certainly no harm in keeping the documentation up to date!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 50ee27bbd04e..06fee7416816 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -349,6 +349,7 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
>   
>   /**
>    * ioasid_get - obtain a reference to the IOASID
> + * @ioasid: the ID to get
>    */
>   void ioasid_get(ioasid_t ioasid)
>   {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..75741ce748d5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -980,17 +980,6 @@ static int iommu_group_device_count(struct iommu_group *group)
>   	return ret;
>   }
>   
> -/**
> - * iommu_group_for_each_dev - iterate over each device in the group
> - * @group: the group
> - * @data: caller opaque data to be passed to callback function
> - * @fn: caller supplied callback function
> - *
> - * This function is called by group users to iterate over group devices.
> - * Callers should hold a reference count to the group during callback.
> - * The group->mutex is held across callbacks, which will block calls to
> - * iommu_group_add/remove_device.
> - */
>   static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   				      int (*fn)(struct device *, void *))
>   {
> @@ -1005,7 +994,17 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   	return ret;
>   }
>   
> -
> +/**
> + * iommu_group_for_each_dev - iterate over each device in the group
> + * @group: the group
> + * @data: caller opaque data to be passed to callback function
> + * @fn: caller supplied callback function
> + *
> + * This function is called by group users to iterate over group devices.
> + * Callers should hold a reference count to the group during callback.
> + * The group->mutex is held across callbacks, which will block calls to
> + * iommu_group_add/remove_device.
> + */
>   int iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   			     int (*fn)(struct device *, void *))
>   {
> @@ -3032,6 +3031,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>    * iommu_sva_bind_device() - Bind a process address space to a device
>    * @dev: the device
>    * @mm: the mm to bind, caller must hold a reference to it
> + * @drvdata: opaque data pointer to pass to bind callback
>    *
>    * Create a bond between device and address space, allowing the device to access
>    * the mm using the returned PASID. If a bond already exists between @device and
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 91749654fd49..980e4af3f06b 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1085,7 +1085,7 @@ static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
>   }
>   
>   /**
> - * omap_iommu_suspend_prepare - prepare() dev_pm_ops implementation
> + * omap_iommu_prepare - prepare() dev_pm_ops implementation
>    * @dev:	iommu device
>    *
>    * This function performs the necessary checks to determine if the IOMMU
