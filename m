Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B5549BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiFMSjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343761AbiFMSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:38:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BD37A1A;
        Mon, 13 Jun 2022 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655134529; x=1686670529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VaArXUZWlGkR+Rg5TxqlTrvxLQWmF66TsY0IDaHvDJU=;
  b=i7tyoT18uRl6ySPsqGZst7te157jclRIvZKMGTMh1TS4sZZrECxYpygY
   +ZXwA7kT+ctDiUX3sPHxLJzo259MFPlaY7UFHQA28Eg2YwkgAi38LeTYw
   O80v9068dP90hPDwDiv2vCA6HdKM3kMNigzjYk88JuQ84TR3QKoTe3CB3
   QpLVcOF9VNnGVOCF66TFwcFZEqMspgH8ZVk552FaY8+mogb2/x7JEeq7x
   3TbF/MlwTzX36pYfC6/t2jhLGMZOYKaVr8KXO2wUVr1VRG5YP8NB7Tsyy
   zfCnuMmlh/JaHpckjv+PNulW9M6nczdRNyhkevR1bw7WODy0CB2Fr1gq9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261357223"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="261357223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 08:35:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="582283738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 08:35:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o0m64-000b8T-6V;
        Mon, 13 Jun 2022 18:35:20 +0300
Date:   Mon, 13 Jun 2022 18:35:19 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Dominik Kierner <dkierner@dh-electronics.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Message-ID: <YqdZN6mtEDF2CRtS@smile.fi.intel.com>
References: <7a78d57342754a5d9bd3ce7c7bf3fa47@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a78d57342754a5d9bd3ce7c7bf3fa47@dh-electronics.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:39:30AM +0000, Dominik Kierner wrote:
> On 5/25/2022 21:46, Javier Martinez Canillas wrote:

...

> > Thanks, I looked at the code briefly and think that there are things there that we
> > could use. I.e the 3-wire SPI support that's in panel-solomon-ssd130x-spi-3wire.c.
> 
> When writing my driver code, I wasn't even considering using regmaps,
> like You did in Your I2C-Code. If that's applicable for 3-wire-SPI,
> it would likely be the better, more generic option. Your SPI-code
> reuses these parts to some extent. For that case,
> ssd130x_spi_regmap_config.reg_bits would need be changed to 1,
> as the "register address" has a length of 1 bit and we are sending
> 9 bits over the line and not 16.
> Since we still have 2 bytes of host memory,
> it should still be compatible with the 4-wire write, right?
> Or would 3-wire SPI require a second regmap?

I believe the cleanest solution is to have different regmap configurations.


-- 
With Best Regards,
Andy Shevchenko


