Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681854A30A9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352725AbiA2QgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:36:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:28556 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbiA2QgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643474167; x=1675010167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NeN+U8iKMJdDOcMiYQHwhsKC4blyvRV8SKBOfqOcU+4=;
  b=g3UMNyPMjRQLa4CRSF4wM9kWg+HLuSxbX6gqbcKRbDwwME7YpMxpQh6F
   zjZDBt13tVbt6uxuTE2Mc5KOQwQDpqTfSX1MZ+ivaPIYf+jYi5e74vYiL
   FMx5oLE8Vkgw/qjMrI4ZwPVxl8eVImhNXvGRH0s+nOaGQRer+i+9kQbTD
   LWQbCV2yFAcpkM3OAqDdxfGH+saQj/46ppG1Fgl/SqvkpFrmJ+QGW05AK
   cOgnqjzm/tY/fxGbrQQGUcvU2Ed7Rof16SZSH4dwXI6V1iNe9QgaYXdUm
   UALg8wOA2xtMdDQdzNBf+KJw5vNr9TWmw3G4ReEAacG6AjBTRvKnpwui0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="230856813"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="230856813"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 08:36:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="496431763"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 08:36:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDqgm-00FxsL-CB;
        Sat, 29 Jan 2022 18:35:00 +0200
Date:   Sat, 29 Jan 2022 18:35:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tsuchiya Yuto <kitakar@gmail.com>
Subject: Re: [PATCH] staging: media: atomisp: Use BIT macro instead of left
 shifting
Message-ID: <YfVstOJ38OTtd43n@smile.fi.intel.com>
References: <20220129113821.324180-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129113821.324180-1-mosescb.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 12:38:04PM +0100, Moses Christopher Bollavarapu wrote:

It's a bit too many people in Cc list (I dropped more than a half in this reply).
I would suggest to use my script [1] or look into it for a hint how to reduce it.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.

In some cases it might fix a (theoretical) UB issue.

> Example: BIT(7) = (1UL << 7)

...

> +		s_config->source.tpg.x_mask = BIT(4) - 1;

> +		s_config->source.tpg.y_mask = BIT(4) - 1;

> +		s_config->source.tpg.xy_mask = BIT(8) - 1;

For masks you may use GENMASK().

...

> -		irq = irq & 1 << INTR_IIR;
> +		irq = irq & BIT(INTR_IIR);

It may be:

	irq &= BIT(...);

...

> -	irq = irq & 1 << INTR_IIR;
> +	irq = irq & BIT(INTR_IIR);

Ditto.

...

> -		virt += (1 << PAGE_SHIFT);
> +		virt += BIT(PAGE_SHIFT);

This is weird. Shouldn't be as simple as

	virt += PAGE_SIZE;

?

...

>  enum ia_css_sp_sleep_mode {
>  	SP_DISABLE_SLEEP_MODE = 0,
> -	SP_SLEEP_AFTER_FRAME = 1 << 0,
> -	SP_SLEEP_AFTER_IRQ = 1 << 1
> +	SP_SLEEP_AFTER_FRAME  = BIT(0),

> +	SP_SLEEP_AFTER_IRQ    = BIT(1)

While at it, add a comma here.

>  };

...

> +	IA_CSS_DEBUG_DUMP_ALL = BIT(14)  /** Dump all device parameters */

Ditto.

...

On top of this don't forget to add

	#include <linux/bits.h>

to the modified header files.

-- 
With Best Regards,
Andy Shevchenko


