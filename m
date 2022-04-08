Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4C4F99C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiDHPqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiDHPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:46:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCF939DF;
        Fri,  8 Apr 2022 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649432643; x=1680968643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gcJtOPIX2/0B3YxiUGz/EyzDxp0SAsqb/v7kxf3M3BU=;
  b=YIlwpyceiHV/M2vrggkScgP/UKLnGgX4BOlZCRHXsY94hevyknTt0V+F
   W4tGLSACYa5ddnCJtgehG86r8Fw4X6+M4ordmitHeV1GeoQPzSt+fFvP2
   EL6IQKBWeVhjawwd1UGPcQkfPKw02Ev2XQXkywbKSQl6AZ2g164mfsAwf
   74PE0+6bFJquoP0IneXW6qdWQY/eec5Diaaz8q9L4xRyWsUndLUE0BeC3
   +ejLVXqSJHwQ95Fnl4jb33fZ2Kv21BoMFyKxpGULirjSWcrVz6dzUKIJ7
   F1kcuvgyvQomHEVjVf1wrp0fOdn8sbEmxXDktcFCpKc+ZSnznDDjjwJRl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259218709"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259218709"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:43:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="589257568"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:43:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncqiH-000Lsk-PD;
        Fri, 08 Apr 2022 18:39:53 +0300
Date:   Fri, 8 Apr 2022 18:39:53 +0300
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
Message-ID: <YlBXSVyj88CqjGj4@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-6-andriy.shevchenko@linux.intel.com>
 <d1f873c6-150f-5f4d-7aa8-7bb15823d991@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f873c6-150f-5f4d-7aa8-7bb15823d991@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 05:22:21PM +0200, Krzysztof Kozlowski wrote:
> On 01/04/2022 12:35, Andy Shevchenko wrote:
> > Switch the code to use for_each_gpiochip_node() helper.

(...)

> >  /*
> >   * Iterate over all driver pin banks to find one matching the name of node,
> >   * skipping optional "-gpio" node suffix. When found, assign node to the bank.
> >   */
> > -static void samsung_banks_of_node_get(struct device *dev,
> > -				      struct samsung_pinctrl_drv_data *d,
> > -				      struct device_node *node)
> > +static void samsung_banks_node_get(struct device *dev, struct samsung_pinctrl_drv_data *d)
> 
> This is worth simplification anyway, so please split it to separate patch.

Not sure what to do and why it worth an additional churn.

> >  {
> >  	const char *suffix = "-gpio-bank";
> >  	struct samsung_pin_bank *bank;
> > -	struct device_node *child;
> > +	struct fwnode_handle *child;
> >  	/* Pin bank names are up to 4 characters */
> >  	char node_name[20];
> >  	unsigned int i;
> > @@ -1038,17 +1037,17 @@ static void samsung_banks_of_node_get(struct device *dev,
> >  			continue;
> >  		}
> >  
> > -		for_each_child_of_node(node, child) {
> > -			if (!of_find_property(child, "gpio-controller", NULL))
> > -				continue;
> 
> This does not look equivalent. There are nodes without this property.

Not sure I understand why not. The macro checks for the property and
iterates over nodes that have this property.

Can you elaborate, please?

> > -			if (of_node_name_eq(child, node_name))
> > +		for_each_gpiochip_node(dev, child) {
> > +			struct device_node *np = to_of_node(child);
> > +
> > +			if (of_node_name_eq(np, node_name))
> >  				break;
> > -			else if (of_node_name_eq(child, bank->name))
> > +			if (of_node_name_eq(np, bank->name))
> >  				break;
> >  		}
> 
> This patch has to wait till someone provides you a tested-by. I might do
> it around next week.

Fine with me, I will drop it from my repo for now.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


