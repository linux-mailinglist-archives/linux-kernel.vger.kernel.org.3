Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7552553AAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356007AbiFAQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355090AbiFAQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:09:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A7A502D;
        Wed,  1 Jun 2022 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654099765; x=1685635765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oZC6UP0stKwFCCsu2gFuJQpdMUHJaXRTUCn92+/3iA=;
  b=npxa+fbGJTKeo+ZBuLYeCUv1muXIYJ1+c3xLHlJKRVOPI03B1YJr+L4B
   0an6o/x8bHa/LfhCvYR1a2Y+2xmCbcGCIhRLPTkUaY4Ca3+nM/QemQ4MB
   2iyuM9AhqW0cnYBe+xzPbq/e7lJ4BPbxGCSsD7h0TTyviKzNKxmINzXLp
   T4WdhVUeXtVssN5fPsBOAzt0jYxtaIYMWrDNgSEE9ak9CRQIyWE35mGd5
   ++ZByCS5E73FRvi9iw0/5h3+eYVldDm2j4PaBs7MtUQ4+AHxMgXRhlm2z
   RwK1oWQvZhxKHvB4eduFwlOHl0Zq5qDvSqnb9VAeDM8ZuDwt4IDGNKTk8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257709041"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257709041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:09:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="680171311"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:09:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwQuL-000Qne-LA;
        Wed, 01 Jun 2022 19:09:17 +0300
Date:   Wed, 1 Jun 2022 19:09:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: wcove: make irq_chip immutable
Message-ID: <YpePLa0jbTLusGU9@smile.fi.intel.com>
References: <20220601154833.2173-1-andriy.shevchenko@linux.intel.com>
 <e965160d-08d1-f148-6452-f759053e7e99@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e965160d-08d1-f148-6452-f759053e7e99@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:51:03AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 6/1/22 8:48 AM, Andy Shevchenko wrote:
> > Since recently, the kernel is nagging about mutable irq_chips:
> > 
> >     "not an immutable chip, please consider fixing it!"
> > 
> > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > helper functions and call the appropriate gpiolib functions.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good to me
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks!

Please fix your tools so it won't split tag line and `b4` may automatically test it.


-- 
With Best Regards,
Andy Shevchenko


