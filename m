Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81055C9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbiF1Jpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiF1Jpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:45:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B39225C41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656409545; x=1687945545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lo9iE3GxTeZNZVSB5e8Qr73INosN6zd+S8p+RW0/J+E=;
  b=QJRAiVzRDx8OVvg4bu6vchPllvMh11I+6ZPTww2WSA4jMay/xb+UzcTn
   et2TWmIaRNFM8oAjEL6TbrCqL4QRPmSrkAI8GRwmcQGwCBYKrv8ZC16yn
   KM7b3LNsHFi95zBe6lZ0tAOlZ5/nD3WVw+CqTk5tLqbCOX1BM2wKvjpi1
   z8XxDNcGu+xxQ/PCx8OwUSSbwaD1XwzV3D6Lwy/rEJQF/VpSAnkH1wjps
   nDlzOZomonDu1nkIrc19WcqfzWFalK9MgjHH5K+ncXuBdwGpPERfQ/nyc
   mV+L07cvaEIprZde5B+xqsR5yoGpimiOViaHBJNdC7FB6SsRCGVqfA9sd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280454568"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280454568"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:45:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732688577"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:45:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o67mv-000wfe-72;
        Tue, 28 Jun 2022 12:45:41 +0300
Date:   Tue, 28 Jun 2022 12:45:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <YrrNxEIMuYLpzCd1@smile.fi.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <Yrlyw1eMFy4kd0JB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrlyw1eMFy4kd0JB@google.com>
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

On Mon, Jun 27, 2022 at 10:05:07AM +0100, Lee Jones wrote:
> On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> > +	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
> > +	if (ret) {
> >  		dev_err(dev, "Invalid register address\n");
> 
> Is that really what failure means, on every failure?
> 
>   "Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing
>    error."

As far as I can see in either case the address is invalid.
Basically we may drop this confusing error message here, if
this what you prefer.

> > -		return -EINVAL;
> > +		return ret;
> >  	}

-- 
With Best Regards,
Andy Shevchenko


