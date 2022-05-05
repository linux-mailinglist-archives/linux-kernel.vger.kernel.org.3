Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FC51C5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382280AbiEERIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiEERIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:08:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECF101C5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651770279; x=1683306279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ppnTDlnUiSAwVHOZZyIHx8ErJ3z/pXNJDcAfk/v+Bes=;
  b=OHIlLlBBpXHmaGOyin5ENaP2MbcXy8jUjDe5CGbP7kMpDgMjh+wK/3O9
   qgzOa6HWrXCGdS0Pre5kfWcRJA3XIDGNvkOju36+9w6AXB3lutplj8hzy
   AkHvmBGjtsnHbBnAqiacIkbr7ATWXVK96jkvTVA8zcHUDv2JjmaDxUEka
   milkU1/eQYwPRGGb6AnL1uw0T/cewNKxsVHD8apU1uk3EZ/4dhLLHZaXB
   Ji3K0Qn3oS9GdG0Wt9jNR4DdVgG825m+L+in819QJ2UmdktWXlxruf9DD
   dOrWvlBXQQWC6I2tuIDQ3dBgoCTw1xXheyni6R7xWN7DyFlG2Rup3xjiz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248720967"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248720967"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:04:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694753447"
Received: from evegaag-mobl1.amr.corp.intel.com (HELO [10.209.187.127]) ([10.209.187.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:04:35 -0700
Message-ID: <0b501f18-a6b8-1d9b-e72a-ea6cb33720a2@intel.com>
Date:   Thu, 5 May 2022 10:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] x86: Remove vendor checks from
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
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110140.453184-1-wyes.karny@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220505110140.453184-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 04:01, Wyes Karny wrote:
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	/* MWAIT is not supported on this platform. Fallback to HALT */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
> +		return 0;
> +
> +	/* Monitor has a bug. Fallback to HALT */
> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>  		return 0;
>  
> -	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
> +	if (c->cpuid_level < CPUID_MWAIT_LEAF)
>  		return 0;

First of all, thanks for all the detail in this new version of the patches!

In arch/x86/kernel/cpu/common.c, we have:

cpuid_dependent_features[] = {
        { X86_FEATURE_MWAIT,            0x00000005 },
	...

Shouldn't that clear X86_FEATURE_MWAIT on all systems without
CPUID_MWAIT_LEAF?  That would make the c->cpuid_level check above
unnecessary.

> +	/*
> +	 * If ECX doesn't have extended info about MWAIT,
> +	 * don't need to check substates.
> +	 */
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
> +		return 1;

Could you explain a bit more about this?  I don't know this CPUID leaf
off the top of my head and the line after this is checking EDX.  It's
not apparent from this comment why "!ECX_EXTENSIONS_SUPPORTED" means
that MWAIT should be preferred.

> +	/* Check, whether at least 1 MWAIT C1 substate is present */
> +	return (edx & MWAIT_C1_SUBSTATE_MASK);

