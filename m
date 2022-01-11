Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43EB48AC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiAKLYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:24:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:22189 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238027AbiAKLYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900250; x=1673436250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sotqoPzGHI5M4H37/UHSqbromMEMBcs2C19kd1d8X8g=;
  b=fFiNFo1NIT5sOwUdKflM9kM90H/NMk08Z2J3b6UNdSueV7as3Rt4aXYY
   DdEuIPzLWTX4/RbsA1vZPkhNIwph9mZfnGXU1IA9mPZdX/2tDRe1w3Nt1
   XKOH9YlOPkId8fG6X96RMb9pt+WnWg6NORkLcQfiiSyrzpBiKiBrQ83zs
   DIqyPzqy14N/WsaJIdd/fkA88rdZ+aWdRyA6gQzMENesNQlUguetP3M4Q
   vadXTYmQVuqVp7vkBuJuaydkTCWC2cia0tGlNwt72QJhvRozj6TVqQ48f
   UXzgUU1gYISruY3Og6cCIn+JsTfbEeLa7/1jEyvLpqyg3fvQT4pYnP+mB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243662363"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243662363"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:23:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="576177529"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:23:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7FET-009CdN-Pz;
        Tue, 11 Jan 2022 13:22:29 +0200
Date:   Tue, 11 Jan 2022 13:22:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd1odcLqimcvSreV@smile.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
 <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
 <Yd1h8c8Sk4fZ+h0A@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1h8c8Sk4fZ+h0A@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:54:41PM +0200, Sakari Ailus wrote:
> On Tue, Jan 11, 2022 at 12:10:28PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 11, 2022 at 12:12:46AM +0200, Sakari Ailus wrote:
> > > On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> > > > The %p4cc specifier in some cases might get an unaligned pointer.
> > > > Due to this we need to make copy to local variable once to avoid
> > > > potential crashes on some architectures due to improper access.
> > > 
> > > I guess this problem exists virtually everywhere where pointers are being
> > > handled: the pointer could be unaligned.
> > 
> > True. And my patch improves the situation.
> > See, for example, 0f70fe605fad ("hexdump: fix for non-aligned buffers").
> 
> This is different since there's no guarantee of a void pointer's alignment.
> 
> The pixelformat used for %p4cc is a pointer to u32.

Oh, look at the %p, compiler doesn't know about the %p extensions and caller
may supply whatever they want, i.e. %p may take any address that can be kept
in void *. Actual argument _is_ void *. What you put there as u32 is just
personal expectation, and not the reality.

-- 
With Best Regards,
Andy Shevchenko


