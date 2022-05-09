Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28F251F620
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiEIHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiEIHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:35:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39DD13B8FB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652081526; x=1683617526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1I5zSUaaRKz4//FnqhNByD1l6y1y2nV5JiA+hv2I3g0=;
  b=RPJ8KbQtA5E+g2T0GJrkntBo1DqZSnikO2KO11Fr+6ltwdKrHXaYpy8A
   tMVTPUNgFt2ElhIt5NHiutWhaRYnh13PRoqgO8Glvj/2vJBy1m0CUzdxX
   NuGyGQ1zLfUdsER377B31wtWwqXm3+KaoXhhlR1mUuG3wyoe8tQ7P/96C
   A7DdKmyXZcwPHOMCUaD+Bq6CtczwxWRL0giUiv7dYjKcyR5JFxqut4onU
   mnfsAxwJTK7PmIdrV8rMGZcA2PWkzUnXDnVF1sBECDFpun8RxchvJtDdW
   JiS0dNI/mgZq6YOUpDTihF96Ak1Z+shhkO2WaoVms8eWvVSpcc9ALUvJa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355396109"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="355396109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="564920340"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 00:30:04 -0700
Date:   Mon, 9 May 2022 15:30:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
Message-ID: <20220509073003.GB40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
 <20220509071652.GE76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509071652.GE76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for the review!

On Mon, May 09, 2022 at 09:16:52AM +0200, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 12:58:39PM +0800, Feng Tang wrote:
> > Sorry, just spotted some typos, here is the updated version
> > 
> > 
> > From ee8e3d772c623d27d79c43da5a76fb6252175aba Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Sun, 8 May 2022 20:22:12 +0800
> > Subject: [PATCH] x86/tsc: Add option to force HW timer based recalibration
> > 
> > Currently when HW provides the tsc freq info through MSR or CPUID(0x15),
> > the info will be taken as the 'best guess', and kernel will set the
> > X86_FEATURE_TSC_KNOWN_FREQ flag and skip the HW timer based recalibration,
> > which works pretty well.
> > 
> > And there is still very few corner case that the freq info is not
> > accurate enough with small deviation from the actual value, like on
> > a product with early buggy version of firmware or on some
> > pre-production hardware.
> > 
> > Add an option 'recalibrate' for 'tsc' kernel parameter to force the
> > tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
> > from previous value is more than about 500 PPM.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Why isn't 'tsc_early_khz=' not working for you? Afaict that will
> override calibrate_tsc() when provided and as such can be used on these
> early platforms for provide the right value until such time that the
> firmware is fixed.

For the early platforms, the problem we met is we don't know what
is the 'correct' tsc-freq, and the value from MSR/CUPID could be wrong. 

And there was some generation, that after enabling some feature, each
instance of HW will have slightly different frequency, so there is
no central "one for all" value to set for 'tsc_early_khz'.

This option is more like a way to double-check the correctness of
tsc-freq got from MSR/CPUID(0x15).

Thanks,
Feng





