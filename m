Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7851FB31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiEIL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEIL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:26:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB74209543
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652095362; x=1683631362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdRt8mOxIA7UThkscuoBXXMGEYQzREYoFGpLUsiUhU4=;
  b=H6xvaofrbCx3niQNR4a+i8djN5hLWTyCI1ZZrt2R+owQOhEgcjPckGmz
   dFeqb9IzIcCvg+Ld0A8F6x5QZ7et7ykSNBpIsu7nIEpHDygO19CkUtwuy
   nKLLU+yZP9QmIEy8OCoFIQS66aeWO5zTWjSTSz+Opf/IpYI+iCibLvHnR
   pZA+bvocbksv70vBPA0wn3e1+wN1dZPKIo4Ba/kWorQNVUiVmhFAby/O6
   uAl2oTR0N76AOWLCtk4v62fPpnKdI1fX3Y2I9Car52DN9RBLjmfThU6wa
   rO272LtX8ODHXSO9U5E18WU1uRcZ0/PYfBcHD4C3PLFdTkIpbTonQTojD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="269159484"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="269159484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="565009451"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 04:22:35 -0700
Date:   Mon, 9 May 2022 19:22:35 +0800
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
Message-ID: <20220509112235.GD40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
 <20220509071652.GE76023@worktop.programming.kicks-ass.net>
 <20220509073003.GB40730@shbuild999.sh.intel.com>
 <87h75zrpmh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h75zrpmh.ffs@tglx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the comments!

On Mon, May 09, 2022 at 12:01:42PM +0200, Thomas Gleixner wrote:
> Feng,
> 
> On Mon, May 09 2022 at 15:30, Feng Tang wrote:
> > On Mon, May 09, 2022 at 09:16:52AM +0200, Peter Zijlstra wrote:
> >> On Mon, May 09, 2022 at 12:58:39PM +0800, Feng Tang wrote:
> >> > And there is still very few corner case that the freq info is not
> >> > accurate enough with small deviation from the actual value, like on
> >> > a product with early buggy version of firmware or on some
> >> > pre-production hardware.
> >> >
> >> > Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> >> > tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
> >> > from previous value is more than about 500 PPM.
> >> > 
> >> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >> 
> >> Why isn't 'tsc_early_khz=' not working for you? Afaict that will
> >> override calibrate_tsc() when provided and as such can be used on these
> >> early platforms for provide the right value until such time that the
> >> firmware is fixed.
> >
> > For the early platforms, the problem we met is we don't know what
> > is the 'correct' tsc-freq, and the value from MSR/CUPID could be wrong. 
> >
> > And there was some generation, that after enabling some feature, each
> > instance of HW will have slightly different frequency, so there is
> > no central "one for all" value to set for 'tsc_early_khz'.
> >
> > This option is more like a way to double-check the correctness of
> > tsc-freq got from MSR/CPUID(0x15).
> 
> If at all it's a workaround for the inability and ignorance of firmware
> people. The crystal frequency and the TSC/crystal ratio _are_ known to
> the system designer and firmware people. It's really not asked too much
> to put the correct values into CPUID(0x15) and have proper quality
> control to ensure the correctness.
> 
> The whole argument about early firmware and pre-production hardware is
> bogus. It's 2022 and we are debating this problem for more than a decade
> now and still hardware and firmware people think they can do what they
> want and it all can be "fixed" in software. It's not rocket science to
> get this straight.
 
I completely understand it, as we've also suffered a lot from such
problems. This patch doesn't change any current work flow, and it simply
calibrates and prints out the freq info (warn if there is big deviation).
It acctually provides SW guys a quick way to argue with HW/FW people:
"See! You've given us a wrong number, please fix it", otherwise I heard
there was customer long ago  who used atomic clock to prove the deviation. 

> Aside of that HPET has become unrealiable and PM timer is not guaranteed
> to be there either. So we really do not need a mechanism to enforce
> recalibration against something which is not guaranteed to provide
> sensible information.

Correct. The HPET on new client platforms turn to be disabled for the
PC10 issue, though it's fine on server platforms where tsc accuracy is
more important. Also even for the disabled HPET case, I remembered that
you've once suggested to leverage its capability for calibration, and
only disable it before cpu idle framework really starts :)

Thanks,
Feng

> Thanks,
> 
>         tglx
