Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441056A872
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiGGQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiGGQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:42:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F045071;
        Thu,  7 Jul 2022 09:42:28 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267GWUmv004637;
        Thu, 7 Jul 2022 16:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Xk0Ulwvvq8GOQ3Gdznv7ZbQQqPA9BsTnl+u0djv5+WY=;
 b=WXjWazxmCh082jtizJP82NgGusU2imyaafycjZieTGXplEBQZT2BA/d7B7SWj/f/fmv5
 RiOrn/KJi2JqWUqpPwZxUiOTqXu9UriPaAi3tH90D2sDveSEajQgpWeQTvyBBs+wbRHA
 rnKUUNdrRWe+Yo/Pq3MKamAV/rRfi6kgbobpo088lsB+1ZTKXoqKVn9ojzCyhMMY7AIf
 02F/hSfrgPlTGoAfLmuJaXHXAiiJOJjUBYdMDgEmp0i56JDrI53Nvh5kHtgJf6hFjyK8
 dcJZnSu/SJ0BfNHp9ix7VbuB/q1JYgyaE93jtOrh8SogREPOqJ56LHzJmqrTx+kbS1r7 lQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h633kr9rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 16:42:15 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267GZb4h004482;
        Thu, 7 Jul 2022 16:42:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3h4ud54kvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 16:42:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267GgDbq20513104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 16:42:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A16A28059;
        Thu,  7 Jul 2022 16:42:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F1C28058;
        Thu,  7 Jul 2022 16:42:10 +0000 (GMT)
Received: from [9.211.36.1] (unknown [9.211.36.1])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 16:42:10 +0000 (GMT)
Message-ID: <af04e6da-fc4f-3d41-431a-73638f413e6f@linux.ibm.com>
Date:   Thu, 7 Jul 2022 12:42:08 -0400
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
 <4c25e3ad-0eb6-5c41-48b2-7c10e745bd5d@linux.ibm.com>
 <a6317b8e-87ea-122d-c1fe-c320f030a7f3@linux.ibm.com>
 <8ad2fec1-8a51-dc35-39bb-a05a0d837ad9@arm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8ad2fec1-8a51-dc35-39bb-a05a0d837ad9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M10LNYkyvjyNMLXh8WJpMZPKRUlJN2vr
X-Proofpoint-ORIG-GUID: M10LNYkyvjyNMLXh8WJpMZPKRUlJN2vr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_13,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 10:58 AM, Robin Murphy wrote:
> On 2022-07-07 13:54, Matthew Rosato wrote:
>> On 7/7/22 8:49 AM, Matthew Rosato wrote:
>>> On 7/5/22 1:08 PM, Robin Murphy wrote:
>>>> Clean up the remaining trivial bus_set_iommu() callsites along
>>>> with the implementation. Now drivers only have to know and care
>>>> about iommu_device instances, phew!
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>
>>>> v3: Also catch Intel's cheeky open-coded assignment
>>>>
>>>
>>> ...
>>>
>>>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>>>> index c898bcbbce11..dd957145fb81 100644
>>>> --- a/drivers/iommu/s390-iommu.c
>>>> +++ b/drivers/iommu/s390-iommu.c
>>>> @@ -385,9 +385,3 @@ static const struct iommu_ops s390_iommu_ops = {
>>>>           .free        = s390_domain_free,
>>>>       }
>>>>   };
>>>> -
>>>> -static int __init s390_iommu_init(void)
>>>> -{
>>>> -    return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
>>>> -}
>>>> -subsys_initcall(s390_iommu_init);
>>>
>>> Previously s390_iommu_ops was only being set for pci_bus_type, but 
>>> with this series it will now also be set for platform_bus_type.
> 
> Ah, indeed I hadn't got as far as fully appreciating that to_zpci_dev() 
> isn't robust enough on its own. Thanks for the patch, I've pulled it in 
> and will include it in v4. Do I take it that all else works OK with this 
> fixed?
> 

Yes, with that patch included this looks OK so for s390 you can also take a

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

