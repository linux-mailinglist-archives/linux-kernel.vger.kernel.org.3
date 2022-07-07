Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588456A2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiGGM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiGGMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:55:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5F2D1EA;
        Thu,  7 Jul 2022 05:55:00 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267BE1Vw029078;
        Thu, 7 Jul 2022 12:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e+6nm5Ds4GELLXBnzsr/JRGB0864mlxyrQfc85EoIRc=;
 b=aIECZrQI+DB6F31FIq3nIXdf/THBdz85H2+oWZJezjIEunx1vhzQEDuOYB2wCs3UaUcO
 yOgOpcDvCBGxtVZif3xVp/D8Oqhtoj7FJ8K901lkdr3s+XfFY+f99XIlco3OJgnbpnRI
 C1D9Qqv0Q54eC/BtLZq8rX4BBwVCratIZIWidvu2z0+mZzoO4FcdF9FucnB6P6mYhgv8
 uQrdkzBi1zrCsCjDaV60tVaPjfraLcwIspRwzW9xY9+2+CYPb4aNLm6RMAZJIfKWCr2W
 uA1+PmKk2Gwd9VGA9OX3jQGO2r3SdHBTcaqprfYbSqZfwvHuznD4Pr1C0O9ggi78ISfs Sg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5xe7jsfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 12:54:46 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267Codfn003924;
        Thu, 7 Jul 2022 12:54:46 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3h4uqy5yn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 12:54:46 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Csi8534341138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 12:54:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D63E228064;
        Thu,  7 Jul 2022 12:54:44 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40ED128066;
        Thu,  7 Jul 2022 12:54:42 +0000 (GMT)
Received: from [9.211.36.1] (unknown [9.211.36.1])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 12:54:41 +0000 (GMT)
Message-ID: <a6317b8e-87ea-122d-c1fe-c320f030a7f3@linux.ibm.com>
Date:   Thu, 7 Jul 2022 08:54:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 15/15] iommu: Clean up bus_set_iommu()
Content-Language: en-US
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
 <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
In-Reply-To: <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6n0HHPssgA4yMkE6V_M0qX_01p8NmEIU
X-Proofpoint-ORIG-GUID: 6n0HHPssgA4yMkE6V_M0qX_01p8NmEIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 8:49 AM, Matthew Rosato wrote:
> On 7/5/22 1:08 PM, Robin Murphy wrote:
>> Clean up the remaining trivial bus_set_iommu() callsites along
>> with the implementation. Now drivers only have to know and care
>> about iommu_device instances, phew!
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: Also catch Intel's cheeky open-coded assignment
>>
> 
> ...
> 
>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>> index c898bcbbce11..dd957145fb81 100644
>> --- a/drivers/iommu/s390-iommu.c
>> +++ b/drivers/iommu/s390-iommu.c
>> @@ -385,9 +385,3 @@ static const struct iommu_ops s390_iommu_ops = {
>>           .free        = s390_domain_free,
>>       }
>>   };
>> -
>> -static int __init s390_iommu_init(void)
>> -{
>> -    return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
>> -}
>> -subsys_initcall(s390_iommu_init);
> 
> Previously s390_iommu_ops was only being set for pci_bus_type, but with 
> this series it will now also be set for platform_bus_type.
> 
> To tolerate that, this series needs a change along the lines of:
> 

...  Sorry, let's try that again without a mangled diff:

From: Matthew Rosato <mjrosato@linux.ibm.com> 

Date: Thu, 7 Jul 2022 08:45:44 -0400 

Subject: [PATCH] iommu/s390: fail probe for non-pci device 

 

s390-iommu only supports pci_bus_type today 

 

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com> 

--- 

  drivers/iommu/s390-iommu.c | 7 ++++++- 

  1 file changed, 6 insertions(+), 1 deletion(-) 

 

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c 

index dd957145fb81..762f892b4ec3 100644 

--- a/drivers/iommu/s390-iommu.c 

+++ b/drivers/iommu/s390-iommu.c 

@@ -185,7 +185,12 @@ static void s390_iommu_detach_device(struct 
iommu_domain *domain,
 

  static struct iommu_device *s390_iommu_probe_device(struct device 
*dev)
  { 

-       struct zpci_dev *zdev = to_zpci_dev(dev); 

+       struct zpci_dev *zdev; 

+ 

+       if (!dev_is_pci(dev)) 

+               return ERR_PTR(-ENODEV); 

+ 

+       zdev = to_zpci_dev(dev); 

 

         return &zdev->iommu_dev; 

  }

