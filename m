Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C141467F35
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383193AbhLCVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:25:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:7454 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343604AbhLCVZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:25:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236872753"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236872753"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:22:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="461027761"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:22:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtFzN-001v1G-QE;
        Fri, 03 Dec 2021 23:21:05 +0200
Date:   Fri, 3 Dec 2021 23:21:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Richard Hsu <saraon640529@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard_Hsu@asmedia.com.tw,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Subject: Re: [PATCH] gpio Add my driver new id
Message-ID: <YaqKQVV1+8ksQInA@smile.fi.intel.com>
References: <20211203092609.8502-1-Richard_Hsu@asmedia.com.tw>
 <CAMRc=McwkKNUt4JZWcUVyd9uiAwJBk7SPw1C3X_F0RH_Qa=row@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McwkKNUt4JZWcUVyd9uiAwJBk7SPw1C3X_F0RH_Qa=row@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:15:46AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 3, 2021 at 10:26 AM Richard Hsu <saraon640529@gmail.com> wrote:

Thanks, Bart, for pointing out to this.

> >  #define PT_TOTAL_GPIO 8
> > +#define PT_TOTAL_GPIO_EX 24

...

> > +       struct acpi_device *acpi_dev;
> > +       acpi_handle handle = ACPI_HANDLE(dev);

> > -       if (!ACPI_COMPANION(dev)) {
> > +       if (acpi_bus_get_device(handle, &acpi_dev)) {

What you are doing here is open coding the ACPI_COMPANION().
But see below.

...

> > +       if (!strncmp(acpi_dev_name(acpi_dev), "AMDIF031", 8))
> > +               pt_gpio->gc.ngpio = PT_TOTAL_GPIO_EX;
> > +       else
> > +               pt_gpio->gc.ngpio = PT_TOTAL_GPIO;

Instead of doing this...

> >  static const struct acpi_device_id pt_gpio_acpi_match[] = {
> >         { "AMDF030", 0 },
> >         { "AMDIF030", 0 },
> > +       { "AMDIF031", 0 },

Just use .driver_data here and if needed in the other ID tables and then simply
retrieve it (w/o any conditions) in the code above:

	pt_gpio->gc.ngpio = (uintptr_t)device_get_match_data(dev);

> >         { },
> >  };

> Please Cc Andy next time on any GPIO stuff related to ACPI. I'll let
> him comment on the code. Your commit message must be more descriptive
> - the title should say "gpio: <driver name>: <do this and that>".
> Please also add a commit message explaining what the code does in
> detail.

-- 
With Best Regards,
Andy Shevchenko


