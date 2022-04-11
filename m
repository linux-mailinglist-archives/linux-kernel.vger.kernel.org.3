Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE44FBB81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiDKMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiDKMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:02:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B730E2A732;
        Mon, 11 Apr 2022 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649678412; x=1681214412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sC8CyttMimPSNhIr3hh4HcfuM59Ph6N7lGNcafQdvcs=;
  b=jqXvzjSStgCyRqvoJe3HZnI+q2y3XJh8E6mUbYsEQEEljEfhy4N71v2t
   Ns+ZpiWLX9hm5jCu6qwfqnBROgzcQ3JRJGTDDX6nw4lGHB9DjZ6MMBGEl
   oOONbDcSSiNWXvQW+4QiqtLtEM5DjIHO4bNzE6AEEs/axwzY+anicEVds
   KpttVF73a/+vW9D3NZiiWT8jxdtVMKBrij3QxOh1dmUsaxBIlDjl9frR2
   uWcvmeacufpMCpXRhrj6wmrem5IC0MvPc75mzIit3AUYI/PHBExqwm/zX
   l0ehMil4gbzh1ksUkyqamWiqcWouuLNL9as6GiLh8YCOPPirLpMQOx+Fu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242684842"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242684842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 05:00:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="699346695"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 05:00:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndsed-001CQ3-RA;
        Mon, 11 Apr 2022 14:56:23 +0300
Date:   Mon, 11 Apr 2022 14:56:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
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
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 05/13] pinctrl: samsung: Switch to use
 for_each_gpiochip_node() helper
Message-ID: <YlQXZ3Ye13rObMy8@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-6-andriy.shevchenko@linux.intel.com>
 <d1f873c6-150f-5f4d-7aa8-7bb15823d991@linaro.org>
 <YlBXSVyj88CqjGj4@smile.fi.intel.com>
 <3b527700-444e-1f6e-fee1-5cd6ed2ef7f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b527700-444e-1f6e-fee1-5cd6ed2ef7f9@linaro.org>
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

On Sat, Apr 09, 2022 at 03:33:49PM +0200, Krzysztof Kozlowski wrote:
> On 08/04/2022 17:39, Andy Shevchenko wrote:
> > On Fri, Apr 08, 2022 at 05:22:21PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/04/2022 12:35, Andy Shevchenko wrote:
> >>> Switch the code to use for_each_gpiochip_node() helper.
> > 
> > (...)
> > 
> >>>  /*
> >>>   * Iterate over all driver pin banks to find one matching the name of node,
> >>>   * skipping optional "-gpio" node suffix. When found, assign node to the bank.
> >>>   */
> >>> -static void samsung_banks_of_node_get(struct device *dev,
> >>> -				      struct samsung_pinctrl_drv_data *d,
> >>> -				      struct device_node *node)
> >>> +static void samsung_banks_node_get(struct device *dev, struct samsung_pinctrl_drv_data *d)
> >>
> >> This is worth simplification anyway, so please split it to separate patch.
> > 
> > Not sure what to do and why it worth an additional churn.
> 
> Makes this change smaller so it's easier to review.

https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git/log/?h=review-andy

That's how it looks like. Tell me if it is what you have had in mind.

-- 
With Best Regards,
Andy Shevchenko


