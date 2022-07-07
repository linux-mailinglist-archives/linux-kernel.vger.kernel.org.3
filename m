Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F356A250
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiGGMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiGGMuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:50:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CE2A412;
        Thu,  7 Jul 2022 05:50:31 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267B85tg016848;
        Thu, 7 Jul 2022 12:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PlMypm8VbcP08LGJlujs3XGqbcicJ/9URreKUsBksuI=;
 b=q/Pszamyh3B5HDb9S/B7TcIn5gcvMG6Q1eYtJSfwrReBDlgrkstSNuTeN1MUEwXmME+s
 pfkYYGIhTyJJX6TAb5I+hjyfMT+mqOAnNNgJ+0LfF1nO8oZEXjldquwhrayI+Rl9Hhw1
 nnntLET/7wyvA4UGWe/goLJK2PcL+bjDmnnrgnm5SEe6jCsmHowEcpFgKl+Br4g4gE9T
 Oiscp7GxPjBHyc9F2srcaLlYGka8TU86wEmmlWmIO+YAsm8GTqlJ1ea6Ka08rbBECf6D
 QNPRfrvKvM6YvuAy0/YcclsaSz9cvh0bOcxJWKKz3kQ794MI/+kQgaraA6DcouppSxvB HQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5w5acpve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 12:49:59 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267CZNbX024918;
        Thu, 7 Jul 2022 12:49:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3h4ud1u9pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 12:49:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Cnvxf33292630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 12:49:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC4128059;
        Thu,  7 Jul 2022 12:49:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E73FF2805A;
        Thu,  7 Jul 2022 12:49:54 +0000 (GMT)
Received: from [9.211.36.1] (unknown [9.211.36.1])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 12:49:54 +0000 (GMT)
Message-ID: <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
Date:   Thu, 7 Jul 2022 08:49:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 15/15] iommu: Clean up bus_set_iommu()
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p2HXZFwf2hk_lYIE5Uci5yo70h5FYbeP
X-Proofpoint-GUID: p2HXZFwf2hk_lYIE5Uci5yo70h5FYbeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 1:08 PM, Robin Murphy wrote:
> Clean up the remaining trivial bus_set_iommu() callsites along
> with the implementation. Now drivers only have to know and care
> about iommu_device instances, phew!
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: Also catch Intel's cheeky open-coded assignment
> 

...

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..dd957145fb81 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -385,9 +385,3 @@ static const struct iommu_ops s390_iommu_ops = {
>   		.free		= s390_domain_free,
>   	}
>   };
> -
> -static int __init s390_iommu_init(void)
> -{
> -	return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
> -}
> -subsys_initcall(s390_iommu_init);

Previously s390_iommu_ops was only being set for pci_bus_type, but with 
this series it will now also be set for platform_bus_type.

To tolerate that, this series needs a change along the lines of:


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

  }  return &zdev->iommu_dev; 

  }
