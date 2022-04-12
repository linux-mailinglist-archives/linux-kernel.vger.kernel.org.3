Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9D4FDF92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiDLMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357416AbiDLMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:20:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B06527D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649762890; x=1681298890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8L7F1aXAv1zmc7BrwX0jr9a4044fPUJAWnmDOdYuoU=;
  b=aNim5OCnVxpV05oKnkg0xEWTaBQ+9RzMhXgOgEBTHGjx35jBOaUhjwBt
   iYyD8fHW4mNxp56s0MgZ29lbHT22Noto2TPO/a9nLwbPvk7p0INOHoOrc
   wq7EqRyvvzzyWoXi3EYgRwyesQkeEXQnv7YLRtbeyUu150C3VIjFXgghw
   ONSrPelGXuwfKL/2MmnHEiwhzN0pGK72in/ibgEryYltzrAbL8hpZaLdQ
   Z5dXrHBjPS+yGtxEp60fJC1DVz60QVjsaRYGcUT7aB+2U/Ix3xaArzqRw
   msbRz09I9fF8Ztp64l/zyG5MviXPKUF6fF7I723rHGPKoxU6n48UAYLPF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348790950"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="348790950"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:26:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526002248"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:26:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neEbI-001Yl0-8d;
        Tue, 12 Apr 2022 14:22:24 +0300
Date:   Tue, 12 Apr 2022 14:22:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2 4/5] drm/solomon: Move device info from ssd130x-i2c to
 the core driver
Message-ID: <YlVg8PE6SBzhmqjI@smile.fi.intel.com>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-5-javierm@redhat.com>
 <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
 <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
 <YlVgpHqqqFy43L37@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVgpHqqqFy43L37@smile.fi.intel.com>
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

On Tue, Apr 12, 2022 at 02:21:08PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 10:07:02AM +0200, Javier Martinez Canillas wrote:
> > On 4/12/22 09:23, Geert Uytterhoeven wrote:
> > > On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> > > <javierm@redhat.com> wrote:

...

> > >> -       ssd130x->device_info = device_get_match_data(dev);
> > >> +
> > >> +       variant = (enum ssd130x_variants)device_get_match_data(dev);
> > > 
> > > (uintptr_t), to avoid a cast from pointer to integer of different
> > > size warning.
> > >
> > 
> > Indeed. The kernel test robot reported the same.
> 
> Not only because of this, but also with the non-NULL pointers I prefer the old
> style without ugly castings.
> 
> Instead, you may export the array (in the driver's namespace) and use
> &info[ID] pointer for the specific device info.

Note that device_get_match_data() has no clue if the data is absent or
data == (void *)0.

-- 
With Best Regards,
Andy Shevchenko


