Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E14FBB97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbiDKMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiDKMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:05:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B33878C;
        Mon, 11 Apr 2022 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649678581; x=1681214581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9kbQrXBy9DVbHOYLkpvDDmu+4Dwl0husw8ro+88KO44=;
  b=Udb9ZPMuvaTVss/zPcH2La4doztWcJTF6UWdhE6cR1Miv8fRiUB5TjOn
   CrQQDXBuBWnepQIiFxs8ReGeim2MKmzcZ1zVeRaRZ2q6ZtwJVDpUp/L+S
   53cZ6GwtWsKqc8yrsdTdX6XRRbIfVsPbWeLbvlhwKnmcWWxj7o34t2F9A
   /aLAltZmUqziI9LJJixnmd/ufVljBN2IzbYpbeSXDGWwKGrvWmRZPMq+j
   rriVJHuET3CgElppTrADxU3JVNpCT/5q0gGdQwctfOgFnw/rUaQlActMX
   oz0nkXgJo4qILRZ2e7AU3paQ8L4c9JO4LVZ9Kbi6HRBzOo8hHfViVPWWY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261842043"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261842043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 05:02:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="654594670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 05:02:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndshK-001CUl-He;
        Mon, 11 Apr 2022 14:59:10 +0300
Date:   Mon, 11 Apr 2022 14:59:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
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
Subject: Re: [PATCH v4 00/13] gpiolib: Two new helpers and way toward fwnode
Message-ID: <YlQYDnCNuTibuVi1@smile.fi.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
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

On Fri, Apr 01, 2022 at 01:35:51PM +0300, Andy Shevchenko wrote:
> This is a spin-off of the previous work of switching GPIO library
> to use fwnode instead of of_node. Here we introduce a couple of
> a new macro helpers, which allows to switch some of the drivers
> to use fwnode and partially fwnode APIs. As a result of this cleanup
> a few drivers switched to use GPIO fwnode instead of of_node.
> 
> Bart, Linus, I can take it thru my tree with an immutable branch if
> it's the way you prefer, otherwise please suggest on how to proceed.

I'm going to push this, without samsung patch(es), but addresing latest
Geert's comment, to my for-next branch pending for PR to GPIO subsystem.

Please inform me within a few hours, if something should be postponed /
dropped / etc.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


