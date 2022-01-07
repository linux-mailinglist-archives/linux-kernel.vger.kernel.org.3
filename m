Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767E487381
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiAGHZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiAGHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:25:12 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C652C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:25:12 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y18so6076955iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dt5wFTIivnEVZNJ35QfigYoIPkloAu9LxIwiM8cfNlM=;
        b=KEUgoAw/F9G/n+DL3vPDPzqUuCnfnBzCRczFO16S99KbAcoAyrV9Vpb2AD74ahCjh8
         uf8VigJL/FmZUKO+jofCVvFOHZuM7q+xtWDz53MAO4BA0Mn2zHV0OH6UxkAKRJl5TaAY
         SUMPxqRnmW04h8A9GnZu7raeMdpapoBAMIqGKj4vLsfHIqnGc4ROdp9a0I4kXG2ahw9d
         XRUltLOLGcfkj+RMWNT+3kyWS7LdregbHr/zh8eNY6EorURFTH4Egx1INGlForVlX1BH
         p2w0dBHu+Ap8teOi/dGdqzp8u93hW6oyVDaMJTA4hopr+3AasJCRGO7TSKgwVQ4jSC74
         LOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dt5wFTIivnEVZNJ35QfigYoIPkloAu9LxIwiM8cfNlM=;
        b=R6E521im32dFumL0GadjY6F1OoQTeI8lLzy+G8uIapXTHC9+LXr3Ispc7tetSS6bQd
         lPAxmEIQY4w57fuMrumYqX04Zjqa35aR3HnqJ63Onmzj/1yrWuzcBwIouDnwgoxSLNb0
         nUw+7tYG0Pk0X4C54ktcSXChWpK0XIu/uatQ6gUmzd8SuD9x4gYgWukmMEXT8f+IcS9g
         mVSMGN3jCBquZXSVzjW7Ckce+R/LeGHEi1Z+O53KEwT1Gd4i8yvAPe/i0C+Ner0lFkEI
         6OtZ3qdxLGa+MVDZy/x/zGuxXZgphEVoJiGjtVWynLdkJavcW25GYG7i6/91KpJjC/C5
         5zbA==
X-Gm-Message-State: AOAM531WnYAoqs7Kg59Z7+lQp6NuWZQd4rL9y3GkL0Y5Llx+nybtkG0w
        Oopge4O5fM5hP43R8J112pWPbw==
X-Google-Smtp-Source: ABdhPJz3x1HWzD5i0AVExGboPsVu371NgLICgXvka4rbxX4XJLCTLcI+ZJ0R+n6BnSvFqM8bGhULrw==
X-Received: by 2002:a5e:9905:: with SMTP id t5mr26785346ioj.16.1641540311737;
        Thu, 06 Jan 2022 23:25:11 -0800 (PST)
Received: from google.com ([2620:15c:183:200:2e0a:5e5e:fac:e07b])
        by smtp.gmail.com with ESMTPSA id g1sm2528097ila.26.2022.01.06.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 23:25:11 -0800 (PST)
Date:   Fri, 7 Jan 2022 00:25:07 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <Ydfq051mnCeZjG3G@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-2-yuzhao@google.com>
 <20220105104526.GA3015@willie-the-truck>
 <YdYDzKvYbBwjfU3W@google.com>
 <20220106103009.GA4420@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106103009.GA4420@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:30:09AM +0000, Will Deacon wrote:
> On Wed, Jan 05, 2022 at 01:47:08PM -0700, Yu Zhao wrote:
> > On Wed, Jan 05, 2022 at 10:45:26AM +0000, Will Deacon wrote:
> > > On Tue, Jan 04, 2022 at 01:22:20PM -0700, Yu Zhao wrote:
> > > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > > index 870c39537dd0..56e4ef5d95fa 100644
> > > > --- a/arch/arm64/tools/cpucaps
> > > > +++ b/arch/arm64/tools/cpucaps
> > > > @@ -36,6 +36,7 @@ HAS_STAGE2_FWB
> > > >  HAS_SYSREG_GIC_CPUIF
> > > >  HAS_TLB_RANGE
> > > >  HAS_VIRT_HOST_EXTN
> > > > +HW_AF
> > > >  HW_DBM
> > > >  KVM_PROTECTED_MODE
> > > >  MISMATCHED_CACHE_TYPE
> > > 
> > > As discussed in the previous threads, we really don't need the complexity
> > > of the additional cap for the arm64 part. Please can you just use the
> > > existing code instead? It's both simpler and, as you say, it's equivalent
> > > for existing hardware.
> > > 
> > > That way, this patch just ends up being a renaming exercise and we're all
> > > good.
> > 
> > No, renaming alone isn't enough. A caller needs to disable preemption
> > before calling system_has_hw_af(), and I don't think it's reasonable
> > to ask this caller to do it on x86 as well.
> > 
> > It seems you really prefer not to have HW_AF. So the best I can
> > accommodate, considering other potential archs, e.g., risc-v (I do
> > plan to provide benchmark results on risc-v, btw), is:
> > 
> >   static inline bool arch_has_hw_pte_young(bool local)
> >   {
> > 	bool hw_af;
> > 
> >   	if (local) {
> >   		WARN_ON(preemptible());
> >   		return cpu_has_hw_af();
> >   	}
> >   
> > 	preempt_disable();
> >   	hw_af = system_has_hw_af();
> > 	preempt_enable();
> > 
> > 	return hw_af;
> >   }
> > 
> > Or please give me something else I can call without disabling
> > preemption, sounds good?
> 
> Sure thing, let me take a look. Do you have your series on a public git
> tree someplace?

Thanks!

This patch (updated) on Gerrit:
https://linux-mm-review.googlesource.com/c/page-reclaim/+/1500/1

And the entire series:
git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/08/1508/1
