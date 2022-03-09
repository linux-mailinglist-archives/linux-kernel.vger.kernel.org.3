Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B84D3B78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiCIU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbiCIU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:57:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB81433A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646859394; x=1678395394;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=NGpqxRLN4GD8V9dc3pB56PiFNqnFN5ebUg7uaCXzHGk=;
  b=Tv31yoQn1RsTkQrAEbrL+futIVzJwgL/4GZm0s4Pju3nO1qn5jAg8Ctg
   hfxWJ6EMAnWHBLWOyxtOjx9dgGeA4oz2h4ZekXiUkddcGCX1OzXE8MAQi
   D2yRVex4+lIfnLX++pavhztXBMkwDBzlYPRb4lj1JK5natn1mKKl3aC2+
   0gBiwikoXl7AM4OWWsAt0UYa4GS4TCM12D/uY+Fl3uW0wBqkGoWNyNO+k
   /5uG6QGL7wYvi6GXo/2mh45YXX7aN9qnBXDwlsogwG7MfLD9e8QqQJVBp
   0zAKGyed5rOQTbup9BM8XsC3nYk6a4Z6OEfpu5kqeqkmLirSEJkYPMsuk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341520164"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="341520164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:56:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642298288"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:56:33 -0800
Message-ID: <5202ac86-7438-eeae-61d7-23bf10b475f5@intel.com>
Date:   Wed, 9 Mar 2022 12:56:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-30-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 29/30] ACPICA: Avoid cache flush inside virtual machines
In-Reply-To: <20220302142806.51844-30-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:28, Kirill A. Shutemov wrote:
> WBINVD is not supported in TDX guest and triggers #VE. There's no robust
> way to emulate it. The kernel has to avoid it.

Not really.  It could just ignore any use of WBVIND.  That's why
hypervisors mostly do today.

> ACPI_FLUSH_CPU_CACHE() flushes caches usign WBINVD on entering sleep

					 ^ using
			
> states. It is required to prevent data loss.
> 
> While running inside virtual machine, the kernel can bypass cache
> flushing. Changing sleep state in a virtual machine doesn't affect the
> host system sleep state and cannot lead to data loss.

How's this?

Before entering sleep states, the ACPI code flushes caches to prevent
data loss using the WBINVD instruction.  This mechanism is required on
bare metal.

But, any use WBINVD inside of a guest is worthless.  Changing sleep
state in a virtual machine doesn't affect the host system sleep state
and cannot lead to data loss, so most hypervisors simply ignore it.
Despite this, the ACPI code calls WBINVD unconditionally anyway.  It's
useless, but also normally harmless.

In TDX guests, though, WBINVD stops being harmless; it triggers a
virtualization exception (#VE).  If the ACPI cache-flushing WBINVD were
left in place, TDX guests would need handling to recover from the exception.

Avoid using WBINVD whenever running under a hypervisor.  This both
removes the useless WBINVDs and saves TDX from implementing WBINVD handling.

> diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
> index 9aff97f0de7f..d937c55e717e 100644
> --- a/arch/x86/include/asm/acenv.h
> +++ b/arch/x86/include/asm/acenv.h
> @@ -13,7 +13,19 @@
>  
>  /* Asm macros */
>  
> -#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
> +/*
> + * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
> + * It is required to prevent data loss.
> + *
> + * While running inside virtual machine, the kernel can bypass cache flushing.
> + * Changing sleep state in a virtual machine doesn't affect the host system
> + * sleep state and cannot lead to data loss.
> + */
> +#define ACPI_FLUSH_CPU_CACHE()					\
> +do {								\
> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))	\
> +		wbinvd();					\
> +} while (0)
>  
>  int __acpi_acquire_global_lock(unsigned int *lock);
>  int __acpi_release_global_lock(unsigned int *lock);

