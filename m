Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF048EAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiANNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:40:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:62826 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbiANNkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642167632; x=1673703632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=POdeD4+1G0JKY0mLHWhbQ3GjB8ZbNAHvQrtkU1zviNg=;
  b=KxxnBzWjLxD4x/MqI916eAtVBZyNZ/YP9HvKyV3EHY8EGKJAaJl4B4xu
   qpt/x+QKKH2GvKcZvxNb2H+A73kEsCgOQf/Kjt82Nv6+Q76/79K1uTV87
   grmUqU1SwpdrYasJR2DV6nHX4wy1NQV/Vbbe9ERQaADnri4IStuZKrl6f
   U1Wr28VT/PY5Z9x8ohFl3oAh+mYnnfnIZqR7xEG2QxAizBjWy2QzIFuPB
   wA/cTUTYSDN07T+N7IWHuFlD/oFxH46Q/z1qHGOYBG79ocaER5sWIHkPX
   YpeEgzRi4GRHiA0JVmgZCsZakv9byWRzKRr/WzFaaWd/4q1yBDwnqCSvk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241807206"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="241807206"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 05:40:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="614341875"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 05:40:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n8Mn4-00AcqY-Hh;
        Fri, 14 Jan 2022 15:38:50 +0200
Date:   Fri, 14 Jan 2022 15:38:27 +0200
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
Message-ID: <YeF806Ucigo5vWmx@smile.fi.intel.com>
References: <20220111014046.5864-1-axe.yang@mediatek.com>
 <20220111014046.5864-4-axe.yang@mediatek.com>
 <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
 <83670f12a4eda1d8aecde3c0bf225642106d1267.camel@mediatek.com>
 <YeADWXPGPW253ssR@smile.fi.intel.com>
 <52901ebe0db555f8e58dc0d59cfd703c5a0fc2de.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52901ebe0db555f8e58dc0d59cfd703c5a0fc2de.camel@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:06:36AM +0800, Axe Yang wrote:
> On Thu, 2022-01-13 at 12:47 +0200, Andy Shevchenko wrote:
> > On Thu, Jan 13, 2022 at 03:58:52PM +0800, Axe Yang wrote:
> > > On Tue, 2022-01-11 at 13:46 +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 11, 2022 at 09:40:46AM +0800, Axe Yang wrote:

...

> > > > > +		host->pins_eint = pinctrl_lookup_state(host-
> > > > > >pinctrl,
> > > > > "state_eint");
> > > > > +		if (IS_ERR(host->pins_eint)) {
> > > > > +			dev_dbg(&pdev->dev, "Cannot find
> > > > > pinctrl
> > > > > eint!\n");
> > > > 
> > > > In debug mode of pin control this will bring a duplicate message.
> > > 
> > > Can you explain more about this comment?
> > > I don't understand what the 'duplicate message' refers for.
> > 
> > Have you chance to read the implementation of pinctrl_lookup_state()?
> 
> I have read pinctrl_lookup_state(), and if the 'duplicate message' you
> were talking about is 'using pinctrl dummy state...':
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c#L1214
> No, this message will not appear in debug mode if pins_eint not found
> because pinctrl_dummy_state is always FALSE. MTK Soc do not need dummy
> state support.

I see, thanks for explanation. I'm wondering how good or bad would be
the idea of adding a debug message on the !pinctrl_dummy_state case.

-- 
With Best Regards,
Andy Shevchenko


