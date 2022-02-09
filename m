Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9E4AF4FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiBIPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiBIPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:18:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19588C0613C9;
        Wed,  9 Feb 2022 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644419901; x=1675955901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAb9Fo/hjk9Pq9HEo1fxRFhKXRqCJKCLiblpnkScaao=;
  b=EQDwosRLOFRW+h0AZXdC8qKh93s3uSLPi0zYxdBroT72lzcMK1ZgglzZ
   2B3H1zzxVTdrzIPDkVAsFpu5NVvk24BT+V8f9hDX+tz+2fOR4SmJ4qQep
   V13O6xNSA3GX6x7KUlFqpG82SUWvj8ooi2f1nGtqj7OUK8pdFGpfGu1H+
   WhpUrJLMmIC9A1T5dfn+e7vquGGxyMNGOlp/fhIzIyt6TdD3k+OAwHfO7
   V1FlHDNQn7FphKQ3iE1wu21qLTnyJSfX895f1gk73AQ889HaPXCLkCWX9
   Mw5ehlm+ddJyo6ijUGku2Cru+wQw7zzpg9elfHTfrska20VBxnsul2rHj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236631078"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="236631078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:18:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="499998951"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 07:18:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHoie-002eYQ-HB;
        Wed, 09 Feb 2022 17:17:20 +0200
Date:   Wed, 9 Feb 2022 17:17:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Message-ID: <YgPbAL0I8Wn7nnNb@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 01:25:46PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

...

> > +               .compatible = "solomon,ssd1305fb-spi",
> 
> This needs an update to the DT bindings.
> Hence this may be a good time to deprecate the existing
> "solomon,ssd130*fb-i2c" compatible values, and switch to
> "solomon,ssd130*fb" instead, for both I2C and SPI.

Agree!

> Of course the I2C subdriver still has to bind against the old values,
> too, for backwards compatibility.


-- 
With Best Regards,
Andy Shevchenko


