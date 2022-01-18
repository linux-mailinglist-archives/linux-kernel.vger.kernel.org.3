Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA54926F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiARNS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:18:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241917AbiARNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:18:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ICexgF016137;
        Tue, 18 Jan 2022 13:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vqn8Hhf6zsUPy9ecE3s9tcqpA6927yqIg+jU15ebVu4=;
 b=FTDBAlYDFMRADYbwIDqeJrg2NWkSv8edZZTIRjoXNjkeSFiuRnbiKLVsM0mk8FW+osq2
 XaGsl6crq7PYGZwsI53uDM0Aw61DpbKg7gZfWBnsS8bbfUosPIl7bByZZt+Kk62Y8B1i
 l7Dr59ChDKwS2SJLVulgLjFb97NJzIhvNKLVJ8dKchdQc1ahDBCVJYQ87YA9HyTwsCnF
 dytkxBytMgxbKBAbWrURIJENOFl7DFSLObJjnFK9mroLszQSsz1Z4ZCofRMRcNMjBukJ
 BqX+E8IFCV4t99BCwCDy6InESbK9vInT8O6JFKf3JRxWdSZuqLpKaVnMNl1SmMi9ON/p lw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnr9ssnht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 13:18:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IDDjv8010640;
        Tue, 18 Jan 2022 13:18:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhjcp3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 13:18:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IDIfcC18547062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 13:18:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9DA5AE04D;
        Tue, 18 Jan 2022 13:18:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28448AE055;
        Tue, 18 Jan 2022 13:18:41 +0000 (GMT)
Received: from [9.145.64.253] (unknown [9.145.64.253])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 13:18:41 +0000 (GMT)
Message-ID: <cb563fbc-3f16-2d41-ab88-5c83e7d484ec@linux.ibm.com>
Date:   Tue, 18 Jan 2022 14:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220118095210.1651483-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VFL91AE36OKyZ0PGMKFRjfptgU1TXiHI
X-Proofpoint-ORIG-GUID: VFL91AE36OKyZ0PGMKFRjfptgU1TXiHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_03,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 10:52, Janis Schoetterl-Glausch wrote:
> KVM needs a mechanism to do accesses to guest memory that honor
> storage key protection.
> Since the copy_to/from_user implementation makes use of move
> instructions that support having an additional access key supplied,
> we can implement __copy_from/to_user_with_key by enhancing the
> existing implementation.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

For this I'd like to have buy-in from the kernel maintainers.
The patch looks good to me but currently I don't understand all of the 
background so:

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   arch/s390/include/asm/uaccess.h | 32 ++++++++++++++++++
>   arch/s390/lib/uaccess.c         | 57 +++++++++++++++++++++++----------
>   2 files changed, 72 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index 02b467461163..5138040348cc 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -33,6 +33,38 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>   
>   #define access_ok(addr, size) __access_ok(addr, size)
>   
> +unsigned long __must_check
> +raw_copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
> +			    char key);
> +
> +unsigned long __must_check
> +raw_copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
> +			  char key);
> +
> +static __always_inline __must_check unsigned long
> +__copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
> +			  char key)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_from_user(to, from, n);
> +	check_object_size(to, n, false);
> +	return raw_copy_from_user_with_key(to, from, n, key);
> +}
> +
> +static __always_inline __must_check unsigned long
> +__copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
> +			char key)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_to_user(to, from, n);
> +	check_object_size(from, n, true);
> +	return raw_copy_to_user_with_key(to, from, n, key);
> +}
> +
>   unsigned long __must_check
>   raw_copy_from_user(void *to, const void __user *from, unsigned long n);
>   
> diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
> index d3a700385875..ce7a150dd93a 100644
> --- a/arch/s390/lib/uaccess.c
> +++ b/arch/s390/lib/uaccess.c
> @@ -59,11 +59,13 @@ static inline int copy_with_mvcos(void)
>   #endif
>   
>   static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
> -						 unsigned long size)
> +						 unsigned long size, char key)
>   {
>   	unsigned long tmp1, tmp2;
>   	union oac spec = {
> +		.oac2.key = key,
>   		.oac2.as = PSW_BITS_AS_SECONDARY,
> +		.oac2.k = 1,
>   		.oac2.a = 1,
>   	};
>   
> @@ -94,19 +96,19 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
>   }
>   
>   static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
> -						unsigned long size)
> +						unsigned long size, char key)
>   {
>   	unsigned long tmp1, tmp2;
>   
>   	tmp1 = -256UL;
>   	asm volatile(
>   		"   sacf  0\n"
> -		"0: mvcp  0(%0,%2),0(%1),%3\n"
> +		"0: mvcp  0(%0,%2),0(%1),%[key]\n"
>   		"7: jz    5f\n"
>   		"1: algr  %0,%3\n"
>   		"   la    %1,256(%1)\n"
>   		"   la    %2,256(%2)\n"
> -		"2: mvcp  0(%0,%2),0(%1),%3\n"
> +		"2: mvcp  0(%0,%2),0(%1),%[key]\n"
>   		"8: jnz   1b\n"
>   		"   j     5f\n"
>   		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
> @@ -115,7 +117,7 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
>   		"   slgr  %4,%1\n"
>   		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
>   		"   jnh   6f\n"
> -		"4: mvcp  0(%4,%2),0(%1),%3\n"
> +		"4: mvcp  0(%4,%2),0(%1),%[key]\n"
>   		"9: slgr  %0,%4\n"
>   		"   j     6f\n"
>   		"5: slgr  %0,%0\n"
> @@ -123,24 +125,36 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
>   		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
>   		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
>   		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
> -		: : "cc", "memory");
> +		: [key] "d" (key << 4)
> +		: "cc", "memory");
>   	return size;
>   }
>   
>   unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>   {
>   	if (copy_with_mvcos())
> -		return copy_from_user_mvcos(to, from, n);
> -	return copy_from_user_mvcp(to, from, n);
> +		return copy_from_user_mvcos(to, from, n, 0);
> +	return copy_from_user_mvcp(to, from, n, 0);
>   }
>   EXPORT_SYMBOL(raw_copy_from_user);
>   
> -static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
> -					       unsigned long size)
> +unsigned long raw_copy_from_user_with_key(void *to, const void __user *from,
> +					  unsigned long n, char key)
> +{
> +	if (copy_with_mvcos())
> +		return copy_from_user_mvcos(to, from, n, key);
> +	return copy_from_user_mvcp(to, from, n, key);
> +}
> +EXPORT_SYMBOL(raw_copy_from_user_with_key);
> +
> +inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
> +					unsigned long size, char key)
>   {
>   	unsigned long tmp1, tmp2;
>   	union oac spec = {
> +		.oac1.key = key,
>   		.oac1.as = PSW_BITS_AS_SECONDARY,
> +		.oac1.k = 1,
>   		.oac1.a = 1,
>   	};
>   
> @@ -171,19 +185,19 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
>   }
>   
>   static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
> -					      unsigned long size)
> +					      unsigned long size, char key)
>   {
>   	unsigned long tmp1, tmp2;
>   
>   	tmp1 = -256UL;
>   	asm volatile(
>   		"   sacf  0\n"
> -		"0: mvcs  0(%0,%1),0(%2),%3\n"
> +		"0: mvcs  0(%0,%1),0(%2),%[key]\n"
>   		"7: jz    5f\n"
>   		"1: algr  %0,%3\n"
>   		"   la    %1,256(%1)\n"
>   		"   la    %2,256(%2)\n"
> -		"2: mvcs  0(%0,%1),0(%2),%3\n"
> +		"2: mvcs  0(%0,%1),0(%2),%[key]\n"
>   		"8: jnz   1b\n"
>   		"   j     5f\n"
>   		"3: la    %4,255(%1)\n" /* %4 = ptr + 255 */
> @@ -192,7 +206,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
>   		"   slgr  %4,%1\n"
>   		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
>   		"   jnh   6f\n"
> -		"4: mvcs  0(%4,%1),0(%2),%3\n"
> +		"4: mvcs  0(%4,%1),0(%2),%[key]\n"
>   		"9: slgr  %0,%4\n"
>   		"   j     6f\n"
>   		"5: slgr  %0,%0\n"
> @@ -200,17 +214,26 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
>   		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
>   		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
>   		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
> -		: : "cc", "memory");
> +		: [key] "d" (key << 4)
> +		: "cc", "memory");
>   	return size;
>   }
>   
>   unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>   {
>   	if (copy_with_mvcos())
> -		return copy_to_user_mvcos(to, from, n);
> -	return copy_to_user_mvcs(to, from, n);
> +		return copy_to_user_mvcos(to, from, n, 0);
> +	return copy_to_user_mvcs(to, from, n, 0);
>   }
>   EXPORT_SYMBOL(raw_copy_to_user);
> +unsigned long raw_copy_to_user_with_key(void __user *to, const void *from,
> +					unsigned long n, char key)
> +{
> +	if (copy_with_mvcos())
> +		return copy_to_user_mvcos(to, from, n, key);
> +	return copy_to_user_mvcs(to, from, n, key);
> +}
> +EXPORT_SYMBOL(raw_copy_to_user_with_key);
>   
>   static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
>   {
> 

