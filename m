Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38EC4A4800
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359643AbiAaNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:24:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:5526 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378331AbiAaNYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643635461; x=1675171461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHSic1vnMAc/hHMVia9qRBO1wV44h4MkxxdP9b6Z+YQ=;
  b=JPWFgsbjPjAndxoNeIL2YaRWimf1k9oW8VetQK5kTnEfPelE3bfPpt3H
   ZYrTFuXHmtBU8zkCfGfcDhSoWvu8LE+V5I/5ynX+66xQ2S2+bwTBSer92
   MQJPMXtuucpHJhIi80nwpDr+KzL/D4bOcfxLuPJ1yNdqJ1kpC9uwqKw0H
   e5w0ZeCCBTBuZmv6dBt4xCUJaN5rPGnZJFmZiSKlHgkvonr0wrTz0vBQF
   J3Gih6sOSr86f0V7wZAHg77YQafWTH8PKZ+ioNCxStedB9U0UKFxVDdpK
   3WBX4GExAMT6g4OxNe7tjG9m9aJCxefF/G7zbicY3aGSNa6DGNTz2Xffq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228120579"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="228120579"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:24:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="564995577"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:24:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEWeH-00Gscc-0e;
        Mon, 31 Jan 2022 15:23:13 +0200
Date:   Mon, 31 Jan 2022 15:23:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YffiwCiFnqF1X1pD@smile.fi.intel.com>
References: <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
 <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com>
 <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
 <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <YffJujbpUGUqpIk/@smile.fi.intel.com>
 <5a3fffc8-b2d8-6ac3-809e-e8e71b66a8ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3fffc8-b2d8-6ac3-809e-e8e71b66a8ea@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 01:08:32PM +0100, Javier Martinez Canillas wrote:
> On 1/31/22 12:36, Andy Shevchenko wrote:

...

> >> +config TINYDRM_SSD130X
> >> +	tristate "DRM support for Solomon SSD130X OLED displays"
> >> +	depends on DRM && OF && I2C
> > 
> > Please, make sure that it does NOT dependent on OF.
> > 
> 
> I actually added this dependency deliberative. It's true that the driver is using
> the device properties API and so there isn't anything from the properties parsing
> point of view that depends on OF. And the original driver didn't depend on OF.
> 
> But the original driver also only would had worked with Device Trees since the
> of_device_id table is the only one that contains the device specific data info.
> 
> The i2c_device_id table only listed the devices supported to match, but then it
> would only had worked with the default values that are set by the driver.
> 
> So in practice it *does* depend on OF. I'll be happy to drop that dependency if
> you provide an acpi_device_id table to match.

The code is deceptive and you become to a wrong conclusion. No, the driver
does NOT depend on OF as a matter of fact. The tricky part is the PRP0001
ACPI PNP ID that allows to reuse it on ACPI-based platforms.

That said, please drop OF dependency.

-- 
With Best Regards,
Andy Shevchenko


