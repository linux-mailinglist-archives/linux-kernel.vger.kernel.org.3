Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EB4A487C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiAaNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:40:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238832AbiAaNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:40:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VDWHNE028641;
        Mon, 31 Jan 2022 13:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1b8E52D7subxzHhYPkwF2V8bjyBoMxQ/AeKVhSntdms=;
 b=lt2f7xNEVA91f0hrEyxn2E9xlq/MonQnYFEMiZURLkSrsBZSu5ABmu8fx8zh+6FgFmQi
 ojz+ajjo6zb26a1lyXVPA/6pOrB8mAH207T3nprehY/VXcxHNReuSfrELRwUjmG/VmXG
 FnlkTZ80aPqhWUMRJrWci+EuVEd+naWbZIfzSIGPRmt8bfw6K+zAc/lqpp90CjHjH7Ep
 hhYwwaEYE25frFUwVMjIFn8h5BwnAnysTn4v+XmwNEru/DA9/bs2WYF04HEvc7qN3UZc
 r7DLtwWyII8aTnD+qS1yytYYiD924Vgab8vey2zrO3nGZwueSsJiamibegUXNTcci+B9 xg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxgr685p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 13:40:02 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VDWMJN008778;
        Mon, 31 Jan 2022 13:40:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3dvw78u6k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 13:40:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VDdtNa34144528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 13:39:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCAE2AE057;
        Mon, 31 Jan 2022 13:39:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88459AE05A;
        Mon, 31 Jan 2022 13:39:55 +0000 (GMT)
Received: from [9.171.76.125] (unknown [9.171.76.125])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 13:39:55 +0000 (GMT)
Message-ID: <ebe26b3f-704c-fb75-4055-0a0b248d89e5@linux.ibm.com>
Date:   Mon, 31 Jan 2022 14:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/2] uaccess: Add mechanism for key checked access to
 user memory
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220126173358.2951879-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Al-f9nZ4_eO9ULmEYFGv-dC2J1IW_ppS
X-Proofpoint-ORIG-GUID: Al-f9nZ4_eO9ULmEYFGv-dC2J1IW_ppS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_05,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.01.22 um 18:33 schrieb Janis Schoetterl-Glausch:
> Something like this patch series is required as part of KVM supporting
> storage keys on s390.
> See https://lore.kernel.org/kvm/20220118095210.1651483-1-scgl@linux.ibm.com/

Just to give some more context. In theory we could confine the alternative
uaccess functions in s390x architecture code, after all we only have one
place in KVM code where we call it. But this will be very likely
result in future changes not being synced. This would very likely also
continue to work but it might miss security and functionality enhancements.
And I think we want our KVM uaccess to also do the kasan, error-inject and
so on. After all there is a reason why all copy_*user functions were merged
and now architectures only provide raw_*_user functions.

> 
> On s390 each physical page is associated with 4 access control bits.
> On access, these are compared with an access key, which is either
> provided by the instruction or taken from the CPU state.
> Based on that comparison, the access either succeeds or is prevented.
> 
> KVM on s390 needs to be able emulate this behavior, for example during
> instruction emulation, when it makes accesses on behalf of the guest.
> In order to do that, we need variants of __copy_from/to_user that pass
> along an access key to the architecture specific implementation of
> __copy_from/to_user. That is the only difference, variants do the same
> might_fault(), instrument_copy_to_user(), etc. calls as the normal
> functions do and need to be kept in sync with those.
> If these __copy_from/to_user_key functions were to be maintained
> in architecture specific code they would be prone to going out of sync
> with their non key counterparts if there were code changes.
> So, instead, add these variants to include/linux/uaccess.h.
> 
> Considerations:
>   * The key argument is an unsigned long, in order to make the functions
>     less specific to s390, which would only need an u8.
>     This could also be generalized further, i.e. by having the type be
>     defined by the architecture, with the default being a struct without
>     any members.
>     Also the functions could be renamed ..._opaque, ..._arg, or similar.
>   * Which functions do we provide _key variants for? Just defining
>     __copy_from/to_user_key would make it rather specific to our use
>     case.
>   * Should ...copy_from/to_user_key functions be callable from common
>     code? The patch defines the functions to be functionally identical
>     to the normal functions if the architecture does not define
>     raw_copy_from/to_user_key, so that this would be possible, however it
>     is not required for our use case.
> 
> For the minimal functionality we require see the diff below.
> 
> bloat-o-meter reported a .03% kernel size increase.
> 
> Comments are much appreciated.
> 
> Janis Schoetterl-Glausch (2):
>    uaccess: Add mechanism for key checked access to user memory
>    s390/uaccess: Provide raw_copy_from/to_user_key
> 
>   arch/s390/include/asm/uaccess.h |  22 ++++++-
>   arch/s390/lib/uaccess.c         |  48 ++++++++------
>   include/linux/uaccess.h         | 107 ++++++++++++++++++++++++++++++++
>   lib/usercopy.c                  |  33 ++++++++++
>   4 files changed, 188 insertions(+), 22 deletions(-)
> 
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..b3c58b7605d6 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -114,6 +114,20 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>   	return raw_copy_from_user(to, from, n);
>   }
>   
> +#ifdef raw_copy_from_user_key
> +static __always_inline __must_check unsigned long
> +__copy_from_user_key(void *to, const void __user *from, unsigned long n,
> +			  unsigned long key)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_from_user(to, from, n);
> +	check_object_size(to, n, false);
> +	return raw_copy_from_user_key(to, from, n, key);
> +}
> +#endif /* raw_copy_from_user_key */
> +
>   /**
>    * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
>    * @to:   Destination address, in user space.
> @@ -148,6 +162,20 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
>   	return raw_copy_to_user(to, from, n);
>   }
>   
> +#ifdef raw_copy_to_user_key
> +static __always_inline __must_check unsigned long
> +__copy_to_user_key(void __user *to, const void *from, unsigned long n,
> +			unsigned long key)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_to_user(to, from, n);
> +	check_object_size(from, n, true);
> +	return raw_copy_to_user_key(to, from, n, key);
> +}
> +#endif /* raw_copy_to_user_key */
> +
>   #ifdef INLINE_COPY_FROM_USER
>   static inline __must_check unsigned long
>   _copy_from_user(void *to, const void __user *from, unsigned long n)
> 
> base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
