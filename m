Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FD52B70F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiERKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiERKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:11:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B3323BE8;
        Wed, 18 May 2022 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652868707; x=1684404707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fb/5ARR3YO8OMuxywWGPResY3kOWVu7cT520bf4RQsA=;
  b=ZRF4xmiSvVHNy/lyauhaFg1KM9QfKfLZoYugICHPLc9ZFakiA6+nbNEA
   QLnNMNICUmVS4LsHbi/LbufwSM7/RN4vMvFDisMMrJck2eH8Jh9GsuLAv
   798PPSLzCRT/rYqgORuut0e9RLj4DNXSu+RVOvH4tTFA5NbW1Vm+ex/wR
   ssh0veNnrl+sj0r7/za4e4jIy4cwIcvtc6LLNdYqGE84UFfKuNY6M02jh
   /+RwHDc6l6uFntfQ3EBiYslZ3BonIHJZxX9SNYtgQac4S34YKwxu8ZZ0w
   KWgpElmDt/bHUcUI4ZCHhesoJxagMjO8e4Fl2WeqGGX4XGmOEKUyfD+yz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="252114448"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="252114448"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 03:11:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="639193497"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 03:11:44 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 18 May 2022 13:11:42 +0300
Date:   Wed, 18 May 2022 13:11:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] pinctrl: intel: make irq_chip immutable
Message-ID: <YoTGXmxTMFTBgwy9@lahna>
References: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
 <YoR/QXuS+VlLVWto@lahna>
 <YoSyTq2908EptTGd@smile.fi.intel.com>
 <YoS6EkfU1TdggKS/@lahna>
 <CAHp75VenknSRSUkGj9rKfzw2q1Mm-+zRrzAmcYRLdK1GJHDoHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VenknSRSUkGj9rKfzw2q1Mm-+zRrzAmcYRLdK1GJHDoHw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:05:38PM +0200, Andy Shevchenko wrote:
> On Wed, May 18, 2022 at 11:19 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, May 18, 2022 at 11:46:06AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 18, 2022 at 08:08:17AM +0300, Mika Westerberg wrote:
> > > > On Tue, May 17, 2022 at 07:38:19PM +0300, Andy Shevchenko wrote:
> > > > > +static const struct irq_chip intel_gpio_irq_chip = {
> > > > > + .name           = "intel-gpio",
> > > > > + .irq_ack        = intel_gpio_irq_ack,
> > > > > + .irq_mask       = intel_gpio_irq_mask,
> > > > > + .irq_unmask     = intel_gpio_irq_unmask,
> > > > > + .irq_set_type   = intel_gpio_irq_type,
> > > > > + .irq_set_wake   = intel_gpio_irq_wake,
> > > > > + .flags          = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> > > > > + GPIOCHIP_IRQ_RESOURCE_HELPERS,
> > > > > +};
> > > >
> > > > You still have the inconsistent alignment here.
> > >
> > > I'm not sure what problem do you see.
> >
> > I mean the tab alignment you use:
> >
> >         .name           = "intel-gpio",
> >         .irq_ack        = intel_gpio_irq_ack,
> >         .irq_mask       = intel_gpio_irq_mask,
> >         .irq_unmask     = intel_gpio_irq_unmask,
> >         .irq_set_type   = intel_gpio_irq_type,
> >         .irq_set_wake   = intel_gpio_irq_wake,
> >
> > All the other struct initializations in the driver use this style (and I
> > prefer it too):
> >
> >         .name = "intel-gpio",
> >         .irq_ack = intel_gpio_irq_ack,
> >         .irq_mask = intel_gpio_irq_mask,
> >         .irq_unmask = intel_gpio_irq_unmask,
> >         .irq_set_type = intel_gpio_irq_type,
> >         .irq_set_wake = intel_gpio_irq_wake,
> >
> > Hope this explains.
> 
> Yes, thanks!
> 
> Okay, can you give your conditional Ack if there are no other
> comments? I will fix it locally.

Sure. There was typo also in the second patch $subject, please fix it
too while you apply them. For both,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
