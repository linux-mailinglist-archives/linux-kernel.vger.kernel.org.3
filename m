Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A47493924
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353937AbiASLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:02:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353857AbiASLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:02:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J9vnpx022766;
        Wed, 19 Jan 2022 11:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vuQsa7jcrh5TcCyBbceIuHnE31xEDzVmMebCUoCOxYw=;
 b=LCoboYKCoL0/c06e4dDPbiATikYLGlXP2MrHYAB91djchq5IQMINmb2MQyq7WoeIEAUm
 rapdlRaHo6j8ZNnMG1iZDtfanZLA6cWrbH2br8Jw6JogLCrqRjhXGbs6DwKK8djqNeiG
 NQAQnCs4HuxWa95WeFQKGp+xCTRiGYkH4skX53doPhqWvjO+8hKEZAOsO0v1ZCzrHZyP
 52fMw6Sl9hXap9FHibpH06jRa/PXHwnVCiBNywqWQz/8fBjLmaODOj7Jvf9bDCGbWzrZ
 5ZojM97tthNVnymGwlZry4SB17lrKPsg7E55AfNUY2h5TJv/MRK6mo6oBitQAiw3LEhN Ow== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpgfm158r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 11:02:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JAxlsk001602;
        Wed, 19 Jan 2022 11:02:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhjmhwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 11:02:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JB2Zu436635094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 11:02:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E100DA417A;
        Wed, 19 Jan 2022 11:02:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FD4A4177;
        Wed, 19 Jan 2022 11:02:34 +0000 (GMT)
Received: from [9.171.12.6] (unknown [9.171.12.6])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 11:02:34 +0000 (GMT)
Message-ID: <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
Date:   Wed, 19 Jan 2022 12:02:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com> <YefeakONMN4PLlml@osiris>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <YefeakONMN4PLlml@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SORBrbFPWDMzbdnpNb8-49k4NAN0QjSu
X-Proofpoint-GUID: SORBrbFPWDMzbdnpNb8-49k4NAN0QjSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 10:48, Heiko Carstens wrote:
> 
> On Tue, Jan 18, 2022 at 10:52:01AM +0100, Janis Schoetterl-Glausch wrote:
>> KVM needs a mechanism to do accesses to guest memory that honor
>> storage key protection.
>> Since the copy_to/from_user implementation makes use of move
>> instructions that support having an additional access key supplied,
>> we can implement __copy_from/to_user_with_key by enhancing the
>> existing implementation.
>>
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/uaccess.h | 32 ++++++++++++++++++
>>  arch/s390/lib/uaccess.c         | 57 +++++++++++++++++++++++----------
>>  2 files changed, 72 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
>> index 02b467461163..5138040348cc 100644
>> --- a/arch/s390/include/asm/uaccess.h
>> +++ b/arch/s390/include/asm/uaccess.h
>> @@ -33,6 +33,38 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>>  
>>  #define access_ok(addr, size) __access_ok(addr, size)
>>  
>> +unsigned long __must_check
>> +raw_copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
>> +			    char key);
>> +
>> +unsigned long __must_check
>> +raw_copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
>> +			  char key);
>> +
>> +static __always_inline __must_check unsigned long
>> +__copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
>> +			  char key)
>> +{
>> +	might_fault();
>> +	if (should_fail_usercopy())
>> +		return n;
>> +	instrument_copy_from_user(to, from, n);
>> +	check_object_size(to, n, false);
>> +	return raw_copy_from_user_with_key(to, from, n, key);
>> +}
>> +
>> +static __always_inline __must_check unsigned long
>> +__copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
>> +			char key)
>> +{
>> +	might_fault();
>> +	if (should_fail_usercopy())
>> +		return n;
>> +	instrument_copy_to_user(to, from, n);
>> +	check_object_size(from, n, true);
>> +	return raw_copy_to_user_with_key(to, from, n, key);
>> +}
>> +
>>  unsigned long __must_check
>>  raw_copy_from_user(void *to, const void __user *from, unsigned long n);
> 
> That's a lot of code churn... I would have expected that the existing
> functions will be renamed, get an additional key parameter, and the
> current API is implemented by defines which map copy_to_user() &
> friends to the new functions, and add a zero key.

I don't think I understand you. I can implement raw_copy_from/to_user
in terms of raw_copy_from/to_user_with_key, which does save a few lines,
but that's it, isn't it?

Thanks!
> 
> This would avoid a lot of code duplication, even though the kernel
> image would get slightly larger.
> 
> Could you do that, please, and also provide bloat-a-meter results?
> 
> And as already mentioned: please don't use "char" for passing a
> key. Besides that this leads to the overflow question as pointed out
> by Sven, this might as usual also raise the question if there might be
> any bugs wrt to sign extension. That is: for anything but characters,
> please always explicitely use signed or unsigned char (or u8/s8), so
> nobody has to think about this.

Will do.
> 
> Thanks!

