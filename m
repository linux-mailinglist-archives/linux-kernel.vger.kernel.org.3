Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249E4F98E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiDHPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiDHPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:02:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D62DE17D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649430020; x=1680966020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fvu7Xj2KZeoBoWYVxKXIZ/ZE9uRhVfjO5sJnAbr0H6g=;
  b=dtaTR0NviXRXhKqbUh8siFEKalrVdmtKVmGsD0B9pMuP/lMO1JyxGXMo
   3sC5JeJ/3Z5g2v/mau2xqxfUBYkiNOuCcB+AdTVq0iF1OuDzCKqONgmv9
   e75u2NLm0j71c7IFKx1TWnvFqjWzOznriehjXK2/AwUD8G5IUBSxJXFUW
   74u3HzLbSc5v5+8zqM19oogkO0PR5uszdPHxC1d4XaoUdqvqxcO3dasAg
   500Z5LwzAgusAeDjzcJXZcIw2vOcXblSipR0SGQ+00XeyQEJKXStKf7na
   VPOLXphjMTCh61y+2wWh/zcOOPcEpzdqzavaBNfa8r/u8MsSinqMoezGs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261300824"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261300824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:00:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524802808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:00:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncq2N-000Kqr-9K;
        Fri, 08 Apr 2022 17:56:35 +0300
Date:   Fri, 8 Apr 2022 17:56:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drm: Fix monochrome conversion for sdd130x
Message-ID: <YlBNIyimU0DGpWK3@smile.fi.intel.com>
References: <20220317081830.1211400-1-geert@linux-m68k.org>
 <f94c0f44-36f1-e1a9-5963-5da0bafb8c90@redhat.com>
 <YjSMWDFxTeJZZ/CB@smile.fi.intel.com>
 <20220318142145.kwq46bf6exgce6wu@houat>
 <YjSYL5oPaDuCXOJQ@smile.fi.intel.com>
 <20220408135413.2vwp4oyzdlu7iczs@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408135413.2vwp4oyzdlu7iczs@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:54:13PM +0200, Maxime Ripard wrote:
> On Fri, Mar 18, 2022 at 04:33:19PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 18, 2022 at 03:21:45PM +0100, Maxime Ripard wrote:
> > > On Fri, Mar 18, 2022 at 03:42:48PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 17, 2022 at 12:39:57PM +0100, Javier Martinez Canillas wrote:
> > > > > On 3/17/22 09:18, Geert Uytterhoeven wrote:
> > > > 
> > > > > By the way, you should probably request commit access to the drm-misc tree:
> > > > > 
> > > > > https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html
> > > > 
> > > > Does it really work? I tried and no one replied to request.
> > > > Keeping silent is a bad service. If people don't want a person
> > > > to have such access it should be well communicated.
> > > 
> > > I don't see any issue on Gitlab to request commit access, so I'm not
> > > sure what you did exactly but it's not surprising you didn't get any
> > > answer.
> > 
> > https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/311
> 
> Indeed, I wasn't expecting it to be that old.

That's part of "non-working" process.

> I'm not sure why it fell through the cracks, sorry for that.
> 
> That being said, the criteria for requesting drm-misc commit access are
> listed here:
> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc
> 
> And looking at your commit history so far, I'm not sure you qualifies
> yet for the first criteria. All your patches to drivers/gpu/drm, while
> definitely useful, only seem to be conversions to helpers and general
> best practices changes, which could be classified as trivial.

Can you, please, comment it there then and close the request?

-- 
With Best Regards,
Andy Shevchenko


