Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6E49CA44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiAZNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:02:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:50538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbiAZNCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202164; x=1674738164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7nK+CH4q5BpWQZsxJYj303+HmKOMjePVbYNz5G/Rv2c=;
  b=h7/kkKrPnGBWH+bsAI5ap86rjpg4ApP5cFOFqVTMg9Ct6lN+NonRRbgh
   S0SBJAAERBdyqFQvBRMH5UGiqL4cFTWKMLedverV/agfyfhKxyil7rKTh
   jO5bCROLlthFg/w+uGk9rXrGxz2kPj1PfKel3aMEfkv68aFj839M13Xf+
   MxV7Zfd9g73eb30faLCcbGtYLl6r30LCUyaIglsRxNnMdnmNCZTdhiBBE
   gLLVzCBsd1N3KDXTQStluJmujmd/Lti4ntnUBgLcwsOrxySCqZ+UixQ4k
   f8XConSzKODoDu/2xR0xAdzT3lCCtYvPl/Y907p5d2BVGc1dSeJUayV/f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227215803"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="227215803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:02:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628297036"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:02:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nChva-00EbO6-MU;
        Wed, 26 Jan 2022 15:01:34 +0200
Date:   Wed, 26 Jan 2022 15:01:34 +0200
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
Message-ID: <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
References: <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
 <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:35:09PM +0100, Peter Rosin wrote:
> On 2022-01-26 13:04, Andy Shevchenko wrote:
> > On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
> >> It's easy to both remove and to add back "the bigger object". I just
> >> don't see the point of the churn. Technically you can probably rearrange
> >> stuff in probe and remove the 2nd argument to ->props() altogether and
> >> chase pointers from the dev object instead. I don't see the point of
> >> that either. It doesn't really make things simpler, it doesn't really
> >> make things easier to read. To me, it's just pointless churn.
> > 
> > Since you still haven't got a point the conclusions are wrong.
> > The point is (I dunno how more clear to make it) is to have proper
> > layering from the (current) design perspective.
> 
> I think got the gist of it. I simply do not agree with your conclusion
> about what the "proper layering" should be.

And I see no real argument against it. With the patch applied I see
a better structure of the code and exactly necessary data to be passed
to the method. Which makes me think that current implementation is
either a leftover or was something like "let's take a bigger object
_just in case_", which I can't take as a proper layering.

-- 
With Best Regards,
Andy Shevchenko


