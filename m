Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC364FDF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiDLMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357106AbiDLMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:20:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D164AE3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649762867; x=1681298867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIs6XvcWXzPcGcyZ4rwFB88kIQ7FOgRfZOHvOled5dE=;
  b=QcsPXEs9Gz6QA2nD7BpODxRIY7Y6uaY7XWHknIwXRPY0xJhG/F8QxIx1
   g73NzHEECaLgx8CbJevCo+CGuad/YnOeCqk93dq3e3T6pZGeOZp2Pda7i
   1VRtwcEcM0QjeqpqzrD/8TRHvb/InM1Ac3pDrpsPrVRBC39tn3LUQ9tZ2
   Gqe65jHgy+HJybZaHqbMtTo9Ok1Kc0/zwUW+HbT6pdZYcyuI117q8V6PD
   qp7ITjUai+Cr81J8FezlIZkfbl8m3tbSCnhuy1GgoQYPqo2h8Y+jpCmGP
   sOgyHUhHfrnxbIihf6Ucttv+eub99mRXji5PUnyRouwNM3rw3O4gN6Qxq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="249636870"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="249636870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:24:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="611397331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:24:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neEa4-001YkI-Tg;
        Tue, 12 Apr 2022 14:21:08 +0300
Date:   Tue, 12 Apr 2022 14:21:08 +0300
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
Message-ID: <YlVgpHqqqFy43L37@smile.fi.intel.com>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-5-javierm@redhat.com>
 <CAMuHMdVSsAtRLob5fLoBMNu-DRXJOaBrEHYEwG5iCA03XR5JSw@mail.gmail.com>
 <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4128b288-2b9a-f9cd-01f3-a1d50d3e10bb@redhat.com>
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

On Tue, Apr 12, 2022 at 10:07:02AM +0200, Javier Martinez Canillas wrote:
> On 4/12/22 09:23, Geert Uytterhoeven wrote:
> > On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:

...

> >> -       ssd130x->device_info = device_get_match_data(dev);
> >> +
> >> +       variant = (enum ssd130x_variants)device_get_match_data(dev);
> > 
> > (uintptr_t), to avoid a cast from pointer to integer of different
> > size warning.
> >
> 
> Indeed. The kernel test robot reported the same.

Not only because of this, but also with the non-NULL pointers I prefer the old
style without ugly castings.

Instead, you may export the array (in the driver's namespace) and use
&info[ID] pointer for the specific device info.

-- 
With Best Regards,
Andy Shevchenko


