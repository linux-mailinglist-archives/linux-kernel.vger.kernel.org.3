Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3773A49813E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbiAXNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:38:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:10476 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242805AbiAXNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643031485; x=1674567485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a1PvZoXdi3eZ4pNxeDvVQM8Mgu1K/7QAjtKXbKbV6xk=;
  b=a5iZ+wfowl1QoAkaq8WEVMzchJJ5WZvbi1TIZrPQpEbXIcN+36Tt8L09
   gJZovggf570T0Xa+SMKshUV2jFMOsKJiLytKC7s7n3CTac+hlFnW++EWZ
   /fi+G5GFmuTtCbNHCkzo4c6ZNbAAX0AOjphz8H8GnDK7A3VIYabird6wq
   zKD+Ja0W+fIYpq58eKCnl7Pa7Y6Oc70r5QTSY+UBzKZYFVtG62Lzw1+NP
   WmFc3ujdfyRVD6nvkOpADL+GM8lRkmlf38EPJptIFfh3coElB2vQmS5yX
   t7IkCeb7yvG+9GwI2muCwfSaAgC1HJMvcfXTxWaoptHCvZ/CthLCcE2Cw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332398208"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332398208"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:38:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479074173"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:38:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nBzWh-00Du6c-MU;
        Mon, 24 Jan 2022 15:36:55 +0200
Date:   Mon, 24 Jan 2022 15:36:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Fix a glitch when updating IRQ
 flags on a preconfigured line
Message-ID: <Ye6rd3UzmLoMWq7S@smile.fi.intel.com>
References: <20220119181915.27519-1-andriy.shevchenko@linux.intel.com>
 <YekS9O5Xhl6VL9GM@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekS9O5Xhl6VL9GM@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:44:52AM +0200, Mika Westerberg wrote:
> On Wed, Jan 19, 2022 at 08:19:15PM +0200, Andy Shevchenko wrote:
> > The commit af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer
> > when switching to GPIO") hadn't taken into account an update of the IRQ
> > flags scenario.
> > 
> > When updating the IRQ flags on the preconfigured line the ->irq_set_type()
> > is called again. In such case the sequential Rx buffer configuration
> > changes may trigger a falling or rising edge interrupt that may lead,
> > on some platforms, to an undesired event.
> > 
> > This may happen because each of intel_gpio_set_gpio_mode() and
> > __intel_gpio_set_direction() updates the pad configuration with a different
> > value of the GPIORXDIS bit. Notable, that the intel_gpio_set_gpio_mode() is
> > called only for the pads that are configured as an input. Due to this fact,
> > integrate the logic of __intel_gpio_set_direction() call into the
> > intel_gpio_set_gpio_mode() so that the Rx buffer won't be disabled and
> > immediately re-enabled.
> > 
> > Fixes: af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer when switching to GPIO")
> > Reported-by: Kane Chen <kane.chen@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Please mark this for stable too.

Pushed to my review and testing queue with the Grace Kao's tag, thanks!

-- 
With Best Regards,
Andy Shevchenko


