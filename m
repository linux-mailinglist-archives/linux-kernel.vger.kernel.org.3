Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9E4CF259
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiCGHCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:02:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0710B0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:01:20 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22767c0e011330;
        Mon, 7 Mar 2022 07:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=RoarqwVzHJy3ek8Ku3QJJyHMkiD0U44gHZOE+zK1q9c=;
 b=cl/If73D4MATm9n7/ZSu1wGiyNIdRGFfU71LTX5LhNyhwLKTSDJoyUnY1yflqQrI1SVw
 yclIlhEeGYz3YXL+/pVfCIZWnQJ7rV7I7XnPmjoAdh5G5nifKxHQjJbc6oPZjIMGm1Ln
 Ml9hPNflM8J13tdDpMFeL9DpI13d2hfCTt5xT5GbvoBYBxLDpTXi8SgxFmqI86C/yIjZ
 w+yew6IeYUI8kGScHcvXUumdpzz7H5UvqNGMhAIZgmB4HKQ9X+8zOVTKtkMz2c/owMsG
 zKRxfxZtTOKsWl9i8ia8RvZ0LZqB/QRvE4qRxlVYZS5G5iiSI5ouQCTocIfoD297XPS5 qA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emr0jfhmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 07:00:09 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2276meoa010791;
        Mon, 7 Mar 2022 07:00:08 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3ekyg93v90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 07:00:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 227708mr48366002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 07:00:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A63B2079;
        Mon,  7 Mar 2022 07:00:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06966B2068;
        Mon,  7 Mar 2022 07:00:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.89.15])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 07:00:05 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     ira.weiny@intel.com, Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pkeys: Make pkey unsigned in arch_set_user_pkey_access()
In-Reply-To: <20220304210543.3490880-1-ira.weiny@intel.com>
References: <20220304210543.3490880-1-ira.weiny@intel.com>
Date:   Mon, 07 Mar 2022 12:30:03 +0530
Message-ID: <878rtmtfgs.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c7fH1oFo6lnSnaXsgViphcgNdJqCCtP8
X-Proofpoint-GUID: c7fH1oFo6lnSnaXsgViphcgNdJqCCtP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070039
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@intel.com writes:

> From: Ira Weiny <ira.weiny@intel.com>
>
> The WARN_ON check in arch_set_user_pkey_access() in the x86 architecture
> fails to check for an invalid negative value.
>
> A simple check for less than 0 would fix this issue however, in the call
> stack below arch_set_user_pkey_access() the pkey should never be
> negative on any architecture.  It is always best to use correct types
> when possible.  x86 only supports 16 keys while ppc supports 32, u8 is
> therefore large enough for all current architectures and likely those in
> the future.

Should we do that as a separate patch? ie, now convert the variable to
unsigned int and later switch all the variables to u8? because what we
now have is confusing.

static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
		unsigned long pkey)
static inline u64 pkey_to_vmflag_bits(u16 pkey)



>
> Change the type of the pkey passed to arch_set_user_pkey_access() to u8.
>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/powerpc/include/asm/pkeys.h | 4 ++--
>  arch/powerpc/mm/book3s64/pkeys.c | 2 +-
>  arch/x86/include/asm/pkeys.h     | 4 ++--
>  arch/x86/kernel/fpu/xstate.c     | 2 +-
>  include/linux/pkeys.h            | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 59a2c7dbc78f..e70615a1da9b 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -143,9 +143,9 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
>  	return __arch_override_mprotect_pkey(vma, prot, pkey);
>  }
>  
> -extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +extern int __arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  				       unsigned long init_val);


> -static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +static inline int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  					    unsigned long init_val)
>  {
>  	if (!mmu_has_feature(MMU_FTR_PKEY))
> diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
> index 753e62ba67af..c048467669df 100644
> --- a/arch/powerpc/mm/book3s64/pkeys.c
> +++ b/arch/powerpc/mm/book3s64/pkeys.c
> @@ -333,7 +333,7 @@ static inline void init_iamr(int pkey, u8 init_bits)
>   * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
>   * specified in @init_val.
>   */
> -int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +int __arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  				unsigned long init_val)
>  {
>  	u64 new_amr_bits = 0x0ul;
> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 5292e6dfe2a7..48efb81f6cc6 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -9,7 +9,7 @@
>   */
>  #define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
>  
> -extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +extern int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  		unsigned long init_val);
>  
>  static inline bool arch_pkeys_enabled(void)
> @@ -115,7 +115,7 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
>  	return 0;
>  }
>  
> -extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +extern int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  		unsigned long init_val);
>  
>  static inline int vma_pkey(struct vm_area_struct *vma)
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 7c7824ae7862..db511bec57e5 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1068,7 +1068,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   * This will go out and modify PKRU register to set the access
>   * rights for @pkey to @init_val.
>   */
> -int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  			      unsigned long init_val)
>  {
>  	u32 old_pkru, new_pkru_bits = 0;
> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> index 86be8bf27b41..aa40ed2fb0fc 100644
> --- a/include/linux/pkeys.h
> +++ b/include/linux/pkeys.h
> @@ -35,7 +35,7 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>  	return -EINVAL;
>  }
>  
> -static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +static inline int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
>  			unsigned long init_val)
>  {
>  	return 0;
> -- 
> 2.35.1
