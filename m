Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3A5A79B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiHaJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHaJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:06:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499D220F3;
        Wed, 31 Aug 2022 02:06:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V8JNQv025446;
        Wed, 31 Aug 2022 09:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=75f35kjL77DptNAVByM0+6RQrOghDx5dYgfSAwEFf70=;
 b=dR8UeaR+ZCHYH1O9pYNg97EKD4C3gJupkq3mNJ01DntBl3itv1/C783Wc39F67kOq23+
 OBMtR4XuWPyqYWLk0pJvcrcMGZ68BMCrdfT2WTNB/1BvuRQM8JE1MbZE2Tn0AowJ1xGx
 DtZje704DRgz3oZf78ehU/aLYB8yxLJ2IkZsK+ejcIBgzdHzwT48ra/BR6fudWuYwKJw
 FoB9tn39RKSvSCzONLoz7ssjZspqdkcFADj1k9ja9rzRAkmwXYyH68xmILne+1tBiYPR
 UaNSfevj050ntBnuKBBV29SKX0ZyMr9CReO+gJ2SyqYOKKD+4jEokr0N8X3GegaQPjA7 Pw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja41j9uk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 09:05:56 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27V8ooNA032569;
        Wed, 31 Aug 2022 09:05:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3j7aw8umpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 09:05:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27V95nVH42598906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 09:05:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A13CE5204F;
        Wed, 31 Aug 2022 09:05:49 +0000 (GMT)
Received: from [9.171.50.113] (unknown [9.171.50.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E946D5204E;
        Wed, 31 Aug 2022 09:05:48 +0000 (GMT)
Message-ID: <12a49c8d-cb38-e22a-0040-88350b6210aa@linux.ibm.com>
Date:   Wed, 31 Aug 2022 11:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220830201546.18871-1-mjrosato@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220830201546.18871-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xEkINlKGRpRgNzbXvPc4bn4UwQuDBDiK
X-Proofpoint-GUID: xEkINlKGRpRgNzbXvPc4bn4UwQuDBDiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_05,2022-08-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/22 22:15, Matthew Rosato wrote:
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
> Changes since v2:
> - Relocate the list_empty and aperture chekcs in attach_dev to the
>    their original locations so they are all done under a single
>    acquisition of the spinlock (Heiko)
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


Shouldn't you take the group_mutex before calling directly 
s390_iommu_detach_device from here?


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
> 

-- 
Pierre Morel
IBM Lab Boeblingen
