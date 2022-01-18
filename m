Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C54929EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiARPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:53:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346021AbiARPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:53:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF5mcd023311;
        Tue, 18 Jan 2022 15:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pUIbwo6CaEeG4mexn1GuonJucf6MenQngOUNfl9jZWE=;
 b=kFsbppA4FaC5DL5CSyIcpp+u4eU6+CBOMlwzpTomgel21Cgqe1Gw3AwAJyG09+ajriWA
 Wt1IKXBKGqi3092NCYcaNg1uFFgasrJr1zxi194+CZGQ0lBVQiXVQluk7qhi+iWj4Qr3
 1SUHyHlLocoEV63QX4xfNDIA2RoJZ9Z3WldxoR2Zt4zFIe0EHRR4b2cma/aHoiouG3Qp
 pTj5jfmO7xe+kz6WGjOWbbbJMcW/WdwPdFkxKPQxx/fn3d+4HHZrdNUlDFcydC6gI/Xl
 1Dvv2/AKyW8f6IL+USG77izhMPnnrBNHICaTxaOgkrYqbLAX2LAgfbN8ooKEcZQe3q6C 4g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dnyvv10y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 15:53:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IFpfDJ029454;
        Tue, 18 Jan 2022 15:53:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhje3yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 15:53:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IFqwJ345875620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:52:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD82811C05C;
        Tue, 18 Jan 2022 15:52:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F89511C054;
        Tue, 18 Jan 2022 15:52:58 +0000 (GMT)
Received: from [9.171.91.170] (unknown [9.171.91.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 15:52:58 +0000 (GMT)
Message-ID: <bf1c79cc-2108-ceb0-4f0a-d83386046f00@linux.ibm.com>
Date:   Tue, 18 Jan 2022 16:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
 <yt9dmtjtcaws.fsf@linux.ibm.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <yt9dmtjtcaws.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFX8pFlPtRW8KtDH_PZMPJ4J8sQWbDNg
X-Proofpoint-ORIG-GUID: uFX8pFlPtRW8KtDH_PZMPJ4J8sQWbDNg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_04,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201180095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 16:37, Sven Schnelle wrote:
> Hi Janis,
> 
> Janis Schoetterl-Glausch <scgl@linux.ibm.com> writes:
> 
>> KVM needs a mechanism to do accesses to guest memory that honor
>> storage key protection.
>> Since the copy_to/from_user implementation makes use of move
>> instructions that support having an additional access key supplied,
>> we can implement __copy_from/to_user_with_key by enhancing the
>> existing implementation.
>>
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> 
> This doesn't apply to my master branch.

Maybe it's due to the prerequisite patch missing?
https://lore.kernel.org/linux-s390/YeGBmPBJ8NMi0Rkp@osiris/T/#t

> 
>> diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
>> index d3a700385875..ce7a150dd93a 100644
>> --- a/arch/s390/lib/uaccess.c
>> +++ b/arch/s390/lib/uaccess.c
>> @@ -59,11 +59,13 @@ static inline int copy_with_mvcos(void)
>>  #endif
>>  
>>  static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
>> -						 unsigned long size)
>> +						 unsigned long size, char key)
>>  {
>>  	unsigned long tmp1, tmp2;
>>  	union oac spec = {
>> +		.oac2.key = key,
>>  		.oac2.as = PSW_BITS_AS_SECONDARY,
>> +		.oac2.k = 1,
>>  		.oac2.a = 1,
>>  	};
>>  
>> @@ -94,19 +96,19 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
>>  }
>>  
>>  static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
>> -						unsigned long size)
>> +						unsigned long size, char key)
> 
> Any special reason for using 'char' as type for key here? Given the left shift
> below i would prefer 'unsigned char' to avoid having to think about
> whether this can overflow. The end result wouldn't look different,
> so more or less a cosmetic issue.

Will do.

[...]
> 
> With that minor nitpick:
> 
> Reviewed-by: Sven Schnelle <svens@linux.ibm.com>

Thanks!

