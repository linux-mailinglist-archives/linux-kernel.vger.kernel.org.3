Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE76501B22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbiDNSgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiDNSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:36:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4EEBB86;
        Thu, 14 Apr 2022 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649961226; x=1681497226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRmVExYVaB1xDR78U0c+1m6aDPKj+y1FVLIHRd7bypw=;
  b=NsWrnO/Xax3gUkRFeDs/RxrYdu+pDeAuQEJCcif5O0yEX3YZezNqWm9s
   krF31/X+mOFPklyGJWRmDnd47Mpi6vmF3Dau4jEj7RqAJoqH5O6d0XSjW
   ta7y5j4pKHW2QXutqlQ7GGaq1FCbbNXTZgMLrMFVzEwWCsK4d13tiwDAu
   5B1C1+ionPUFmtF5A/HSTC40+lV/y1cv51GT9vkc0U4BQbOlL5dm527te
   VPMC99BNEoqJpWi2+dAdEOY0WW6+FE+CMvEH4t9t7WuFWuUQWwydEvzRx
   sbrrT+FDF85wD9mj5JY9+VGsTpVnZD3b5Myngti4iQEpLARuDQLlOsRzT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="325909054"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="325909054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 11:33:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527503151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 11:33:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nf4HH-002Rzo-IM;
        Thu, 14 Apr 2022 21:33:11 +0300
Date:   Thu, 14 Apr 2022 21:33:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 11/13] pinctrl: meson: Replace custom code by
 gpiochip_node_count() call
Message-ID: <Ylho5+teMJGxooYI@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <CGME20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9@eucas1p1.samsung.com>
 <20220401103604.8705-12-andriy.shevchenko@linux.intel.com>
 <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com>
 <CAHp75VfMPpfeMpawRyLo_GtLR8+gVGgm8zW-fatp6=9a9wK18A@mail.gmail.com>
 <CAFBinCCCtZvdp+01DdEE=-f7rZ8V46O125wKDqE1muA645sdUg@mail.gmail.com>
 <CAHp75VcYaGmEruEsi2UUrLU4=k3OpBn2YV8B0LhyrhtQ=uCTXg@mail.gmail.com>
 <Ylhnzg3bvbrfpoFi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylhnzg3bvbrfpoFi@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:28:30PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 14, 2022 at 07:06:21PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 14, 2022 at 6:32 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > > On Thu, Apr 14, 2022 at 3:51 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > [...]
> > > > > This patch landed in linux next-20220413 as commit 88834c75cae5
> > > > > ("pinctrl: meson: Replace custom code by gpiochip_node_count() call").
> > > > > Unfortunately it breaks booting of all my Amlogic-based test boards
> > > > > (Odroid C4, N2, Khadas VIM3, VIM3l). MMC driver is no longer probed and
> > > > > boards are unable to mount rootfs. Reverting this patch on top of
> > > > > linux-next fixes the issue.
> > > >
> > > > Thank you for letting me know, I'll withdraw it and investigate.
> > > If needed I can investigate further later today/tomorrow. I think the
> > > problem is that our node name doesn't follow the .dts recommendation.
> > >
> > > For GXL (arch/arm64/boot/dts/amlogic/meson-gxl.dtsi) the GPIO
> > > controller nodes are for example:
> > >   gpio: bank@4b0 {
> > >       ...
> > >   }
> > > and
> > >   gpio_ao: bank@14 {
> > >       ...
> > >   }
> > >
> > > See also:
> > > $ git grep -C6 gpio-controller arch/arm64/boot/dts/amlogic/*.dtsi
> > >
> > > Marek did not state which error he's getting but I suspect it fails
> > > with "no gpio node found".
> > 
> > Would be interesting to know that, yeah.
> > 
> > The subtle difference between the patched and unpatched version is
> > that the former uses only available nodes, it means that node is not
> > available by some reason and then the error would be the one you
> > guessed.
> 
> Looking into the difference between iterating via available nodes I have found
> nothing suspicious. Your DTSes do not have status property, so it assumes the
> node is available.
> 
> I'm quite puzzled what's going on there. Because I can't see what the logical
> difference the patch brought in.
> 
> P.S. In any case it's withdrawn now and shouldn't appear in the next Linux
> Next. But I would really appreciate more input on this.

Okay, now I got it. The "name" of the node is not the same as containing the
property with a given name. So, the faulting line of the code is this one:

gpio_np = to_of_node(device_get_named_child_node(pc->dev, "gpio-controller"));


-- 
With Best Regards,
Andy Shevchenko


