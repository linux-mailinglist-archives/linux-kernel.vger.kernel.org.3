Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D39498368
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbiAXPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:19:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:20520 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238469AbiAXPTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643037583; x=1674573583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mimpR4/W0b7KnV6xIlcXHDgxrwp8juuzVrZ3EPC/il0=;
  b=GfYKP9R41jkATZFfaQw61P926o/AhMsdIYmPsIgU79OXu9JLyQ5PLKfl
   aIU6C5jzXu/qtzsJgc3aHXRl5trO2ywDgPzNnkubqGK5EkHkX/jbQ+q7r
   0czabm8rTKCa01rqhj5vwcHMNUxPk5/bnu1SVtvdJ+l05Nhp7QuIET7YI
   b/dSoZNPQArYuI7SlacEcR+D4Q4Uvi6ead/FQOz5CCiPK0yK/dY+6uXIL
   EF2V7yLYR4yPqQji53tjhY9Vl/Pz0mX3pJXHVkLJRcYn8CnZvJpP1HDWn
   MMfYoNvuNOGlxtmFnoIcSQC/Yfa/Bt+r8iYcnOZFdqJ3hPUJ4egK8BV2s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332421382"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332421382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:19:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479110611"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:19:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC173-00Dw23-53;
        Mon, 24 Jan 2022 17:18:33 +0200
Date:   Mon, 24 Jan 2022 17:18:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115185203.567780e8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> On Mon, 10 Jan 2022 21:31:04 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Instead of custom data type re-use generic struct s32_fract.
> > No changes intended.
> > 
> > The new member is put to be the first one to avoid additional
> > pointer arithmetic. Besides that one may switch to use fract
> > member to perform container_of(), which will be no-op in this
> > case, to get struct rescale.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I'm not totally sold on this series showing there is a strong case for
> these macros so interested to hear what others think.

So far no news :-)

> Boiler plate removal is always nice of course...

That's what I considered nice as well.

...

> > I found this better in order how code is structurally (re)organized.
> > I may rebase this on top of ongoing AFE series.
> > 
> > Also reveals possibility to switch to rational best approximation.
> > But this is another story...
> 
> Now that may well justify introducing this shared infrastructure :)

We also have mult_frac() macro which can be extended by mult_fract() for
these structures.

...

> >  	rescale = iio_priv(indio_dev);
> > -
> > +	rescale->source = source;
> 
> There seems to be more reorganizing going on in here than is necessary
> for the function of this patch. At very least, description should
> call it out.  Why move setting source?

Yeah, I agree that this may be in a separate change before of after the series.
I will split.

> >  	rescale->cfg = of_device_get_match_data(dev);
> > -	rescale->numerator = 1;
> > -	rescale->denominator = 1;
> >  
> > -	ret = rescale->cfg->props(dev, rescale);
> > +	fract = &rescale->fract;
> > +	fract->numerator = 1;
> > +	fract->denominator = 1;

> > -	rescale->source = source;
> > -

-- 
With Best Regards,
Andy Shevchenko


