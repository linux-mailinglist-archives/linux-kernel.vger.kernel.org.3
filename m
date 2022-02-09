Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8845E4AF704
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiBIQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiBIQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:41:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D285C05CB8E;
        Wed,  9 Feb 2022 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644424884; x=1675960884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9L2ApNXksnGqO8AjDsuLj/L+RaApKpFYz722Z9aqx4=;
  b=n0X+kD9aFzQkzbxN1rb8OKL3uK5VoIejB1X9LewuF9jCRbUE1mX9ltoS
   FzLVkfY93xVH0he898WHFEKIE33KgZnXp0xV4z17CXoam7ao+SL/Blzlv
   c3RpMEIDn5sL9MmuTXwR6LYZw7OvGplCtCbLY8zajjE6WuZ3iez495fTl
   yuCaNxrN0xsZU1/lOik5wnZQNe86gG4jfmEol0CRRx1Xl00Lh2TJLUt+k
   EEDyilYXPUyQl3ZBgUucf3XOljyb9W2QA0p49CxUPVqjv2tqq1irvKguB
   /xW/YpF+Wbd14YY6mGHT4N6MaG9v/dvdWikLpjvmDllhb4Ado5ryt4RNg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312539880"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312539880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:41:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="482386274"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:41:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHq11-002g3O-CS;
        Wed, 09 Feb 2022 18:40:23 +0200
Date:   Wed, 9 Feb 2022 18:40:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Message-ID: <YgPudz6YTweyx8pg@smile.fi.intel.com>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <YgPbAL0I8Wn7nnNb@smile.fi.intel.com>
 <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
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

On Wed, Feb 09, 2022 at 05:07:03PM +0100, Javier Martinez Canillas wrote:
> On 2/9/22 16:17, Andy Shevchenko wrote:
> > On Wed, Feb 09, 2022 at 01:25:46PM +0100, Geert Uytterhoeven wrote:
> >> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> >> <javierm@redhat.com> wrote:
> > 
> > ...
> > 
> >>> +               .compatible = "solomon,ssd1305fb-spi",
> >>
> >> This needs an update to the DT bindings.
> >> Hence this may be a good time to deprecate the existing
> >> "solomon,ssd130*fb-i2c" compatible values, and switch to
> >> "solomon,ssd130*fb" instead, for both I2C and SPI.
> > 
> > Agree!
> > 
> 
> Did you see my comment about automatic module loading ? I think
> that would be an issue if we use the same compatible for both
> I2C and SPI drivers.

Bug in OF code? This is not a problem in ACPI AFAICT.

-- 
With Best Regards,
Andy Shevchenko


