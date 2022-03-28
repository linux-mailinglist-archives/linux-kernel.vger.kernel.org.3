Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F654E9712
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiC1MyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiC1Mxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:53:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3F5BD25;
        Mon, 28 Mar 2022 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648471928; x=1680007928;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=GcFmmw+wq2araDt2jjVJDabU9v0zfQ0Zqb+8UCPwJTM=;
  b=QQYDzUttAtDJODjJRsrbjOztA2xNrZc+M17EA+P54KLqZqi1XV16x6Qm
   b4LTeC2WXT3jZIcI2x/iaSqy5r8SwbWA4q1idWGIzDSyNahVQwn0qFjSF
   uEPeiXTLUFmy+zhrnkYNtQ2ZIIlygHsJTDHNTYK5rKsht+O6Zlkq5XFwA
   ZVAnvV1a2Nd+cYx9lifB6BjGORSdKlerphUtuadnzNcMyxV3qITEkxkoL
   HwKBHHi+/bwpaUPcgY/ycfxpCPBlLQpeAfkr0Vk/549f8ZKgc+L66BO7B
   t222ysktVeHwpMyIT288TStPz4uwcjdMAqI97ArLCrI51e3F0yPrjDrZD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="257817038"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="257817038"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 05:52:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="651993171"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 05:52:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nYoqK-0086hU-9k;
        Mon, 28 Mar 2022 15:51:32 +0300
Date:   Mon, 28 Mar 2022 15:51:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YkGvU3l1Lq7OlYKK@smile.fi.intel.com>
References: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
 <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
 <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
 <YkGB3AgME/OZAdoG@ninjato>
 <YkGSzCykWvPXX89O@smile.fi.intel.com>
 <YkGn6/B4XHhb72YC@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGn6/B4XHhb72YC@ninjato>
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

On Mon, Mar 28, 2022 at 02:19:55PM +0200, Wolfram Sang wrote:
> 
> > > I don't like assigning 'priv' memebers twice, so I'd like to keep it as
> > > is.
> > 
> > But this will give better understanding of the steps the code performs, no?
> 
> IMO the current version is readable :)

OK!

...

> > (Because this function basically contains two steps at once. I assume it's
> >  done this way due to absence of vrealloc(), right?)
> > 
> > But we have kvrealloc(). Can it be used here?
> 
> This has a huge disadvantage: realloc() requests new memory before the
> old one is discarded. If you want to make a huge buffer bigger, this can
> lead to OOM. The old contents do not matter, so the old buffer can go
> away in favor of the new one.

Fair enough.

...

> > > > Can it be wrapped by DEFINE_SHOW_ATTRIBUTE()?
> > > 
> > > I don't see a way. Do you?
> > 
> > Me neither. I mixed this up with (not upstreamed yet) DEFINE_STORE_ATTRIBUTE.
> 
> Still no cigar. That one is for rw files. Mine is writable only, so I use
> e.g. no_llseek.
> 
> Probably, the above macro should be named, DEFINE_SHOWSTORE_ATTRIBUTE.
> But I see this macro is stalled since late 2020 anyhow.

Right, not applicable here anyway.

-- 
With Best Regards,
Andy Shevchenko


