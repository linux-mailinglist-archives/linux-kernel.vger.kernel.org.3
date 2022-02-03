Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74794A8C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbiBCTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:20:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234694AbiBCTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:20:18 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213J4LGr025497;
        Thu, 3 Feb 2022 19:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GrG0lTYj5OU/VgdZdulxxIHUMoTSHwn5jyPClSgR/CE=;
 b=gxvITQrixNCNooRDuR+ygjiggKkgCK+DeVT23yaB6xrRsM8hlO3Kz0soHc0+gBCAn627
 KOWYh1xRtI+aHfvC2wa8VP471QMS4AnfkJkFhlIZjAqnh3hswwFpnxfKf0CTVIkV3SOt
 Z7E9RDDl49woLD7im6L31ZMsXB3OiVD6RZnz43evCv94CUDUQgGEi/krag2HIc82tONQ
 8XS5jhSvvXZwp3AqB+oMIWNCKPB0bPHEUngNulmwttXFquI6kp8Kt/ch+z3nIVAaID/i
 Am3kkXx8PvbsSX2DC78X7RINtORYqDQgsZoZI010WMJj1zCcJrXoiE5IkSneM7TaF7ez jw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0aa3yucu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 19:20:13 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213JInJq000699;
        Thu, 3 Feb 2022 19:20:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3dvw7a784s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 19:20:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213JK7Bd45744554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 19:20:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A9011C05C;
        Thu,  3 Feb 2022 19:20:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FCB211C04C;
        Thu,  3 Feb 2022 19:20:07 +0000 (GMT)
Received: from osiris (unknown [9.145.62.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Feb 2022 19:20:07 +0000 (GMT)
Date:   Thu, 3 Feb 2022 20:20:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        borntraeger@linux.ibm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH 1/2] uaccess: Add mechanism for arch specific user
 access with argument
Message-ID: <Yfwq5fsRiWfWCSAB@osiris>
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
 <20220203181141.2682997-1-scgl@linux.ibm.com>
 <20220203181141.2682997-2-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203181141.2682997-2-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EScjTBmF9xNNm9T9fny0ckmWuRYY9dpe
X-Proofpoint-ORIG-GUID: EScjTBmF9xNNm9T9fny0ckmWuRYY9dpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 07:11:40PM +0100, Janis Schoetterl-Glausch wrote:
> KVM on s390 needs a mechanism to do accesses to guest memory
> that honor storage key protection.
> 
> On s390 each physical page is associated with 4 access control bits.
> On access these are compared with an access key, which is either
> provided by the instruction or taken from the CPU state.
> Based on that comparison, the access either succeeds or is prevented.
> 
> KVM on s390 needs to be able emulate this behavior, for example during
> instruction emulation. KVM usually accesses the guest via
> __copy_from/to_user, but in this case we need to also pass the access key.
> Introduce __copy_from/to_user_opaque functions KVM can use to achieve
> this by forwarding an architecture specific argument.
> These functions are the same as their non _opaque counterparts, except
> for the additional argument and also reside in include/linux/uaccess.h
> so that they will not go out of sync should their counterparts change.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  include/linux/uaccess.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..cc2c7c6e2b92 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -114,6 +114,20 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>  	return raw_copy_from_user(to, from, n);
>  }
>  
> +#ifdef uaccess_opaque
> +static __always_inline __must_check unsigned long
> +__copy_from_user_opaque(void *to, const void __user *from, unsigned long n,
> +			struct uaccess_opaque opaque)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_from_user(to, from, n);
> +	check_object_size(to, n, false);
> +	return raw_copy_from_user_opaque(to, from, n, opaque);
> +}
> +#endif /* uaccess_opaque */
> +
>  /**
>   * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
>   * @to:   Destination address, in user space.
> @@ -148,6 +162,20 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
>  	return raw_copy_to_user(to, from, n);
>  }
>  
> +#ifdef uaccess_opaque
> +static __always_inline __must_check unsigned long
> +__copy_to_user_opaque(void __user *to, const void *from, unsigned long n,
> +		      struct uaccess_opaque opaque)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_to_user(to, from, n);
> +	check_object_size(from, n, true);
> +	return raw_copy_to_user_opaque(to, from, n, opaque);
> +}
> +#endif /* uaccess_opaque */

I don't think this is acceptable for several reasons:

- we really don't want an "opaque" copy_to_user variant with completely
  different semantics for each architecture

- even if this would be only for s390 it is anything but obvious for the
  reader what the semantics of "opaque" are

- making a double underscore variant of something the regular api is really
  not nice

So I guess we have three options:

- add a "key" variant to common code, where the semantics are clearly that
  "key" is a matching access key required to access a user space page

- have this completely in s390 arch code and accept the burden (and risk)
  of keeping instrumentation, etc. in sync

- add some macros similar to the SYSCALL_DEFINE macros, which allow to
  create architecture specific copy_to/from_user variants with additional
  parameters.
