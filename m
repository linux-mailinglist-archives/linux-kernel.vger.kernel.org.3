Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34D75A9490
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiIAK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiIAK0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:26:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB2EDC650B;
        Thu,  1 Sep 2022 03:25:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEFC8D6E;
        Thu,  1 Sep 2022 03:26:02 -0700 (PDT)
Received: from [10.57.18.92] (unknown [10.57.18.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0D83F7B4;
        Thu,  1 Sep 2022 03:25:54 -0700 (PDT)
Message-ID: <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
Date:   Thu, 1 Sep 2022 11:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-GB
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220831201236.77595-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-31 21:12, Matthew Rosato wrote:
> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> domains and the DMA API handling.  However, this commit does not
> sufficiently handle the case where the device is released via a call
> to the release_device op as it may occur at the same time as an opposing
> attach_dev or detach_dev since the group mutex is not held over
> release_device.  This was observed if the device is deconfigured during a
> small window during vfio-pci initialization and can result in WARNs and
> potential kernel panics.

Hmm, the more I think about it, something doesn't sit right about this 
whole situation... release_device is called via the notifier from 
device_del() after the device has been removed from its parent bus and 
largely dismantled; it should definitely not still have a driver bound 
by that point, so how is VFIO doing things that manage to race at all?

Robin.

> Handle this by tracking when the device is probed/released via
> dev_iommu_priv_set/get().  Ensure that once the device is released only
> release_device handles the re-init of the device DMA.
> 
> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   arch/s390/include/asm/pci.h |  1 +
>   arch/s390/pci/pci.c         |  1 +
>   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
>   3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 7b4cdadbc023..080251e7b275 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -157,6 +157,7 @@ struct zpci_dev {
>   	/* DMA stuff */
>   	unsigned long	*dma_table;
>   	spinlock_t	dma_table_lock;
> +	struct mutex	dma_domain_lock; /* protects s390_domain value */
>   	int		tlb_refresh;
>   
>   	spinlock_t	iommu_bitmap_lock;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..973edd32ecc9 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>   	kref_init(&zdev->kref);
>   	mutex_init(&zdev->lock);
>   	mutex_init(&zdev->kzdev_lock);
> +	mutex_init(&zdev->dma_domain_lock);
>   
>   	rc = zpci_init_iommu(zdev);
>   	if (rc)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..1137d669e849 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -99,6 +99,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   	if (!domain_device)
>   		return -ENOMEM;
>   
> +	/* Leave now if the device has already been released */
> +	mutex_lock(&zdev->dma_domain_lock);
> +	if (!dev_iommu_priv_get(dev)) {
> +		mutex_unlock(&zdev->dma_domain_lock);
> +		kfree(domain_device);
> +		return 0;
> +	}
> +
>   	if (zdev->dma_table && !zdev->s390_domain) {
>   		cc = zpci_dma_exit_device(zdev);
>   		if (cc) {
> @@ -132,9 +140,10 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   		goto out_restore;
>   	}
>   	domain_device->zdev = zdev;
> -	zdev->s390_domain = s390_domain;
>   	list_add(&domain_device->list, &s390_domain->devices);
>   	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +	zdev->s390_domain = s390_domain;
> +	mutex_unlock(&zdev->dma_domain_lock);
>   
>   	return 0;
>   
> @@ -147,6 +156,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   				   virt_to_phys(zdev->dma_table));
>   	}
>   out_free:
> +	mutex_unlock(&zdev->dma_domain_lock);
>   	kfree(domain_device);
>   
>   	return rc;
> @@ -176,17 +186,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>   	}
>   	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>   
> -	if (found && (zdev->s390_domain == s390_domain)) {
> +	mutex_lock(&zdev->dma_domain_lock);
> +	if (found && (zdev->s390_domain == s390_domain) &&
> +	    dev_iommu_priv_get(dev)) {
>   		zdev->s390_domain = NULL;
>   		zpci_unregister_ioat(zdev, 0);
>   		zpci_dma_init_device(zdev);
>   	}
> +	mutex_unlock(&zdev->dma_domain_lock);
>   }
>   
>   static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>   {
>   	struct zpci_dev *zdev = to_zpci_dev(dev);
>   
> +	dev_iommu_priv_set(dev, zdev);
> +
>   	return &zdev->iommu_dev;
>   }
>   
> @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
>   	 *
>   	 * So let's call detach_dev from here if it hasn't been called before.
>   	 */
> -	if (zdev && zdev->s390_domain) {
> +	if (zdev) {
> +		/*
> +		 * Clear priv to block further attaches for this device,
> +		 * ensure detaches don't init DMA.  Hold the domain lock
> +		 * to ensure that attach/detach get a consistent view of
> +		 * whether or not the device is released.
> +		 */
> +		mutex_lock(&zdev->dma_domain_lock);
> +		dev_iommu_priv_set(dev, NULL);
> +		mutex_unlock(&zdev->dma_domain_lock);
> +		/* Make sure this device is removed from the domain list */
>   		domain = iommu_get_domain_for_dev(dev);
>   		if (domain)
>   			s390_iommu_detach_device(domain, dev);
> +		/* Now ensure DMA is initialized from here */
> +		mutex_lock(&zdev->dma_domain_lock);
> +		if (zdev->s390_domain) {
> +			zdev->s390_domain = NULL;
> +			zpci_unregister_ioat(zdev, 0);
> +			zpci_dma_init_device(zdev);
> +		}
> +		mutex_unlock(&zdev->dma_domain_lock);
>   	}
>   }
>   
