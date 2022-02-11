Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235E4B2411
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbiBKLOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:14:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiBKLN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:13:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC43E58;
        Fri, 11 Feb 2022 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644578039; x=1676114039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwLXbIIZzHbMAw4pY6RvQqqG4HJGRvuDXCe7ZYOPqv0=;
  b=KfqGZh09UBzL11pgwSKG30xWSfqG1k3JpAjUpUphyO3nLIdcibiiq4wB
   9anS3lCqpGhFDPg4sfkWjZWmxXwfBfjrb+oPPC/wW0Pg05PCy9TwWaTyL
   CEUIp79nSNElv2MDMS920ZizQ81nc2vKPqmVj7Xu4CWM+0oQN3p2anCIL
   h+FqJfgHsjdOWW1hOQWO7br5V1Lw1WQ0d1hDnr7Y+y4QAJB4z045B+c8L
   75h01SrxjI1XQgQWz0VozYmfY+YFxcSAk1CdU70gnPG5ISXevHiNUqGO+
   LjAuG0WU50t+fiVxfaZ4eMMVjg2JJxi9r2Z7bsxkX16UxTNvWCVcqhD9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229679286"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="229679286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:13:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="569011379"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:13:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nITrF-003Q2V-Nb;
        Fri, 11 Feb 2022 13:12:57 +0200
Date:   Fri, 11 Feb 2022 13:12:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:
> On 2/11/22 11:28, Andy Shevchenko wrote:
> > On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:

...

> >> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> >> +{
> >> +	unsigned int x;
> >> +
> >> +	for (x = 0; x < pixels; x++) {
> >> +		u8 r = (*src & 0x00ff0000) >> 16;
> >> +		u8 g = (*src & 0x0000ff00) >> 8;
> >> +		u8 b =  *src & 0x000000ff;
> >> +
> >> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> >> +		*dst++ = (3 * r + 6 * g + b) / 10;
> >> +		src++;
> >> +	}
> > 
> > Can be done as
> > 
> > 	while (pixels--) {
> > 		...
> > 	}
> > 
> > or
> > 
> > 	do {
> > 		...
> > 	} while (--pixels);
> > 
> 
> I don't see why a while loop would be an improvement here TBH.

Less letters to parse when reading the code.

> In any case, I just pulled the line conversion logic as a separate
> function with minimal code changes since doing that should be in a
> separate patch.


> Feel free to post a patch if you want to change that while loop.

Perhaps some day :-)

-- 
With Best Regards,
Andy Shevchenko


