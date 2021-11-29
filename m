Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C164B461BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbhK2Qhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:37:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:63246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234379AbhK2Qfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:35:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236235541"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="236235541"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:32:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="676418513"
Received: from ticela-nm-11.amr.corp.intel.com (HELO [10.212.98.225]) ([10.212.98.225])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:32:09 -0800
Subject: Re: ALSA: hda: Make proper use of timecounter
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
References: <871r35kwji.ffs@tglx>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c1b9ecd-cefe-f890-f309-39d602201d58@linux.intel.com>
Date:   Mon, 29 Nov 2021 10:06:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <871r35kwji.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/21 4:40 PM, Thomas Gleixner wrote:
> HDA uses a timecounter to read a hardware clock running at 24 MHz. The
> conversion factor is set with a mult value of 125 and a shift value of 0,
> which is not converting the hardware clock to nanoseconds, it is converting
> to 1/3 nanoseconds because the conversion factor from 24Mhz to nanoseconds
> is 125/3. The usage sites divide the "nanoseconds" value returned by
> timecounter_read() by 3 to get a real nanoseconds value.
> 
> There is a lengthy comment in azx_timecounter_init() explaining this
> choice. That comment makes blatantly wrong assumptions about how
> timecounters work and what can overflow.
> 
> The comment says:
> 
>      * Applying the 1/3 factor as part of the multiplication
>      * requires at least 20 bits for a decent precision, however
>      * overflows occur after about 4 hours or less, not a option.
> 
> timecounters operate on time deltas between two readouts of a clock and use
> the mult/shift pair to calculate a precise nanoseconds value:
> 
>     delta_nsec = (delta_clock * mult) >> shift;
> 
> The fractional part is also taken into account and preserved to prevent
> accumulated rounding errors. For details see cyclecounter_cyc2ns().
> 
> The mult/shift pair has to be chosen so that the multiplication of the
> maximum expected delta value does not result in a 64bit overflow. As the
> counter wraps around on 32bit, the maximum observable delta between two
> reads is (1 << 32) - 1 which is about 178.9 seconds.
> 
> That in turn means the maximum multiplication factor which fits into an u32
> will not cause a 64bit overflow ever because it's guaranteed that:
> 
>      ((1 << 32) - 1) ^ 2 < (1 << 64)
> 
> The resulting correct multiplication factor is 2796202667 and the shift
> value is 26, i.e. 26 bit precision. The overflow of the multiplication
> would happen exactly at a clock readout delta of 6597069765 which is way
> after the wrap around of the hardware clock at around 274.8 seconds which
> is off from the claimed 4 hours by more than an order of magnitude.
> 
> If the counter ever wraps around the last read value then the calculation
> is off by the number of wrap arounds times 178.9 seconds because the
> overflow cannot be observed.
> 
> Use clocks_calc_mult_shift(), which calculates the most accurate mult/shift
> pair based on the given clock frequency, and remove the bogus comment along
> with the divisions at the readout sites.
> 
> Fixes: 5d890f591d15 ("ALSA: hda: support for wallclock timestamps")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I don't recall the reason of why I added separate steps for
multiplication by 125 and division by 3 back in 2012, but obviously they
weren't aligned with my own comment "Max buffer time is limited to 178
seconds to make sure wall clock counter does not overflow".

Thanks for the patch, much appreciated.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

