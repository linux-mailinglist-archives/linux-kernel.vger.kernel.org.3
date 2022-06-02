Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1E53B7FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiFBLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiFBLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:45:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E852462C3;
        Thu,  2 Jun 2022 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654170349; x=1685706349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S+iHHapTCEiHLOQdaIrdeB+XG5BsdsuBHVvjo6BfwPs=;
  b=jMkUJvRST3bXQSQJxsHgOjGJ3LWc/DzQDSjl9YD0XEMxXvE6cIqMAdgt
   LnQAftAZVoIWIyTZkHL/BW1yog3khJ52w9MN/e9qNioY8f06GRADDZr41
   fiaUziQwshBGul9SWBWG4WpYtp/F53BxAFCYyAglNdM3IDVVFJAAGyOpp
   FgXlNL1rhNa6LERf+DHwj1D7ixhODNYIzNEIjfxHaLb7+/tVCC0MLoeZK
   YpRyZJXzxVsbQIqLN+81WWro0C9rex/qBtj8GyX+1o0uCSB6FmGamo+Jj
   C9Jy6WgLH3IbcTHI/SVP0nuyOlRHXvlqdMCIo78kKaLUabXu+lr3S1wwo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275930429"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275930429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:45:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="707533261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:45:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwjGq-000Rcf-EC;
        Thu, 02 Jun 2022 14:45:44 +0300
Date:   Thu, 2 Jun 2022 14:45:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpio: sch: make irq_chip immutable
Message-ID: <Ypii6K0JGkpvejgd@smile.fi.intel.com>
References: <20220601153656.76454-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McgEzFcmgcWMb3L3Drjcyzhs0kb4JfBHMi7AoAU04txLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McgEzFcmgcWMb3L3Drjcyzhs0kb4JfBHMi7AoAU04txLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 07:19:22PM +0200, Bartosz Golaszewski wrote:
> On Wed, Jun 1, 2022 at 5:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Since recently, the kernel is nagging about mutable irq_chips:
> >
> >    "not an immutable chip, please consider fixing it!"
> >
> > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > helper functions and call the appropriate gpiolib functions.

> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>

Thanks!

I think I will collect all of these and send a PR after v5.19-rc1
to be included into v5.19-rc2+. Tell me if you think differently.

-- 
With Best Regards,
Andy Shevchenko


