Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD35AA0E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiIAU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIAU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E449D665;
        Thu,  1 Sep 2022 13:29:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281KPq6e031018;
        Thu, 1 Sep 2022 20:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MaoUKT/PmWS2nrfEZabmkbBY3WUaGFyrBOhbFKksVaI=;
 b=Kj/FxiY4ec5P8sG5nOeuzIWvfEQL7DRuIUaK9/iq2AbyRB6+ZiZcgL/SQxdTHY+mfJEa
 JuH1/6zCGcAt7e0O0uup0MRn1USoKug15Y/OlRh0SQsiJST5TMfFDCy4qSzsz0NVBG9m
 W1DTDoErJy5fJjAwX5Wkxe6GfaxI7IBALpjGODsY9/b+eYglznDEilkmG2+0CPkLKd9J
 0dnRC4K/4Fx4HGvHUBglbcj5h2e8Z0dWzRKdQrH5u1SwcrUTWxQIyjIbGtIHb8dXKW5H
 1e+DrwOfLWo+looWpgtjJKs7GtXX8nl8Yq3O+8jy5YFDz1nfuL8O6TXiIz7qZ66z8tAs iw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jb3rk81vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 20:29:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 281K6H2a001959;
        Thu, 1 Sep 2022 20:29:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3j7awbcg6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 20:29:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 281KT9DQ9437912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 20:29:09 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 190356E054;
        Thu,  1 Sep 2022 20:29:09 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFBC6E070;
        Thu,  1 Sep 2022 20:29:07 +0000 (GMT)
Received: from [9.160.86.252] (unknown [9.160.86.252])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 20:29:07 +0000 (GMT)
Message-ID: <6be7b0ff-63d4-0352-a7de-e66a93411c2b@linux.ibm.com>
Date:   Thu, 1 Sep 2022 16:28:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3G1ovyeNmRMDx_iHQNld8e02hC9irtkm
X-Proofpoint-GUID: 3G1ovyeNmRMDx_iHQNld8e02hC9irtkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 5:37 AM, Niklas Schnelle wrote:
> On Thu, 2022-09-01 at 09:56 +0200, Pierre Morel wrote:
>>
>> On 8/31/22 22:12, Matthew Rosato wrote:
>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>> domains and the DMA API handling.  However, this commit does not
>>> sufficiently handle the case where the device is released via a call
>>> to the release_device op as it may occur at the same time as an opposing
>>> attach_dev or detach_dev since the group mutex is not held over
>>> release_device.  This was observed if the device is deconfigured during a
>>> small window during vfio-pci initialization and can result in WARNs and
>>> potential kernel panics.
>>>
>>> Handle this by tracking when the device is probed/released via
>>> dev_iommu_priv_set/get().  Ensure that once the device is released only
>>> release_device handles the re-init of the device DMA.
>>>
>>> Fixes: fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev calls")
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> ---
>>>   arch/s390/include/asm/pci.h |  1 +
>>>   arch/s390/pci/pci.c         |  1 +
>>>   drivers/iommu/s390-iommu.c  | 39 ++++++++++++++++++++++++++++++++++---
>>>   3 files changed, 38 insertions(+), 3 deletions(-)
>>>
>>>
> ---8<---
>>>   
>>> @@ -206,10 +221,28 @@ static void s390_iommu_release_device(struct device *dev)
>>>
>>
> ---8<---
>>> +		/* Make sure this device is removed from the domain list */
>>>   		domain = iommu_get_domain_for_dev(dev);
>>>   		if (domain)
>>>   			s390_iommu_detach_device(domain, dev);
>>> +		/* Now ensure DMA is initialized from here */
>>> +		mutex_lock(&zdev->dma_domain_lock);
>>> +		if (zdev->s390_domain) {
>>> +			zdev->s390_domain = NULL;
>>> +			zpci_unregister_ioat(zdev, 0);
>>> +			zpci_dma_init_device(zdev);
>>
>> Sorry if it is a stupid question, but two things looks strange to me:
>>
>> - having DMA initialized just after having unregistered the IOAT
>> Is that really all we need to unregister before calling dma_init_device?

This is also how s390-iommu has been handling detach_dev (and still does)

>>
>> - having DMA initialized inside the release_device callback:
>> Why isn't it done in the device_probe ?
> 
> As I understand it iommu_release_device() which calls this code is only
> used when a device goes away. So, I think you're right in that it makes
> little sense to re-initialize DMA at this point, it's going to be torn
> down immediately after anyway. I do wonder if it would be an acceptably
> small change to just set zdev->s390_domain = NULL here and leave DMA
> uninitialized while making zpci_dma_exit_device() deal with that e.g.
> by doing nothing if zdev->dma_table is NULL but I'm not sure.

Right -- since it's a fix, I was trying to keep the changes minimal and this behavior (re-init DMA even on release_device) was existing, it was just always done within s390_iommu_detach_device before.

If you want, I could experiment with setting zdev->dma_table = NULL on the release path only (and checking it in zpci_dma_exit_device())

> 
> Either way I fear this mess really is just a symptom of our current
> design oddity of driving the same IOMMU hardware through both our DMA
> API implementation (arch/s390/pci_dma.c) and the IOMMU driver
> (driver/iommu/s390-iommu.c) and trying to hand off between them
> smoothly where common code instead just layers one atop the other when
> using an IOMMU at all.
> 
> I think the correct medium term solution is to use the common DMA API
> implementation (drivers/iommu/dma-iommu.c) like everyone else. But that
> isn't the minimal fix we need now. 

Agree

> 
> I do have a working prototype of using the common implementation but
> the big problem that I'm still searching a solution for is its
> performance with a virtualized IOMMU where IOTLB flushes (RPCIT on
> s390) are used for shadowing and are expensive and serialized. The
> optimization we used so far for unmap, only doing one global IOTLB
> flush once we run out of IOVA space, is just too much better in that
> scenario to just ignore. As one data point, on an NVMe I get about
> _twice_ the IOPS when using our existing scheme compared to strict
> mode. Which makes sense as IOTLB flushes are known as the bottleneck
> and optimizing unmap like that reduces them by almost half. Queued
> flushing is still much worse likely due to serialization of the
> shadowing, though again it works great on LPAR. To make sure it's not
> due to some bug in the IOMMU driver I even tried converting our
> existing DMA driver to layer on top of the IOMMU driver with the same
> result.
> 
> 

