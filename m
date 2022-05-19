Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586DE52D9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiESQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiESQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:00:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52EA0D01
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652976034; x=1684512034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d0+Q8tZ0yi3/2AaQVtmSSJxoJMdSkTRdXPxoNfmt8PY=;
  b=i4fGDU9VeNJIOSZizdC+PIu5QUK0aocMtjsIL0jTdXhSs3u8aspDdfVs
   /GzkS5hVqdfYHA8UA/wSjBQe/rbnaW6USb5WyWmOkWCe0K9ZgXrBLeKC3
   v467jDZLmABviFJ/1miIMzjI/UXyepIpQtTiJbgPBf8jFh6tPodi8Hb8z
   W7wJwISmr7PD9F1F+OlGD6sqMB5u7Z6B/lOprRT9E1OfVX5N67owAqNr/
   Oy+l90ylTPZQPG6jx+B/ghjeYdK8NjLuKOY6XtWpMyvLMHD2JO28mKBug
   h4FIu0Tt9fX/CamR+2EzXB8ClUeMSXG3r9Rq1t/NJRDIBJaTSF/bL/m8M
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="332881403"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="332881403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 09:00:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="606555168"
Received: from rlsharma-mobl.amr.corp.intel.com (HELO [10.212.180.228]) ([10.212.180.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 09:00:33 -0700
Message-ID: <b1c9fd6c-9f00-9662-d590-b52ce26d0aca@intel.com>
Date:   Thu, 19 May 2022 09:00:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
 <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 03:18, Wyes Karny wrote:
>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>  {
> +	u32 eax, ebx, ecx, edx;
> +
>  	/* User has disallowed the use of MWAIT. Fallback to HALT */
>  	if (boot_option_idle_override == IDLE_NOMWAIT)
>  		return 0;
>  
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	/* MWAIT is not supported on this platform. Fallback to HALT */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
>  		return 0;
>  
> -	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
> +	/* Monitor has a bug. Fallback to HALT */
> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>  		return 0;

So, before, we pretty much just assume that all Intel CPUs with MWAIT
should use MWAIT C1.

> -	return 1;
> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> +
> +	/*
> +	 * If MWAIT extensions are not available, it is safe to use MWAIT
> +	 * with EAX=0, ECX=0.
> +	 */
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
> +		return 1;
> +
> +	/*
> +	 * If MWAIT extensions are available, there should be least one
> +	 * MWAIT C1 substate present.
> +	 */
> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
>  }
So, I guess the "If MWAIT extensions are not available" check is
consistent with the "always use it on Intel" behavior.

But, this would change the behavior on Intel systems that both have
CPUID5_ECX_EXTENSIONS_SUPPORTED and do not set bits in
MWAIT_C1_SUBSTATE_MASK.

Is that a problem or an improvement?
