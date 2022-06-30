Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019295620C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiF3RCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiF3RCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:02:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CD25E82
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656608561; x=1688144561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtFeqhHInUlf1HTSI6nBel+ECuiX/g1xsby6AlpKuNM=;
  b=NeG6Ev+jcXKgXt/yQCH8W1ZTVmX4m/q8oL+nU5Nro4v2VptkG1BcXvDe
   1q060QJRSO5FVhDPguw7Houo0FfZHpjdZJccnKghtqmIF70tzVC+xw+DU
   lF2faQvAv+WNJ6JCtlJtha8OT5SPxk4O5pbTAgAic9O13JvnZCo2c8e6k
   I/qVrxFsuaz7bM8MzNZ0FG8pFQCZYsSpdUgtZEm5G1PDt+o8JLiMRoKwo
   3NEnVLF5EwTt+0CW2JCu1FxiianYYszggZTCS/zgM8blyuqiVCGVHzRfT
   /cKkUH2YMPJ1UbyZEsVrBWMq+5pX0SHAxupKNaDOOLqR8Mcaqx03vO/sY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346397713"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="346397713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 10:02:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="733705178"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 10:02:38 -0700
Date:   Thu, 30 Jun 2022 10:02:36 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] RAS/CEC: Reduce default threshold to offline a page to
 "2"
Message-ID: <Yr3XLMwYnRMa3Opw@agluck-desk3.sc.intel.com>
References: <20220607212015.175591-1-tony.luck@intel.com>
 <YrnBWjkX82OhXAtL@zn.tnic>
 <7da92773f7084c57814f7ef4d033bc53@intel.com>
 <Yrsleko0MnGtwaaR@zn.tnic>
 <8f580a2544d846c69c9941e151fa7cc3@intel.com>
 <Yr1MntoeRKAmkxAf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1MntoeRKAmkxAf@zn.tnic>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:11:26AM +0200, Borislav Petkov wrote:
> On Tue, Jun 28, 2022 at 04:51:49PM +0000, Luck, Tony wrote:
> > It fails to use the capabilities of h/w an Linux to avoid a fatal
> > error in the future. Corrected errors are (sometimes) a predictor of
> > marginal/aging memory. Copying data out of a failing page while there
> > are just corrected errors can avoid losing that whole page later.
> 
> Hm, for some reason you're trying to persuade me that 2 correctable
> errors per page mean that that location is going to turn into
> uncorrectable and thus all pages which get two CEs per 24h should
> immediately be offlined.

Yes. The cost to offline a page is low (4KB reduction in system capacity
on a system with 10's or 100's of GB memory). The risk to the system
if the page does develop an uncorected error is high (process is killed,
or system crashes).

> It might and it is commonly accepted that CEs in a DIMM could likely
> lead to UEs in the future but not necessarily. That DIMM could trigger
> those CEs for years and if the ECC function in the memory controller is
> good enough, it could handle those CEs and keep on going like nothing's
> happened.

The question is whether the default threshold should be "do I feel
lucky?" and those corrected errors are nothing to worry about. Or
"do I want to take the safe path?" and premptively offline pages
at the first sign of trouble.

> I.e., I'm not buying this unconditional 2 CEs/24h without any sensible
> proof. That "study" simply says that someone has done some evaluation
> and here's our short-term solution and you should accept it - no
> questions asked.
> 
> Hell, that study is even advocating the opposite:
> 
> "not all the faults (or the pages with the CE rate satisfying a certain
> condition) are equally prone to future UEs. The CE rate in the past
> period is not a good predictive indicator of future UEs."

It's a cost/risk tradeoff. I think the costs are so low and the risks
are so high that a low threshold is the right choice.

> So what you're doing is punishing DIMMs which can "wobble" this way with
> a couple of CEs for years without causing any issues otherwise.

Is there a study about "wobbly" DIMMs?

> > Explain further. Apart from the "ostrich" case I'm not sure what they
> > are.
> 
> Actually, you should explain why this drastic measure of only two
> correctable errors, all of a sudden?

We now have some real data. Instead of a "finger in the air guess" that
was made (on a different generation of DIMM technology ... the AMD paper
you reference below says DDR4 is 5.5x worse than DDR3).

> The most common failure in DIMMs is single-device failure, modern ECC
> schemes can handle those just fine. So what's up?

Second most common on DDR4 DIMMs is "row failure". Which current ECC
systems don't handle well.

> > It's far more a property of DIMMs than of the CPU. Unless AMD are
> > using some DECTED or better level of ECC for memory.
> 
> Well, it does the usual any number of bit flips in a single DRAM device
> ECC recovery:
> 
> https://www.amd.com/system/files/documents/advanced-memory-device-correction.pdf
> 
> And the papers quoted there basically say that the majority of failures
> are to single DRAM devices which the ECC scheme can handle just fine.
> 
> And the multiple DRAM devices failures are a very small percentage of
> all the failures.
> 
> Which makes me wonder even more why is your change needed at all?
> 
> I'd understand if this were some very paranoid HPC system doing very
> important computations and where it can't allow itself to suffer UEs so
> it'll go and proactively offline pages at the very first sign of trouble
> but the data says that the ECC scheme can handle single device failure
> just fine and those devices fail only very seldomly and after a loooong
> time.
> 
> So, if anything, your change should be Intel-only.

What AMD named "AMDC" looks the same as the trademarked feature Chipkill"
by IBM, and also implemented by Intel with various (less catchy) names
like ADDDC and DDDDC.  So everyone has some form of "advanced RAS" to
handle DRAM device failure.

But lets talk about "fail only very seldomly". For you and I with only a
handful of machines to worry about "very seldom" translates into "there
are many other more important things to worry about".

But look at the error rate for memory from the perspective of a medium
sized cloud service provider with 100,000 systems across a few data
centers. Say just 8 DIMMs per server, and 18 DRAM devices per DIMM
that's 14.4 million devices. Run 24x7 for a week (168 hours) and you
have clocked 2.4 billion device hours. The AMD paper says average
FIT rate for DDR4 DRAM is 248. So the expectation should be nearly 600
DRAM faults per week across all 100K systems.

While that's low from one perspective (0.6% servers affected) it's high
enough to be interesting to the CSP - because they lose revenue and
reputation when they have to tell their customers: "sorry the VM you
rented from us just crashed". Note that one physical system crashing
may take down dozens of VMs.

While anyone can tune the RAS_CEC threshold. The default value should
be something reasonable. I'm sticking with "2" being much more
reasonable default than 1023.

-Tony
