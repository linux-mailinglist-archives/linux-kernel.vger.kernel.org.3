Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79544929C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiARPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:37:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238270AbiARPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:37:50 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IExOwB007661;
        Tue, 18 Jan 2022 15:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=tj+uAAwN4ZOApXkvlRULHVk/tpOVX+PuIuDySDyIRV0=;
 b=OIKM6/osMYsXMxk2FlWyvSttoNvolUESkQTsTKEFCe19DLnUjtgK8mgKB04ueI2HQUHy
 +EqMwbUxPPoEPpT9Dj7NFP445j2wPtxhi0zU9SfOHdtsTB5AZHy0E5sX9hpBf+vnEkpz
 iF8LJ5QQFNP9btzV922BPBE0YoBbUB7OKfvi/41X2rChfiAP7E5BZEaHk6S/Xrk4g5Do
 ZMvwrSXxMCG7eqg5JdSy/7M7oFWqvEJchlzt3pIo05N61C6N/NPZ05OGYGFsSzDXiWkk
 QWa1S7bX/vqzKMv1CXCy3Yuu7Cc9ODZBdfDItaHCZ9tIIHjtOGyCgfJccDNeG3jCoSYd 4g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnkwhsxw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 15:37:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IFXiHG027790;
        Tue, 18 Jan 2022 15:37:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3dknw9nxph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 15:37:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IFbePh37093638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:37:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8994DA404D;
        Tue, 18 Jan 2022 15:37:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D8E9A406D;
        Tue, 18 Jan 2022 15:37:40 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Jan 2022 15:37:40 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
        <20220118095210.1651483-2-scgl@linux.ibm.com>
Date:   Tue, 18 Jan 2022 16:37:39 +0100
In-Reply-To: <20220118095210.1651483-2-scgl@linux.ibm.com> (Janis
        Schoetterl-Glausch's message of "Tue, 18 Jan 2022 10:52:01 +0100")
Message-ID: <yt9dmtjtcaws.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pE3mlCcOGk9cqcy40ZOp9rWrMS-lpKEn
X-Proofpoint-GUID: pE3mlCcOGk9cqcy40ZOp9rWrMS-lpKEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_04,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janis,

Janis Schoetterl-Glausch <scgl@linux.ibm.com> writes:

> KVM needs a mechanism to do accesses to guest memory that honor
> storage key protection.
> Since the copy_to/from_user implementation makes use of move
> instructions that support having an additional access key supplied,
> we can implement __copy_from/to_user_with_key by enhancing the
> existing implementation.
>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

This doesn't apply to my master branch.

> diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
> index d3a700385875..ce7a150dd93a 100644
> --- a/arch/s390/lib/uaccess.c
> +++ b/arch/s390/lib/uaccess.c
> @@ -59,11 +59,13 @@ static inline int copy_with_mvcos(void)
>  #endif
>  
>  static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
> -						 unsigned long size)
> +						 unsigned long size, char key)
>  {
>  	unsigned long tmp1, tmp2;
>  	union oac spec = {
> +		.oac2.key = key,
>  		.oac2.as = PSW_BITS_AS_SECONDARY,
> +		.oac2.k = 1,
>  		.oac2.a = 1,
>  	};
>  
> @@ -94,19 +96,19 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
>  }
>  
>  static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
> -						unsigned long size)
> +						unsigned long size, char key)

Any special reason for using 'char' as type for key here? Given the left shift
below i would prefer 'unsigned char' to avoid having to think about
whether this can overflow. The end result wouldn't look different,
so more or less a cosmetic issue.

>  {
>  	unsigned long tmp1, tmp2;
>  
>  	tmp1 = -256UL;
>  	asm volatile(
>  		"   sacf  0\n"
> -		"0: mvcp  0(%0,%2),0(%1),%3\n"
> +		"0: mvcp  0(%0,%2),0(%1),%[key]\n"
>  		"7: jz    5f\n"
>  		"1: algr  %0,%3\n"
>  		"   la    %1,256(%1)\n"
>  		"   la    %2,256(%2)\n"
> -		"2: mvcp  0(%0,%2),0(%1),%3\n"
> +		"2: mvcp  0(%0,%2),0(%1),%[key]\n"
>  		"8: jnz   1b\n"
>  		"   j     5f\n"
>  		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
> @@ -115,7 +117,7 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
>  		"   slgr  %4,%1\n"
>  		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
>  		"   jnh   6f\n"
> -		"4: mvcp  0(%4,%2),0(%1),%3\n"
> +		"4: mvcp  0(%4,%2),0(%1),%[key]\n"
>  		"9: slgr  %0,%4\n"
>  		"   j     6f\n"
>  		"5: slgr  %0,%0\n"
> @@ -123,24 +125,36 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
>  		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
>  		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
>  		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
> -		: : "cc", "memory");
> +		: [key] "d" (key << 4)
> +		: "cc", "memory");
>  	return size;
>  }
>  

With that minor nitpick:

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
