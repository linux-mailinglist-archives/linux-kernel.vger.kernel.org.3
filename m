Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB74CD466
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiCDMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiCDMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:42:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2231B3A53;
        Fri,  4 Mar 2022 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646397714; x=1677933714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tToEW6BUY+JQKKIOnbayADvzQCRUYzF46ca/0eu8mY=;
  b=VgBnHHwXfLeN64VPLO+Ht5OsmUsXKC7aWcMv44L0P9OzWH3/abatRjZ5
   vMvMs5KipcN8m5Qn3gKClfIkZ267wXYli/CJxDUMlFP4tpNajnyBK097e
   uooEF/804DqVGDAR9OrZ9A39H9SKghwl+t0I69giurHVDyh2d7V4cHuJs
   zPbVJoT4qAYs3+jhOG+MN/J4PzinWuvQKcDm8XZ2bjWo+tr+l2UkPmIHt
   sRIu7tcEpUibUa13zeInlkJTbRfiSt2CMv8Nv1H9PmTZ5K1ecOD+z0Cbc
   25tvdJyWV+jvfYML3v6RZHa7RcjnXV8Wf4gTpC0+VXiDuLhF/P5g8889L
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="340398127"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="340398127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:41:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="494318508"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:41:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7F4-00BDfD-MH;
        Fri, 04 Mar 2022 14:41:06 +0200
Date:   Fri, 4 Mar 2022 14:41:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, colin.foster@in-advantage.com
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix interrupt parsing
Message-ID: <YiII4mMembqLiX5D@smile.fi.intel.com>
References: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
 <20220303203716.3012703-3-horatiu.vultur@microchip.com>
 <YiIIxXemSB8LIq8L@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIIxXemSB8LIq8L@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:40:38PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 03, 2022 at 09:37:16PM +0100, Horatiu Vultur wrote:
> > In the blamed commit, it removes the duplicate of_node assignment in the
> > driver. But the driver uses this before calling into of_gpio_dev_init to
> > determine if it needs to assign an IRQ chip to the GPIO. The fixes
> > consists in using of_node from dev.
> 
> ...
> 
> > -	irq = irq_of_parse_and_map(gc->of_node, 0);
> > +	irq = irq_of_parse_and_map(info->dev->of_node, 0);
> 
> Why platform_get_irq() can't be used?

Or actually _optional() variant of it?

-- 
With Best Regards,
Andy Shevchenko


