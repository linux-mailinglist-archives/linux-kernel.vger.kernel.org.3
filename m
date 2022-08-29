Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7185A4E52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiH2NjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2NjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49119109B;
        Mon, 29 Aug 2022 06:39:14 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TDWgq4025417;
        Mon, 29 Aug 2022 13:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XuvId1UDU+8g7JvPfJTa+H726uIokQD9Vp40e81EFwA=;
 b=snnboG1yEIcnmMuJk7BsNaMkpo4c/eW5m8olslegB1hiMCmjTMaVNcavyj4vhhzD5CAI
 uXcoy1T2uKh+bgeBfPyjwbPjHpXM+jaaTEX2Q7Rd/SNTlaGuJXDbpZS6wM2BTAl+xZHS
 fEPS51ygJwPJNHHfkBoBmxP669O1akPx8vodDnJb5bIwQO1G2C1D6bG841/bkcIcjvPq
 8grZoQbpPCXqTxhsl2h5lCHrNTknI5FF/7XFtQ7s655IKxvU6zpzfxei7QVmdLtRS7bf
 BhiHgNe+o7TYDOyFGhANm2znahvTF6zc/z1ednMRkt6BaaccPuXa2u8TrjxNPxBXVBov ew== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8xe38fcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 13:38:54 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27TDZCDm019079;
        Mon, 29 Aug 2022 13:38:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3j7aw9gq8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 13:38:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27TDcF4B31326660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 13:38:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 675802805A;
        Mon, 29 Aug 2022 13:38:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 317B928059;
        Mon, 29 Aug 2022 13:38:12 +0000 (GMT)
Received: from [9.211.43.66] (unknown [9.211.43.66])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 13:38:12 +0000 (GMT)
Message-ID: <e64025a7-c066-8b6e-34aa-d0cf204aca89@linux.ibm.com>
Date:   Mon, 29 Aug 2022 09:38:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     iommu@lists.linux.dev, linux-s390@vger.kernel.org,
        schnelle@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220826194721.250123-1-mjrosato@linux.ibm.com>
 <Ywyc/WxFg3zawXL5@osiris>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <Ywyc/WxFg3zawXL5@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0XoP2BntefoejZitlG_4L79zZcJRxiIv
X-Proofpoint-GUID: 0XoP2BntefoejZitlG_4L79zZcJRxiIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 7:03 AM, Heiko Carstens wrote:
> On Fri, Aug 26, 2022 at 03:47:21PM -0400, Matthew Rosato wrote:
>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>> domains and the DMA API handling.  However, this commit does not
>> sufficiently handle the case where the device is released via a call
>> to the release_device op as it may occur at the same time as an opposing
>> attach_dev or detach_dev since the group mutex is not held over
>> release_device.  This was observed if the device is deconfigured during a
>> small window during vfio-pci initialization and can result in WARNs and
>> potential kernel panics.
>>
>> Handle this by tracking when the device is probed/released via
>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>> release_device handles the re-init of the device DMA.
>>
>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ...
>> +	/* First check compatibility */
>> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>> +	/* First device defines the DMA range limits */
>> +	if (list_empty(&s390_domain->devices)) {
>> +		domain->geometry.aperture_start = zdev->start_dma;
>> +		domain->geometry.aperture_end = zdev->end_dma;
>> +		domain->geometry.force_aperture = true;
>> +	/* Allow only devices with identical DMA range limits */
>> +	} else if (domain->geometry.aperture_start != zdev->start_dma ||
>> +		   domain->geometry.aperture_end != zdev->end_dma) {
>> +		rc = -EINVAL;
>> +	}
>> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> ...
>>  	spin_lock_irqsave(&s390_domain->list_lock, flags);
>> -	/* First device defines the DMA range limits */
>> -	if (list_empty(&s390_domain->devices)) {
>> -		domain->geometry.aperture_start = zdev->start_dma;
>> -		domain->geometry.aperture_end = zdev->end_dma;
>> -		domain->geometry.force_aperture = true;
>> -	/* Allow only devices with identical DMA range limits */
>> -	} else if (domain->geometry.aperture_start != zdev->start_dma ||
>> -		   domain->geometry.aperture_end != zdev->end_dma) {
>> -		rc = -EINVAL;
>> -		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> -		goto out_restore;
>> -	}
>>  	domain_device->zdev = zdev;
>> -	zdev->s390_domain = s390_domain;
>>  	list_add(&domain_device->list, &s390_domain->devices);
>>  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> 
> Stupid question: but how is this not racy when the spinlock is
> released between doing something that depends on an empty list and
> actually adding to the list later, after the lock had been released?
> 

Oh, that's a good point...  This was re-arranged to simplify error backout cases, but theoretically yeah there could be 2 competing threads with different apertures that would both list_add here when really first-in should win and the 2nd should be rejected.  That's no good.  In practice this wouldn't happen today because of the device<->domain relationship we have in s390, but we still need to avoid introducing such an issue.

We should probably just go back to doing the aperture check at the later point at the same time we list_add and live with the more complicated backout path -- I'll have a closer look but either way there will be a v3 that changes this, thanks.

>> +		mutex_lock(&zdev->dma_domain_lock);
>> +		dev_iommu_priv_set(dev, NULL);
>> +		mutex_unlock(&zdev->dma_domain_lock);
>> +		/* Make sure this device is removed from the domain list */
>>  		domain = iommu_get_domain_for_dev(dev);
>>  		if (domain)
>>  			s390_iommu_detach_device(domain, dev);
>> +		/* Now ensure DMA is initialized from here */
>> +		mutex_lock(&zdev->dma_domain_lock);
>> +		if (zdev->s390_domain) {
>> +			zdev->s390_domain = NULL;
>> +			zpci_unregister_ioat(zdev, 0);
>> +			zpci_dma_init_device(zdev);
>> +		}
>> +		mutex_unlock(&zdev->dma_domain_lock);
> 
> Looking at the patch and this code it is also anything but obvious
> which _data_ is actually protected by the mutex. Anyway.. just some
> stupid comments while briefly looking at the patch :)

Fair; largely, it's purpose is to protect the setting of zdev->s390_domain (which indicates e.g. whether s390-iommu or s390 pci-dma is being used to access the device).  However we also use it to protect the updating/checking of the priv value (e.g. probe state of the device) as this is relevant to what change we make to s390_domain during an attach/detach and we want to make that decision based on a consistent 'probed' state.  Since there will already be a v3 I will try to add a comment to its definition in pci.h and/or maybe here in release_device.
