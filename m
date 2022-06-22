Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD3554EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359079AbiFVPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359014AbiFVPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:08:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB11186F2;
        Wed, 22 Jun 2022 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655910487; x=1687446487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zh0phUUpaFOeqqrnhE09SGS410LKWAC5CpTN1a7yln4=;
  b=ZWzzLnDuJyPkknFF+qVqyaJeA4B2VrnVbKgaiVnTY6zXWoujWtMkhbOh
   OAdOix7ALM8YrypojxkOXBBy8PRq0vy7CnLhPxR7UyDNJVs592T76Bt5H
   LfcDT1Rgar3h1npuWjGGYNbgJS0g4dFgV/N1pjzaQveGLKBLdgbXbLejH
   IgTr4s8tEWrsNANSmDJHVm8s09FlMEry/HhuVV5EK4r4n+AbtomAy3BEB
   kPCSodI2+hLKRv5g81UvXeMeWk+wpI4IHUhID7MjGEZ+/NiPcvar/22zF
   qkraGbKNJo1/gJzS+ZUdM5yK/Q5QTfSekQTxxwvpE+7CiIiMVwoRBNzWC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="342128826"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342128826"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:08:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677596572"
Received: from bshakya-mobl.amr.corp.intel.com (HELO [10.212.188.76]) ([10.212.188.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:08:04 -0700
Message-ID: <6f83722d-d402-ca68-7d3e-77dca14a794b@intel.com>
Date:   Wed, 22 Jun 2022 08:07:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] x86/cpuid: move filter_cpuid_features to cpuid-deps.c
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
 <20220622144820.751402-4-mlevitsk@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220622144820.751402-4-mlevitsk@redhat.com>
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

On 6/22/22 07:48, Maxim Levitsky wrote:
> No functional change intended.

It would be really nice to at least write a "why" sentence.  You wrote
the "what" (move code), but I have no idea why you are moving it.

>  arch/x86/kernel/cpu/common.c      | 46 -----------------------------
>  arch/x86/kernel/cpu/cpuid-deps.c  | 48 +++++++++++++++++++++++++++++++

That looks a wee bit odd for a code move.  Where did the 2 lines go?

> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index ea34cc31b0474f..3eb5fe0d654e63 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -147,6 +147,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  
>  extern void setup_clear_cpu_cap(unsigned int bit);
>  extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> +extern void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn);
>  
>  #define setup_force_cpu_cap(bit) do { \
>  	set_cpu_cap(&boot_cpu_data, bit);	\
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 4730b0a58f24a5..4cc79971d2d847 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -620,52 +620,6 @@ __noendbr void cet_disable(void)
>  		wrmsrl(MSR_IA32_S_CET, 0);
>  }
>  
> -/*
...
> -}
>  
>  /*
>   * Naming convention should be: <Name> [(<Codename>)]

One, by leaving extra whitespace.

> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index d6777d07ba3302..bcb091d02a754b 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -131,3 +131,51 @@ void setup_clear_cpu_cap(unsigned int feature)
>  {
>  	clear_cpu_cap(&boot_cpu_data, feature);
>  }
> +
> +
> +/*

Two, by adding extra whitespace.
