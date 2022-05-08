Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3E51ECDD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiEHKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiEHKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:24:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662126362
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652005260; x=1683541260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wezW3+DT+J5CsHqEInqhEUoA+xaz/n2ysdiXysoRoO8=;
  b=dwB5IkhFoY0r6Xi8SpsKU7Yi0FfbC9W8LLK279BMEqbCQ4FkCEhvmmft
   1dJ7YZYE7u3I1s5XtaLoDKPRpvv9pRKvDR8W29AFtlYtagVXJTT1U+QTd
   zv04gYw5ewHjJNVB29tPIiy1L4ILgoNXChl8NGG1ykGgtfSCIWksvr1En
   GgLFzBhcLlR2nAWhZxVAryJwoJ9yBpaAWUrCO/r6i/iSStJ+0XXDy+ynC
   Q8Rhu6KkP5fouQEZ2ge5AK1ZaBDtMSIyf7Zp/A/Ctcv74GGDZBsZCqSNh
   hPVZ2/GSq90wyG9ToO9oG4ozV2B7VPurYVKJ6D5OPOP+MVO1VenZd/5nB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="267661867"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267661867"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 03:20:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="695866793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 03:20:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nne22-00DSfJ-2e;
        Sun, 08 May 2022 13:20:54 +0300
Date:   Sun, 8 May 2022 13:20:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Puyou Lu <puyou.lu@gmail.com>, Andy Shevchenko <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/string_helpers: fix not adding strarray to
 device's resource list.
Message-ID: <YneZhStpXcIFppPs@smile.fi.intel.com>
References: <20220506073623.2679-1-puyou.lu@gmail.com>
 <20220507114516.5de49b46cf5349db7121eff8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507114516.5de49b46cf5349db7121eff8@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 11:45:16AM -0700, Andrew Morton wrote:
> On Fri,  6 May 2022 15:36:22 +0800 Puyou Lu <puyou.lu@gmail.com> wrote:
> 
> > Add allocated strarray to device's resource list. This is a must to
> > automatically release strarray when the device disappears.
> 
> So at present we have a memory leak?

Yes.

> Is this likely to be serious enough to justify backporting the fix into
> -stable kernels?

I think so, however there are only few drivers are using it, hence it's
serious, but rare.

-- 
With Best Regards,
Andy Shevchenko


