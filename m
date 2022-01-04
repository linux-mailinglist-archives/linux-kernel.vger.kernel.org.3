Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97B04842EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiADOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:00:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:26513 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233959AbiADOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641304816; x=1672840816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/3kE49QY8roAAplpV8aPPuBV9yvbQ9KIEivOIa/RJSk=;
  b=f/fDnxlZq68foMnnAmcB+f8ZLX5vPnw8naOkvL7rleAaYN8GV9FsIqwZ
   idYe9dl2bXTzNv2cVQunfRd7sO0UJdjpSDBDowMOVBPHOZeFhSaXAWNag
   jrP6YXh6j9jDkA4yOmFMAt/qrh4tfMcYPFDuBxm7Va3c57APZmkkC617q
   2oObFAllO1EJnraUqfc4S8cx/ec7EOZQ3XsWOp8siJYHYiDZ7Zk1qXPqr
   Gzg0veR5tsLM5MmVOahYyWl6xjZRA48SkgC7jMpCe75A9dbnbyyjJhQST
   xgR2cP54t1X//y7IwqeTCp5tI7A/Lkf5Jldw5jl67sHvXclvmwxts4WUE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229045060"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229045060"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 06:00:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488202168"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 06:00:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n4kL1-006E1Z-Ds;
        Tue, 04 Jan 2022 15:58:55 +0200
Date:   Tue, 4 Jan 2022 15:58:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     vishakha.joshi@intel.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v1 1/2] pwm: Add count to sysfs for Intel PWM driver
Message-ID: <YdRSnxqIJf1C14+x@smile.fi.intel.com>
References: <20220103081610.6656-1-vishakha.joshi@intel.com>
 <20220103081610.6656-2-vishakha.joshi@intel.com>
 <20220103121454.rduz4jftean4hkaw@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220103121454.rduz4jftean4hkaw@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 01:14:54PM +0100, Uwe Kleine-König wrote:
> On Mon, Jan 03, 2022 at 01:46:09PM +0530, vishakha.joshi@intel.com wrote:
> > From: Vishakha Joshi <vishakha.joshi@intel.com>

...

> >  struct pwm_state {
> >  	u64 period;
> >  	u64 duty_cycle;
> > +	u32 count;
> >  	enum pwm_polarity polarity;
> >  	bool enabled;
> >  	bool usage_power;
> 
> This needs more documentation about what the semantic should be. E.g.
> what should .get_state return?

Good point. I guess ideally we should return the amount of the periods we still
need to produce, but I'm not sure if it can be done cleanly.

It would probably require a timer to be run in parallel, hence almost full
software implementation of the feature. (This answers the second concern)

> Also I doubt this is a good idea given that most controllers cannot
> implement it.
> 
> If we really want to support a count, I request that all drivers that
> don't support it get updated to refuse a request with count != 0.

Hmm... Not sure it worth it, perhaps taking into account above the -1
(in unsigned type) returned on ->get_state() can suffice as not supporting
feature?

-- 
With Best Regards,
Andy Shevchenko


