Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03248495E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380057AbiAULFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:05:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380071AbiAULEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:04:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L8g9Fa020680;
        Fri, 21 Jan 2022 11:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D/iEdnt3pjMKntSlvY676T4wumFjLEYbbN235FI2fL0=;
 b=VabtiYw985Ya2IsYARMN8OASJXI54Cs3BANFMSu3EqIf7wixzB493ysI/euAtM3UCRhn
 VmzJRz3qOsI3MxwQA/ISxgYDZz+S5TeuO84GimbS4SVY9rDbmLug5rYaXuFJLXnkR32+
 wwPEvrYyzLICOXVIDdJdwGvcPZsGdsKdvKXs4L2lyqJtT0To5xhb7Sw1wRbd36Id5IzB
 a148Ikvoo9Bgc4fry7CoGXrL8dgb83asz9e/0CQAYRtrtMEL4fDq7J/tvhPlpwgs3OSx
 BJmc/X3f/0uLetZSLzA1hqZhPG4TGg3BedPk5CJ0wN0leFx40ICxQ7/KVihYltbmsiNT 2Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dqsj4traw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:04:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LB2Z3M017518;
        Fri, 21 Jan 2022 11:04:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3dqjepkkr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:04:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LB4Xmc47055196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 11:04:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AB20AE080;
        Fri, 21 Jan 2022 11:04:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A1CEAE056;
        Fri, 21 Jan 2022 11:04:33 +0000 (GMT)
Received: from osiris (unknown [9.145.74.142])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jan 2022 11:04:33 +0000 (GMT)
Date:   Fri, 21 Jan 2022 12:04:31 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YeqTP6WDbZzEJUbJ@osiris>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
 <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
 <YelcCEuVbIg9ND90@osiris>
 <YemnprCIEjjGFeTn@osiris>
 <b6896b1a-d529-1504-091c-d41287c01dc8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6896b1a-d529-1504-091c-d41287c01dc8@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c1aMgmJccfuhrwkCJlcakJd8YShtiGFg
X-Proofpoint-ORIG-GUID: c1aMgmJccfuhrwkCJlcakJd8YShtiGFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 08:32:25AM +0100, Christian Borntraeger wrote:
> So in essence adding something like this and then providing raw_copy_from/to_user_key?
> (whitespace damaged, just pasted in)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..3b6e78ee211c 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -201,6 +201,59 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
>         return n;
>  }
> +
> +#if defined(__s390x__) && defined(CONFIG_KVM)
> +/*
> + * Variants that pass along an access key. Uses by KVM on s390x to implement
> + * key checks for guests that use storage keys Must be kept in sync with the
> + * non-key variants from above. The only difference is the _key suffix when
> + * calling raw_copy_from/to_user_key.
> + */

This is too architecture specific, I wouldn't like to see __s390__ or
KVM dependencies. This should be a bit more generic, so other
architectures _might_ also make use of this interface that is:

> +static inline __must_check unsigned long
> +_copy_from_user_key(void *to, const void __user *from, unsigned long n, u8 key)

Make key unsigned long, add support for INLINE_COPY_TO_USER, and maybe
add a wrapper, so this works on all architectures, e.g. if
raw_copy_to_user_key() is not defined, then fall back to
raw_copy_to_user() and ignore the key parameter.

Just some ideas. The _only_ concern about the previous implementation
I have, is that we could run out-of-sync with common code wrt
instrumentation and other options. Given how sensitive uaccess ops
are, I think we should try to avoid that by all cost, if possible.

Does that make sense?
