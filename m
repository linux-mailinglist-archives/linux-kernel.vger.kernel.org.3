Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DD5A8664
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiHaTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiHaTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:03:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBEBD170;
        Wed, 31 Aug 2022 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661972612; x=1693508612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oc5afPBJoiKAq9k8AffdBfDU/q/uf+1J66UG/80FFUk=;
  b=MHTZ4Xeb4dGkuPCCxias8NyyXDdBA1OzOSllAph/1IzdWprvpuxrqMSf
   t3qwD3OvSjs/HLvP7ET5AZHoSZsfrFhQ1FWPHG8fWODT9i1fq+RwtDWXh
   3uc9ZKNAdECuuzhFC8rnb5DY2E3kfxVX1NXKga76Mqszlnr125yFK+3Q4
   GRtYuLQEqYkyjJBaLn0GNhHxGnF7rbrqwfFvavILUh4nLZ0MmHN/jFNyl
   iyM7dEbgk2A2vDqb4lUxoyWnZuGbMYxORc3sYJ2arqZ/OvXcYC28ywnas
   lVu2VlSvjqIpUL68DD2gp+1hoZMqEkjMH7VUw9bDRLzsB2hAPtUIWUXBV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294263043"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="294263043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:03:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="680525696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:03:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTSze-006VQP-0a;
        Wed, 31 Aug 2022 22:03:18 +0300
Date:   Wed, 31 Aug 2022 22:03:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/1] gpio: rockchip: Switch to use fwnode instead of
 of_node
Message-ID: <Yw+wdUvRm8rIAK4G@smile.fi.intel.com>
References: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdQiBHr3cDPWN_PRj2nGVoG-GJJyRNrHNwTaAUvz=35ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdQiBHr3cDPWN_PRj2nGVoG-GJJyRNrHNwTaAUvz=35ew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:11:36PM +0200, Bartosz Golaszewski wrote:
> On Wed, Aug 31, 2022 at 3:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -       bank->clk = of_clk_get(bank->of_node, 0);
> > +       bank->clk = of_clk_get(np, 0);
> 
> Why did you stop above? Why not regular clk_get here?

Indices... And there is no non-OF API for that.

> >         if (IS_ERR(bank->clk))
> >                 return PTR_ERR(bank->clk);
> >
> > @@ -668,7 +660,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
> >         if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
> >                 bank->gpio_regs = &gpio_regs_v2;
> >                 bank->gpio_type = GPIO_TYPE_V2;
> > -               bank->db_clk = of_clk_get(bank->of_node, 1);
> > +               bank->db_clk = of_clk_get(np, 1);
> 
> Ah, the clocks don't have names in DT? That's unfortunate...

Yeah...

-- 
With Best Regards,
Andy Shevchenko


