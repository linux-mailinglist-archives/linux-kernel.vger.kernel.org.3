Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301034FFC12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiDMRIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiDMRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:08:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655AD4D608
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649869551; x=1681405551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r7UZnsohXbfhEJy1H1rNsdtuWYYR6ExyFJHIjKpmqhA=;
  b=ZMJFTaBNkhzc3AugrI3dN5IWT02fyCurrvUDn2bAmi0WuK62S2GQN8NF
   FgtOekLxst4LBeQqWicIIzzFEOVwQgTmUR2ba+oWkXvI11H38OepdOmop
   c9GmzY28Eqk8kU7V9eDm0q8BNVk3thANkuWYb+rpaL9PaRbnOltoD0zh6
   Zg+iczNmE+i6YjTdlX1r3iy2CVPXTo/1cbN4gNBen+/y8enlj2CtOPK5L
   4FJDyviosS/eH7L7BJ4+J3UZtdXjLOVIMh3Cx7Izx6k/UqbPmsCP24d3i
   YeZoyFFHHcHeC0obOAkxUU04CGsVHLyG+va4IQSSpLtquuPzZoY7V9VeK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261568556"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261568556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:05:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526548796"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:05:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1negNc-001wAW-Ll;
        Wed, 13 Apr 2022 20:02:08 +0300
Date:   Wed, 13 Apr 2022 20:02:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Message-ID: <YlcCEP8ADyJNxd/Z@smile.fi.intel.com>
References: <20220413162359.325021-1-javierm@redhat.com>
 <20220413162359.325021-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413162359.325021-5-javierm@redhat.com>
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

On Wed, Apr 13, 2022 at 06:23:57PM +0200, Javier Martinez Canillas wrote:
> These are declared in the ssd130x-i2c transport driver but the information
> is not I2C specific, and could be used by other SSD130x transport drivers.
> 
> Move them to the ssd130x core driver and just set the OF device entries to
> an ID that could be used to lookup the correct device info from an array.
> 
> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
> bytes. Since even though they are used by the I2C interface, they could
> also be useful for other transport protocols such as SPI.

Thanks!

...

> @@ -139,6 +106,8 @@ static struct i2c_driver ssd130x_i2c_driver = {
>  };
>  module_i2c_driver(ssd130x_i2c_driver);
>  
> +

Seems stray change. Dunno if maintainers can fix this when applying.

>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(DRM_SSD130X);

-- 
With Best Regards,
Andy Shevchenko


