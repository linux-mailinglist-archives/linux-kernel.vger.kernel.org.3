Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B957314A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiGMIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGMIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:39:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514FD7A4B;
        Wed, 13 Jul 2022 01:39:57 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D8aowm006521;
        Wed, 13 Jul 2022 08:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TizzkofkPLYM5cfAMGlOfFOMezl4jD6xmSbVX7fi9YU=;
 b=YHeQ7VoFeaMtu13RvDV+1/JKhSTQcFXFQzFJYrhgQGlIUzoBR43zkfvzO5VOcyhktNFx
 ZfEcKxaI8CuEmuSxTDPGUwnn1ypgv+ax12Tn6TUGW9zVCUU3MeJmCYcaBIyR/2C4fp/F
 pEc6Z1cmxMH1s4E6nvdV5ZSnJa/bZo7mtxq+lWKWTFNIt5lcNWWIyI3emmRM0R1Ur50w
 JSSimNl1/6s/ISUbPJwmnk0x1sV5v2nv/Mbjiue4JSKF/3svSgFllfWHhPKh83UdbmkR
 2hmyMCJvex+PAn5elrAC0bfJ/uST0l4BVeElPhE7I9uvcMtLgEWKfkAfBJC+rkurs8PJ 7Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9t2qh01t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:39:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26D8LZsV012148;
        Wed, 13 Jul 2022 08:39:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3h71a8v1hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:39:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26D8dlgU17367388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 08:39:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D83FC4203F;
        Wed, 13 Jul 2022 08:39:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD5942045;
        Wed, 13 Jul 2022 08:39:47 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 08:39:47 +0000 (GMT)
Message-ID: <02b6537d-97e6-c27b-7621-c5b116995a00@linux.ibm.com>
Date:   Wed, 13 Jul 2022 10:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] s390/uvdevice: autoload module based on CPU facility
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-4-seiden@linux.ibm.com>
 <20220712184924.0d80c474@p-imbrenda>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220712184924.0d80c474@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bm1QkXzouI91UwL-R4sSteIHhti0ChGY
X-Proofpoint-ORIG-GUID: Bm1QkXzouI91UwL-R4sSteIHhti0ChGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 18:49, Claudio Imbrenda wrote:
> On Tue, 12 Jul 2022 12:52:20 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
>> Make sure the uvdevice driver will be automatically loaded when
>> facility 158 is available.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/cpufeature.h | 1 +
>>   arch/s390/kernel/cpufeature.c      | 1 +
>>   drivers/s390/char/uvdevice.c       | 5 ++---
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
>> index aa8081dad411..4b17f876ab54 100644
>> --- a/arch/s390/include/asm/cpufeature.h
>> +++ b/arch/s390/include/asm/cpufeature.h
>> @@ -33,6 +33,7 @@ enum {
>>   	S390_CPU_FEATURE_NNPA,
>>   	S390_CPU_FEATURE_PCI_MIO,
>>   	S390_CPU_FEATURE_SIE,
>> +	S390_CPU_FEATURE_UV,
>>   	MAX_CPU_FEATURES
>>   };
>>   
>> diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
>> index e70b29804db4..0b854d37edcb 100644
>> --- a/arch/s390/kernel/cpufeature.c
>> +++ b/arch/s390/kernel/cpufeature.c
>> @@ -42,6 +42,7 @@ static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
>>   	[S390_CPU_FEATURE_NNPA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_NNPA},
>>   	[S390_CPU_FEATURE_PCI_MIO]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_PCI_MIO},
>>   	[S390_CPU_FEATURE_SIE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SIE},
>> +	[S390_CPU_FEATURE_UV]		= {.type = TYPE_FACILITY, .num = 158},
>>   };
>>   
>>   /*
>> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
>> index 66505d7166a6..1d40457c7b10 100644
>> --- a/drivers/s390/char/uvdevice.c
>> +++ b/drivers/s390/char/uvdevice.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/stddef.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/slab.h>
>> +#include <linux/cpufeature.h>
>>   
>>   #include <asm/uvdevice.h>
>>   #include <asm/uv.h>
>> @@ -244,12 +245,10 @@ static void __exit uvio_dev_exit(void)
>>   
>>   static int __init uvio_dev_init(void)
>>   {
>> -	if (!test_facility(158))
>> -		return -ENXIO;
>>   	return misc_register(&uvio_dev_miscdev);
>>   }
>>   
>> -module_init(uvio_dev_init);
>> +module_cpu_feature_match(S390_CPU_FEATURE_UV, uvio_dev_init);
> 
> does this still prevent manual loading when the feature is not present?
yes.

Have a look at the macro definition at 'include/linux/cpufeature.h':

Use module_cpu_feature_match(feature, module_init_function) to 

declare that 

[snip]
b) the module must not be loaded if CPU feature 'feature' is not present 

    (not even by manual insmod).

The test 'facility(158)' just moved to cpu_have_feature() in 
'/arch/s390/kernel/cpufeature.c'.
> 
>>   module_exit(uvio_dev_exit);
>>   
>>   MODULE_AUTHOR("IBM Corporation");
> 
