Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE96554F95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357795AbiFVPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358974AbiFVPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:40:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035E2E6A4;
        Wed, 22 Jun 2022 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655912447; x=1687448447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XRv7WIIIaL148PgNEUbb+gM+rHVPsb681+eLBnV7MAk=;
  b=eH/+SOVylhugFlaB4oZhBJh8TjRYCT5kgqjRb9nuChhctNbnmCd7f+H4
   0m9UJY2g1XvdwwjjTu0pw+VB4jnKByoLBueR3Tp310JJ+wBxVppsxl8ON
   FX4WANGB4cPUF0tBbEk3HoiwJ3sm9eGQ1oUZtcexplaFIwcs+qlgVbcGC
   YePt+daUltUsfhactiuJfXUVz6LK+HIgQPLwGZ8QErObRdlsMluabyo6n
   z3RrMFafcQgbBqtne/7/yzVHprEcdgDP1XaXezhQsewjcuqXDfrSovc1w
   6BcIfcH+z6C2P23mi5mNPdnFNioUZd3snd/5oD2N+bDdoQ0cLvM5srMcS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280497603"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280497603"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:32:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677607283"
Received: from bshakya-mobl.amr.corp.intel.com (HELO [10.212.188.76]) ([10.212.188.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:32:56 -0700
Message-ID: <c271cbf5-dfb5-c3dd-002b-9a358c90e984@intel.com>
Date:   Wed, 22 Jun 2022 08:32:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] x86/cpuid: check for dependencies violations in CPUID
 and attempt to fix them
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
 <20220622144820.751402-5-mlevitsk@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220622144820.751402-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 07:48, Maxim Levitsky wrote:
> Due to configuration bugs, sometimes a CPU feature is disabled in CPUID,
> but not features that depend on it.
> 
> While the above is not supported, the kernel should try to not crash,
> and clearing the dependent cpu caps is the best way to do it.

That's a rather paltry changelog.

If I remember correctly, there's a crystal clear problem:

	If a CPU enumerates support for AVX2 but AVX via CPUID, the
	kernel crashes.

There's also a follow-on problem.  The kernel has all the data it needs
to fix this, but just doesn't consult it:

	To make matters worse, the kernel _knows_ that this is an ill-
	advised situation: The kernel prevents itself from clearing the
	software representation of the AVX CPUID bit without also
	clearing AVX2.

	But, the kernel only consults this knowledge when it is clearing
	cpu_cap bits.  It does not consult this information when it is
	populating those cpu_cap bits.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 4cc79971d2d847..c83a8f447d6aed 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1469,7 +1469,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  			this_cpu->c_early_init(c);
>  
>  		c->cpu_index = 0;
> -		filter_cpuid_features(c, false);
> +		filter_cpuid_features(c, true);
>  
>  		if (this_cpu->c_bsp_init)
>  			this_cpu->c_bsp_init(c);
> @@ -1757,7 +1757,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	 */
>  
>  	/* Filter out anything that depends on CPUID levels we don't have */
> -	filter_cpuid_features(c, true);
> +	filter_cpuid_features(c, false);
>  
>  	/* If the model name is still unset, do table lookup. */
>  	if (!c->x86_model_id[0]) {

While we're at it, could we please rid ourselves of this unreadable
mystery true/false gunk?

> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index bcb091d02a754b..6d9c0e39851805 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -94,6 +94,11 @@ static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
>  		set_bit(feature, (unsigned long *)cpu_caps_cleared);
>  }
>  
> +static inline bool test_feature(struct cpuinfo_x86 *c, unsigned int feature)
> +{
> +	return test_bit(feature, (unsigned long *)c->x86_capability);
> +}
> +
>  /* Take the capabilities and the BUG bits into account */
>  #define MAX_FEATURE_BITS ((NCAPINTS + NBUGINTS) * sizeof(u32) * 8)
>  
> @@ -127,6 +132,7 @@ void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
>  	} while (changed);
>  }
>  
> +
>  void setup_clear_cpu_cap(unsigned int feature)

More superfluous whitespace.

>  {
>  	clear_cpu_cap(&boot_cpu_data, feature);
> @@ -137,6 +143,10 @@ void setup_clear_cpu_cap(unsigned int feature)
>   * Some CPU features depend on higher CPUID levels, which may not always
>   * be available due to CPUID level capping or broken virtualization
>   * software.  Add those features to this table to auto-disable them.
> + *
> + * Also due to configuration bugs, some CPUID features might be present
> + * while CPUID features that they depend on are not present,
> + * e.g a AVX2 present but AVX is not present.
>   */
>  struct cpuid_dependent_feature {
>  	u32 feature;
> @@ -151,9 +161,10 @@ cpuid_dependent_features[] = {
>  	{ 0, 0 }
>  };
>  
> -void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
> +void filter_cpuid_features(struct cpuinfo_x86 *c, bool early)
>  {

I have at least an inkling what 'warn' could mean.  But, 'early'?  One
man's 'early' is another one's 'late'.

>  	const struct cpuid_dependent_feature *df;
> +	const struct cpuid_dep *d;
>  
>  	for (df = cpuid_dependent_features; df->feature; df++) {
>  
> @@ -172,10 +183,22 @@ void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
>  			continue;
>  
>  		clear_cpu_cap(c, df->feature);
> -		if (!warn)
> +		if (early)
>  			continue;

Why is it that 'early' calls don't want warnings?

>  		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
>  			x86_cap_flag(df->feature), df->level);
>  	}
> +
> +	for (d = cpuid_deps; d->feature; d++) {
> +
> +		if (!test_feature(c, d->feature) || test_feature(c, d->depends))
> +			continue;
> +
> +		clear_feature(c, d->feature);
> +
> +		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, because it depends on "
> +			X86_CAP_FMT " which is not supported in CPUID\n",
> +			x86_cap_flag(d->feature), x86_cap_flag(d->depends));
> +	}
>  }

The do_clear_cpu_cap() does this with a loop, presumably because a later
(higher index in the array) feature in cpuid_deps[] could theoretically
clear an earlier (lower index) feature.

Also, is that message strictly correct?  There might have been a
clearcpuid= argument or even another dependency that ended up clearing a
bit.  It might have nothing to do with CPUID itself.
