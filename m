Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA548D607
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiAMKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:49:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:5804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbiAMKtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642070953; x=1673606953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTYhz+JLVLGh52BwP1c/i/glpIIbyehr0ElDLiBRGfE=;
  b=N7ehVD3OVNtNd2u/wPc5RpAvWtWARGUSiYAdYeCNWBsnL8AAWsLXNJXC
   V5TB5S5aKpq40jk+7ebBVW2zYJtNag6xIp2oXrJJ5zhyGQ5IiCQscuwwh
   XwHV8C5whEho9NXHfMThvzZ5ky26K7ygv4oQcwIcFNqaXUHF5YsN0IEV9
   lB5T/LohROQ9JdQ3YpLaMT3TSZEBCxAIAxPLe5Y2nkI3cLwXi0RqoE5eH
   idYsJPiOP3qJGaHcqpxeX8uPgjc+seX1mwn6W/Z6Enn6D4QQUrd8XbAFY
   Imh68lrbTiyhPt1OtPDAbNgu8aIvzGECdQqzjEhG4alKOL6W4sbliQf08
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="231326202"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="231326202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:49:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="593310113"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:49:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7xe5-00A9zW-RM;
        Thu, 13 Jan 2022 12:47:53 +0200
Date:   Thu, 13 Jan 2022 12:47:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mmc: mediatek: add support for SDIO eint irq
Message-ID: <YeADWXPGPW253ssR@smile.fi.intel.com>
References: <20220111014046.5864-1-axe.yang@mediatek.com>
 <20220111014046.5864-4-axe.yang@mediatek.com>
 <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
 <83670f12a4eda1d8aecde3c0bf225642106d1267.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83670f12a4eda1d8aecde3c0bf225642106d1267.camel@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:58:52PM +0800, Axe Yang wrote:

> But for the comment for 'dev_dbg', can you explain more about that?

Sure.

> On Tue, 2022-01-11 at 13:46 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 11, 2022 at 09:40:46AM +0800, Axe Yang wrote:

...

> > > +		host->pins_eint = pinctrl_lookup_state(host->pinctrl,
> > > "state_eint");
> > > +		if (IS_ERR(host->pins_eint)) {
> > > +			dev_dbg(&pdev->dev, "Cannot find pinctrl
> > > eint!\n");
> > 
> > In debug mode of pin control this will bring a duplicate message.
> 
> Can you explain more about this comment?
> I don't understand what the 'duplicate message' refers for.

Have you chance to read the implementation of pinctrl_lookup_state()?

-- 
With Best Regards,
Andy Shevchenko


