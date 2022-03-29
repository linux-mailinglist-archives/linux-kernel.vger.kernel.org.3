Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723784EAD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiC2M1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiC2M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:27:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F44D9C1;
        Tue, 29 Mar 2022 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648556751; x=1680092751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4gfQZ727rl7OXibsvWflHV4WHOqBqSX/MZ7Umzjj+U=;
  b=hTOMwYLmd5r+rqE7BtdFiUKsn2Enep2Mdr/hIep4uQGm0f0IcAi58d0t
   PULxF3zK06I27mRsmOd5t4qwZCx16bDluOdf2XF7HkOyHAVgC7eVNiZNm
   ozb2NpuXNKgq4/XhqKdvETHMoM39ZB2YI8Mbh4CDPTSGPiSInjyxecZNW
   eVIs9931oGuS90Y2RvF3ptaA01BkU6G34Cy9DKFLrSrZXKnkyfLushqQm
   3Ms/z3Y4iy5NRlS0oSSG1e1+Iy393TVHUhFeZJa8W4D8udllThbZGqf0Z
   LaDQ5gsW3uN/bb4h+BgJgp3kyxUoGfKQ4KYiJE/Q7Tj5D1CwfUdy0qGZA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258065891"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="258065891"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 05:25:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="518900483"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 05:25:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZAuN-008jlQ-PL;
        Tue, 29 Mar 2022 15:25:11 +0300
Date:   Tue, 29 Mar 2022 15:25:11 +0300
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
Message-ID: <YkL6p89LpPS4kLHo@smile.fi.intel.com>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
 <20220325200338.54270-2-andriy.shevchenko@linux.intel.com>
 <ca54534d-9752-44fc-7341-a8b45e1a00d7@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca54534d-9752-44fc-7341-a8b45e1a00d7@foss.st.com>
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

On Tue, Mar 29, 2022 at 02:07:01PM +0200, Fabien DESSENNE wrote:
> Hi Andy
> 
> Thank you for your the clarification.

> Reviewed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Thanks!

In v2 I'm going to add another patch and the first (against gpiolib) will be
split to two. This patch will be almost unchanged: I've decided to rename
gpiochip_count() to gpiochip_node_count(), otherwise it's the same. So, I'll
keep your tag.

-- 
With Best Regards,
Andy Shevchenko


