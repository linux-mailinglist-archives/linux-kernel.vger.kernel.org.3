Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1A4EAC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiC2LQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiC2LQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:16:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491149F16;
        Tue, 29 Mar 2022 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648552486; x=1680088486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WW7g88rQ37IyUYcFgRuJ0tHqtRy6l/Sd1url/SgYtxc=;
  b=K+wygYLWZFOk+RJ11U9Z66aBwtbB1O1TCCLpz6oIBcqvN975juAj3U/m
   Ja3JYd2C2oilh/sRqJGuCVf0Wsi21+BUwxmeuFsqb3cbxRUI6ZckoA2td
   XDVSEu8lmLaUaKsBbuV02WgmgS+nXmCOVdi/zdx/q0f01oAnlmxFrYYtx
   ZEGSqTxsS2mp0mefMr23c8nMm8/MoNlUd5g6LMNmtemRhz1lXl3dU1l/j
   Kx6K6yGHPjeaoTrl2JOmV+nHZZSgeo7lLRV2iaqH5hUQ6ombPsd3EQRsb
   syvZRt6HxDdu4avxgM2ncQQp5u6jl6FdqnEvNG6kKCQA/tcQstIJ/JZoQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="322408088"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="322408088"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 04:14:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="787559197"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 04:14:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZ9nb-008hp9-9H;
        Tue, 29 Mar 2022 14:14:07 +0300
Date:   Tue, 29 Mar 2022 14:14:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabien DESSENNE <fabien.dessenne@foss.st.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 2/5] pinctrl: stm32: Replace custom code by
 gpiochip_count() call
Message-ID: <YkLp//IFvgohHycw@smile.fi.intel.com>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
 <20220325200338.54270-2-andriy.shevchenko@linux.intel.com>
 <44057328-2454-4f4d-cc90-b0ca35ba1e5a@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44057328-2454-4f4d-cc90-b0ca35ba1e5a@foss.st.com>
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

On Tue, Mar 29, 2022 at 09:59:32AM +0200, Fabien DESSENNE wrote:
> On 25/03/2022 21:03, Andy Shevchenko wrote:

Thanks for review, my answers below.

> > -	for_each_available_child_of_node(np, child)
> 
> Here we look for "available" child, while the new generic helper
> gpiochip_count() looks for any child, available or not.
> Would it be possible to hav gpiochip_count() looking for available child as
> well?

It's done already that way. The fwnode loop is done against available children.

> It looks like there is '_available_' version of
> 'device_for_each_child_node', maybe this shall be added too.

No need.

-- 
With Best Regards,
Andy Shevchenko


