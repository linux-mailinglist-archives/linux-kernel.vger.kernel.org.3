Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA249FBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbiA1OhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:37:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:26056 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349324AbiA1OhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643380628; x=1674916628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zw3XX/fGUlnc9TdMF747lxwOgOa9xXLLuawIXyx0fyg=;
  b=HmEjVop2/eTuKiydgurlgnGQOwukl6lUMNtoxDxmM5LYGQiikp9lktIk
   P6lIC3hVW3r8IMdQsapS/goLiuhfFBmRWFEMEEOW20E+g4Qy3mQqYtfnI
   bdQ8JbfqBIpL2tqG2VFSyneNXZKCru6ht+iMGXVPMTAD1ormtLfeaLJl/
   msB6I/Y2iGG17qd1K1bTySiHO8Zd3XqkC4hQaJtYmmdbFZBuFKflDklYc
   yFImkv4S9O1338E6fGyb7iVSqB14rOGnm95Zo/ytsPwS9w/7ZaH76w+Zw
   2HYnbF6pj3sQTBK6vqN10lg5dRK4g/C6t1EEjbwCxB1FFRP5+tq1r/MZB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247350302"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="247350302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:37:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697106965"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:37:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDSM3-00FRXn-4S;
        Fri, 28 Jan 2022 16:35:59 +0200
Date:   Fri, 28 Jan 2022 16:35:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jason Wang <wangborong@cdjrlc.com>,
        Marc Zyngier <maz@kernel.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pinctrl: bcm2835: Fix a few error paths
Message-ID: <YfP/TuEERCrgst+k@smile.fi.intel.com>
References: <20220127215033.267227-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127215033.267227-1-f.fainelli@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:50:31PM -0800, Florian Fainelli wrote:
> After commit 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio
> hogs") a few error paths would not unwind properly the registration of
> gpio ranges. Correct that by assigning a single error label and goto it
> whenever we encounter a fatal error.

>  1 file changed, 15 insertions(+), 8 deletions(-)

While this seems legit per se, my eyes caught this:


>  	if (!girq->parents) {
> -		pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto out_remove;

Non-devm....

>  	}
>  
>  	if (is_7211) {
>  		pc->wake_irq = devm_kcalloc(dev, BCM2835_NUM_IRQS,
>  					    sizeof(*pc->wake_irq),
>  					    GFP_KERNEL);

...followed by devm.

It means more ordering bugs in the ->remove() and error path are lurking
around. Can you double check and be sure that we do not have a case where
non-devm registration code followed by devm?

If that is the case it has to be fixed as well.

> -		if (!pc->wake_irq)
> -			return -ENOMEM;
> +		if (!pc->wake_irq) {
> +			err = -ENOMEM;
> +			goto out_remove;
> +		}
>  	}


-- 
With Best Regards,
Andy Shevchenko


