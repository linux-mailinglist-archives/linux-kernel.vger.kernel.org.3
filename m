Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7F4AC29B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442715AbiBGPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383140AbiBGOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:44:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF27C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644245049; x=1675781049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/duGNHsUm97N0VAdH1ZLjtrQxZmGiFTO5lsQ0azM+M=;
  b=fU+ysjMhKNvQxxv1NKM5p24k8G+7FUGgbUiOZgk/j0s5mgBWVs/E0Czs
   u0/euEdzPUY5JaV556K21n11VV9jkr4oG9rZCeVL6fxnu3+A796S9YlTf
   JTUMmxGJvPqc7CZuX/vP8Gyz9p2F2xMLV+85ZJLlWuPDdyT6YpT9hIEPf
   qvLpIe6G4DCPW+h1Se799VGiSb5yH1ShbrXoOzxPqrHkgKKZmTDBUtDUV
   v2SYLt3KpITW01J+UPrqXk1aLy21iPod1a40LZUFWVqZ5u7Vfrlck26Ss
   RhPmiaEt1T2naSyKBzT72A7vnqwS7Z695HEHSjo0RSZnRX2+cL3TGRoo2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248493479"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248493479"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:44:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="700486892"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:44:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH5ES-001w7G-L3;
        Mon, 07 Feb 2022 16:43:08 +0200
Date:   Mon, 7 Feb 2022 16:43:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 0/4] gpiolib: A fix and a few cleanups
Message-ID: <YgEv/MIydfZlL1zQ@smile.fi.intel.com>
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:27:54PM +0200, Andy Shevchenko wrote:
> Patch 1 is a fix for wrong error code to user space.
> Patches 2-4 are small cleanups.

> Can be routed via my tree, or directly into GPIO, whatever maintainers
> prefer.

Bart, if the series is okay for you tell me which route to take?

> Changelog v3:
> - joined two patches into a single fix (Bart)
> - added Rb tag (Linus)
> - renamed for_each_gpio_desc_with_flag() macro to be descriptive (Johan)
> - added two new cleanups
> 
> Andy Shevchenko (4):
>   gpiolib: Never return internal error codes to user space
>   gpiolib: Introduce for_each_gpio_desc_with_flag() macro
>   gpiolib: Use short form of ternary operator in gpiod_get_index()
>   gpiolib: Simplify error path in gpiod_get_index() when requesting GPIO
> 
>  drivers/gpio/gpiolib-cdev.c  |  6 +++---
>  drivers/gpio/gpiolib-of.c    | 10 ++++------
>  drivers/gpio/gpiolib-sysfs.c | 14 ++++----------
>  drivers/gpio/gpiolib.c       | 35 ++++++++++++++++-------------------
>  drivers/gpio/gpiolib.h       | 19 +++++++++++++++++++
>  5 files changed, 46 insertions(+), 38 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


