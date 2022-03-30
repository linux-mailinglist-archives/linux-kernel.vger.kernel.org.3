Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6598B4EC415
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiC3McE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiC3Mbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:31:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9585B3D0;
        Wed, 30 Mar 2022 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648642639; x=1680178639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=degjoFghFkob5qL3ehvoGOpozoU5J2XRIt2L6L1iub0=;
  b=Okt9Oqm+LDLdGXc/frHGOpysiYDcWjPX6TSDTb0sm+U+8pbb0EPbpKnH
   E84IkigOgB32vk6LO8/eoOeQYL8NYjmYdGoPGgzGQJQBMpmZ5ELJvVl5V
   rrFxOJwTn2nQL5uzglEgjFfrf0wp0Gx63hlIxlYHLPFCXiQTVBQf0vR+B
   8rtKaC46TFy/T2RysdOnna/u0kslAKlXet9PmDUXmhyHhpT8mJapGXtj1
   ASTGWiPe597Dc/uOFFt5pMDf5jcy0CH+0qh4raa/UgLBzPThojks7ZhgF
   sIt4OU1J8lD5w8ZHQcC+4cBiik/RlZyvQUnhbR3KT6O7iSDYwpOPORZvB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345964900"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="345964900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 05:17:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565512740"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 05:17:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZXFc-009OGn-0z;
        Wed, 30 Mar 2022 15:16:36 +0300
Date:   Wed, 30 Mar 2022 15:16:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 07/13] pinctrl: renesas: rza1: Switch to use
 for_each_gpiochip_node() helper
Message-ID: <YkRKI6W4vR/aCr8c@smile.fi.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-8-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWs+OuxV0cO=XGYvOOJ0Mctwu6fKV5HnkdRBXNKkLE3uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWs+OuxV0cO=XGYvOOJ0Mctwu6fKV5HnkdRBXNKkLE3uQ@mail.gmail.com>
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

On Wed, Mar 30, 2022 at 12:00:27PM +0200, Geert Uytterhoeven wrote:
> On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +       struct fwnode_reference_args of_args;
> 
> fw_args?

Perhaps just args as other drivers do?

...

> > -       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
> > -                                        np);
> > +       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pfw", fwnode);
> 
> This changes the label from e.g. "/soc/pinctrl@fcfe3000/gpio-11" to "gpio-11".

Hmm... It seems other way around, i.e. it changes from the name to full name.

> %pfwP?

But conclusion here is correct. Good catch!

...

> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for review and testing!

-- 
With Best Regards,
Andy Shevchenko


