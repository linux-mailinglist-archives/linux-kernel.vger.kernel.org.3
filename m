Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E959F567
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiHXIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:37:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1B67CAD;
        Wed, 24 Aug 2022 01:37:56 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O8WF3N014260;
        Wed, 24 Aug 2022 08:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V44GAZsPFDkPnrfaW24hhDDPS0M1vcyxT9HTto3ItJA=;
 b=PHAIvi9acM3BRnzyJdgaW9OWyN6l7GJ7oDz/3wbYJF582xXOCPPvPR2Mw3Af4k9imKfD
 6g0b9W9o2eDJS5NAFBVMxlv7M6APypKJlLrA00UuEUrpsymREgfP2f0g3oOs1kuZt9BH
 ManrN0YlH8aI9Jr4Iia0qnCrL2ppO/jWVYemLLePehW4S5YXJrRvxYCK+pdYJ7EyfyFc
 UjDzT7GFyeRIns2VGsTBzB0Xgy5zPvvI09Bn5OkLQ3lmuec+9Utnzx+sGZlaH7sB7VNr
 He0K1LbYmUBVZjMfG6i19LciGfm7unXxn13bjDi7K1vFG7lgANKFLjgxBCLEq0Rbz7bU GQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5gjf858w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:37:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27O8Zq9M008985;
        Wed, 24 Aug 2022 08:37:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3j2pvjbjqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:37:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27O8bRCN21430566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 08:37:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0DFB52051;
        Wed, 24 Aug 2022 08:37:27 +0000 (GMT)
Received: from [9.171.80.120] (unknown [9.171.80.120])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A18452057;
        Wed, 24 Aug 2022 08:37:24 +0000 (GMT)
Message-ID: <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
Date:   Wed, 24 Aug 2022 10:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220823203059.81919-1-mjrosato@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220823203059.81919-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8swtbQhPImiEQc6PFIcVq50axsfaQJ1P
X-Proofpoint-ORIG-GUID: 8swtbQhPImiEQc6PFIcVq50axsfaQJ1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/22 22:30, Matthew Rosato wrote:
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
>   drivers/iommu/s390-iommu.c  | 68 ++++++++++++++++++++++++++++---------
>   3 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 7b4cdadbc023..1295b6900e4b 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -157,6 +157,7 @@ struct zpci_dev {
>   	/* DMA stuff */
>   	unsigned long	*dma_table;
>   	spinlock_t	dma_table_lock;
> +	spinlock_t	dma_domain_lock;
>   	int		tlb_refresh;
>   
>   	spinlock_t	iommu_bitmap_lock;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..61901c1be3cc 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>   	kref_init(&zdev->kref);
>   	mutex_init(&zdev->lock);
>   	mutex_init(&zdev->kzdev_lock);
> +	spin_lock_init(&zdev->dma_domain_lock);
>   
>   	rc = zpci_init_iommu(zdev);
>   	if (rc)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..513a7ebd23b3 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   	struct zpci_dev *zdev = to_zpci_dev(dev);
>   	struct s390_domain_device *domain_device;
>   	unsigned long flags;
> -	int cc, rc;
> +	int cc, rc = 0;
>   
>   	if (!zdev)
>   		return -ENODEV;
>   
> +	/* First check compatibility */
> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
> +	/* First device defines the DMA range limits */
> +	if (list_empty(&s390_domain->devices)) {
> +		domain->geometry.aperture_start = zdev->start_dma;
> +		domain->geometry.aperture_end = zdev->end_dma;
> +		domain->geometry.force_aperture = true;
> +	/* Allow only devices with identical DMA range limits */
> +	} else if (domain->geometry.aperture_start != zdev->start_dma ||
> +		   domain->geometry.aperture_end != zdev->end_dma) {
> +		rc = -EINVAL;
> +	}
> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +	if (rc)
> +		return rc;
> +
>   	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
>   	if (!domain_device)
>   		return -ENOMEM;
>   
> +	/* Leave now if the device has already been released */
> +	spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> +	if (!dev_iommu_priv_get(dev)) {
> +		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
> +		kfree(domain_device);
> +		return 0;
> +	}
> +
>   	if (zdev->dma_table && !zdev->s390_domain) {
>   		cc = zpci_dma_exit_device(zdev);
>   		if (cc) {

Am I wrong? It seems to me that zpci_dma_exit_device here is called with 
the spin_lock locked but this function zpci_dma_exit_device calls vfree 
which may sleep.


> @@ -117,22 +141,11 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   		rc = -EIO;
>   		goto out_restore;
>   	}
> +	zdev->s390_domain = s390_domain;
> +	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
>   
>   	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	/* First device defines the DMA range limits */
> -	if (list_empty(&s390_domain->devices)) {
> -		domain->geometry.aperture_start = zdev->start_dma;
> -		domain->geometry.aperture_end = zdev->end_dma;
> -		domain->geometry.force_aperture = true;
> -	/* Allow only devices with identical DMA range limits */
> -	} else if (domain->geometry.aperture_start != zdev->start_dma ||
> -		   domain->geometry.aperture_end != zdev->end_dma) {
> -		rc = -EINVAL;
> -		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> -		goto out_restore;
> -	}
>   	domain_device->zdev = zdev;
> -	zdev->s390_domain = s390_domain;
>   	list_add(&domain_device->list, &s390_domain->devices);
>   	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>   
> @@ -147,6 +160,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>   				   virt_to_phys(zdev->dma_table));
>   	}
>   out_free:
> +	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
>   	kfree(domain_device);
>   
>   	return rc;
> @@ -176,17 +190,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>   	}
>   	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>   
> -	if (found && (zdev->s390_domain == s390_domain)) {
> +	spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> +	if (found && (zdev->s390_domain == s390_domain) &&
> +	    dev_iommu_priv_get(dev)) {
>   		zdev->s390_domain = NULL;
>   		zpci_unregister_ioat(zdev, 0);
>   		zpci_dma_init_device(zdev);
>   	}
> +	spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
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
> @@ -194,6 +213,7 @@ static void s390_iommu_release_device(struct device *dev)
>   {
>   	struct zpci_dev *zdev = to_zpci_dev(dev);
>   	struct iommu_domain *domain;
> +	unsigned long flags;
>   
>   	/*
>   	 * This is a workaround for a scenario where the IOMMU API common code
> @@ -206,10 +226,26 @@ static void s390_iommu_release_device(struct device *dev)
>   	 *
>   	 * So let's call detach_dev from here if it hasn't been called before.
>   	 */
> -	if (zdev && zdev->s390_domain) {
> +	if (zdev) {
> +		/*
> +		 * Clear priv to block further attaches for this device,
> +		 * ensure detaches don't init DMA
> +		 */
> +		spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> +		dev_iommu_priv_set(dev, NULL);
> +		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
> +		/* Make sure this device is removed from the domain list */
>   		domain = iommu_get_domain_for_dev(dev);
>   		if (domain)
>   			s390_iommu_detach_device(domain, dev);
> +		/* Now ensure DMA is initialized from here */
> +		spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> +		if (zdev->s390_domain) {
> +			zdev->s390_domain = NULL;
> +			zpci_unregister_ioat(zdev, 0);
> +			zpci_dma_init_device(zdev);


If I do not make a mistake, zpci_dma_init_device() calls vzalloc() and 
dma_alloc_cpu_table() which both could sleep.


> +		}
> +		spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
>   	}
>   }
>   
> 

-- 
Pierre Morel
IBM Lab Boeblingen
