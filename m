Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A65A4605
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiH2JZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiH2JZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:25:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951E10FFE;
        Mon, 29 Aug 2022 02:24:55 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8oG4w014873;
        Mon, 29 Aug 2022 09:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KSGmMwoVrn1SDghIExOHJJoAe/tDNSQWWv5MVB9CqVw=;
 b=kbBQDewf0xMwbdJiP9N7B3gnRI8VCBXwJxHeBGcKOGx0EJh9ysedBgSWu3UceQ+HQYJa
 cHACCAjKuOIuXv7FuFYkDwoQXKvNxa45NumvkKOv3q6LNxU/ltxzIzoavEXd3cyd4IOQ
 wmZvk7x2lmxe+wXbh3JOqBRjKSwH7flSnTj7fLRTe1hQIuvVZnnFoYm3sxSQRiEuoIz2
 oZDklyyRtj2AgiSm3cily5cG/p50YV7C+HP0jdZxxk8p3SDCbBPPo4FKnOfuqjJQyprv
 dr4SaEusslzQNrdLNzCqYPhtO0gOI4jyhH64yNeTd8GgdSvEnqY20xup/boPqmOT60EF nQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8ta1rt2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 09:24:37 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T9LSeM016787;
        Mon, 29 Aug 2022 09:24:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8shgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 09:24:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T9Or3K43581758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 09:24:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77C2A42041;
        Mon, 29 Aug 2022 09:24:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCEE4203F;
        Mon, 29 Aug 2022 09:24:31 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 09:24:30 +0000 (GMT)
Message-ID: <39df905509721dd1f13c837b81fcf69a56096870.camel@linux.ibm.com>
Subject: Re: [PATCH v2] iommu/s390: Fix race with release_device ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 11:24:30 +0200
In-Reply-To: <20220826194721.250123-1-mjrosato@linux.ibm.com>
References: <20220826194721.250123-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EczvPnffFh08637A0kY8JNCaXiQM4bxZ
X-Proofpoint-ORIG-GUID: EczvPnffFh08637A0kY8JNCaXiQM4bxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-26 at 15:47 -0400, Matthew Rosato wrote:
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
> Changes since v1:
> - Use mutex instead of spinlock due to potential sleep (Pierre)
> ---
>  arch/s390/include/asm/pci.h |  1 +
>  arch/s390/pci/pci.c         |  1 +
>  drivers/iommu/s390-iommu.c  | 67 ++++++++++++++++++++++++++++---------
>  3 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 7b4cdadbc023..8f2041eea741 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -157,6 +157,7 @@ struct zpci_dev {
>  	/* DMA stuff */
>  	unsigned long	*dma_table;
>  	spinlock_t	dma_table_lock;
> +	struct mutex	dma_domain_lock;
>  	int		tlb_refresh;
>  
>  	spinlock_t	iommu_bitmap_lock;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..973edd32ecc9 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>  	kref_init(&zdev->kref);
>  	mutex_init(&zdev->lock);
>  	mutex_init(&zdev->kzdev_lock);
> +	mutex_init(&zdev->dma_domain_lock);
>  
>  	rc = zpci_init_iommu(zdev);
>  	if (rc)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..ffb4e3cee7f6 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  	struct s390_domain_device *domain_device;
>  	unsigned long flags;
> -	int cc, rc;
> +	int cc, rc = 0;
>  
>  	if (!zdev)
>  		return -ENODEV;
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
>  	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
>  	if (!domain_device)
>  		return -ENOMEM;
>  
> +	/* Leave now if the device has already been released */
> +	mutex_lock(&zdev->dma_domain_lock);
> +	if (!dev_iommu_priv_get(dev)) {
> +		mutex_unlock(&zdev->dma_domain_lock);
> +		kfree(domain_device);
> +		return 0;
> +	}
> +
>  	if (zdev->dma_table && !zdev->s390_domain) {
>  		cc = zpci_dma_exit_device(zdev);
>  		if (cc) {
> @@ -117,22 +141,11 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  		rc = -EIO;
>  		goto out_restore;
>  	}
> +	zdev->s390_domain = s390_domain;
> +	mutex_unlock(&zdev->dma_domain_lock);
>  
>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
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
>  	domain_device->zdev = zdev;
> -	zdev->s390_domain = s390_domain;
>  	list_add(&domain_device->list, &s390_domain->devices);
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
> @@ -147,6 +160,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  				   virt_to_phys(zdev->dma_table));
>  	}
>  out_free:
> +	mutex_unlock(&zdev->dma_domain_lock);
>  	kfree(domain_device);
>  
>  	return rc;
> @@ -176,17 +190,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>  	}
>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>  
> -	if (found && (zdev->s390_domain == s390_domain)) {
> +	mutex_lock(&zdev->dma_domain_lock);
> +	if (found && (zdev->s390_domain == s390_domain) &&
> +	    dev_iommu_priv_get(dev)) {
>  		zdev->s390_domain = NULL;
>  		zpci_unregister_ioat(zdev, 0);
>  		zpci_dma_init_device(zdev);
>  	}
> +	mutex_unlock(&zdev->dma_domain_lock);
>  }
>  
>  static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>  {
>  	struct zpci_dev *zdev = to_zpci_dev(dev);
>  
> +	dev_iommu_priv_set(dev, zdev);
> +
>  	return &zdev->iommu_dev;
>  }
>  
> @@ -206,10 +225,26 @@ static void s390_iommu_release_device(struct device *dev)
>  	 *
>  	 * So let's call detach_dev from here if it hasn't been called before.
>  	 */
> -	if (zdev && zdev->s390_domain) {
> +	if (zdev) {
> +		/*
> +		 * Clear priv to block further attaches for this device,
> +		 * ensure detaches don't init DMA
> +		 */
> +		mutex_lock(&zdev->dma_domain_lock);
> +		dev_iommu_priv_set(dev, NULL);
> +		mutex_unlock(&zdev->dma_domain_lock);
> +		/* Make sure this device is removed from the domain list */
>  		domain = iommu_get_domain_for_dev(dev);
>  		if (domain)
>  			s390_iommu_detach_device(domain, dev);
> +		/* Now ensure DMA is initialized from here */
> +		mutex_lock(&zdev->dma_domain_lock);
> +		if (zdev->s390_domain) {
> +			zdev->s390_domain = NULL;
> +			zpci_unregister_ioat(zdev, 0);
> +			zpci_dma_init_device(zdev);
> +		}
> +		mutex_unlock(&zdev->dma_domain_lock);
>  	}
>  }
>  

Looks good to me now. Thanks for tackling this! Feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>



