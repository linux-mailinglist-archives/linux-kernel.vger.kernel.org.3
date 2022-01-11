Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9948B07E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiAKPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:10:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:16693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbiAKPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641913843; x=1673449843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=raQ8l+bv6wdJlnIW7NpStfMFzzYdy0dFEY+CK/dN7yc=;
  b=jPJyvjmeGYXGSrHHRWcHYCChQqKeqEweyxlhyzo+CvntIoMA29bAAwyQ
   Fah/vCuLEPQBxOM/eiveYlk3CI2CiqetIxfoh3MLhj4Ilum9/PxMH2N3e
   0nxjP2N/NdwY0M0NRvj9h6IW++8mbK/lrKUkIzsAiquhZuJfTMCSb1Xq3
   Ah0nj8A/13+SAKAVU+PCpt63PnyJ3lBPSGktLljlPrYNpPgpi4LwGOzpq
   Dwx+tRKChZV0dtxTbITDSGCMtc7jzVLR9PSzdOxGLRZh5Q3gm0nP96TGX
   SKXiJKk/IfzA8m6NUFv9LpWpGqM0/EV567bFsfC8OsjUyhs6DWsBapAvq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="230845430"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="230845430"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:10:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613243314"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 07:10:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7Ilp-009H3k-3J;
        Tue, 11 Jan 2022 17:09:09 +0200
Date:   Tue, 11 Jan 2022 17:09:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd2dlEMp0a8TAi9i@smile.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <Yd2a4MApVR8hexny@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd2a4MApVR8hexny@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:57:36PM +0100, Petr Mladek wrote:
> On Mon 2022-01-10 22:50:49, Andy Shevchenko wrote:
> > The %p4cc specifier in some cases might get an unaligned pointer.
> > Due to this we need to make copy to local variable once to avoid
> > potential crashes on some architectures due to improper access.
> > 
> > Fixes: af612e43de6d ("lib/vsprintf: Add support for printing V4L2 and DRM fourccs")
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I have already sent pull request for 5.17. Could this wait
> for 5.18 or would you prefer to get it into 5.17, please?

It's not so critical.
But would be nice to have.

> My understanding of Sakari's reply is that the current callers
> provide aligned pointers. In that case it would not be urgent.
> But I might have gotten it wrong.

Not really. There are potential unaligned callers, but Sakari
has another patch that fixes that on the (one of *) caller side.

*) I dunno how many other callers (probably none) in tree and
   how many potentially can be with similar issue.

-- 
With Best Regards,
Andy Shevchenko


