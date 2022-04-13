Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22C44FF51C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiDMKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiDMKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:52:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403C35858
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649846992; x=1681382992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24MmeEn2Cbl39Z9DZndnyl+5AVJ6TfhTumGasuy47do=;
  b=Z94uTTS3c7NoBUaIgInaSWig6IrAgRICXK/y5gWDlv/nKpqcoV+Oq03B
   xYLFJRF1gb8JV7ytwBKOeJAB2AYH1aEeHfRTx4wqXaMIgVx5sUHgbXi7E
   XPjwDIcdPtaMY5yYFWmIjiWnoGLHSyYicCKTOF6jtqG54kf0xNg3jDxcS
   9Gp3r1dGX1BsPNm6d9GIedlOw7Z4BMN5Ypuib6itbGWgRSZdnMIeoOz5R
   eUhx9Jtu4JvV/VaWP+9Ul6CMbvpYQqmbr687bMBMSAHo+DPzir5Zaqe3f
   08TXPj98G0uY/kDP1/5BduLHxaZcTwhnlzvo97rSz15KCNa6JImy13Vt/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262077085"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262077085"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:49:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="660883901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:49:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neaVm-001nR0-8j;
        Wed, 13 Apr 2022 13:46:10 +0300
Date:   Wed, 13 Apr 2022 13:46:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v3 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Message-ID: <Ylap8rTKbXp80Woc@smile.fi.intel.com>
References: <20220412162729.184783-1-javierm@redhat.com>
 <20220412162729.184783-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412162729.184783-5-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 06:27:28PM +0200, Javier Martinez Canillas wrote:
> These are declared in the ssd130x-i2c transport driver but the information
> is not I2C specific, and could be used by other SSD130x transport drivers.
> 
> Move them to the ssd130x core driver and just set the OF device entries to
> an ID that could be used to lookup the correct device info from an array.
> 
> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
> bytes. Since even though they are used by the I2C interface, they could
> also be useful for other transport protocols such as SPI.

...

> +EXPORT_SYMBOL_GPL(ssd130x_variants);

What I meant is to use EXPORT_SYMBOL_NS_GPL() here. It might require a separate
patch to move other exports to that namespace first.

-- 
With Best Regards,
Andy Shevchenko


