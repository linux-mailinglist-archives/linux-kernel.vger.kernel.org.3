Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E245AE6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiIFLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiIFLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:47:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367B41D2C;
        Tue,  6 Sep 2022 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662464864; x=1694000864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZFdAqLLCkAK18dTg0m9aGKuAoPgAnLxj5S7NDofG9Z0=;
  b=LQmo1ThsyO5x/8M/mv8jXowR6x/kLHpYxuWkTPBvWKzkX+fi2heAQzaL
   DzGee0KJBhlZuSLTnLbYXlMScgG//UG1eJOFOAkBVckz5cgRRI+RCIXkn
   rX4Xw24+unJSLIJVLZG4DMMee7N5vOGuAF2pRhUY4wtRnp3+cvbkYB1u4
   vPvsgtrCHmil/9w/FHBGTY202qzs5l7L132g7kC0SpeMEsuasJkozdZ43
   NJKz6c1mEz6sIWvTjh+2ZFBay+smGhuS2ycfq5jJPO3F+2xbB67gyPyra
   lJ1hyDfiU39F4zXBVQ+SHbmn6FIOKw9a8xdBBP7qUNo4T6FdrIeBge56p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="279585983"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279585983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:47:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682371275"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:47:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVX3K-009663-1t;
        Tue, 06 Sep 2022 14:47:38 +0300
Date:   Tue, 6 Sep 2022 14:47:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 1/1] pinctr: microchip-sgpio: Correct the
 fwnode_irq_get() return value check
Message-ID: <YxczWhMyDJgC5jmP@smile.fi.intel.com>
References: <20220905190849.73194-1-andriy.shevchenko@linux.intel.com>
 <21f2241f19003a1210bd475883ee077b@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f2241f19003a1210bd475883ee077b@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:24:43AM +0200, Michael Walle wrote:
> Am 2022-09-05 21:08, schrieb Andy Shevchenko:
> > fwnode_irq_get() may return all possible signed values, such as Linux
> > error code. Fix the code to handle this properly.
> > 
> > Fixes: be2dc859abd4 ("pinctrl: pinctrl-microchip-sgpio: Add irq
> > support (for sparx5)")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Michael Walle <michael@walle.cc>

Thanks! I will send a v2 since I have to fix a typo in the Subject.

> Btw. do we care about EPROBE_DEFER?

In the original code this big (unsigned) value was added as parent IRQ and
things wouldn't work, with the proposed change IRQ won't work, but at least
in robust way without any surprises (whatever big parent IRQ number mean).

I think the people who have access to hardware and different configurations
of the kernel may or may not add the support later on.

-- 
With Best Regards,
Andy Shevchenko


