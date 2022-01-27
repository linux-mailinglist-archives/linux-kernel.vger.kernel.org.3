Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7749E57E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbiA0PKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:10:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:60688 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbiA0PKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643296222; x=1674832222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hMfEXPWVpbvX1S6c0gfWDQMTstAwIM+/e46Tz9PlgE=;
  b=H8YHMjRz+mYrdYyDoajQxOxu3mc2S9DPG7vASBMe31aDLeDQ76oKp1Bv
   ftNpeQgeWobTKw3BT0RCMdc2kaEUCpxGewQ3bGcybNttdm5ecjTUwyeMq
   KN6e23emzwYEfwMFzvoph/GSe/G4fR8FoqVUec7WPioMpi2NWVElQUi2E
   tg8LQZwoFHERTtrhr1Qf28ozui0oQvnzaQ2wUedSDw3vohkowpWJAJEsz
   vZUwoKCRJuRHkgRNfnQvuNnWqta/zgqZSXvUjHMZKJ7yiGNDT46AOvyMY
   4LUMTxYNJ3KvLs7Dr0YOI234t1OSdLbkzA8OQZJT1C7R1zsfoR2Iw+HvY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246824865"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246824865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:10:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="563817526"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:10:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD6Of-00F1Cx-FN;
        Thu, 27 Jan 2022 17:09:13 +0200
Date:   Thu, 27 Jan 2022 17:09:13 +0200
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
Message-ID: <YfK1mZQ0BTyDgNUB@smile.fi.intel.com>
References: <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
 <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
 <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
 <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
 <c3fac656-5c9b-4b39-f5e9-e3637f4d5746@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3fac656-5c9b-4b39-f5e9-e3637f4d5746@axentia.se>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:11:14PM +0100, Peter Rosin wrote:
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
> > 
> > If we go to the road full of "if it will come XYZ then this sucks".
> > The future is uncertain and neither of us may prove the current
> > change good or bad in terms of the future (unknown and uncertain)
> > changes.
> > 
> > Preventing this patch to land is to tell "Oh, my design is bad,
> > but I will keep it, because in the future everything may change".
> > So, why don't you make this future to be now?
> > 
> >>> TL;DR: It makes possible not to mix bananas with wooden boxes.
> >>
> >> Which is all good until you need to ship an apple in the box with the
> >> bananas. (e.g. if you for some reason need the bananas to get ripe real
> >> quick, apples produce ethylene)
> > 
> > Really. arguments about the future changes are weak. If you have
> > patches in mind, send them, We will see in practice what you meant.
> 
> I can do one better - here are links to patches from 7-8 months ago.
> 
> https://lore.kernel.org/lkml/20210530005917.20953-1-liambeguin@gmail.com/
> https://lore.kernel.org/lkml/20210530005917.20953-6-liambeguin@gmail.com/
> 
> Or, if you prefer, the latest revisions.
> 
> https://lore.kernel.org/lkml/20220108205319.2046348-9-liambeguin@gmail.com/
> https://lore.kernel.org/lkml/20220108205319.2046348-14-liambeguin@gmail.com/
> 
> You have made review comments on that series.
> 
> My previous arguments were based on gut feel, and I'm sorry for not
> thinking of the offset in the referred series before.

No problem and thanks for your comments!

-- 
With Best Regards,
Andy Shevchenko


