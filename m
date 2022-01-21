Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E6495FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380757AbiAUNqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:46:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380567AbiAUNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:46:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LBGTPh002895;
        Fri, 21 Jan 2022 13:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JXyGD+6qyYAPrwJA+4HRaiK0sTCQlCIuJ/AqErjzjN4=;
 b=TQzHbWCC44q+25nLp8fgfQOYMqziD50gC3IZT1ok9yDxsP3bwHNF8iyo8JxgCmk1Oe4r
 dBvEoYLzjrF4rP70sASI7UOFYzNNa80cVfIntoCN3wbRVAQwxpAe74yYhVEFdQf8k7tD
 ZV0y1gLtqL41xEL601gNFJyW7x4ZRJNW3LqDWhYRWaqi9vN1dyqF516YgDM4jKh0M4wl
 55vZ9lCiYxp8BbExrrlwZewNdjh75nSCyiwOeQ5vt5yDZfzGn1API2kHMQF+RCMORYQ8
 J7TFsFnxV2IbYrxBr0ucUs4IPSO+z11qA/Zcb4gaJCAXm7S81Nlck/Q/2Q3vt8anjq+3 pw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqutjtw6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 13:46:08 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LDg1LF023181;
        Fri, 21 Jan 2022 13:46:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3dqjegcx8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 13:46:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LDk3Hf43516284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 13:46:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 067F552054;
        Fri, 21 Jan 2022 13:46:03 +0000 (GMT)
Received: from [9.171.30.56] (unknown [9.171.30.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9CEEF52059;
        Fri, 21 Jan 2022 13:46:02 +0000 (GMT)
Message-ID: <13a03972-0020-b8e7-2fc0-def8a164eb10@linux.ibm.com>
Date:   Fri, 21 Jan 2022 14:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com> <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
 <YelcCEuVbIg9ND90@osiris> <YemnprCIEjjGFeTn@osiris>
 <b6896b1a-d529-1504-091c-d41287c01dc8@linux.ibm.com>
 <YeqTP6WDbZzEJUbJ@osiris>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <YeqTP6WDbZzEJUbJ@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1J7rmFUY1BDT5y93PM8CZth9xWuTxnVw
X-Proofpoint-GUID: 1J7rmFUY1BDT5y93PM8CZth9xWuTxnVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 12:04, Heiko Carstens wrote:
> On Fri, Jan 21, 2022 at 08:32:25AM +0100, Christian Borntraeger wrote:
>> So in essence adding something like this and then providing raw_copy_from/to_user_key?
>> (whitespace damaged, just pasted in)
>>
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index ac0394087f7d..3b6e78ee211c 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -201,6 +201,59 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
>>         return n;
>>  }
>> +
>> +#if defined(__s390x__) && defined(CONFIG_KVM)
>> +/*
>> + * Variants that pass along an access key. Uses by KVM on s390x to implement
>> + * key checks for guests that use storage keys Must be kept in sync with the
>> + * non-key variants from above. The only difference is the _key suffix when
>> + * calling raw_copy_from/to_user_key.
>> + */
> 
> This is too architecture specific, I wouldn't like to see __s390__ or
> KVM dependencies. This should be a bit more generic, so other
> architectures _might_ also make use of this interface that is:
> 
>> +static inline __must_check unsigned long
>> +_copy_from_user_key(void *to, const void __user *from, unsigned long n, u8 key)
> 
> Make key unsigned long, add support for INLINE_COPY_TO_USER, and maybe
> add a wrapper, so this works on all architectures, e.g. if
> raw_copy_to_user_key() is not defined, then fall back to
> raw_copy_to_user() and ignore the key parameter.
> 

Since we only need the double underscore variants, even if we're going to be more
general than we need to be, we can restrict ourselves to those, can't we?

I don't understand your comment about the wrapper. You'd want an error on misuse,
that is, if you try to use a _with_key function if the functionality is not defined, no?

I see the following possibilities:
 1. raw_copy_from/to_user is declared by each architecture.
    Mirror that for raw_copy_from/to_user_with_key.
    Linker error on misuse.
 2. Opt in with #define UACCESS_WITH_KEY or similar.
    Undeclared function on misuse.
 3. Opt in by requiring that raw_copy_from/to_user_with_key are macros.
    Undeclared function on misuse.
 4. Declare raw_copy_from/to_user_with_key in include/linux/uacess.h.
    Linker error on misuse.
