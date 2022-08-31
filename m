Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44D5A874E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiHaULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiHaULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:11:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB6C2774;
        Wed, 31 Aug 2022 13:10:53 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VJo2Cm021881;
        Wed, 31 Aug 2022 20:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EoFDqYDmAmcHelb1TwaylGQ01tRux6eGAVVSEzEPYcE=;
 b=jLV/OtEcDmD/m9cLTgrZWWgTN6SBlpsAcEe31da8vOg72D3D9X+/dXZDn5UYiCGuSmT3
 W+9A3XBWKbk5gcAIAJQvtP1+DhzywpBAcfq8yngAs3/3bJeWNGwwPCGzMfhTtPE2+uGS
 Z4DpmvaWrELG4iapG9RwTTxMh3WD/bzrxsftkiGtux3OCDio3CQ6Z1texMj0PbbRK13p
 Qeo6o5FUH0WdQutAmkhneaBo+sogXZTTgj1b+fQwlfCriuJAfvOOCawBTK24ugw95cVm
 ZmdjjWt6vBQTJ3d28IeNwmvUDwIeaS3Gb9qfH3X3w8C9a4OqvBqt2I8Yj74+OssLmtVx Hw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jae518st2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:10:37 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27VK69hv020020;
        Wed, 31 Aug 2022 20:10:36 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3j7aw9umwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 20:10:36 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27VKAZkM10355314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:10:35 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D4BE112062;
        Wed, 31 Aug 2022 20:10:35 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADA06112061;
        Wed, 31 Aug 2022 20:10:34 +0000 (GMT)
Received: from [9.160.77.30] (unknown [9.160.77.30])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Aug 2022 20:10:34 +0000 (GMT)
Message-ID: <ebe5fa1e-812b-d705-1dff-41fa390c8596@linux.ibm.com>
Date:   Wed, 31 Aug 2022 16:10:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] iommu/s390: Fix race with release_device ops
Content-Language: en-US
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220830201546.18871-1-mjrosato@linux.ibm.com>
 <12a49c8d-cb38-e22a-0040-88350b6210aa@linux.ibm.com>
 <89bd532b-33ac-5f9d-a06e-eb002168778b@linux.ibm.com>
In-Reply-To: <89bd532b-33ac-5f9d-a06e-eb002168778b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L1GGMTxseALPilKmrl6irVrGbXklrTe-
X-Proofpoint-GUID: L1GGMTxseALPilKmrl6irVrGbXklrTe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 10:12 AM, Matthew Rosato wrote:
> On 8/31/22 5:05 AM, Pierre Morel wrote:
>>
>>
>> On 8/30/22 22:15, Matthew Rosato wrote:
>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>> domains and the DMA API handling.  However, this commit does not
>>> sufficiently handle the case where the device is released via a call
>>> to the release_device op as it may occur at the same time as an opposing
>>> attach_dev or detach_dev since the group mutex is not held over
>>> release_device.  This was observed if the device is deconfigured during a
>>> small window during vfio-pci initialization and can result in WARNs and
>>> potential kernel panics.
>>>
>>> Handle this by tracking when the device is probed/released via
>>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>>> release_device handles the re-init of the device DMA.
>>>
>>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> ---
>>> Changes since v2:
>>> - Relocate the list_empty and aperture chekcs in attach_dev to the
>>>    their original locations so they are all done under a single
>>>    acquisition of the spinlock (Heiko)
>>> ---
>>>   arch/s390/include/asm/pci.h |  1 +
>>>   arch/s390/pci/pci.c         |  1 +
>>>   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
>>>   3 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>>> index 7b4cdadbc023..080251e7b275 100644
>>> --- a/arch/s390/include/asm/pci.h
>>> +++ b/arch/s390/include/asm/pci.h
>>> @@ -157,6 +157,7 @@ struct zpci_dev {
>>>       /* DMA stuff */
>>>       unsigned long    *dma_table;
>>>       spinlock_t    dma_table_lock;
>>> +    struct mutex    dma_domain_lock; /* protects s390_domain value */
>>>       int        tlb_refresh;
>>>         spinlock_t    iommu_bitmap_lock;
>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>> index 73cdc5539384..973edd32ecc9 100644
>>> --- a/arch/s390/pci/pci.c
>>> +++ b/arch/s390/pci/pci.c
>>> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>>>       kref_init(&zdev->kref);
>>>       mutex_init(&zdev->lock);
>>>       mutex_init(&zdev->kzdev_lock);
>>> +    mutex_init(&zdev->dma_domain_lock);
>>>         rc = zpci_init_iommu(zdev);
>>>       if (rc)
>>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>>> index c898bcbbce11..1137d669e849 100644
>>> --- a/drivers/iommu/s390-iommu.c
>>> +++ b/drivers/iommu/s390-iommu.c
>>> @@ -99,6 +99,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>>       if (!domain_device)
>>>           return -ENOMEM;
>>>   +    /* Leave now if the device has already been released */
>>> +    mutex_lock(&zdev->dma_domain_lock);
>>> +    if (!dev_iommu_priv_get(dev)) {
>>> +        mutex_unlock(&zdev->dma_domain_lock);
>>> +        kfree(domain_device);
>>> +        return 0;
>>> +    }
>>> +
>>>       if (zdev->dma_table && !zdev->s390_domain) {
>>>           cc = zpci_dma_exit_device(zdev);
>>>           if (cc) {
>>> @@ -132,9 +140,10 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>>           goto out_restore;
>>>       }
>>>       domain_device->zdev = zdev;
>>> -    zdev->s390_domain = s390_domain;
>>>       list_add(&domain_device->list, &s390_domain->devices);
>>>       spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>>> +    zdev->s390_domain = s390_domain;
>>> +    mutex_unlock(&zdev->dma_domain_lock);
>>>         return 0;
>>>   @@ -147,6 +156,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>>                      virt_to_phys(zdev->dma_table));
>>>       }
>>>   out_free:
>>> +    mutex_unlock(&zdev->dma_domain_lock);
>>>       kfree(domain_device);
>>>         return rc;
>>> @@ -176,17 +186,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
>>>       }
>>>       spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>>>   -    if (found && (zdev->s390_domain == s390_domain)) {
>>> +    mutex_lock(&zdev->dma_domain_lock);
>>> +    if (found && (zdev->s390_domain == s390_domain) &&
>>> +        dev_iommu_priv_get(dev)) {
>>>           zdev->s390_domain = NULL;
>>>           zpci_unregister_ioat(zdev, 0);
>>>           zpci_dma_init_device(zdev);
>>>       }
>>> +    mutex_unlock(&zdev->dma_domain_lock);
>>>   }
>>>     static struct iommu_device *s390_iommu_probe_device(struct device *dev)
>>>   {
>>>       struct zpci_dev *zdev = to_zpci_dev(dev);
>>>   +    dev_iommu_priv_set(dev, zdev);
>>> +
>>>       return &zdev->iommu_dev;
>>>   }
>>>   @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
>>>        *
>>>        * So let's call detach_dev from here if it hasn't been called before.
>>>        */
>>> -    if (zdev && zdev->s390_domain) {
>>> +    if (zdev) {
>>> +        /*
>>> +         * Clear priv to block further attaches for this device,
>>> +         * ensure detaches don't init DMA.  Hold the domain lock
>>> +         * to ensure that attach/detach get a consistent view of
>>> +         * whether or not the device is released.
>>> +         */
>>> +        mutex_lock(&zdev->dma_domain_lock);
>>> +        dev_iommu_priv_set(dev, NULL);
>>> +        mutex_unlock(&zdev->dma_domain_lock);
>>> +        /* Make sure this device is removed from the domain list */
>>>           domain = iommu_get_domain_for_dev(dev);
>>
>>
>> Shouldn't you take the group_mutex before calling directly s390_iommu_detach_device from here?
>>
> 
> Well, we can't do that directly as the group mutex is only accessible to the iommu core.  But perhaps the right answer is to call back into the core here by just replacing the existing call to s390_iommu_detach_device below with a call to iommu_detach_device (1 line change).  Then we still ensure DMA is initialized next after this point.  I've been running tests with such a change for the last few hours and this works well.
> 

Nope, looking closer that won't work -- There is a small window between calling iommu_get_domain_for_dev and then the subsequent call to iommu_detach_device() where the group->domain could still change, which would trigger a WARN_ON in iommu_detach_device (I managed to trigger this once). 

But really, I think just leaving this as a call to s390_iommu_detach_device without the group_mutex held at this point is OK, all the detach will do at this point (since priv has already been nullified) is get the list_lock and clear the entry for the domain that happened to be the group domain at the time release_device started - and any attempts at further attaches will just quietly return 0 because priv is null.  I guess technically we could also inline that list_del work into release_device and not even call s390_iommu_detach_device.  But the reality is by the time we've reached this point the device is going away and so it's going to have to be removed from all associated domains very soon, not just the one that happens to be active -- So this combined with my 2nd patch (sending shortly as a v4 series) would ensure the device gets removed from each domain, either from a detach_dev or a domain_free call.

> But this also made me notice another subtle issue re: a mismatch between the number of kallocs and kfrees for s390_domain_device.  Need to investigate that further before a next version.
> 
>>
>>>           if (domain)
>>>               s390_iommu_detach_device(domain, dev);
>>
>>
>>
>>
>>> +        /* Now ensure DMA is initialized from here */
>>> +        mutex_lock(&zdev->dma_domain_lock);
>>> +        if (zdev->s390_domain) {
>>> +            zdev->s390_domain = NULL;
>>> +            zpci_unregister_ioat(zdev, 0);
>>> +            zpci_dma_init_device(zdev);
>>> +        }
>>> +        mutex_unlock(&zdev->dma_domain_lock);
>>>       }
>>>   }
>>>  
>>
> 

