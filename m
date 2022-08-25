Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E565A0A13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiHYHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiHYHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:22:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056A98D14;
        Thu, 25 Aug 2022 00:22:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P6w2Ac024302;
        Thu, 25 Aug 2022 07:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=YN9sy3cnWjVNQmJSTgZu94d+HQJtS+Apq8l2IFiHvbg=;
 b=QiE7pQ2y6OkrJqpweilZmZrw6jXfSDXRhJDZb8+FYUdFNzKnAgQn6E+L/OurtIwdYdjX
 7dqEasntBf0YZ1gy7XspG4JxD9KX5goRL/cvFIJ1aRdVarl8YwjTOsw1m9ISMRu0EHNe
 RUm2WA8Xv45eqV6S70WQP880ONz6r1W23tZXXBdD+cI1CsaEVRmKBo3/4P3as39PJEzp
 Iqc677ILyXeVI22tKNRfU3oFFZa2/a6p5w6cuzAZSebZLlAWMy8+kGo+zaZHfSWtureI
 9ylftAAiOtlkuZDQmdfALawWeQk/RpWAksKOjTfu78guzZflBA99EulodxPsNl9LAD6j Gw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j649ch4t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27P7Li2r021968;
        Thu, 25 Aug 2022 07:22:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3j2pvjcf37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27P7MAoY33358088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 07:22:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83600AE04D;
        Thu, 25 Aug 2022 07:22:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE68DAE045;
        Thu, 25 Aug 2022 07:22:09 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.165.99])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Aug 2022 07:22:09 +0000 (GMT)
Date:   Thu, 25 Aug 2022 09:22:08 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, svens@linux.ibm.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Fix race with release_device ops
Message-ID: <YwcjIPcT1b0uyyFn@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220823203059.81919-1-mjrosato@linux.ibm.com>
 <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
 <04644ee5-2386-1f3d-c1a3-fc4227570cf7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04644ee5-2386-1f3d-c1a3-fc4227570cf7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wEg2yD5fVaA665QzuLZhmfaYteAk9PA3
X-Proofpoint-ORIG-GUID: wEg2yD5fVaA665QzuLZhmfaYteAk9PA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=854 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:25:19PM -0400, Matthew Rosato wrote:
> >> @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> >>       struct zpci_dev *zdev = to_zpci_dev(dev);
> >>       struct s390_domain_device *domain_device;
> >>       unsigned long flags;
> >> -    int cc, rc;
> >> +    int cc, rc = 0;
> >>         if (!zdev)
> >>           return -ENODEV;
> >>   +    /* First check compatibility */
> >> +    spin_lock_irqsave(&s390_domain->list_lock, flags);
> >> +    /* First device defines the DMA range limits */
> >> +    if (list_empty(&s390_domain->devices)) {
> >> +        domain->geometry.aperture_start = zdev->start_dma;
> >> +        domain->geometry.aperture_end = zdev->end_dma;
> >> +        domain->geometry.force_aperture = true;
> >> +    /* Allow only devices with identical DMA range limits */
> >> +    } else if (domain->geometry.aperture_start != zdev->start_dma ||
> >> +           domain->geometry.aperture_end != zdev->end_dma) {
> >> +        rc = -EINVAL;
> >> +    }
> >> +    spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> >> +    if (rc)
> >> +        return rc;
> >> +
> >>       domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
> >>       if (!domain_device)
> >>           return -ENOMEM;
> >>   +    /* Leave now if the device has already been released */
> >> +    spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> >> +    if (!dev_iommu_priv_get(dev)) {
> >> +        spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
> >> +        kfree(domain_device);
> >> +        return 0;
> >> +    }
> >> +
> >>       if (zdev->dma_table && !zdev->s390_domain) {
> >>           cc = zpci_dma_exit_device(zdev);
> >>           if (cc) {
> > 
> > Am I wrong? It seems to me that zpci_dma_exit_device here is called with the spin_lock locked but this function zpci_dma_exit_device calls vfree which may sleep.
> > 
> 
> Oh, good point, I just enabled lockdep to verify that.
> 
> I think we could just replace this with a mutex instead, it's not a performance path.  I've been running tests successfully today with this patch modified to instead use a mutex for dma_domain_lock.

But your original version uses irq-savvy spinlocks.
Are there data that need to be protected against interrupts?

Thanks!
