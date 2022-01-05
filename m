Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29948543B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiAEOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:20:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:9114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237028AbiAEOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641392444; x=1672928444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZEI13h17z3pJrJ004QDuVsnoHswuZo0Xg7ON2boPr8=;
  b=c+DtodsAXZgU+/qpBInO+K+df2WV0yLVb7yprEcZ6YdlGMPNlv/dL094
   OuZa2dD2U6xDSEpGFp9/FM58htcxvmC2xxO8Bc19Ce6RnT5qB8D8QXa7r
   Q3MXVCLY3iPP+vhrlKNdR6cFdNla27xnRq06mXKE0+OZRTThCMvOnTrso
   eV17oOZCXHmHr87UN0Dq66O1trxejcvyd8EQAy0d6HtapYFdr7YNjX0Cn
   IUR/F5n6Jw3T1LJAD0N4LVX8lMpTTsjuEcDqMPCOQtpds/8zhp/N4Sv5W
   EWbg6KYf4ryHoaUTRxAjXCHsChbaoIQ+VlRHAoBnUe/FX1hNHUO3ovpca
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229767229"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229767229"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 05:53:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="621044967"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 05:53:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n56i5-006ilL-Kt;
        Wed, 05 Jan 2022 15:52:13 +0200
Date:   Wed, 5 Jan 2022 15:52:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Adriana Reus <adi.reus@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: Fix error handling in
 bmg160_core_probe
Message-ID: <YdWijUwMwwSWE8+n@smile.fi.intel.com>
References: <20220105125633.21989-1-linmq006@gmail.com>
 <20220105130743.00001661@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105130743.00001661@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:07:43PM +0000, Jonathan Cameron wrote:
> On Wed,  5 Jan 2022 12:56:30 +0000
> Miaoqian Lin <linmq006@gmail.com> wrote:
> 
> > The pm_runtime_enable will increase power disable depth.
> > If the probe fails, we should use pm_runtime_disable() to balance
> > pm_runtime_enable(). In the PM Runtime docs:
> >     Drivers in ->remove() callback should undo the runtime PM changes done
> >     in ->probe(). Usually this means calling pm_runtime_disable(),
> >     pm_runtime_dont_use_autosuspend() etc.
> > We should do this in error handling.
> > 
> > Fixes: 7d0ead5 ("iio: Reconcile operation order between iio_register/unregister and pm functions")
> 
> Hi Miaoqian,
> 
> Please check this fixes tag against the format it should have.

I usually advise people to put the following in the ~/.gitconfig:

[core]
	abbrev = 12

[alias]
	one = show -s --pretty='format:%h (\"%s\")'
	c = show -s --pretty='format:https://git.kernel.org/torvalds/c/%h'

`git one ...` will give a right thing.

-- 
With Best Regards,
Andy Shevchenko


