Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1933554E16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358765AbiFVO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358888AbiFVO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389636308;
        Wed, 22 Jun 2022 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655909912; x=1687445912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KIu2os6/xgxh1AGNcBH9yuG71tpVxfYaQBSW95DqGr4=;
  b=C4XyESYxUSG8tTbzYSa4fxCwWkfyyZqvnaz6x1lyuIJJPhPlQF/57Be2
   HiYxWguRw2/Uhhnd4UF4/HWZ/dFmyZf9c42ShxRPyinYDRfvOABBCIY0F
   xMs0SyDIggImV3qlHT2KCHbkBxWRGMaWnPTiMYfF2uKJYBjlL2BVWy87B
   ZwQUxZ1Gt4KptoQjjAWglXIfsNsKi/C1Dv30uNfZBiS8jgDeWqsPjn+WI
   hJr1rBQKPb2SZGSfbW0pn/8uF4TjUdlgEyaxe3YiCMSThxa3W9Jm7zpMj
   zLpF2NewiW8vX/iYLCftyHv+CeuHfSD897TKqCXrDmO5qwHIjAle4f2RT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366760359"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="366760359"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677591901"
Received: from bshakya-mobl.amr.corp.intel.com (HELO [10.212.188.76]) ([10.212.188.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:58:30 -0700
Message-ID: <84c84de9-f5f1-1f8c-fa7c-6a416ea3373e@intel.com>
Date:   Wed, 22 Jun 2022 07:58:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] perf/x86/intel/lbr: use setup_clear_cpu_cap instead
 of clear_cpu_cap
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
        Paolo Bonzini <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
 <20220622144820.751402-2-mlevitsk@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220622144820.751402-2-mlevitsk@redhat.com>
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
> clear_cpu_cap(&boot_cpu_data) is very similar to setup_clear_cpu_cap
> except that the latter also sets a bit in 'cpu_caps_cleared' which
> later clears the same cap in secondary cpus, which is likely
> what is meant here.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Seems like a:

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")

would be in order.

Kan, does this change look right to you?

>  arch/x86/events/intel/lbr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 13179f31fe10fa..b08715172309a7 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1860,7 +1860,7 @@ void __init intel_pmu_arch_lbr_init(void)
>  	return;
>  
>  clear_arch_lbr:
> -	clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
> +	setup_clear_cpu_cap(X86_FEATURE_ARCH_LBR);
>  }
>  
>  /**

