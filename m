Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7F4A5DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbiBAODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:03:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:17214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237314AbiBAODp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643724225; x=1675260225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4cD8Nnk/cAjxUMAyT4wL7Ctq8gRWHUD/fFe2hLfCcRo=;
  b=i96t03R/IL1EH6NCn1Y7bVfQLQKNs4EY3/nUUCawULiR/y63T0KTJBEv
   Jm++tIATGmms8AwIZkBBaDbTvfb12hBC13sOty60vLXkwWupmN9ndZuBe
   HXC/fTqlOqSqlNgm9VlFfWNF92qwcaqUEj47pktW3pGId9Os+/kmsSPUG
   Zqj04FNssXNTrrzubOKYhvmqAf/+3F5xQtJB+o2ibKZJ7KoHXjpqCTbIc
   ST6gveDM/DmMQVwqv6IwHeQbIHCsjRWqxPq9PHNyFV2AswEcOOtlZjqHo
   Yp5ELzrIyQ5gxclwfzl+I+IKrwHVgIEEduR9hELikB927zxaTk6EwmN8k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308426417"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="308426417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:03:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="626738935"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:03:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEtjz-00HKFy-02;
        Tue, 01 Feb 2022 16:02:39 +0200
Date:   Tue, 1 Feb 2022 16:02:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <Yfk9fuazUSgI6C9n@smile.fi.intel.com>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <YfhVBtv1UIA7bJja@ravnborg.org>
 <3aac291a-b30e-2775-336f-66dd08d634e2@redhat.com>
 <YfkA4ER/52I2v1JP@smile.fi.intel.com>
 <9ddd8a8c-4aa9-bc4a-5637-66197a7342d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ddd8a8c-4aa9-bc4a-5637-66197a7342d1@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 12:45:53PM +0100, Javier Martinez Canillas wrote:
> On 2/1/22 10:44, Andy Shevchenko wrote:
> > On Tue, Feb 01, 2022 at 01:14:22AM +0100, Javier Martinez Canillas wrote:

...

> > The problem with no backward compatibility means that removal of old driver
> > makes users unhappy since DT is kinda ABI and we do not break it.
> > 
> 
> I think that's the crux of the issue. Do we want people to update their
> kernel but using their existing Device Tree and be able to switch to the
> DRM driver ?
> 
> My take is that we should and that's why I kept the backward compatibility.
> 
> Maybe we could do that in the meantime and at some point introduce new DT
> bindings (with a different compatible string) that would use the latest
> and greatest conventions in DT ? That seems to be a good compromise.

I have over-read in this discussion that current binding is not fully
correct from hw perspective. If it's indeed the case (and I believe it's),
then probably we should come with brand new driver with ssd130x name and
incompatible bindingas (*).

Otherwise in this driver we continue to be incorrect in them.

*) But even though I think it would be good if you take the old one under your
   maintainership.

-- 
With Best Regards,
Andy Shevchenko


