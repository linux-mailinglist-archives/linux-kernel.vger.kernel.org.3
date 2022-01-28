Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874F649FE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiA1Q2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:28:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:9372 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbiA1Q2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643387285; x=1674923285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDEdIyx/eA82CyxCDokO/3tZLh4lgebJYwjeiPMLUqE=;
  b=QoKMLjxhxXAMPvweGpnCH4NYh9N5pTf4F4EMdUmYjLjmLtVIh4DzePIC
   fl1uJXW7a0MpZpqnPVGB2gH3XizTgG9NRWNT2nxhfxDo3Ns+XysQJ4ubd
   1HWS8nO82OI0MjL0t/YYFLjj/touNqPM29WTvMKHSTl1uPVI+j0Ws6mnM
   8wShmmSlJus/wdHghdMr9DPX3UL6paQIMz16j+8vPx+j4cfGR/iFTV7g1
   aYBd22JnmMFDCAtXldPJCNQjhT9ie3lsYqk6kcRoQMQ23g7/LjZWg+mp1
   pRwyo45l9dqkFDp4gzHog+gJvdDzxx7KoC0B39X06hu1EUMiqgDNBvHIq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="333502956"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="333502956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 08:28:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="480790453"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 08:28:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDU5P-00FTd6-Vl;
        Fri, 28 Jan 2022 18:26:55 +0200
Date:   Fri, 28 Jan 2022 18:26:55 +0200
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
Message-ID: <YfQZT3NokrgF5OQA@smile.fi.intel.com>
References: <20220127215033.267227-1-f.fainelli@gmail.com>
 <YfP/TuEERCrgst+k@smile.fi.intel.com>
 <f28cba7f-6799-9f08-71b2-249a2a506913@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28cba7f-6799-9f08-71b2-249a2a506913@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:12:02AM -0800, Florian Fainelli wrote:
> On 1/28/2022 6:35 AM, Andy Shevchenko wrote:
> > On Thu, Jan 27, 2022 at 01:50:31PM -0800, Florian Fainelli wrote:
> > > After commit 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio
> > > hogs") a few error paths would not unwind properly the registration of
> > > gpio ranges. Correct that by assigning a single error label and goto it
> > > whenever we encounter a fatal error.
> > 
> > >   1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > While this seems legit per se, my eyes caught this:
> > 
> > 
> > >   	if (!girq->parents) {
> > > -		pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
> > > -		return -ENOMEM;
> > > +		err = -ENOMEM;
> > > +		goto out_remove;
> > 
> > Non-devm....
> > 
> > >   	}
> > >   	if (is_7211) {
> > >   		pc->wake_irq = devm_kcalloc(dev, BCM2835_NUM_IRQS,
> > >   					    sizeof(*pc->wake_irq),
> > >   					    GFP_KERNEL);
> > 
> > ...followed by devm.
> > 
> > It means more ordering bugs in the ->remove() and error path are lurking
> > around. Can you double check and be sure that we do not have a case where
> > non-devm registration code followed by devm?
> 
> It seems to me like we are fine with the patch as is, because:
> 
> - girq->parents is allocated with devm
> - pc->wake_irq is allocated with devm
> - name is allocated with devm
> 
> and those are the only variables being allocated for which we also process
> an error handling path.

Okay, thanks.

My worries that it might be the case when the GPIO ranges have been removed by
explicit call in ->remove() followed by some interrupt or so and oops or
misbehaviour because of that.

-- 
With Best Regards,
Andy Shevchenko


