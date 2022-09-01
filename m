Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977805A9CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiIAQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:14:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152E9350E;
        Thu,  1 Sep 2022 09:14:40 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281FMhNg010252;
        Thu, 1 Sep 2022 16:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FxSD4RizfGmzEnvre6Dp8PWywNJnxm7IbTH2/I5183Q=;
 b=hJFF1/s+9d3rRXkuzlccwXxxSWN/my5TTc6fI/vygatl6wW5wF2dYCe20LOaFABUIvN/
 T9fkzetHqSOjHn3bsLqLBeer9VWy9NVHYHnmr3aAuft78mJyFQBFmqo2HKdfxC7AvXCY
 WhOjiF0C5XSqBFHv5zvkkTs/MUeGOPC2Z6NBi3PKjeVPVFGyXzOvykabIFbXQ1uwrk3X
 sXJLkk6wwHatiu/QWo8khBfpoSzPaxPyi+AvPQ2sG/0t0U0tCbm7PFOb6jPriy3xXU4y
 KrEQ34j1ER56A/K733gUtorX09+qrLMQSrdR3zdemx8iyEZCaE4Sxsde1nXZRDT45i7W eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaxaana7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 16:14:28 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 281FNYXF014346;
        Thu, 1 Sep 2022 16:14:28 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaxaana78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 16:14:28 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 281Fo3rw007503;
        Thu, 1 Sep 2022 16:14:27 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3j7awa2c0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 16:14:27 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 281GEQLf5308952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 16:14:26 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDC36E050;
        Thu,  1 Sep 2022 16:14:26 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DFE16E04E;
        Thu,  1 Sep 2022 16:14:24 +0000 (GMT)
Received: from [9.160.86.252] (unknown [9.160.86.252])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 16:14:24 +0000 (GMT)
Message-ID: <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
Date:   Thu, 1 Sep 2022 12:14:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        jgg@nvidia.com, Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CKjMEFZWF1Ls_nsT4-BatYt49fWHTG52
X-Proofpoint-GUID: Pb7i3VhrrS3SVOTguPEzPligCUqsWdMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 6:25 AM, Robin Murphy wrote:
> On 2022-08-31 21:12, Matthew Rosato wrote:
>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>> domains and the DMA API handling.  However, this commit does not
>> sufficiently handle the case where the device is released via a call
>> to the release_device op as it may occur at the same time as an opposing
>> attach_dev or detach_dev since the group mutex is not held over
>> release_device.  This was observed if the device is deconfigured during a
>> small window during vfio-pci initialization and can result in WARNs and
>> potential kernel panics.
> 
> Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
> 
> Robin.

So, I generally have seen the issue manifest as one of the calls into the iommu core from __vfio_group_unset_container (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.  This happens when the vfio group fd is released, which could be coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.  AFAICT there's nothing serializing the notion of calling into the iommu core here against a device that is simultaneously going through release_device (because we don't enter release_device with the group mutex held), resulting in unpredictable behavior between the dueling attach_dev/detach_dev and the release_device for s390-iommu at least.  


> 
>> Handle this by tracking when the device is probed/released via
>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>> release_device handles the re-init of the device DMA.
>>
>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  1 +
>>   arch/s390/pci/pci.c         |  1 +
>>   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
>>   3 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 7b4cdadbc023..080251e7b275 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -157,6 +157,7 @@ struct zpci_dev {
>>       /* DMA stuff */
>>       unsigned long    *dma_table;
>>       spinlock_t    dma_table_lock;
>> +    struct mutex    dma_domain_lock; /* protects s390_domain value */
>>       int        tlb_refresh;
>>         spinlock_t    iommu_bitmap_lock;
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 73cdc5539384..973edd32ecc9 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>>       kref_init(&zdev->kref);
>>       mutex_init(&zdev->lock);
>>       mutex_init(&zdev->kzdev_lock);
>> +    mutex_init(&zdev->dma_domain_lock);
>>         rc = zpci_init_iommu(zdev);
>>       if (rc)
>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>> index c898bcbbce11..1137d669e849 100644
>> --- a/drivers/iommu/s390-iommu.c
>> +++ b/drivers/iommu/s390-iommu.c
>> @@ -99,6 +99,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>       if (!domain_device)
>>           return -ENOMEM;
>>   +    /* Leave now if the device has already been released */
>> +    mutex_lock(&zdev->dma_domain_lock);
>> +    if (!dev_iommu_priv_get(dev)) {
>> +        mutex_unlock(&zdev->dma_domain_lock);
>> +        kfree(domain_device);
>> +        return 0;
>> +    }
>> +
>>       if (zdev->dma_table && !zdev->s390_domain) {
>>           cc = zpci_dma_exit_device(zdev);
>>           if (cc) {
>> @@ -132,9 +140,10 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>           goto out_restore;
>>       }
>>       domain_device->zdev = zdev;
>> -    zdev->s390_domain = s390_domain;
>>       list_add(&domain_device->list, &s390_domain->devices);
>>       spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> +    zdev->s390_domain = s390_domain;
>> +    mutex_unlock(&zdev->dma_domain_lock);
>>         return 0;
>>   @@ -147,6 +156,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>                      virt_to_phys(zdev->dma_table));
>>       }
>>   out_free:
>> +    mutex_unlock(&zdev->dma_domain_lock);
>>       kfree(domain_device);
>>         return rc;
>> @@ -176,17 +186,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>>       }
>>       spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>>   -    if (found && (zdev->s390_domain == s390_domain)) {
>> +    mutex_lock(&zdev->dma_domain_lock);
>> +    if (found && (zdev->s390_domain == s390_domain) &&
>> +        dev_iommu_priv_get(dev)) {
>>           zdev->s390_domain = NULL;
>>           zpci_unregister_ioat(zdev, 0);
>>           zpci_dma_init_device(zdev);
>>       }
>> +    mutex_unlock(&zdev->dma_domain_lock);
>>   }
>>     static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>>   {
>>       struct zpci_dev *zdev = to_zpci_dev(dev);
>>   +    dev_iommu_priv_set(dev, zdev);
>> +
>>       return &zdev->iommu_dev;
>>   }
>>   @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
>>        *
>>        * So let's call detach_dev from here if it hasn't been called before.
>>        */
>> -    if (zdev && zdev->s390_domain) {
>> +    if (zdev) {
>> +        /*
>> +         * Clear priv to block further attaches for this device,
>> +         * ensure detaches don't init DMA.  Hold the domain lock
>> +         * to ensure that attach/detach get a consistent view of
>> +         * whether or not the device is released.
>> +         */
>> +        mutex_lock(&zdev->dma_domain_lock);
>> +        dev_iommu_priv_set(dev, NULL);
>> +        mutex_unlock(&zdev->dma_domain_lock);
>> +        /* Make sure this device is removed from the domain list */
>>           domain = iommu_get_domain_for_dev(dev);
>>           if (domain)
>>               s390_iommu_detach_device(domain, dev);
>> +        /* Now ensure DMA is initialized from here */
>> +        mutex_lock(&zdev->dma_domain_lock);
>> +        if (zdev->s390_domain) {
>> +            zdev->s390_domain = NULL;
>> +            zpci_unregister_ioat(zdev, 0);
>> +            zpci_dma_init_device(zdev);
>> +        }
>> +        mutex_unlock(&zdev->dma_domain_lock);
>>       }
>>   }
>>   

