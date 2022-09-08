Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBC5B1988
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIHKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIHKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:01:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB1E4DF7;
        Thu,  8 Sep 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662631311; x=1694167311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w2tDfZt6u3hn+SCpvEA9SBmEoYmSetazfTtjlLehh7c=;
  b=Z47flTmERBehmSFH1KZkCHpMah28vsrJRAnb7oRndnb5JBmPL2uJRLE6
   ZdG2YV4a8Z0nq0zb/7du/9/vk2T3LhoafcoU12AlK9KJa9/oFsyFaRWkd
   PBlMJXfYJOcZCWoUeixpz7TV6geiTwLe/VBK5lNHQVUYtQullDz1heb0h
   dOjcc6dKGq9mTlTRgSI+Robj6x3iZMvMyLV4VKnfelCU+Sbq2cfggQg0O
   Mnhs7/9lbxwVEu2gSK9O4CVsVuOAKWo9ozYKO1YtF8y3DCfTbUZkyP6ty
   hyNH1H7KG8ItRcqhU1N/afisP0Ymg7C1ra1SSzKwLrNIo3oLVyXKRq9kN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358857801"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="358857801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:01:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614832034"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:01:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWELk-00A4K4-1a;
        Thu, 08 Sep 2022 13:01:32 +0300
Date:   Thu, 8 Sep 2022 13:01:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: wpcm450: Correct the fwnode_irq_get()
 return value check
Message-ID: <Yxm9fB/5IJS3MXGu@smile.fi.intel.com>
References: <20220905191408.73794-1-andriy.shevchenko@linux.intel.com>
 <YxkHaBKtiO9zVuKM@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxkHaBKtiO9zVuKM@probook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:04:40PM +0200, Jonathan Neuschäfer wrote:
> On Mon, Sep 05, 2022 at 10:14:08PM +0300, Andy Shevchenko wrote:
> > fwnode_irq_get() may return all possible signed values, such as Linux
> > error code. Fix the code to handle this properly.
> 
> It would be good to note explicitly here what a return value of zero
> means, i.e., as the documentation of of_irq_get says, "IRQ mapping
> failure", and why it should result in skipping this IRQ.

Not that I'm fun of duplicating documentation in the commit message,
but it won't take much in this case.

...

> >  		for (i = 0; i < WPCM450_NUM_GPIO_IRQS; i++) {
> > -			int irq = fwnode_irq_get(child, i);
> > +			int irq;
> >  
> > +			irq = fwnode_irq_get(child, i);

> (Unneccesary churn, but I'll allow it)

The point here is to see that we actually check something that we just got
from somewhere else. It's slightly better for reading and maintaining the
code as I explained in [1].

And there is a difference to the cases like

static int foo(struct platform_device *pdev, ...)
{
	struct device *dev = &pdev->dev;
	...
}

when we know ahead that if pdev is NULL, something is _so_ wrong that
it's not even our issue.

[1]: https://lore.kernel.org/lkml/CAHp75Vda5KX5pVrNeueQEODoEy405eTb9SYJtts-Lm9jMNocHQ@mail.gmail.com/

> >  			if (irq < 0)
> >  				break;
> > +			if (!irq)
> > +				continue;
> 
> Since irq == 0 seems to be an error condition, the following seems fine
> to me, and simpler:
> 
> -			if (irq < 0)
> +			if (irq <= 0)
>  				break;

Not sure it's the same by two reasons:
 1) break != continue;
 2) we might need to convert 0 to error if we ever go to report this

So, to me mapping error shouldn't be fatal to continue, but I would
like to hear your interpretation since you know this case much better
than me.

Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko


