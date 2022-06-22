Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EA554EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359018AbiFVPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbiFVPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:07:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EBA393F7;
        Wed, 22 Jun 2022 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655910471; x=1687446471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=spGuvBmrzu5CQX1DEn7d16VfVTAFMeRLkLyRMCTgqtI=;
  b=mIv24N/h1ry+ejUcipwuX0mrP4sXGlRLO3JloZ0FeZy8zbgYRUP2skWY
   mQmrLK4o7rzGfG11aLljLKsZtUrU9SPmDm0q3PX/X0yrZrFL0PfTgLsaf
   So/i93RKq3+CdXobkcm1TBKJW/1sIw2AaxvsFBtNorXi5yGKM9ZJCteZZ
   VTzAEnEkptI7LWlEK2n4RWgUYSKi24E5UO48SyLX/UMYvmm3SLQgahCpC
   Pf+dJmirTGVaFgVRfNM85HU57vFa8f/WV6MxuD5KRoznh3EFSP+KvZDfJ
   KcKU1+TfAz74BduG1FnFLGWqELn3Mze5OhcPoPAmyrMxiC5Nu712u57aC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366763810"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="366763810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:07:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="677596461"
Received: from bshakya-mobl.amr.corp.intel.com (HELO [10.212.188.76]) ([10.212.188.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:07:49 -0700
Message-ID: <677c46db-02ef-24b8-c25f-762b41fb8bdb@intel.com>
Date:   Wed, 22 Jun 2022 08:07:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] x86/cpuid: refactor setup_clear_cpu_cap/clear_feature
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
 <20220622144820.751402-3-mlevitsk@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220622144820.751402-3-mlevitsk@redhat.com>
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
> Simplify the code a bit by always passing &boot_cpu_data
> in case the setup_clear_cpu_cap was called.
> 
> Also unify clear_cpu_cap and do_clear_cpu_cap.

Please always add a "()" suffix to functions.  "foo" is a variable, but
"foo()" is a function.

I also really like when a changelog has a clear problem statement.  I
_think_ the problem here is something along the lines of the 'c'
argument to clear_feature() having different behavior when it is NULL
versus '&boot_cpu_data'.

Basically, there's no reason to support clearing a bit in
'&boot_cpu_data' without also setting that bit in 'cpu_caps_cleared'.
>  {
> -	do_clear_cpu_cap(NULL, feature);
> +	clear_cpu_cap(&boot_cpu_data, feature);
>  }

