Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C131151FE71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiEINkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiEINkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:40:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236E34672
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652103387; x=1683639387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvznECsuLkK6RXnOeA6Ax0m0ofe4wfy3oTmtVcMDJIo=;
  b=GNTyz5+0V/cBVk7JAFhQgu30dpvhSgoc5TBiGSfN40duvGUBfbAqbg/d
   sxzVNcGFhmMIxF/2nltpLUnzrh8vRPBNbJY1ppSzB7wRJxptOl+auT9NE
   h+wM01o4yGt+rfJxg+RfZRlFHLlpW5xp/bjrkIQ3fOVVMXgzQ7FJ+4J6J
   KCTW/i19WhXwhWblW3Xd06GwjrR7dK1+awDCtLSUrxjygl0o23WSHd6K6
   n0qH3WvKq0tS1884Ns2DLJ8OavE/5NNxUeoIcasiTgpCaolcUu4srvQUJ
   FyXTu89HvsT9zpeTM0TQD07K08ONOT+8eidWUxlDGjvBAQVBYmvFPACcy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="267891049"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="267891049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="738168423"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2022 06:36:22 -0700
Date:   Mon, 9 May 2022 21:36:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
Message-ID: <20220509133622.GE40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
 <20220509071652.GE76023@worktop.programming.kicks-ass.net>
 <20220509073003.GB40730@shbuild999.sh.intel.com>
 <87h75zrpmh.ffs@tglx>
 <20220509112235.GD40730@shbuild999.sh.intel.com>
 <87levarh7m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87levarh7m.ffs@tglx>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:03:25PM +0200, Thomas Gleixner wrote:
> Feng,
> 
> On Mon, May 09 2022 at 19:22, Feng Tang wrote:
> > On Mon, May 09, 2022 at 12:01:42PM +0200, Thomas Gleixner wrote:
> >> > This option is more like a way to double-check the correctness of
> >> > tsc-freq got from MSR/CPUID(0x15).
> >> 
> >> If at all it's a workaround for the inability and ignorance of firmware
> >> people. The crystal frequency and the TSC/crystal ratio _are_ known to
> >> the system designer and firmware people. It's really not asked too much
> >> to put the correct values into CPUID(0x15) and have proper quality
> >> control to ensure the correctness.
> >> 
> >> The whole argument about early firmware and pre-production hardware is
> >> bogus. It's 2022 and we are debating this problem for more than a decade
> >> now and still hardware and firmware people think they can do what they
> >> want and it all can be "fixed" in software. It's not rocket science to
> >> get this straight.
> >  
> > I completely understand it, as we've also suffered a lot from such
> > problems. This patch doesn't change any current work flow, and it simply
> > calibrates and prints out the freq info (warn if there is big deviation).
> > It acctually provides SW guys a quick way to argue with HW/FW people:
> > "See! You've given us a wrong number, please fix it", otherwise I heard
> > there was customer long ago  who used atomic clock to prove the
> > deviation.
> 
> Then please say clearly in the changelog what this is about.
> 
>  "Currently when HW provides the tsc freq info through MSR or
>   CPUID(0x15), the info will be taken as the 'best guess', and kernel
>   will set the X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer
>   based recalibration, which works pretty well.
> 
>   And there is still very few corner case that the freq info is not
>   accurate enough will small deviation from the actual value, like on
>   a product with early version (fix needed) of firmware or some
>   pre-production hardware.
> 
>   Add..."
> 
> versus:
> 
>  "The kernel assumes that the TSC frequency which is provided by the
>   hardware / firmware via MSRs or CPUID(0x15) is correct after applying
>   a few basic consistency checks. This disables the TSC recalibration
>   against HPET or PM timer.
> 
>   As a result there is no mechanism to validate that frequency in cases
>   where a firmware or hardware defect is suspected.
> 
>   Add..."
> 
> Can you spot the difference in intention? The first one sounds like:
> 
>     We need to tolerate the hardware/firmware induced crap.
> 
> The second one says:
> 
>     Provide a mechanism to validate because we cannot trust hardware /
>     firmware.
> 
> Hmm?

I see now. My commit log was ambiguous and didn't state clearly what
was the real problem and what we want to achieve. 

Many thanks for rewording! will use it as commit log in the next spin.

> >> Aside of that HPET has become unrealiable and PM timer is not guaranteed
> >> to be there either. So we really do not need a mechanism to enforce
> >> recalibration against something which is not guaranteed to provide
> >> sensible information.
> >
> > Correct. The HPET on new client platforms turn to be disabled for the
> > PC10 issue, though it's fine on server platforms where tsc accuracy is
> > more important.
> 
> TSC accuracy is important in any case. Why would it be more important on
> server platforms? Just because?

It was my wild guess, as I thought servers used by enterprise or financial
system may care more about the accuracy.

> > Also even for the disabled HPET case, I remembered that you've once
> > suggested to leverage its capability for calibration, and only disable
> > it before cpu idle framework really starts :)
> 
> Correct, but that would only be valid for early boot calibration and not
> accross the recalibration.
> 
> That's why we ended up disabling HPET early in case of PC10. See
> hpet_is_pc10_damaged().

Got it. And I just checked some new client generations at hand like
Icelake and Alderlake, they both have acpi_pm timer and CPUID (0x15) 
supported.

Thanks,
Feng

> Thanks,
> 
>         tglx
