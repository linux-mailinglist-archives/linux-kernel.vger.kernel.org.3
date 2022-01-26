Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E534649CBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiAZOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:11:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:29900 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241866AbiAZOLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206295; x=1674742295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37Crpy1HQSpJjEfNxm/BR1LrwtVeACM1zBGmbeLzZvQ=;
  b=lai4Ypn2F3kdocLmGCTikTM0zswzuA78Fxj+0I95m55T78TMMBccF+6n
   SpOvonMYU/5dZHjSIOF0kC4673GwMTfgYemrZprJBA6FFTrS2ETOD/tep
   KwggAmOCSR9FTTCkik/1NJd0A1ntGtUu+ZpZxm3FyXCIKOd3gRqBRXtZo
   wfYWi0Ccl0xz7BLKdU87qEXBnsNZLs9pisxJXYOBrNuklOwAo3rH1Vefn
   7Prnu66S1r2NZOrN+6yvVvCEhs/DZniV/Px9cSIqJW7qcCvyG39p46j3w
   br760N4LHWpnHfpNylaXcQxhjsxKabEJGjMPyMAME4T18plRQ4JmH14TH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307270154"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="307270154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:11:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="696250344"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:11:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCizu-00EcTp-VD;
        Wed, 26 Jan 2022 16:10:06 +0200
Date:   Wed, 26 Jan 2022 16:10:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YfFWPmG2D093gz4N@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
 <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFV4EJosayH+e6C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:08:32PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 02:46:08PM +0100, Javier Martinez Canillas wrote:
> > On 1/26/22 14:12, Andy Shevchenko wrote:

...

> > I've just bought a SSD1306 (I2C) based one and will attempt to write a DRM
> > driver using drivers/staging/fbtft/fb_ssd1306.c as a reference.
> 
> You should take ssd1307fb.c instead. And basically create a MIPI based driver
> for I2C. Then we won't go same road again for other similar devices.

For the record it supports your device:

static const struct i2c_device_id ssd1307fb_i2c_id[] = {
{ "ssd1305fb", 0 },
{ "ssd1306fb", 0 },
{ "ssd1307fb", 0 },
{ "ssd1309fb", 0 },


-- 
With Best Regards,
Andy Shevchenko


