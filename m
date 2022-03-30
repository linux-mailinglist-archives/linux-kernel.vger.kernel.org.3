Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BED4EC51F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiC3NE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbiC3NE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:04:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46B16D8DF;
        Wed, 30 Mar 2022 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648645362; x=1680181362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJ4bTg/Jje7M8hJIE2LrKZWgq7g/VxTTlmJq4PtT+5k=;
  b=eGC9eqbn/O1lwPZ8WOBCZu9swZTwbD/G1MrHFC5ZORqmACymd2MM+x2A
   JSW9OrMnCvg7m+xZJXNIa9AWoKBL75i01nDdo+GnJOGiSvzR6jyabSQ6+
   JRaa1PySzWhzyWBU2uWNemSkuU4N7ysu6+mJeX62fSjdWYbUsUd0NOMNA
   UoaH3do8Z130BzZ7Izrv1CHUSxXcSr2v/Op51gzFxRTffVCHjhSRexRSH
   ++pFBWqxGoeA/U7/wO7NRTv/YpqShVhFzjmIBfSS+MQ1gtqZ816bKVRn7
   bRjZJgg2SxYyhcDfSRO+/DuD0CZzCs/zbIxbA9/GYz8uh/1/j2NajxPuN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="240131002"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="240131002"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:02:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519668600"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:02:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZXxJ-009PSJ-LE;
        Wed, 30 Mar 2022 16:01:45 +0300
Date:   Wed, 30 Mar 2022 16:01:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabien DESSENNE <fabien.dessenne@foss.st.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
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
Subject: Re: [PATCH v2 04/13] pinctrl: stm32: Switch to use
 for_each_gpiochip_node() helper
Message-ID: <YkRUuS5YKXstq9T7@smile.fi.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-5-andriy.shevchenko@linux.intel.com>
 <ec5a56e6-9402-f80f-3c86-1820e39fec27@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5a56e6-9402-f80f-3c86-1820e39fec27@foss.st.com>
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

On Wed, Mar 30, 2022 at 02:32:36PM +0200, Fabien DESSENNE wrote:
> Hi Andy
> 
> 
> Thank you for the patch.
> 
> Fabien
> 
> On 29/03/2022 17:29, Andy Shevchenko wrote:
> > Switch the code to use for_each_gpiochip_node() helper.
> > 
> > While at it, in order to avoid additional churn in the future,
> > switch to fwnode APIs where it makes sense.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Thank you for the prompt review!

-- 
With Best Regards,
Andy Shevchenko


