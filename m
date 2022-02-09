Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF34AF339
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiBINsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiBINsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:48:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D519C0613C9;
        Wed,  9 Feb 2022 05:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644414487; x=1675950487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mCLMTF/Kdx89pdQlhSi2Q8AM8SGXYokPeOlF4018GTY=;
  b=igg+PSnoXDn1wjMhWhwcu7P489uBVRdRo1qLxMmFrgJqxs0ncqZIB7Tj
   b6prnd/ycl7nSvhsxUEUt/rP94tbgh1PKEwPLCACr+sloZ0nB8u3FNSKw
   f42JxeUWQeSfo55dSSpTmMF8FHiUaiXrR4gYUYw2g+wcRzvb65/Q0ETQK
   OLFlV755m/X0WyPQVNWwv5ZeihAcM2et+9rxZdEcB/KivVjAEIMgw7GVH
   I5Pkz2OmDSDEiazLK2hsumHE8gklgx2eiXK2s5H48BIkihvvIbFDTIIQf
   78hQ0GuYg5i6kTpOUfCwOs5Ya1xJiT3aXBvcKkD4EqYbnPZb6cgS5lUyh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232771017"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="232771017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:48:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="601625256"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:48:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHnJG-002d2W-2F;
        Wed, 09 Feb 2022 15:47:02 +0200
Date:   Wed, 9 Feb 2022 15:47:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <YgPF1cBMsd9973Dx@smile.fi.intel.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:10:49PM +0100, Javier Martinez Canillas wrote:
> On 2/8/22 15:19, Geert Uytterhoeven wrote:
> > On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:

> >   - Kernel size increased by 349 KiB,
> >   - The "Memory:" line reports 412 KiB less memory,
> >   - On top of that, "free" shows ca. 92 KiB more memory in use after
> >     bootup.

The memory consumption should really be taken seriously, because these kind of
displays are for embedded platforms with limited amount of resources.

Thanks, Geert, for testing and reporting this issue in particular.

-- 
With Best Regards,
Andy Shevchenko


