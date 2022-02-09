Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD874AF727
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiBIQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiBIQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:45:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1EC0613C9;
        Wed,  9 Feb 2022 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644425155; x=1675961155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6o8PBrt2dlQLXaGpgRDUe/a5h6z2Gt3tbLxke74fXBE=;
  b=BoSiNaTaF/ZWlX6FT9MpJh1o9hUj+W+lIbsOOUGqG7euOLcji5tj6Fu4
   bSQoirC+Mb2TVVpHF9E7mLbPFcD8XFL/uQdTEvPcSBWQF/Rb9z+7KJOJx
   P1VNPt+WjHBWdLq04+4XTXkQSca56hNn/e/Me/qUej0VaVAbDyJ27XXiy
   0dcJbJ2yAsLeAQGindItOWWIUI2czD/ghMe/lf5cSM6qdiLEy5nJsqIr/
   R6ly69qsJfUzTQY4lVXl7E8aothRRmi1K9HGFSDaZ+OhvLWGJ1IzHdbMv
   B+vKY0O98ntPNwIlxl7s30LrxfCZP+prCtmnitvyMpsHkdFBWFYrECWT+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312540860"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312540860"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:45:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="633276717"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:45:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHq5K-002g8V-C9;
        Wed, 09 Feb 2022 18:44:50 +0200
Date:   Wed, 9 Feb 2022 18:44:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Message-ID: <YgPvgtQ7ANd540Ht@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPZ3W0e7N7JQ1dT@smile.fi.intel.com>
 <e29eaccc-863a-21d4-e669-0b708604d723@redhat.com>
 <YgPnE0yj0Y0OJxq6@smile.fi.intel.com>
 <406152d8-13e4-de8a-9542-bf1d96dbab0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406152d8-13e4-de8a-9542-bf1d96dbab0a@redhat.com>
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

On Wed, Feb 09, 2022 at 05:26:00PM +0100, Javier Martinez Canillas wrote:
> On 2/9/22 17:08, Andy Shevchenko wrote:

...

> On that topic, I even typed a SPI driver because of your feedback :)

Much appreciated, makes me much easier to test.

Thank you for doing all this!

-- 
With Best Regards,
Andy Shevchenko


