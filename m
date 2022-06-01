Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899253AB6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354250AbiFAQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbiFAQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:58:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BAC313B1;
        Wed,  1 Jun 2022 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654102709; x=1685638709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gwfhI1oZGrbLaBNHLPYsrYeVXkiVePA59FrgD/UWM4k=;
  b=hQSW0WHNJloSEkd+fBNg6x0D7FQwMvl1Suv+2dWGOEJpYpQ4CxA42Xq6
   qoLY0h8sYiJLuykchPmzBw4+gYxjTAlF250nj05Y6Sd7euk0V/cHXAB6J
   USNZdcbTYv7I0SthhZyVYkKSAYlfdJAEiE7ZjSloh8pnhwcxl6UOFG2Ef
   e89nTdPbuy7Fe3HMIJQ0FgtRSb97ffHdc2iLOcalfVu4TkQuQ/m95xlz3
   7IdXJbcqq5A/80LgAfsKHGUQVEX2XlhG6FEJO8VsyLjitY9RMiFCF/AQ2
   zbxIvvldRj32SY1P6AiaYaVzouCJrhxogRr7A+ry11DDBeMxd+0ZxsMUf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275734842"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275734842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:58:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="530150781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:58:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwRfm-000QqW-EX;
        Wed, 01 Jun 2022 19:58:18 +0300
Date:   Wed, 1 Jun 2022 19:58:18 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Dominik Kierner <dkierner@dh-electronics.com>,
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
Message-ID: <Ypeaqgc9r7TOiSbn@smile.fi.intel.com>
References: <5d817ea54144414aa7865a72694b5811@dh-electronics.com>
 <536d4700-6f28-176d-7883-5793f5cd7c8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536d4700-6f28-176d-7883-5793f5cd7c8e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:46:24PM +0200, Javier Martinez Canillas wrote:
> On 3/10/22 14:11, Dominik Kierner wrote:

...

> > # DRM Mode Configuration via Device Tree
> > 
> > In the old fbdev driver, the display modes are hard-coded, which means
> > for every new display configuration, a new patch needs to be mainlined,
> > which slows down official Kernel support and
> > puts burden on the maintainers.
> > Additionally, with the DRM-subsystem supporting height and length
> > information, for scaling, this opens up a lot of new combinations.
> > The SSD1306 for example, is available in multiple resolutions like
> > 128x64 and 96x16 and comes in different sizes per resolution as well.
> > Just to name a few:
> > * 128x64 0.96" (22x11mm)
> > * 128x64 1.3" (30x15mm)
> > * 96x16 0.69" (18x3mm)
> >> Instead of hard-coding, I would suggest something along the lines of
> > of_get_drm_display_mode().
> > The displays won't need to support multiple modes at the same time,
> > let alone support for switching between them,
> > so the one-time invocation of this expensive function might be worth it. 
> > maybe a new and simpler function that could be named:
> > of_get_drm_display_mode_simple()
> 
> This makes sense to me as well.

What about non-OF platforms? Please, do not spread OF-only interfaces,
and use fwnode instead.

> > Providing a mode could later prove useful for a conversion to
> > drm_panel, if that is feasible.
> > 
> > But for a function like this, I have to chicken out.

-- 
With Best Regards,
Andy Shevchenko


