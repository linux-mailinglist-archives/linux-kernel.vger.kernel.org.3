Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18E5A934E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiIAJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIAJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:38:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62EEAF487;
        Thu,  1 Sep 2022 02:38:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819MfEe014660;
        Thu, 1 Sep 2022 09:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vr+oN+0mzOLCldfGQK+zqMbMPm/uw1L7uTTyZtzZJqY=;
 b=ryLniEjY6M/s01Qxf1TO2XOtzzDTTWMqvmkTUHVW7YTdd1us50MPue7Pa2iUfAqClOuk
 NaJ+4PJlhu6+2KRofjPrw6BGCsQR9/crjjbuFATAkfJSffe2Z1S9QEBWu5mqJtV/Ty+P
 O3HIzo0XfyWZXb0evHAIplv6ApeHgpSuTdlsBJ/BIFiPxuuGk3vhslC0ePErvH/JyJ2f
 dwBiCZHsnQeywEzXFsFsHCLTFvQFmeZ+LcEiCtyMGCUPEYpr3YZwO+L75VuIOOOfTqX9
 XDjW8F8jMJgmSaa1wZaDyRwnc2CoD3vVarFUP30IrbV/HhSNvBqqkYzJL9TeEoQI5VWT Pw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jat26gfyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:38:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2819a3dY024832;
        Thu, 1 Sep 2022 09:38:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3j7aw8xhm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:38:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2819bxaR39715308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 09:37:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F060A42042;
        Thu,  1 Sep 2022 09:37:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ACA142045;
        Thu,  1 Sep 2022 09:37:58 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 09:37:58 +0000 (GMT)
Message-ID: <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 11:37:58 +0200
In-Reply-To: <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
         <20220831201236.77595-2-mjrosato@linux.ibm.com>
         <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a2V74qihax44fYjtJDFpFs83uiKv0LZY
X-Proofpoint-ORIG-GUID: a2V74qihax44fYjtJDFpFs83uiKv0LZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209010042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-01 at 09:56 +0200, Pierre Morel wrote:
> 
> On 8/31/22 22:12, Matthew Rosato wrote:
> > With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> > domains and the DMA API handling.  However, this commit does not
> > sufficiently handle the case where the device is released via a call
> > to the release_device op as it may occur at the same time as an opposing
> > attach_dev or detach_dev since the group mutex is not held over
> > release_device.  This was observed if the device is deconfigured during a
> > small window during vfio-pci initialization and can result in WARNs and
> > potential kernel panics.
> > 
> > Handle this by tracking when the device is probed/released via
> > dev_iommu_priv_set/get().  Ensure that once the device is released only
> > release_device handles the re-init of the device DMA.
> > 
> > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/pci.h |  1 +
> >   arch/s390/pci/pci.c         |  1 +
> >   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
> >   3 files changed, 38 insertions(+), 3 deletions(-)
> > 
> > 
---8<---
> >   
> > @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
> > 
> 
---8<---
> > +		/* Make sure this device is removed from the domain list */
> >   		domain = iommu_get_domain_for_dev(dev);
> >   		if (domain)
> >   			s390_iommu_detach_device(domain, dev);
> > +		/* Now ensure DMA is initialized from here */
> > +		mutex_lock(&zdev->dma_domain_lock);
> > +		if (zdev->s390_domain) {
> > +			zdev->s390_domain = NULL;
> > +			zpci_unregister_ioat(zdev, 0);
> > +			zpci_dma_init_device(zdev);
> 
> Sorry if it is a stupid question, but two things looks strange to me:
> 
> - having DMA initialized just after having unregistered the IOAT
> Is that really all we need to unregister before calling dma_init_device?
> 
> - having DMA initialized inside the release_device callback:
> Why isn't it done in the device_probe ?

As I understand it iommu_release_device() which calls this code is only
used when a device goes away. So, I think you're right in that it makes
little sense to re-initialize DMA at this point, it's going to be torn
down immediately after anyway. I do wonder if it would be an acceptably
small change to just set zdev->s390_domain = NULL here and leave DMA
uninitialized while making zpci_dma_exit_device() deal with that e.g.
by doing nothing if zdev->dma_table is NULL but I'm not sure.

Either way I fear this mess really is just a symptom of our current
design oddity of driving the same IOMMU hardware through both our DMA
API implementation (arch/s390/pci_dma.c) and the IOMMU driver
(driver/iommu/s390-iommu.c) and trying to hand off between them
smoothly where common code instead just layers one atop the other when
using an IOMMU at all.

I think the correct medium term solution is to use the common DMA API
implementation (drivers/iommu/dma-iommu.c) like everyone else. But that
isn't the minimal fix we need now. 

I do have a working prototype of using the common implementation but
the big problem that I'm still searching a solution for is its
performance with a virtualized IOMMU where IOTLB flushes (RPCIT on
s390) are used for shadowing and are expensive and serialized. The
optimization we used so far for unmap, only doing one global IOTLB
flush once we run out of IOVA space, is just too much better in that
scenario to just ignore. As one data point, on an NVMe I get about
_twice_ the IOPS when using our existing scheme compared to strict
mode. Which makes sense as IOTLB flushes are known as the bottleneck
and optimizing unmap like that reduces them by almost half. Queued
flushing is still much worse likely due to serialization of the
shadowing, though again it works great on LPAR. To make sure it's not
due to some bug in the IOMMU driver I even tried converting our
existing DMA driver to layer on top of the IOMMU driver with the same
result.


