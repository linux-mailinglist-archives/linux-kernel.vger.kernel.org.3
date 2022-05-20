Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384E52EF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351083AbiETPqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351243AbiETPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:46:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02395AA64
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653061573; x=1684597573;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwAQQFiNniZWQWykR1w1dfYJzoYw0slCncYbLV54olY=;
  b=T+J2/RxehLqR0PW2GpUHN+F6xJcLuOa5YCTaE5WrDIY5ReVoRo4GZVGR
   /QHKyHYjtQZehDkJS404LKLwwFbX7erdiMDgOZ8G4bUAH6ZTJ3O8NG7An
   /M7eRmp9TpDB1mbL2LfRfJO2AxXEmMly41NVDZOAJFHKTOfJWSJk4y0ib
   m1e0sUSzvUu/7ozKe1Avj+BpkMBIEk6VgWTdy7AZSb/jvyiD9BzcWwOYl
   Dqlack21FeWtAnwmT4qz4Suw4KFegom86JxZQKsFRSYSQb8fkGn6AXraG
   qNSCNddDh26ORtnaBZVRHsfWrFMtF6UEHMvLR2tndkCTcneAApDkFyPKJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270224197"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="270224197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715579968"
Received: from yyan7-mobl1.ccr.corp.intel.com ([10.255.31.53])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:46:03 -0700
Message-ID: <43da52e2c07f56f548a6543b7d15bcd4b192cfbf.camel@intel.com>
Subject: Re: [PATCH v3 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Fri, 20 May 2022 23:46:01 +0800
In-Reply-To: <410f36ccecb36644e196d71fef6e46bdc186b409.camel@intel.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
         <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
         <b1c9fd6c-9f00-9662-d590-b52ce26d0aca@intel.com>
         <410f36ccecb36644e196d71fef6e46bdc186b409.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 21:43 +0800, Zhang Rui wrote:
> On Thu, 2022-05-19 at 09:00 -0700, Dave Hansen wrote:
> > On 5/10/22 03:18, Wyes Karny wrote:
> > >  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86
> > > *c)
> > >  {
> > > +	u32 eax, ebx, ecx, edx;
> > > +
> > >  	/* User has disallowed the use of MWAIT. Fallback to HALT */
> > >  	if (boot_option_idle_override == IDLE_NOMWAIT)
> > >  		return 0;
> > >  
> > > -	if (c->x86_vendor != X86_VENDOR_INTEL)
> > > +	/* MWAIT is not supported on this platform. Fallback to HALT */
> > > +	if (!cpu_has(c, X86_FEATURE_MWAIT))
> > >  		return 0;
> 
> I'm new to x86 code, a dumb question, what about the other vendors?
> with this patch, prefer_mwait_c1_over_halt() can return 1 for other
> vendors as well?
> 
> > >  
> > > -	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
> > > boot_cpu_has_bug(X86_BUG_MONITOR))
> > > +	/* Monitor has a bug. Fallback to HALT */
> > > +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
> > >  		return 0;
> > 
> > So, before, we pretty much just assume that all Intel CPUs with
> > MWAIT
> > should use MWAIT C1.
> > 
> > > -	return 1;
> > > +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> > > +
> > > +	/*
> > > +	 * If MWAIT extensions are not available, it is safe to use
> > > MWAIT
> > > +	 * with EAX=0, ECX=0.
> > > +	 */
> > > +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
> > > +		return 1;
> > > +
> > > +	/*
> > > +	 * If MWAIT extensions are available, there should be least one
> > > +	 * MWAIT C1 substate present.
> > > +	 */
> > > +	return (edx & MWAIT_C1_SUBSTATE_MASK);
> > >  }
> > 
> > So, I guess the "If MWAIT extensions are not available" check is
> > consistent with the "always use it on Intel" behavior.
> > 
> > But, this would change the behavior on Intel systems that both have
> > CPUID5_ECX_EXTENSIONS_SUPPORTED and do not set bits in
> > MWAIT_C1_SUBSTATE_MASK.
> > 
> > Is that a problem or an improvement?
> 
> At least Intel processors since Nehalem have MWAIT C1 support.
> For elder ones, need to confirm with Len.
> 
> When no bits set in MWAIT_C1_SUBSTATE_MASK, it means MWAIT C1 is not
> available for some reason, let me check if I can make this happen or
> not in real life.

I tried an Icelake server and a whiskeylake client, the supported
cstates in CPUID(5) edx doesn't change when a specific cstate or all
cstates are enabled/disabled in BIOS.

So there are always bits set in MWAIT_C1_SUBSTATE_MASK, and this patch
doesn't make any change to these Intel processors that have MWAIT C1
support.

thanks,
rui


