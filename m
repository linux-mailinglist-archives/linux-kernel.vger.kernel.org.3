Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D339355E2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbiF1Kii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbiF1Kii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:38:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7931181B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656412717; x=1687948717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yv61Q4zI/c9hepJhd/spVtRRRwJJ78xcjUZM66N8L/A=;
  b=NeJtF9pMWMSeSz5DCQpUHW7VpRmJLEAah2J2JAAInAEjKciTwFMwt6eo
   yhsdL9HIangzMb8LXiL2DjzQlcn71dmUmngj3uWuFe5kASUlUEKjeeMv6
   m5T/WUxSYWZ0JYxVMCbIAi8KWEio9n5HbsWBn6SbMV2VumkZY+KKoGIY7
   J5R+WODtyEP3pWs+5NpJDZjwKkpb2nv+S8pG6NKDHeTauWgDRTMGf50U/
   YmLtLiip3GpFg3IhS/HtcHXhgw7Pf2v5ea4w63f8t2/QVxJAR0VQj7Wuh
   GEk7NuANTlGsucG2uYNjW4t02ugrErIDZj0CJIc7Z6mVIN8k+H0Z8y4bL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282796942"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282796942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:38:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="658089605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:38:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o68c5-000wjG-4X;
        Tue, 28 Jun 2022 13:38:33 +0300
Date:   Tue, 28 Jun 2022 13:38:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <YrraKMemrHImty7s@smile.fi.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <Yrlyw1eMFy4kd0JB@google.com>
 <YrrNxEIMuYLpzCd1@smile.fi.intel.com>
 <YrrOHtDjI+P6Iq0r@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrOHtDjI+P6Iq0r@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:47:10AM +0100, Lee Jones wrote:
> On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> > On Mon, Jun 27, 2022 at 10:05:07AM +0100, Lee Jones wrote:
> > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> > > > +	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
> > > > +	if (ret) {
> > > >  		dev_err(dev, "Invalid register address\n");
> > > 
> > > Is that really what failure means, on every failure?
> > > 
> > >   "Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing
> > >    error."
> > 
> > As far as I can see in either case the address is invalid.
> > Basically we may drop this confusing error message here, if
> > this what you prefer.
> 
> Your call.  I just wanted you to consider it for a moment.

Userspace will print an error based on the error code, so
I would rather remove _this_ message since it doesn't add
value, esp. when we could have -ERANGE.

-- 
With Best Regards,
Andy Shevchenko


