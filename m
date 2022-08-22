Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943059BC46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiHVJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiHVJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:05:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92142ED4B;
        Mon, 22 Aug 2022 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWsB3a2GElxXD8l5gqgAM51j5OsBohLTMGRPFhEXfEU=; b=pbTHASZCDUS4YjjOv9eJsQnUcR
        2nBbGmRDgKBw5929GRTXdqmVYCagoL9OgLAd30QKEjodvx6SzsSE7X4+cPJ9mpkSXSa2JUThr7fgu
        8a1NBA1JgLWeXAN8bmPmnJA4oJpgRrypTHVaIiWd0aM78D8cH5OJaR7v02Q+THHdNL+rphAvI4ppf
        HTAGIKgxKD15H/pzOuNklzsihYc6lO5RFV6YbQJ51R8opY/kohnkvwGmBh7eXKWiXNEZ1d/r0xCj7
        V5JbHFUGNDtWS1vkbPtrPLtH/92uJVKPzx0mhed9qDN2/x/FifNltQ86yxATl6kleB9WeDwr9g2hS
        Gwpg5p7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ3N9-0052yi-Ek; Mon, 22 Aug 2022 09:05:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9651980BC2; Mon, 22 Aug 2022 11:05:25 +0200 (CEST)
Date:   Mon, 22 Aug 2022 11:05:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Message-ID: <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:42:23PM -0700, Stephane Eranian wrote:
> Hi,
> 
> On Mon, Aug 15, 2022 at 4:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Aug 11, 2022 at 05:59:52PM +0530, Sandipan Das wrote:
> > > CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new performance
> > > monitoring features for AMD processors.
> > >
> > > Bit 1 of EAX indicates support for Last Branch Record Extension Version 2
> > > (LbrExtV2) features. If found to be set during PMU initialization, the EBX
> > > bits of the same leaf can be used to determine the number of available LBR
> > > entries.
> > >
> > > For better utilization of feature words, LbrExtV2 is added as a scattered
> > > feature bit.
> > >
> > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > > ---
> > >  arch/x86/include/asm/cpufeatures.h | 2 +-
> > >  arch/x86/kernel/cpu/scattered.c    | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > > index 393f2bbb5e3a..e3fa476a24b0 100644
> > > --- a/arch/x86/include/asm/cpufeatures.h
> > > +++ b/arch/x86/include/asm/cpufeatures.h
> > > @@ -96,7 +96,7 @@
> > >  #define X86_FEATURE_SYSCALL32                ( 3*32+14) /* "" syscall in IA32 userspace */
> > >  #define X86_FEATURE_SYSENTER32               ( 3*32+15) /* "" sysenter in IA32 userspace */
> > >  #define X86_FEATURE_REP_GOOD         ( 3*32+16) /* REP microcode works well */
> > > -/* FREE!                                ( 3*32+17) */
> > > +#define X86_FEATURE_LBREXT_V2                ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> > >  #define X86_FEATURE_LFENCE_RDTSC     ( 3*32+18) /* "" LFENCE synchronizes RDTSC */
> > >  #define X86_FEATURE_ACC_POWER                ( 3*32+19) /* AMD Accumulated Power Mechanism */
> > >  #define X86_FEATURE_NOPL             ( 3*32+20) /* The NOPL (0F 1F) instructions */
> > > diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> > > index dbaa8326d6f2..6be46dffddbf 100644
> > > --- a/arch/x86/kernel/cpu/scattered.c
> > > +++ b/arch/x86/kernel/cpu/scattered.c
> > > @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
> > >       { X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> > >       { X86_FEATURE_MBA,              CPUID_EBX,  6, 0x80000008, 0 },
> > >       { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
> > > +     { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },
> > >       { 0, 0, 0, 0, 0 }
> > >  };
> >
> > Would LBR_V2 work at all? It being a new version already seems to imply
> > extention, no? Then again, I suppose there's an argument to be had for
> > avoiding confusion vs the Intel LBR thing.. Couldn't you have called
> > this BRS_V2 :-)
> >
> I believe it is called v2 because there was already a LBR in previous
> generations, however it

That's not the question; It's currently called LBREXT_V2, which is a bit
of a shit name. Then again LBR_V2 is too because AMD and Intel LBR are
quite different. So in that respect BRS_V2 would be an ever so much
better name.
