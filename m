Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D14D0AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiCGWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbiCGWOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:14:54 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A1574BA;
        Mon,  7 Mar 2022 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646691240; x=1678227240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4J0Ww48+Y6RMho2RZiFW1MiMdw4OpBGixlfQLH7Sec=;
  b=d/00p/7mXufry9AiP+JWNWPngCq6GT7A6h1zSvKSWAGbyGU4fSXTfY7a
   ZF7w1cMy7P/btzNwMAFmEqPzSCjnEeSsXulQ7vkNyUj9AoUH197QBgs5E
   4SvJUwBSD8fX1ijQwQ4B27sHq+5tYajjvSGY82U64XVXCts//3IWTNa9L
   ai5oAZAgoeT+grGwxORMvsoDq++Aon2SoI+j19cNGy6aQdNsQI5OjCSy3
   7Pj773ur+7k5wsCssfrJsCCCPvksaptNlX9/LgDhK75qEfkhI+prT5PHc
   6eL/X6fLBc23YgAIczPK6cWbFKzQD/Ybs4he09Kd/ESJM71txnaCUxHVa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315234971"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="315234971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 14:13:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="509867463"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 14:13:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRLbM-00D1zP-80;
        Tue, 08 Mar 2022 00:13:12 +0200
Date:   Tue, 8 Mar 2022 00:13:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 7/7] usb: typec: mux: Add On Semi fsa4480 driver
Message-ID: <YiaDd+quwXgbuz5D@smile.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-7-bjorn.andersson@linaro.org>
 <YiXbg4QwgIgLh3LW@smile.fi.intel.com>
 <YiYbOQpX4+fP8S1W@ripper>
 <YiYvMf5X+S0WZ9lO@smile.fi.intel.com>
 <YiZzco76Nrxbxz95@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiZzco76Nrxbxz95@ripper>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 01:04:50PM -0800, Bjorn Andersson wrote:
> On Mon 07 Mar 08:13 PST 2022, Andy Shevchenko wrote:
> > On Mon, Mar 07, 2022 at 06:48:25AM -0800, Bjorn Andersson wrote:
> > > On Mon 07 Mar 02:16 PST 2022, Andy Shevchenko wrote:
> > > > On Sun, Mar 06, 2022 at 07:40:40PM -0800, Bjorn Andersson wrote:

...

> > > > > +		/* 15us to allow the SBU switch to turn off */
> > > > > +		usleep_range(15, 1000);
> > > > 
> > > > This is quite unusual range.
> > > > 
> > > > If you are fine with the long delay, why to stress the system on it?
> > > > Otherwise the use of 1000 is unclear.
> > > > 
> > > > That said, I would expect one of the below:
> > > > 
> > > > 		usleep_range(15, 30);
> > > > 		usleep_range(500, 1000);
> > > 
> > > Glad you asked about that, as you say the typical form is to keep the
> > > range within 2x of the lower value, or perhaps lower + 5.
> > > 
> > > But if the purpose is to specify a minimum time and then give a max to
> > > give the system some flexibility in it's decision of when to wake up.
> > > And in situations such as this, we're talking about someone connecting a
> > > cable, so we're in "no rush" and I picked the completely arbitrary 1ms
> > > as the max.
> > > 
> > > Do you see any drawback of this much higher number? (Other than it
> > > looking "wrong")
> > 
> > I see the drawback of low number.
> 
> 15us is based on the data sheet and if the kernel is ready to serve us
> after 15us then let's do that.
> 
> > The 1000 makes not much sense to me with the minimum 66x times less.
> > If there is no rush, use some reasonable values,
> > what about
> > 
> > 		usleep_range(100, 1000);
> > 
> > ? 10x is way better than 66x.
> 
> I don't agree, and in particular putting 100 here because it's 1/10 of
> the number I just made up doesn't sounds like a good reason. The
> datasheet says 15us, so that is at least based on something real.
> 
> In https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> I find the following:
> 
>     With the introduction of a range, the scheduler is
>     free to coalesce your wakeup with any other wakeup
>     that may have happened for other reasons, or at the
>     worst case, fire an interrupt for your upper bound.
> 
>     The larger a range you supply, the greater a chance
>     that you will not trigger an interrupt; this should
>     be balanced with what is an acceptable upper bound on
>     delay / performance for your specific code path. Exact
>     tolerances here are very situation specific, thus it
>     is left to the caller to determine a reasonable range.
> 
> Which to me says that the wider range is perfectly reasonable. In
> particular 15, 30 (which seems to be quite common) makes the available
> range to the scheduler unnecessarily narrow.
> 
> And it's clear that whatever the upper bound it's going to be some
> arbitrary number, but 1ms should ensure that there are other hrtimer
> interrupts to piggy back on.

Okay, I have grepped for usleep_range(x[x], yyyy) and there are 9 modules
use it. A few commit messages call 1000 as "reasonable upper limit".

-- 
With Best Regards,
Andy Shevchenko


