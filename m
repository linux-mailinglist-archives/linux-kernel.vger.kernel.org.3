Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B475A0EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiHYLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiHYLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:12:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25DAE857;
        Thu, 25 Aug 2022 04:12:13 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PAlhbb016632;
        Thu, 25 Aug 2022 11:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=n538U2wM0cJf+DwolmG0+fphd+7c2U2jME2cTAmu5mU=;
 b=A2z/eBTsTaFYeq0OO9inHGzYVkCA+/Qw+2xAjXfmB3UvRGivBFDTp2MwtUdFhomd2vW3
 UD5zxO0/7/5MM3l4TFOLqqvaRaurPBxF3F7MiHOMvJSWHq8KLd3ylFfTp2IwfKRyWtJE
 pCaJaor4ErJDxDmzgwz1S1mYbj5TGH8lgq5XlMro5hJkEBFqMUKDcZciMtfQq6dvtt1j
 f+2gNq7eD+QaHgd7ViWvNaoUplaon+yt+cw3vS/mx2KmLfXzzActgrOpyUI/47REPlKD
 8Ft6kV+ZOsG4RXY+URTpteWcDXxWgI1EyRMQ1ihYg6taUQR8matJvSppQnseTQE/aZZi vw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j67mt0pp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:11:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PB50Aq007361;
        Thu, 25 Aug 2022 11:11:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3j2q88vmr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:11:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PBBnEc42271030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 11:11:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06B00A404D;
        Thu, 25 Aug 2022 11:11:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35351A4040;
        Thu, 25 Aug 2022 11:11:48 +0000 (GMT)
Received: from sig-9-145-54-205.uk.ibm.com (unknown [9.145.54.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 11:11:48 +0000 (GMT)
Message-ID: <69b7b496c3658b385f2404d6e3209970b3677c08.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: Fix race with release_device ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, svens@linux.ibm.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Thu, 25 Aug 2022 13:11:47 +0200
In-Reply-To: <YwcjIPcT1b0uyyFn@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220823203059.81919-1-mjrosato@linux.ibm.com>
         <a6e42442-d9cb-0d63-bb71-da78a5669a51@linux.ibm.com>
         <04644ee5-2386-1f3d-c1a3-fc4227570cf7@linux.ibm.com>
         <YwcjIPcT1b0uyyFn@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cac7hgFlkSPbnmZdVKuRu-7ODdEIF00-
X-Proofpoint-GUID: cac7hgFlkSPbnmZdVKuRu-7ODdEIF00-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 mlxlogscore=672 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208250043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-25 at 09:22 +0200, Alexander Gordeev wrote:
> On Wed, Aug 24, 2022 at 04:25:19PM -0400, Matthew Rosato wrote:
> > > > @@ -90,15 +90,39 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
> > > >       struct zpci_dev *zdev = to_zpci_dev(dev);
> > > >       struct s390_domain_device *domain_device;
> > > >       unsigned long flags;
> > > > -    int cc, rc;
> > > > +    int cc, rc = 0;
> > > >         if (!zdev)
> > > >           return -ENODEV;
> > > >   +    /* First check compatibility */
> > > > +    spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > > +    /* First device defines the DMA range limits */
> > > > +    if (list_empty(&s390_domain->devices)) {
> > > > +        domain->geometry.aperture_start = zdev->start_dma;
> > > > +        domain->geometry.aperture_end = zdev->end_dma;
> > > > +        domain->geometry.force_aperture = true;
> > > > +    /* Allow only devices with identical DMA range limits */
> > > > +    } else if (domain->geometry.aperture_start != zdev->start_dma ||
> > > > +           domain->geometry.aperture_end != zdev->end_dma) {
> > > > +        rc = -EINVAL;
> > > > +    }
> > > > +    spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > > > +    if (rc)
> > > > +        return rc;
> > > > +
> > > >       domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
> > > >       if (!domain_device)
> > > >           return -ENOMEM;
> > > >   +    /* Leave now if the device has already been released */
> > > > +    spin_lock_irqsave(&zdev->dma_domain_lock, flags);
> > > > +    if (!dev_iommu_priv_get(dev)) {
> > > > +        spin_unlock_irqrestore(&zdev->dma_domain_lock, flags);
> > > > +        kfree(domain_device);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > >       if (zdev->dma_table && !zdev->s390_domain) {
> > > >           cc = zpci_dma_exit_device(zdev);
> > > >           if (cc) {
> > > 
> > > Am I wrong? It seems to me that zpci_dma_exit_device here is called with the spin_lock locked but this function zpci_dma_exit_device calls vfree which may sleep.
> > > 
> > 
> > Oh, good point, I just enabled lockdep to verify that.
> > 
> > I think we could just replace this with a mutex instead, it's not a performance path.  I've been running tests successfully today with this patch modified to instead use a mutex for dma_domain_lock.
> 
> But your original version uses irq-savvy spinlocks.
> Are there data that need to be protected against interrupts?
> 
> Thanks!

I think that was a carry over from my original attempt that used the
zdev->dma_domain_lock in some more places including in interrupt
context. I think these are gone now so I think Matt is right in his
version this can be a mutex.

