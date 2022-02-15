Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3526D4B75B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiBOTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:45:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiBOTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:45:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35D9748891;
        Tue, 15 Feb 2022 11:45:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2251480;
        Tue, 15 Feb 2022 11:45:46 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B178B3F70D;
        Tue, 15 Feb 2022 11:45:41 -0800 (PST)
Date:   Tue, 15 Feb 2022 19:45:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] perf: Expand perf_branch_entry.type
Message-ID: <YgwC0S846lBUBf51@FVFF77S0Q05N>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
 <Yfpxv9+TP9rP72wL@FVFF77S0Q05N>
 <6168f881-92a4-54f8-929a-c2f40a36c112@arm.com>
 <Yf1N/EWjlQ/bEA0D@FVFF77S0Q05N>
 <Ygv4cmO/zb3qO48q@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygv4cmO/zb3qO48q@robh.at.kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:01:06PM -0600, Rob Herring wrote:
> On Fri, Feb 04, 2022 at 04:02:04PM +0000, Mark Rutland wrote:
> > On Fri, Feb 04, 2022 at 10:25:24AM +0530, Anshuman Khandual wrote:
> > > On 2/2/22 5:27 PM, Mark Rutland wrote:
> > > > On Fri, Jan 28, 2022 at 11:14:13AM +0530, Anshuman Khandual wrote:
> > > >> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
> > > >>  		in_tx:1,    /* in transaction */
> > > >>  		abort:1,    /* transaction abort */
> > > >>  		cycles:16,  /* cycle count to last branch */
> > > >> -		type:4,     /* branch type */
> > > >> -		reserved:40;
> > > >> +		type:6,     /* branch type */
> > > > 
> > > > As above, is this a safe-change ABI-wise?
> > > 
> > > If the bit fields here cannot be expanded without breaking ABI, then
> > > there is a fundamental problem. Only remaining option will be to add
> > > new fields (with new width value) which could accommodate these new
> > > required branch types.
> > 
> > Unfortunately, I think expanding this does break ABI, and is a fundamental
> > problem, as:
> > 
> > (a) Any new values in the expanded field will be truncated when read by old
> >     userspace, and so those may be mis-reported. Maybe we're not too worried
> >     about this case.
> 
> 'type' or specfically branch stack is not currently supported on arm64. 
> Do we expect an old userspace which this didn't work on to start working 
> with a new kernel?

I agree for arm64 specifically this probably doesn't matter; I just wanted to
have a clear explanation of why this *could* be a problem, since this could
affect other architectures.

> Given at least some of the new types are arch specific, perhaps 
> the existing type field should get a new 'PERF_BR_ARCH_SPECIFIC' or 
> 'PERF_BR_EXTENDED' value (or use PERF_BR_UNKNOWN?) which means read a 
> new 'arch_type' field.

Yup; something of that shape sounds good to me -- that was roughly what I had
suggested elsewhere.

> Another option is maybe some of these additional types just shouldn't be 
> exposed to userspace? For example, are branches to FIQ useful or leaking 
> any info about secure world? Debug mode branches also seem minimally 
> useful to me (though I'm no expert in how this is used).

I agree; this wasn't clear to me, and regardless I think many of the types
added in the prior patch should not be generic since they're very specific to
the Arm architecture.

> > (b) Depending on how the field is placed, existing values might get stored
> >     differently. This could break any mismatched combination of
> >     {old,new}-kernel and {old,new}-userspace.
> > 
> >     In practice, I think this means that this is broken for BE, and happens to
> >     work for LE, but I don't know how bitfields are defined for each
> >     architecture, so there could be other brokenness.
> > 
> > Consider the test case below:
> 
> [...]
> 
> > ... where the low bits of the field have moved, and so this is broken even for
> > existing values!
> 
> So that is a separate issue to be fixed and not directly related to the 
> size of 'type'. 

I agree if you moved the entire field that's broken everywhere, but in this
case it *is* directly related to the size changing. In my example the meaning
of specific bits changed *because* the size of the field changed and in BE that
meant the low bits of the field moved, even though the field started at the
same position.

> Looks like it needs similar '#if 
> defined(__LITTLE_ENDIAN_BITFIELD)' treatment as some of the other struct 
> bitfields. Though somehow BE PPC hasn't had issues?

IIRC there were recent problems in this area, and I think historically we've
broken ABI and people only noticed much later.

Thanks,
Mark.
