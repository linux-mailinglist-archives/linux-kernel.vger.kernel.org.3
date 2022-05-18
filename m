Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026A52B63E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiERJTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiERJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:19:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E42D1CC;
        Wed, 18 May 2022 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652865560; x=1684401560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4vHAuot1/wnt2e2b1J2hjTc823BIiYYt7U1IpgjCpw=;
  b=PgPDbHVewK8+U5w+QIWOJoPw2/vqY5GAPsuf0fIUJLLrePXG+xcj3RyH
   20XG3fKwpUad7eKPAbdjQ1lt5y74LYWwyrux6/jpgrvCESaWCqCzHu4dY
   2epSnzmUMxf57WfZszlJot+SoImYn/tzbIJ6ogItbl7URDXFuJ1eCSoXb
   mA4dOu+uDdbIDIuKnqK1vtjEBnIE7uvMrqQRMUoShbo+NCgQd0ouI5Wbm
   LE2fVL1R7uWC4vDhu7NcJdyCecsCIhpAtvMAvlCn2gk058ChWBcEdos9e
   r7HltvLMycZw16LPY8Tdsx41/bOznuaEfAozYLdQNpn6jnKHKGmmE9XXg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="259144766"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="259144766"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 02:19:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="742234478"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 02:19:16 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 18 May 2022 12:19:14 +0300
Date:   Wed, 18 May 2022 12:19:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] pinctrl: intel: make irq_chip immutable
Message-ID: <YoS6EkfU1TdggKS/@lahna>
References: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
 <YoR/QXuS+VlLVWto@lahna>
 <YoSyTq2908EptTGd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoSyTq2908EptTGd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:46:06AM +0300, Andy Shevchenko wrote:
> On Wed, May 18, 2022 at 08:08:17AM +0300, Mika Westerberg wrote:
> > On Tue, May 17, 2022 at 07:38:19PM +0300, Andy Shevchenko wrote:
> > > +static const struct irq_chip intel_gpio_irq_chip = {
> > > +	.name		= "intel-gpio",
> > > +	.irq_ack	= intel_gpio_irq_ack,
> > > +	.irq_mask	= intel_gpio_irq_mask,
> > > +	.irq_unmask	= intel_gpio_irq_unmask,
> > > +	.irq_set_type	= intel_gpio_irq_type,
> > > +	.irq_set_wake	= intel_gpio_irq_wake,
> > > +	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> > > +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
> > > +};
> > 
> > You still have the inconsistent alignment here.
> 
> I'm not sure what problem do you see.

I mean the tab alignment you use:

	.name		= "intel-gpio",
	.irq_ack	= intel_gpio_irq_ack,
	.irq_mask	= intel_gpio_irq_mask,
	.irq_unmask	= intel_gpio_irq_unmask,
	.irq_set_type	= intel_gpio_irq_type,
	.irq_set_wake	= intel_gpio_irq_wake,

All the other struct initializations in the driver use this style (and I
prefer it too):

	.name = "intel-gpio",
	.irq_ack = intel_gpio_irq_ack,
	.irq_mask = intel_gpio_irq_mask,
	.irq_unmask = intel_gpio_irq_unmask,
	.irq_set_type = intel_gpio_irq_type,
	.irq_set_wake = intel_gpio_irq_wake,

Hope this explains.
