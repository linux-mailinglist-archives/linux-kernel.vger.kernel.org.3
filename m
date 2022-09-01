Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C55A9155
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIAH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiIAH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:56:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC8C9E8D;
        Thu,  1 Sep 2022 00:56:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2817q8UV009562;
        Thu, 1 Sep 2022 07:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VWJ0iF7Jqd3Q1V4eJazCtQU9rpjJz6u+8TnZDmEJ39s=;
 b=jgV94N6NED0GjOVcnrETcQrYaRq21r0e3WGYNzW0H0grghtGskaxOOgVywjHrGsL86UV
 HGnd5fIUOONfVq+OFeSyyLI+YYLLg4miSwvNE512HYVuAezFCyprI/IEWJf+9SZ6OJBE
 RRCUlpG3OAO3wnZDMPam79EIf5g/Z0/gKzdG9AcI1etrY/vo+cL4eMMOyEXth0eoUMvM
 cZTHzIgUdiRgPjGlWHFLnrI5K+55ZpNpFSEwKzJHFpA7eU2w1T9Xi9OYndvKkrzHQ4tA
 1Hnp7QTS7fR8+/Q+9vcBE4gRu34TweWZta49fjMQMAAwI3MQuzuLED3svvIu24DRRUyp RQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jarqrg240-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 07:56:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2817tuW8029348;
        Thu, 1 Sep 2022 07:56:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3j7ahj6dq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 07:56:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2817uArh37552432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 07:56:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDCD9A4054;
        Thu,  1 Sep 2022 07:56:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2054EA405F;
        Thu,  1 Sep 2022 07:56:10 +0000 (GMT)
Received: from [9.171.52.69] (unknown [9.171.52.69])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 07:56:10 +0000 (GMT)
Message-ID: <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
Date:   Thu, 1 Sep 2022 09:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220831201236.77595-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1tmo4lT0ADQ0FCDWTdxaB8P2OmHyGC7e
X-Proofpoint-ORIG-GUID: 1tmo4lT0ADQ0FCDWTdxaB8P2OmHyGC7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/22 22:12, Matthew Rosato wrote:
> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> domains and the DMA API handling.  However, this commit does not
> sufficiently handle the case where the device is released via a call
> to the release_device op as it may occur at the same time as an opposing
> attach_dev or detach_dev since the group mutex is not held over
> release_device.  This was observed if the device is deconfigured during a
> small window during vfio-pci initialization and can result in WARNs and
> potential kernel panics.
> 
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

We release the lock here to later call s390_iommu_detach_device safely 
right?
Couldn't we keep the lock and put the common code from 
s390_iommu_release_device and s390_iommu_detach_device inside a common 
function?

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

Sorry if it is a stupid question, but two things looks strange to me:

- having DMA initialized just after having unregistered the IOAT
Is that really all we need to unregister before calling dma_init_device?

- having DMA initialized inside the release_device callback:
Why isn't it done in the device_probe ?


> +		}
> +		mutex_unlock(&zdev->dma_domain_lock);
>   	}
>   }
>   
> 

-- 
Pierre Morel
IBM Lab Boeblingen
