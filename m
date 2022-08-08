Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2658CFDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbiHHVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiHHVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:43:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5C6369
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659995032; x=1691531032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Boi/Zh6eXcW5/t2n1fgKkv3ji9kPw/7kfpHBq9bj9g=;
  b=l9jN1dLwPTNVb/I60zKciSVOiJPOvqlATqKWyHxq3HQnqiZkseta1oLd
   R+eMY96pTympjhBSGY2+Di+vLPueu2nUKfv3hf0DodfTNBfh7nC6Rlwwg
   WHrXfr4FT+12wjqcHyqKPhX+pjwVBS5uAc/t4FXEUCbKj2DoHSZRPbVq8
   zW5iillTTa3Z+TaVsfFgTPnm+DLxXRoPrF+0thZNd8wlWyPfbm4WCnKUI
   v5K3/kqn2zv6nq5orJTQDv9628svf1eWkhgNinJZlShH87P8c1LYhJvTg
   wmoY/yzeJIfohyAQLg72kcEvwlz8oyK/IVtMd1BLHQEo4Caq/J1j92F2D
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="376990031"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376990031"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:43:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="555088663"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO [10.212.251.15]) ([10.212.251.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:43:50 -0700
Message-ID: <50599c3c-eacb-7774-746c-021adf3f56e3@intel.com>
Date:   Mon, 8 Aug 2022 14:43:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 10:16, Tom Lendacky wrote:
...
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b8357d6ecd47..6f7268a817fc 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -107,7 +107,7 @@ enum psc_op {
>  #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
>  
>  /* SNP Page State Change NAE event */
> -#define VMGEXIT_PSC_MAX_ENTRY		253
> +#define VMGEXIT_PSC_MAX_ENTRY		64

In general, the stack-based allocation looks fine.  It might be worth a
comment in there to make it clear that this can consume stack space.

>  struct psc_hdr {
>  	u16 cur_entry;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c05f0124c410..275aa890611f 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -66,6 +66,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb *boot_ghcb __section(".data");
>  
> +/* Flag to indicate when the first per-CPU GHCB is registered */
> +static bool ghcb_percpu_ready __section(".data");

So, there's a code path that can't be entered until this is set?  Seems
like the least we can do it annotate that path with a
WARN_ON_ONCE(!ghcb_percpu_ready).

Also, how does having _one_ global variable work for indicating the
state of multiple per-cpu structures?  The code doesn't seem to delay
setting this variable until after _all_ of the per-cpu state is ready.

>  /* Bitmap of SEV features supported by the hypervisor */
>  static u64 sev_hv_features __ro_after_init;
>  
> @@ -660,7 +663,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>  	}
>  }
>  
> -static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
> +static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
>  {
>  	unsigned long paddr_end;
>  	u64 val;
> @@ -868,11 +871,16 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>  static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>  {
>  	unsigned long vaddr_end, next_vaddr;
> -	struct snp_psc_desc *desc;
> +	struct snp_psc_desc desc;
> +
> +	/*
> +	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
> +	 * since vmgexit_psc() uses the per-CPU GHCB.
> +	 */
> +	if (!ghcb_percpu_ready)
> +		return early_set_pages_state(__pa(vaddr), npages, op);
>  
> -	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> -	if (!desc)
> -		panic("SNP: failed to allocate memory for PSC descriptor\n");
> +	memset(&desc, 0, sizeof(desc));

Why is this using memset()?  The compiler should be smart enough to
delay initializing 'desc' until after the return with this kind of
construct:

	struct snp_psc_desc desc = {};
	if (foo)
		return;
	// use 'desc' here

The compiler *knows* there is no access to 'desc' before the if().


>  	vaddr = vaddr & PAGE_MASK;
>  	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> @@ -882,12 +890,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
>  		next_vaddr = min_t(unsigned long, vaddr_end,
>  				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
>  
> -		__set_pages_state(desc, vaddr, next_vaddr, op);
> +		__set_pages_state(&desc, vaddr, next_vaddr, op);
>  
>  		vaddr = next_vaddr;
>  	}
> -
> -	kfree(desc);
>  }
>  
>  void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
> @@ -1254,6 +1260,8 @@ void setup_ghcb(void)
>  		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  			snp_register_per_cpu_ghcb();
>  
> +		ghcb_percpu_ready = true;
> +
>  		return;
>  	}
>  

