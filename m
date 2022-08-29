Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4945A4B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiH2MJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiH2MIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:08:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F242923F0;
        Mon, 29 Aug 2022 04:54:06 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TAkh3l027531;
        Mon, 29 Aug 2022 11:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bSJgSRJ3VmmbkJp4VulvwZx3DOhngyMhxgioW3de0mQ=;
 b=GKCuNUfTr3whv0OCjXYDaSdhTsuY6Mpg5pmObIreLQ1+MPD42vTSlBlhddE9ZyAonWi5
 +aQqJw3+MnsbLIceJPMh4RBWUdPUdNXbJr1Q+oYv58K4jN85hXiuC+UB1laC/v+t4lFe
 /aXp4q8gRdKfXCiFa+5nSfpNdSiQ3k0gV6Bkh9oeuvwsfhHXLhN+kmWEt1RIY3aBbC5p
 z/QjWzgft+fTjtXNlxHrGzuB0gxa5+d/CpWivmwpMFin7VdWQDkyX6exCCiPYmaxfajq
 KfylQdHW0As5pQqGxuiBXQgBvj/60VKhO7kt3SJQGP/jEqUce9dfKlmz/sj0pF+wUnbE 7Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8v0k8cu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 11:03:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27TApgwr023927;
        Mon, 29 Aug 2022 11:03:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3j7aw8t79k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 11:03:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27TB3R9542271046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 11:03:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3A68A405C;
        Mon, 29 Aug 2022 11:03:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A8B5A405B;
        Mon, 29 Aug 2022 11:03:26 +0000 (GMT)
Received: from osiris (unknown [9.145.9.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Aug 2022 11:03:26 +0000 (GMT)
Date:   Mon, 29 Aug 2022 13:03:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     iommu@lists.linux.dev, linux-s390@vger.kernel.org,
        schnelle@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/s390: Fix race with release_device ops
Message-ID: <Ywyc/WxFg3zawXL5@osiris>
References: <20220826194721.250123-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826194721.250123-1-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: egKB1HyF-_Tz6sV0aCPUc9FNkyUCtzOS
X-Proofpoint-ORIG-GUID: egKB1HyF-_Tz6sV0aCPUc9FNkyUCtzOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=759 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 03:47:21PM -0400, Matthew Rosato wrote:
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
...
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
...
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

Stupid question: but how is this not racy when the spinlock is
released between doing something that depends on an empty list and
actually adding to the list later, after the lock had been released?

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

Looking at the patch and this code it is also anything but obvious
which _data_ is actually protected by the mutex. Anyway.. just some
stupid comments while briefly looking at the patch :)
