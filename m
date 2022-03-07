Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250984D0448
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiCGQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiCGQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:40:38 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40D34B9B;
        Mon,  7 Mar 2022 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646671183; x=1678207183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/WhdRqYVGV6xgIgJtdfTvyUo9gS8a8NYiC/+LyePM0=;
  b=jMnFnzZU+tD8fY2tSDk0QLUkA03RuUtc5ccXZZqJVrnbS0LG9j+tn6ly
   0DepUG5cNeZU8aVHVBwbZwz79TAf50SygLiXpy4td656VygRPu9V9IilU
   KcXzYaPtQOPtqPN98p5B/D8Ue6R+oydSFu2YLPp4rn2+fO7nO9JGiqztO
   FamBzIvOAlDjT1CbO9pjf+hXMwE3iT8ohPfFEsalQW2CuuG+LMPtgT63n
   k6qrclsevO0vy7VkDpyJ1BxeTxi31TQaMFy+xfiBfHkj8xSngSzmrd4xx
   RE5dpo68EMd6QODMH7DDLZKKBKlos0iN0murpBjZoTWWErjshyHYNK3Hi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315152933"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="315152933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:39:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="711172367"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:39:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRGNo-00CrsT-5g;
        Mon, 07 Mar 2022 18:38:52 +0200
Date:   Mon, 7 Mar 2022 18:38:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to
 microseconds
Message-ID: <YiY1GwLPREl0OGeM@smile.fi.intel.com>
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3_W49Wq5-zaxdNzELW87OogEN5wW6XQnF9aMpZrRvBA@mail.gmail.com>
 <YiYNPhUoXH8XakKO@smile.fi.intel.com>
 <CAMRc=Mcp5YeVYJn1FCK+0=72HhJ2haTU02wd9MK7O7fxgXyj4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcp5YeVYJn1FCK+0=72HhJ2haTU02wd9MK7O7fxgXyj4Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:33:43PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 7, 2022 at 2:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Mar 07, 2022 at 01:48:10PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Mar 7, 2022 at 12:56 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Do you have some more stuff coming up for fixes
> >
> > I don't think so.

Hmm... As a matter of fact, one small fix is on its way since I noticed during
compilation test of the above.

...

> Applied, thanks!

Thank you!

-- 
With Best Regards,
Andy Shevchenko


