Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B814D006E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiCGNuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCGNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:50:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783622F01B;
        Mon,  7 Mar 2022 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646660974; x=1678196974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dIQqO5t+tsHUp2VyYbqEKMh07HoUStLQJRGqMjZQaiM=;
  b=Carlon8CfQm6v+o04jK1DN+se+RVdtkO7sy7kThSihl8NVz6ShA7HMHJ
   1FDW7Y4bN39QlANXxOp2oO3sXHSIUyGswlEDwmwi6Xq5ztbA4uoe4NfkN
   AGT8HtcyLrJeE9EL2OKAyMnXs0UWQ/pHE4R1mUUYD3dsxsNr/cGtTxHSl
   wChZFTJyI2rE6t1Aop6Cyalz8p0m/0zV31uNM7KRxtwLoasTHEVkgZVEE
   SPJ5BSS/FvYkwZNL8EZ+U4oHrFCjFYV3CJjTVKD8cBJn9GrrZl2dw1i2U
   dMFi9zAX4kVva4Ya7NohmkKWKVPuvAAxBBUwbSOz841A4tTZeCFkHJ/og
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254120525"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254120525"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:49:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643250216"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:49:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRDjD-00CnRy-7k;
        Mon, 07 Mar 2022 15:48:47 +0200
Date:   Mon, 7 Mar 2022 15:48:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to
 microseconds
Message-ID: <YiYNPhUoXH8XakKO@smile.fi.intel.com>
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3_W49Wq5-zaxdNzELW87OogEN5wW6XQnF9aMpZrRvBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md3_W49Wq5-zaxdNzELW87OogEN5wW6XQnF9aMpZrRvBA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 01:48:10PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 7, 2022 at 12:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It appears that GPIO ACPI library uses ACPI debounce values directly.
> > However, the GPIO library APIs expect the debounce timeout to be in
> > microseconds.
> >
> > Convert ACPI value of debounce to microseconds.
> >
> > While at it, document this detail where it is appropriate.

> Do you have some more stuff coming up for fixes

I don't think so.

> or do you want me to queue it directly?

Yes, please take it directly, thanks!

-- 
With Best Regards,
Andy Shevchenko


