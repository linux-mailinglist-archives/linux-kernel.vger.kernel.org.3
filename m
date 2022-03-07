Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C024CFC2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiCGLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiCGLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:03:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF51EC6B;
        Mon,  7 Mar 2022 02:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646648698; x=1678184698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JP3i4k92HCF7w/7CAemouqXsnWuC4cbfniI4xZkkhGo=;
  b=CErph2rl+gTbWxAlgoehvSjO03Q5vNuWpmCYCcshu1k7lpA/fnlSEqMh
   nx0GiQxDpg66F3mh5RtrAkA0+rxvtLQB7d6z5G3MZy/zi3CmlX0yoZ1qo
   bhhte5pNNsZSk4+oLDGgtPxl8ZaDIClaBs3haYYfwpMTbceIkcP45GQ2S
   WFiRaIYeTMSEylHaAl2XBnEuuwLrbCNfv8sP71AKlIK/Q9YQgrcoEBuNf
   zTiRjBWSHmnLgcH7rWo3a4yDFkLEOPjv6ST4IrolDI0VYsYCwwcqkC85+
   Uy5kIR2A7ZEpwUnhCStQ2T+iD7m72AAELZbwLYLvhvaoitJNLIKzBlMRp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254087439"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="254087439"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:24:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="643194326"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:24:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRAWy-00ChxM-TK;
        Mon, 07 Mar 2022 12:23:56 +0200
Date:   Mon, 7 Mar 2022 12:23:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: check for overflow when reading the 'ngpios'
 property
Message-ID: <YiXdPLGR3EVryJyB@smile.fi.intel.com>
References: <20220306193420.99714-1-brgl@bgdev.pl>
 <CAHp75Vfgsa5Ru5aA7Bx_mV--h-GFKSX9Uocf+njvh8Rc1yNTow@mail.gmail.com>
 <CAHp75Vd8Z-XmSE-JxM55rLAzMqFqm5D7B2HsQ+P_vdh==deOJQ@mail.gmail.com>
 <YiXWBAlQ4GHiPkDg@smile.fi.intel.com>
 <CAMRc=McRVSjiWxaDz0G5pWn7JxMXUV-b8VoUfvsLhc-iZSk4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McRVSjiWxaDz0G5pWn7JxMXUV-b8VoUfvsLhc-iZSk4oQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:08:51AM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 7, 2022 at 10:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Mar 07, 2022 at 12:23:03AM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 7, 2022 at 12:19 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Mar 7, 2022 at 12:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> > > > > The ngpio fields both in struct gpio_device as well as gpio_chip are
> > > > > 16-bit unsigned integers. Let's not risk an overflow and check if the
> > > > > property value represented as a 32-bit unsigned integer is not greater
> > > > > than U16_MAX.
> > > >
> > > > ...
> > > >
> > > > > +               if (ngpios > U16_MAX) {
> > > > > +                       ret = EINVAL;
> > > > > +                       goto err_free_descs;
> > > > > +               }
> > > >
> > > > I don't think it's a fatal error in this case. I would perhaps print a
> > > > warning and simply use a masked (which is done implicitly by an
> > > > assignment of the different type) value. Note, the above is buggy on
> > > > the buggy DTs, where the upper part of the value is not used. After
> > > > this patch you effectively make a regression on, yes, broken DTs.
> > >
> > > Like
> > >
> > >     if (ngpios > U16_MAX)
> > >         chip_warn(gc, "line cnt %u is greater than supported; use
> > > %u\n", ngpios, (u16)ngpio);
> >
> > Or to be on safer side move this after == 0 check as
> >
> >         if (gc->ngpio != ngpios)
> >                 chip_warn(gc, "line cnt %u is greater than supported; use %u\n", ngpios, gc->ngpio);
> >
> 
> ngpios is not necessarily used so this check must be in the scope of
> the device property read (inside the if (gc->ngpio == 0) { block).

Can be done as

        if (gc->ngpio == 0) {
		...
	} else {
		ngpios = gc->ngpio;
	}

        if (gc->ngpio == 0) {
		...
	}

	if (gc->ngpio != ngpios)
		chip_warn(gc, "line cnt %u is greater than supported; use %u\n", ngpios, gc->ngpio);

The point of this exercise is to avoid hard coded type of the variable in a
few places, so if gc->ngpio and/or ngpios have changed type in the future,
you don't need to change this code.


-- 
With Best Regards,
Andy Shevchenko


