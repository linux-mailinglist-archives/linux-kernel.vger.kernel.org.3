Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C305A02A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiHXUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiHXUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:25:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2530F6D;
        Wed, 24 Aug 2022 13:25:35 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OJlaQi006584;
        Wed, 24 Aug 2022 20:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=x+LyAortpu5TRNqNPw55nWkD8w2jYuet0vVJUp2hZBI=;
 b=CNRhwlfCznXGvlpKVMdbdslqPoQ3zmArcivgD1OJbbFm6mH+28gnLq1qkFKgAE0wrw+M
 9SOhr/HmspNvon+Od2fsU/KwsJVCiSqgaXXfmp9ZvuqPKxPCb6sB8vNsZvzB6TMwik3/
 pIWHtt5UGW12AsKQj+yPbm0OTnqezXkO0SSBGkCJBp2c7h77a75IpewvD0ZSjGogB3ls
 EapBtUJ4NDIatsBXecmHNrxV2hPLkNeU2T78kN9uZSCgfuXaIAfvLc4eW+1TwsbOleCT
 v5morBSY3JFGr6jLdvzzjMWGi6R6qb5DTYoL5J1lunlyGnsZVVJ0sjq3E4mk/2D2kkTB mQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5tf41078-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 20:25:23 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27OKK0UO022273;
        Wed, 24 Aug 2022 20:25:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3j2q8a25wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 20:25:23 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27OKPLgj42533120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 20:25:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 710F66A04D;
        Wed, 24 Aug 2022 20:25:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 277DB6A047;
        Wed, 24 Aug 2022 20:25:20 +0000 (GMT)
Received: from [9.211.112.122] (unknown [9.211.112.122])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Aug 2022 20:25:19 +0000 (GMT)
Message-ID: <04644ee5-2386-1f3d-c1a3-fc4227570cf7@linux.ibm.com>
Date:   Wed, 24 Aug 2022 16:25:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220823203059.81919-1-mjrosato@linux.ibm.com>
 <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4qAPCH24FV5xKnEVuvKrWrpsZJM3HJf
X-Proofpoint-ORIG-GUID: r4qAPCH24FV5xKnEVuvKrWrpsZJM3HJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_12,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 4:37 AM, Pierre Morel wrote:
> 
> 
> On 8/23/22 22:30, Matthew Rosato wrote:
>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>> domains and the DMA API handling.  However, this commit does not
>> sufficiently handle the case where the device is released via a call
>> to the release_device op as it may occur at the same time as an opposing
>> attach_dev or detach_dev since the group mutex is not held over
>> release_device.  This was observed if the device is deconfigured during a
>> small window during vfio-pci initialization and can result in WARNs and
>> potential kernel panics.
>>
>> Handle this by tracking when the device is probed/released via
>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>> release_device handles the re-init of the device DMA.
>>
>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  1 +
>>   arch/s390/pci/pci.c         |  1 +
>>   drivers/iommu/s390-iommu.c  | 68 ++++++++++++++++++++++++++++---------
>>   3 files changed, 54 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 7b4cdadbc023..1295b6900e4b 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -157,6 +157,7 @@ struct zpci_dev {
>>       /* DMA stuff */
>>       unsigned long    *dma_table;
>>       spinlock_t    dma_table_lock;
>> +    spinlock_t    dma_domain_lock;
>>       int        tlb_refresh;
>>         spinlock_t    iommu_bitmap_lock;
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 73cdc5539384..61901c1be3cc 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -832,6 +832,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>>       kref_init(&zdev->kref);
>>       mutex_init(&zdev->lock);
>>       mutex_init(&zdev->kzdev_lock);
>> +    spin_lock_init(&zdev->dma_domain_lock);
>>         rc = zpci_init_iommu(zdev);
>>       if (rc)
>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>> index c898bcbbce11..513a7ebd23b3 100644
>> --- a/drivers/iommu/s390-iommu.c
>> +++ b/drivers/iommu/s390-iommu.c
>> @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>>       struct zpci_dev *zdev = to_zpci_dev(dev);
>>       struct s390_domain_device *domain_device;
>>       unsigned long flags;
>> -    int cc, rc;
>> +    int cc, rc = 0;
>>         if (!zdev)
>>           return -ENODEV;
>>   +    /* First check compatibility */
>> +    spin_lock_irqsave(&s390_domain->list_lock, flags);
>> +    /* First device defines the DMA range limits */
>> +    if (list_empty(&s390_domain->devices)) {
>> +        domain->geometry.aperture_start = zdev->start_dma;
>> +        domain->geometry.aperture_end = zdev->end_dma;
>> +        domain->geometry.force_aperture = true;
>> +    /* Allow only devices with identical DMA range limits */
>> +    } else if (domain->geometry.aperture_start != zdev->start_dma ||
>> +           domain->geometry.aperture_end != zdev->end_dma) {
>> +        rc = -EINVAL;
>> +    }
>> +    spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> +    if (rc)
>> +        return rc;
>> +
>>       domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
>>       if (!domain_device)
>>           return -ENOMEM;
>>   +    /* Leave now if the device has already been released */
>> +    spin_lock_irqsave(&zdev->dma_domain_lock, flags);
>> +    if (!dev_iommu_priv_get(dev)) {
>> +        spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
>> +        kfree(domain_device);
>> +        return 0;
>> +    }
>> +
>>       if (zdev->dma_table && !zdev->s390_domain) {
>>           cc = zpci_dma_exit_device(zdev);
>>           if (cc) {
> 
> Am I wrong? It seems to me that zpci_dma_exit_device here is called with the spin_lock locked but this function zpci_dma_exit_device calls vfree which may sleep.
> 

Oh, good point, I just enabled lockdep to verify that.

I think we could just replace this with a mutex instead, it's not a performance path.  I've been running tests successfully today with this patch modified to instead use a mutex for dma_domain_lock.

