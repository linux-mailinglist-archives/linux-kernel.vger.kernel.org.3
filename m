Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735D4DDBBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiCROfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiCROfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:35:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3DB1945E7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647614069; x=1679150069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwmAYTkFkdcVZvm7QSe/7bEg6oDYfOaHQySbw9Qn9NE=;
  b=e4hHuJoP1IoZcqAjMmFxLWYJV20LQo/CBrzKtRe8P6PfznfFOc91S9OP
   b17Qw/iiAmJUf/7NR2/FRAvAXgwFxpXKPqXOYknfYlIvQnbDFdY8pAaxF
   fEarZAQ09b6HH1xXVX60p247E2Fg2hQng3Zetuxe+mcvAtDOE/49kNLZE
   BfoKIM1BkMLshVW/oOA2g2qxwYA1DcbOFypZv36IOsy+2Zvi82tcjduav
   w5Aid6AyA3dMpIgn2d4Vnb7SF6akgt6dfjm/WbsFZXCFyvrHOS+vGLroG
   hFy2Sydp89sDj9NIP0Gn4YdWe1QFMfbWuhr41cQulTxBiBZ7+rWsz3Ygk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257333726"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257333726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:34:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="645537258"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:33:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDfM-002HB6-3c;
        Fri, 18 Mar 2022 16:33:20 +0200
Date:   Fri, 18 Mar 2022 16:33:19 +0200
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
Message-ID: <YjSYL5oPaDuCXOJQ@smile.fi.intel.com>
References: <20220317081830.1211400-1-geert@linux-m68k.org>
 <f94c0f44-36f1-e1a9-5963-5da0bafb8c90@redhat.com>
 <YjSMWDFxTeJZZ/CB@smile.fi.intel.com>
 <20220318142145.kwq46bf6exgce6wu@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318142145.kwq46bf6exgce6wu@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:21:45PM +0100, Maxime Ripard wrote:
> On Fri, Mar 18, 2022 at 03:42:48PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 17, 2022 at 12:39:57PM +0100, Javier Martinez Canillas wrote:
> > > On 3/17/22 09:18, Geert Uytterhoeven wrote:
> > 
> > > By the way, you should probably request commit access to the drm-misc tree:
> > > 
> > > https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html
> > 
> > Does it really work? I tried and no one replied to request.
> > Keeping silent is a bad service. If people don't want a person
> > to have such access it should be well communicated.
> 
> I don't see any issue on Gitlab to request commit access, so I'm not
> sure what you did exactly but it's not surprising you didn't get any
> answer.

https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/311


-- 
With Best Regards,
Andy Shevchenko


