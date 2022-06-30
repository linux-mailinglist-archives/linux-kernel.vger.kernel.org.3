Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8148561657
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiF3JbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiF3JbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:31:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B221242A34;
        Thu, 30 Jun 2022 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656581477; x=1688117477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ts2C+OqBlxWP7DBOA939sjPkbYuxOnt3IFBir6lTgbI=;
  b=iHaBuJWFdcIHRxrzU5+WLKkAkRK39u8rXNbNLPW0ujdBqsiljlUHOKK3
   tUwqqWGs51w/g3NUnVTP++QZz8lqamEiS/MnFmSXuj6r6mDkGlwqK3ptA
   x2utLx9AxOtnhy/FFaJE8t1o9OawF/TtXLivEFzYcvf573VM5DL0HDl9d
   zg6/p/NNia+81+y/zloelwo2iH2USlAD0ODqETAda2B/KqYr1NWm2rEll
   +14mUQxIWiVoOi3B2CHA9/gqxoA7WNR3RmJ3tbbXcpMvGtRdJe0zZEUOY
   ZfpGpeOzAFh6NB1/fTUzKcUkXOZTez/fZw1PlG7KqFjjosFC19QDpp9ze
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262704216"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="262704216"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:31:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="718160631"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:31:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6qW0-000yQX-DP;
        Thu, 30 Jun 2022 12:31:12 +0300
Date:   Thu, 30 Jun 2022 12:31:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
Message-ID: <Yr1tYLgj4+F8pKO4@smile.fi.intel.com>
References: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com>
 <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
 <J98AER.7ZO6O9DK05IM1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <J98AER.7ZO6O9DK05IM1@crapouillou.net>
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

On Thu, Jun 30, 2022 at 09:44:07AM +0100, Paul Cercueil wrote:
> Le jeu., juin 30 2022 at 10:41:40 +0300, Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> a écrit :
> > On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> > 
> > >  Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting
> > > dw8250_pm_ops
> > >  to use new PM macros.
> > > 
> > >  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I will drop this for v2.

> > Not directily related to the patch itself but do you have any idea why
> > 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
> > didn't wrap RUNTIME_PM_OPS() pointers with pm_ptr()? I'm asking this
> > because in SET_RUNTIME_PM_OPS() the callbacks are only created with
> > #ifdef CONFIG_PM so I'd have expected RUNTIME_PM_OPS() to maintain that
> > behavior but it didn't? Was it just an oversight that should be fixed?
> 
> The RUNTIME_PM_OPS() does not wrap pointers with pm_ptr(), because the
> pointer to the dev_pm_ops should only ever be used wrapped with pm_ptr() or
> pm_sleep_ptr().
> 
> Which is not done here.
> 
> Andy:
> The deference of dw8250_pm_ops should be pm_ptr(&dw8250_pm_ops). If you only
> had system suspend/resume functions, you'd use pm_sleep_ptr() there.

Right, it's a shame how I forgot that while telling everybody to use them.

Thanks, Paul!

-- 
With Best Regards,
Andy Shevchenko


