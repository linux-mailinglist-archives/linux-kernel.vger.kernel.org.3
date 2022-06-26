Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D655B024
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiFZIDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiFZIDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:03:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF013CC5;
        Sun, 26 Jun 2022 01:03:41 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25Q5r9Yq024522;
        Sun, 26 Jun 2022 08:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TNWSlpbsycXcSLb456Pz4qH8uAG5dWq9D4erlKr2t4s=;
 b=fJo2xWBwjpjtDrZzpCEmKT2Gp2aqkNXyeP9Gnr3/34LUX9XZMTWJxFvGp7UkspvC8gCi
 C2jEOzYfEtovNVXW0cF90YztHsRqebjdJVmDgzLuAPVajkYg7VHVbFlyav6BtkV0kmbr
 JhStWdoTVMRz7JD2wewpwDyBTzgnpaJC9AagC+cXqFiqyqEq0M+4bKNn/7esPGL80BXU
 b+OFxTfBTX0N8iPRCt4FQrppR5ZtHbXgqYv8H8qH02wT1zWYikTSeMRfaKzSt31UNW5u
 3Iww2CLVqtQ1AwoFgzeRd52yPzfPbGgCfsP29jCAEh2pXQboeSQHNesa988YsEnHt8t+ RA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxc1gxth4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 08:03:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25Q7of9t030929;
        Sun, 26 Jun 2022 08:03:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt08sc4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 08:03:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25Q83Qop22020376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 08:03:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25DA852050;
        Sun, 26 Jun 2022 08:03:26 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 91E805204F;
        Sun, 26 Jun 2022 08:03:25 +0000 (GMT)
Date:   Sun, 26 Jun 2022 10:03:24 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/3] jump_label: mips: move module NOP patching into
 arch code
Message-ID: <YrgSzHIZB6eTQ2M8@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220615154142.1574619-1-ardb@kernel.org>
 <20220615154142.1574619-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615154142.1574619-3-ardb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1ElMEBJImVhodnQI0tdEkvIctPogczDW
X-Proofpoint-ORIG-GUID: 1ElMEBJImVhodnQI0tdEkvIctPogczDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-25_11,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206260029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:41:41PM +0200, Ard Biesheuvel wrote:
> MIPS is the only remaining architecture that needs to patch jump label
> NOP encodings to initialize them at load time. So let's move the module
> patching part of that from generic code into arch/mips, and drop it from
> the others.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/mips/kernel/jump_label.c | 19 ++++++++++++++
>  arch/mips/kernel/module.c     |  5 ++--
>  arch/s390/kernel/module.c     |  1 -
>  arch/sparc/kernel/module.c    |  3 ---
>  arch/x86/kernel/module.c      |  3 ---
>  include/linux/jump_label.h    |  7 +----
>  kernel/jump_label.c           | 27 +-------------------
>  7 files changed, 24 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
> index 662c8db9f45b..e4c775e7c063 100644
> --- a/arch/mips/kernel/jump_label.c
> +++ b/arch/mips/kernel/jump_label.c
> @@ -88,3 +88,22 @@ void arch_jump_label_transform(struct jump_entry *e,
>  
>  	mutex_unlock(&text_mutex);
>  }
> +
> +#ifdef CONFIG_MODULE
> +void jump_label_apply_nops(struct module *mod)
> +{
> +	struct jump_entry *iter_start = mod->jump_entries;
> +	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> +	struct jump_entry *iter;
> +
> +	/* if the module doesn't have jump label entries, just return */
> +	if (iter_start == iter_stop)
> +		return;
> +
> +	for (iter = iter_start; iter < iter_stop; iter++) {
> +		/* Only write NOPs for arch_branch_static(). */
> +		if (jump_label_init_type(iter) == JUMP_LABEL_NOP)
> +			arch_jump_label_transform(iter, JUMP_LABEL_NOP);
> +	}
> +}
> +#endif
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 14f46d17500a..0c936cbf20c5 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -21,6 +21,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/jump_label.h>
>  
> +extern void jump_label_apply_nops(struct module *mod);
>  
>  struct mips_hi16 {
>  	struct mips_hi16 *next;
> @@ -428,8 +429,8 @@ int module_finalize(const Elf_Ehdr *hdr,
>  	const Elf_Shdr *s;
>  	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  
> -	/* Make jump label nops. */
> -	jump_label_apply_nops(me);
> +	if (IS_ENABLED(CONFIG_JUMP_LABEL))
> +		jump_label_apply_nops(me);
>  
>  	INIT_LIST_HEAD(&me->arch.dbe_list);
>  	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index 26125a9c436d..2d159b32885b 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -548,6 +548,5 @@ int module_finalize(const Elf_Ehdr *hdr,
>  #endif /* CONFIG_FUNCTION_TRACER */
>  	}
>  
> -	jump_label_apply_nops(me);
>  	return 0;
>  }
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index df39580f398d..66c45a2764bc 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -208,9 +208,6 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *me)
>  {
> -	/* make jump label nops */
> -	jump_label_apply_nops(me);
> -
>  	do_patch_sections(hdr, sechdrs);
>  
>  	/* Cheetah's I-cache is fully coherent.  */
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b98ffcf4d250..95b9cf25d4bd 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -304,9 +304,6 @@ int module_finalize(const Elf_Ehdr *hdr,
>  					    tseg, tseg + text->sh_size);
>  	}
>  
> -	/* make jump label nops */
> -	jump_label_apply_nops(me);
> -
>  	if (orc && orc_ip)
>  		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
>  				   (void *)orc->sh_addr, orc->sh_size);
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index bf1eef337a07..2003a0935478 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -230,12 +230,12 @@ extern void static_key_slow_inc(struct static_key *key);
>  extern void static_key_slow_dec(struct static_key *key);
>  extern void static_key_slow_inc_cpuslocked(struct static_key *key);
>  extern void static_key_slow_dec_cpuslocked(struct static_key *key);
> -extern void jump_label_apply_nops(struct module *mod);
>  extern int static_key_count(struct static_key *key);
>  extern void static_key_enable(struct static_key *key);
>  extern void static_key_disable(struct static_key *key);
>  extern void static_key_enable_cpuslocked(struct static_key *key);
>  extern void static_key_disable_cpuslocked(struct static_key *key);
> +extern enum jump_label_type jump_label_init_type(struct jump_entry *entry);
>  
>  /*
>   * We should be using ATOMIC_INIT() for initializing .enabled, but
> @@ -303,11 +303,6 @@ static inline int jump_label_text_reserved(void *start, void *end)
>  static inline void jump_label_lock(void) {}
>  static inline void jump_label_unlock(void) {}
>  
> -static inline int jump_label_apply_nops(struct module *mod)
> -{
> -	return 0;
> -}
> -
>  static inline void static_key_enable(struct static_key *key)
>  {
>  	STATIC_KEY_CHECK_USE(key);
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index b156e152d6b4..b1ac2948be79 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -508,7 +508,7 @@ void __init jump_label_init(void)
>  
>  #ifdef CONFIG_MODULES
>  
> -static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
> +enum jump_label_type jump_label_init_type(struct jump_entry *entry)
>  {
>  	struct static_key *key = jump_entry_key(entry);
>  	bool type = static_key_type(key);
> @@ -596,31 +596,6 @@ static void __jump_label_mod_update(struct static_key *key)
>  	}
>  }
>  
> -/***
> - * apply_jump_label_nops - patch module jump labels with arch_get_jump_label_nop()
> - * @mod: module to patch
> - *
> - * Allow for run-time selection of the optimal nops. Before the module
> - * loads patch these with arch_get_jump_label_nop(), which is specified by
> - * the arch specific jump label code.
> - */
> -void jump_label_apply_nops(struct module *mod)
> -{
> -	struct jump_entry *iter_start = mod->jump_entries;
> -	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> -	struct jump_entry *iter;
> -
> -	/* if the module doesn't have jump label entries, just return */
> -	if (iter_start == iter_stop)
> -		return;
> -
> -	for (iter = iter_start; iter < iter_stop; iter++) {
> -		/* Only write NOPs for arch_branch_static(). */
> -		if (jump_label_init_type(iter) == JUMP_LABEL_NOP)
> -			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
> -	}
> -}
> -
>  static int jump_label_add_module(struct module *mod)
>  {
>  	struct jump_entry *iter_start = mod->jump_entries;

To the common and s390 parts:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

FWIW, the change is not mips-only, thus Subject is not exactly correct.

> -- 
> 2.35.1
> 
