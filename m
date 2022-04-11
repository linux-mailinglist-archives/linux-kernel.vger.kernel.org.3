Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDE4FBB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbiDKLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbiDKLr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:47:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF4F43481;
        Mon, 11 Apr 2022 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649677544; x=1681213544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r5Ar8qxrxZpK4XRu/tA3qWYavit0uwaROYPXccoJAjE=;
  b=HKdg96oTw6HeyMFhfPjS2ZBUZOsgiEUl5qaGVH/l/OkajNRH+t3fY+Hz
   UNjijB2yVrGE97oepAqsQ7Nk0IpUJOXGeaxp5bLWSLKtSH4taKw700uBi
   +rMVj+nct0sOGo/Hh3BtLdqyTh06TmXqMdM5b2JaBG36GrdBm2bZht5LX
   QQ8WzViqTz0cwgchPcF3UpQ437fB+RnzXOsePm/+R12GfpZknerrwdub1
   7xxg546NkLYysTDhZxkENJSOB+DhBXbv+OA6/1Y1PC1gI+8roXZqyVaBL
   BT1wa3fRq1rSs1gK6dc6qhcXdgUi+lxpqY1jK4lElRr6/vatBtdUt4QpS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="262274364"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="262274364"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:45:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="622798226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:45:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndsQJ-001CCZ-MO;
        Mon, 11 Apr 2022 14:41:35 +0300
Date:   Mon, 11 Apr 2022 14:41:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
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
Subject: Re: [PATCH v4 09/13] pinctrl: meson: Rename REG_* to MESON_REG_*
Message-ID: <YlQT7w1XSbnkNI9E@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdX8zWA-3_=Je7sB_72G8Ky7-syqCH-RXGxNMazUipW-2g@mail.gmail.com>
 <YlQAn9+4kdB0F/4d@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQAn9+4kdB0F/4d@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:19:11PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 11, 2022 at 11:04:00AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 1, 2022 at 12:36 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > >         NUM_REG,
> > 
> > MESON_NUM_REG?
> 
> Hmm... Only one place where it's defined and used, but I can do it, sure.

Updated locally.

-- 
With Best Regards,
Andy Shevchenko


