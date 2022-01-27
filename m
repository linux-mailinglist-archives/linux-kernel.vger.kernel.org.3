Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE25849E57A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiA0PJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:09:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:6532 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242794AbiA0PJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643296163; x=1674832163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m03jHFTsmH0kl+SqiX5YOIzStgNgXmrl9679DYrvc54=;
  b=lvUEeT+EiN9OrHviiqLdOYjoWxfbiPe1wg7LiEZnsXUza4IC6IsQjQMD
   VwJQ3sowxyrM6iaRGmXSAvDXF4C748CVLRjZOBRst2357Nfovh3WWpyuX
   ldeTF3Myynm+WZykaMvQXM1O5rwfyGEp5nD9JsKPEd+nBl50ujo8YdzZb
   S6mEjWNG1N6fKItraAq4spQDzGhEoBo6bOTGCHadPExD9uHBBwMsJ6Owe
   wf/fWDU3YV9WMtiHK2n8ZkYuleUU+NOoiJxyzD6LFyZwGCU5BaOv/2TGD
   FLpvZsLI2+i+sqMOwDsuiKWOIWJv+ptVAQY9xNHx83TL3bvbzXmmCbtOf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="247099735"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="247099735"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:09:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="618361102"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:09:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD6Nh-00F1CR-MI;
        Thu, 27 Jan 2022 17:08:13 +0200
Date:   Thu, 27 Jan 2022 17:08:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <YfK1XSfVW8P+gzd/@smile.fi.intel.com>
References: <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
 <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
 <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
 <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:03:49PM +0100, Peter Rosin wrote:
> On 2022-01-26 14:01, Andy Shevchenko wrote:
> > On Wed, Jan 26, 2022 at 01:35:09PM +0100, Peter Rosin wrote:
> >> On 2022-01-26 13:04, Andy Shevchenko wrote:
> >>> On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
> >>>> It's easy to both remove and to add back "the bigger object". I just
> >>>> don't see the point of the churn. Technically you can probably rearrange
> >>>> stuff in probe and remove the 2nd argument to ->props() altogether and
> >>>> chase pointers from the dev object instead. I don't see the point of
> >>>> that either. It doesn't really make things simpler, it doesn't really
> >>>> make things easier to read. To me, it's just pointless churn.
> >>>
> >>> Since you still haven't got a point the conclusions are wrong.
> >>> The point is (I dunno how more clear to make it) is to have proper
> >>> layering from the (current) design perspective.
> >>
> >> I think got the gist of it. I simply do not agree with your conclusion
> >> about what the "proper layering" should be.
> > 
> > And I see no real argument against it. With the patch applied I see
> > a better structure of the code and exactly necessary data to be passed
> > to the method. Which makes me think that current implementation is
> > either a leftover or was something like "let's take a bigger object
> > _just in case_", which I can't take as a proper layering.
> 
> The bigger object, or the one and only object as the current code is
> written, is given to ->props() by design.
> 
> BTW, you don't seem to understand the ->props() functions. There is no
> data "passed to" the ->props() functions. These functions instead fill
> in properties. Currently this boils down to the scaling fraction, but I
> can imagine other properties.

Currently the object of the properties is the same as struct __Txx_fract.
In the future it may indeed be expanded. In such case I see that the layering
might look like

struct ..._props {
	struct __Txx_fract fract;
	...
};

Of course it depends on the properties themselves, but at least that's
how I believe the OOP paradigm works. Am I mistaken?

> On 2022-01-25 19:17, Andy Shevchenko wrote:
> >                              The bigger object would be needed
> > in case of using data that is not fraction. Either way it would
> > be easy to add a container_of() than supply unneeded data to
> > the method.
> 
> You argued that it is easy to "break out" to the bigger object in case
> it's needed. Which in my book is a sign of poor layering.
> It's way easier to *not* change things, it's perfectly fine as-is.
> 
> The argument against making the change you propose is that it does not
> make this small driver any easier to understand. It would still just
> change things for the sake of changing them, and I do not see the point
> of erasing the existing future-proofing when it has no cost.
> 
> To sum up, I'm ok with introducing fract_s32 in this driver, but I
> don't agree with the signature change of ->props().

Thanks for valuable comments!

I postponed the change in any case, let Liam to finish his part first,
which we agreed is more important.


-- 
With Best Regards,
Andy Shevchenko


