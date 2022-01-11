Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C33848AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiAKL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:29:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:22576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349353AbiAKL3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641900577; x=1673436577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uEbhMD3CVozMIkV3oFhlvGU94pvzjb5tECx8GpK/Qg4=;
  b=TS9krxXhNpQkgxNBei8ulxW9p7nB6cTZyZSEaafQlljriiYpT3n+X85m
   3nf8+3EdtmYxHGwf1PYbSRtuUBeUi+2ldTjzGCPjsdODdoebIKdsM8J4s
   kvNYdj1rMt08Swh3E6YCrlBakuc0AKwHyXh67HXJVXyU23Kzrz06IPQKS
   MrM5nAWOFLJQWLlQsK4gz7ocaRa2jl/AyYOC7fM/Xq7AznoBq1REKz9DP
   3HZhKvVjlCM3TRpmiPAA8Q6dzp4SOX9mYjXfA4H0+S2vAxP6pa/lxIM81
   pJ7gr1TuFk6vNF1Eb5DaiifAUNIzA0UZIXXYQfJWZbHH2AU/WKinyviM8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243663186"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243663186"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:29:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613190123"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:29:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7FKA-009CjI-1M;
        Tue, 11 Jan 2022 13:28:22 +0200
Date:   Tue, 11 Jan 2022 13:28:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <Yd1p1XckKtdPyKSr@smile.fi.intel.com>
References: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
 <308b7158-7c2a-cc98-6091-14dae2b2cbba@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308b7158-7c2a-cc98-6091-14dae2b2cbba@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:26:21AM +0100, Rasmus Villemoes wrote:
> On 10/01/2022 21.55, Andy Shevchenko wrote:
> > The literals "big-endian" and "little-endian" may be potentially
> > occurred in other places. Dropping space allows compiler to
> > "compress" them by using only a single copy.
> 
> Nit: it's not the compiler which does that, but the linker.

Ah, I stand corrected, thanks!

> > -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
> > +	*p++ = ' ';
> > +	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
> >  	p += strlen(p);
> 
> Hm, ok, those two strings do occur a lot with of_property_read_bool()
> and friends. But if you're micro-optimizing anyway, why not drop the
> strlen() and say p = stpcpy(...) instead?

Why not? I'll do it for v2.

Any thoughts / comments on the
https://lore.kernel.org/lkml/20220110205049.11696-1-andriy.shevchenko@linux.intel.com/T/#u?
I'm asking since dependency and I would like to know if we still want that
fix or not.

-- 
With Best Regards,
Andy Shevchenko


