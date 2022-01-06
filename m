Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEF4862F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiAFKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:30:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49860 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiAFKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8990161B14;
        Thu,  6 Jan 2022 10:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35ADC36AE3;
        Thu,  6 Jan 2022 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641465017;
        bh=AEUEKRvg76KMQjAE75Y8qZ3DdjJA0ls98F6fkt74Q3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgnoiHBfsRG62UCju9J4NqZLmn02Wcr/KkvJ8+Qf3PIMVLGW1rTDjMgOoshmufJtb
         W8GLzzI7B47KdR1gK4b6ElugYeccp2hnOJQ+3ppmP8p/uRK+Jpl6lwB09dZ0u6rTLQ
         xHAjldNujXTEDHk56AuI1kPFjWIlSGL55ns/UUxslkW3G8wAVGKympfcAbxpxDkNFe
         Q6x5Q2+AOEUdO8vFybJ+IrbBQTjVCH6bKRUsxEluX/jgsGPQvNqCCFpTmTZqatEh7r
         LGHdpEDt91JbfoBEkQy64onOX3vlxqcmYkeqQZdDesILBsuvT011Rb3T0JEaOzdRiM
         hXvXxlvbomx4A==
Date:   Thu, 6 Jan 2022 10:30:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 1/9] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20220106103009.GA4420@willie-the-truck>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-2-yuzhao@google.com>
 <20220105104526.GA3015@willie-the-truck>
 <YdYDzKvYbBwjfU3W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdYDzKvYbBwjfU3W@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:47:08PM -0700, Yu Zhao wrote:
> On Wed, Jan 05, 2022 at 10:45:26AM +0000, Will Deacon wrote:
> > On Tue, Jan 04, 2022 at 01:22:20PM -0700, Yu Zhao wrote:
> > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > index 870c39537dd0..56e4ef5d95fa 100644
> > > --- a/arch/arm64/tools/cpucaps
> > > +++ b/arch/arm64/tools/cpucaps
> > > @@ -36,6 +36,7 @@ HAS_STAGE2_FWB
> > >  HAS_SYSREG_GIC_CPUIF
> > >  HAS_TLB_RANGE
> > >  HAS_VIRT_HOST_EXTN
> > > +HW_AF
> > >  HW_DBM
> > >  KVM_PROTECTED_MODE
> > >  MISMATCHED_CACHE_TYPE
> > 
> > As discussed in the previous threads, we really don't need the complexity
> > of the additional cap for the arm64 part. Please can you just use the
> > existing code instead? It's both simpler and, as you say, it's equivalent
> > for existing hardware.
> > 
> > That way, this patch just ends up being a renaming exercise and we're all
> > good.
> 
> No, renaming alone isn't enough. A caller needs to disable preemption
> before calling system_has_hw_af(), and I don't think it's reasonable
> to ask this caller to do it on x86 as well.
> 
> It seems you really prefer not to have HW_AF. So the best I can
> accommodate, considering other potential archs, e.g., risc-v (I do
> plan to provide benchmark results on risc-v, btw), is:
> 
>   static inline bool arch_has_hw_pte_young(bool local)
>   {
> 	bool hw_af;
> 
>   	if (local) {
>   		WARN_ON(preemptible());
>   		return cpu_has_hw_af();
>   	}
>   
> 	preempt_disable();
>   	hw_af = system_has_hw_af();
> 	preempt_enable();
> 
> 	return hw_af;
>   }
> 
> Or please give me something else I can call without disabling
> preemption, sounds good?

Sure thing, let me take a look. Do you have your series on a public git
tree someplace?

Cheers,

Will
