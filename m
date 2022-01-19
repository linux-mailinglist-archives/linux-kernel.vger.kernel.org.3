Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13674937B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353250AbiASJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353244AbiASJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J9LcXq029720;
        Wed, 19 Jan 2022 09:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=pMvWzKUvxgTuxRy8WlkURMvxWNJx1Lozqz24/q4tzo0=;
 b=Vbibj1wNWzBLU+qCwjmlHxKxeJvcbRfHy8dhDahOQ1FHxBiW8azh03VD+yBD5t935han
 qILCt7ve8p9PPDeEP01ebU1e4+sj4H/d3I62et6oN3WKbXVlcgb2QSnbHMwa0BGJLJY4
 /FJpPkZJC8qM3rFIWR9AM7lCySjBMbH6m7TbDAxnzWsKZ+/TQanBugCcknj5oKsRpx2Q
 dqV2bNLRkJU8TYafv7AtppS3UHyk+/TcDI90TpN6jv+igrvivHUANR7fVSZEL0Vj87RV
 GxRIZYnk/Rtbqo6LK/WPKpJWKoMKf7TWT2i7XA7x6Lu1950wesNWdDZwJtJARb5tomHk gA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpdunu3ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 09:48:41 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20J9mCnU011371;
        Wed, 19 Jan 2022 09:48:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3dknhjab48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 09:48:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20J9mS2h45023506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 09:48:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C788D42045;
        Wed, 19 Jan 2022 09:48:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9CC42042;
        Wed, 19 Jan 2022 09:48:28 +0000 (GMT)
Received: from osiris (unknown [9.145.70.139])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Jan 2022 09:48:28 +0000 (GMT)
Date:   Wed, 19 Jan 2022 10:48:26 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YefeakONMN4PLlml@osiris>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118095210.1651483-2-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lE4o_iBFdN-uuYsDeRkFbKeNibCdh1K3
X-Proofpoint-ORIG-GUID: lE4o_iBFdN-uuYsDeRkFbKeNibCdh1K3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jan 18, 2022 at 10:52:01AM +0100, Janis Schoetterl-Glausch wrote:
> KVM needs a mechanism to do accesses to guest memory that honor
> storage key protection.
> Since the copy_to/from_user implementation makes use of move
> instructions that support having an additional access key supplied,
> we can implement __copy_from/to_user_with_key by enhancing the
> existing implementation.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  arch/s390/include/asm/uaccess.h | 32 ++++++++++++++++++
>  arch/s390/lib/uaccess.c         | 57 +++++++++++++++++++++++----------
>  2 files changed, 72 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index 02b467461163..5138040348cc 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -33,6 +33,38 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>  
>  #define access_ok(addr, size) __access_ok(addr, size)
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
>  unsigned long __must_check
>  raw_copy_from_user(void *to, const void __user *from, unsigned long n);

That's a lot of code churn... I would have expected that the existing
functions will be renamed, get an additional key parameter, and the
current API is implemented by defines which map copy_to_user() &
friends to the new functions, and add a zero key.

This would avoid a lot of code duplication, even though the kernel
image would get slightly larger.

Could you do that, please, and also provide bloat-a-meter results?

And as already mentioned: please don't use "char" for passing a
key. Besides that this leads to the overflow question as pointed out
by Sven, this might as usual also raise the question if there might be
any bugs wrt to sign extension. That is: for anything but characters,
please always explicitely use signed or unsigned char (or u8/s8), so
nobody has to think about this.

Thanks!
