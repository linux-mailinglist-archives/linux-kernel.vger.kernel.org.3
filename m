Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522094F4735
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiDEVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452441AbiDEPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415164667A;
        Tue,  5 Apr 2022 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649170559; x=1680706559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzWWaOe8dpgOyl28XgBsyJbkLQtzWsf2/VylB+LCjtU=;
  b=MOzXD47PSDevMhcLExVMIJq+DqjlAubxGDgI9F2shNxXqHNKrCCGTJEL
   zpJ9b/bL5oQqdLNqNEsYmIaELVRUyqW424b2v6HYMWzPx+J6PVckTqeWV
   kBP3UqhnBXUUZBs/7QABZjkzW4Le+QYXqrd2AmEdVn2MfRHjoLaU/jV21
   JoqpV+oGCQU1mKgZm1utOkhr8CK3XX5EkFKjwKq2uAP5FhVnJ6w63vXuZ
   c5ah4pRdOECLi1n/BhFSmWiUJ7PZmoapZ0WT1fMwF/4W057gVW+KlaBu0
   qu6SoiJFKnSNm5kCALKDWOq9S/23dJ0IoKEvIIJcx+Dat/yY4p3MNxXzh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="248282983"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="248282983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:55:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549083117"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:55:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbkaM-00DQCd-7l;
        Tue, 05 Apr 2022 17:55:10 +0300
Date:   Tue, 5 Apr 2022 17:55:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/3] gpiolib: Split out for_each_gpio_desc() macro
Message-ID: <YkxYTXbJqpBp4H0a@smile.fi.intel.com>
References: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McZihs+aKOGE3M5_BW__CTiyX2u2bdS6xc+uHU9RCAZdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McZihs+aKOGE3M5_BW__CTiyX2u2bdS6xc+uHU9RCAZdw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:21:42PM +0200, Bartosz Golaszewski wrote:
> On Wed, Mar 30, 2022 at 4:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -#define for_each_gpio_desc_with_flag(i, gc, desc, flag)                \
> > +#define for_each_gpio_desc(i, gc, desc)                                \
> 
> While at it: how about declaring the i variable in the loop definition?

It will require changes in the users, so, I will do it as a prerequisite
separate change.

> >         for (i = 0, desc = gpiochip_get_desc(gc, i);            \
> >              i < gc->ngpio;                                     \
> > -            i++, desc = gpiochip_get_desc(gc, i))              \
> > +            i++, desc = gpiochip_get_desc(gc, i))

-- 
With Best Regards,
Andy Shevchenko


