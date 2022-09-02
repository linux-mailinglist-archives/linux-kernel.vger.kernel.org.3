Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9635AA914
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiIBHuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiIBHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA219C13;
        Fri,  2 Sep 2022 00:50:06 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2827NTNa011108;
        Fri, 2 Sep 2022 07:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SqqHuYXP03vxJlXwvq1vxFZfU0Izyq/Wz+bacwTS40Q=;
 b=qeN5Jqg18jGfa2z0uF/+zNQLAQMlTN0QbAEluod4HiocBX4dy+/A57jdy1WSER2l3S4J
 2gtkEav95IPczrlfpe/JZ5iOPaYv0nGeLo2ZjlilvF3lI4Wt0WUQjXEjswldx58o9QEw
 J8NX5r03hPW5QuaDAJT6JLAIOq8ZZcgrmriE5GW3AhmpNULF+jIvBx4PR81L4Kc4jf/9
 El4kEc4eO6pvM9EzgEFdAsCx3bpT4rrAQedQy1p/KwaNTkp52TDnm4Je/cj3jSdb2afh
 eUZd0za3OmwtQFYaaa1UCaHgP1/sfZi/HMFsfGfsBPDNlkCR9O69XuChWjClS+Ufx+/g bg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbddbgrs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 07:49:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2827ZpIM031914;
        Fri, 2 Sep 2022 07:49:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3j7ahj7v7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 07:49:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2827nmCo37224800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 07:49:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33CA942041;
        Fri,  2 Sep 2022 07:49:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1724203F;
        Fri,  2 Sep 2022 07:49:47 +0000 (GMT)
Received: from sig-9-145-10-94.uk.ibm.com (unknown [9.145.10.94])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 07:49:47 +0000 (GMT)
Message-ID: <aa4ce332b6e280ec741064935fdd3e6fbabd8dbe.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Fri, 02 Sep 2022 09:49:45 +0200
In-Reply-To: <6be7b0ff-63d4-0352-a7de-e66a93411c2b@linux.ibm.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
         <20220831201236.77595-2-mjrosato@linux.ibm.com>
         <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
         <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
         <6be7b0ff-63d4-0352-a7de-e66a93411c2b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UxnGRVFgp2eSAYyhQf-gbdjf2QB7Kb79
X-Proofpoint-ORIG-GUID: UxnGRVFgp2eSAYyhQf-gbdjf2QB7Kb79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-01 at 16:28 -0400, Matthew Rosato wrote:
> > 


> On 9/1/22 5:37 AM, Niklas Schnelle wrote:
> > On Thu, 2022-09-01 at 09:56 +0200, Pierre Morel wrote:
> > > On 8/31/22 22:12, Matthew Rosato wrote:
> > > > With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> > > > calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> > > > domains and the DMA API handling.  However, this commit does not
> > > > sufficiently handle the case where the device is released via a call
> > > > to the release_device op as it may occur at the same time as an opposing
> > > > attach_dev or detach_dev since the group mutex is not held over
> > > > release_device.  This was observed if the device is deconfigured during a
> > > > small window during vfio-pci initialization and can result in WARNs and
> > > > potential kernel panics.
> > > > 
> > > > Handle this by tracking when the device is probed/released via
> > > > dev_iommu_priv_set/get().  Ensure that once the device is released only
> > > > release_device handles the re-init of the device DMA.
> > > > 
> > > > Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
> > > > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > > ---
> > > >   arch/s390/include/asm/pci.h |  1 +
> > > >   arch/s390/pci/pci.c         |  1 +
> > > >   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
> > > >   3 files changed, 38 insertions(+), 3 deletions(-)
> > > > 
> > > > 
> > ---8<---
> > > >   
> > > > @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
> > > > 
> > ---8<---
> > > > +		/* Make sure this device is removed from the domain list */
> > > >   		domain = iommu_get_domain_for_dev(dev);
> > > >   		if (domain)
> > > >   			s390_iommu_detach_device(domain, dev);
> > > > +		/* Now ensure DMA is initialized from here */
> > > > +		mutex_lock(&zdev->dma_domain_lock);
> > > > +		if (zdev->s390_domain) {
> > > > +			zdev->s390_domain = NULL;
> > > > +			zpci_unregister_ioat(zdev, 0);
> > > > +			zpci_dma_init_device(zdev);
> > > 
> > > Sorry if it is a stupid question, but two things looks strange to me:
> > > 
> > > - having DMA initialized just after having unregistered the IOAT
> > > Is that really all we need to unregister before calling dma_init_device?
> 
> This is also how s390-iommu has been handling detach_dev (and still does)
> 
> > > - having DMA initialized inside the release_device callback:
> > > Why isn't it done in the device_probe ?
> > 
> > As I understand it iommu_release_device() which calls this code is only
> > used when a device goes away. So, I think you're right in that it makes
> > little sense to re-initialize DMA at this point, it's going to be torn
> > down immediately after anyway. I do wonder if it would be an acceptably
> > small change to just set zdev->s390_domain = NULL here and leave DMA
> > uninitialized while making zpci_dma_exit_device() deal with that e.g.
> > by doing nothing if zdev->dma_table is NULL but I'm not sure.
> 
> Right -- since it's a fix, I was trying to keep the changes minimal and this behavior (re-init DMA even on release_device) was existing, it was just always done within s390_iommu_detach_device before.
> 
> If you want, I could experiment with setting zdev->dma_table = NULL on the release path only (and checking it in zpci_dma_exit_device())
> 

Your current approach is fine with me. After all this oddity of
detaching on release and initializing DMA is existing behavior.


