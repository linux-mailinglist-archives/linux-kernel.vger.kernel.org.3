Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411D848AF56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiAKOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:19:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:3744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241424AbiAKOTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641910792; x=1673446792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjmRYcPiOSTmJ8eUv83YKuMyPL5Rx4ijsqVPkpiDxoc=;
  b=IflNObXiiW4AP6aSUuLDIrziJoXlIqrrJFAAwsvAQiSM1nVq7nSK7e/3
   gRguNA2nsS5ixGfhx6d0+19Qdx9VD/7o74JXK5ta4Hhinfp6IBywQPG6v
   CYyaS2CQLAy7oawd+H8om11hQdXhVkUnhIpHyd7r5HVz9mPv4+iMfpgbq
   53q93theHCfSPWofXMmOcmOUvkO1Ra99B8Cb7eUlR0uop9kGKDGc5wuoc
   /V2V9nTZ1kFTM3j1e2dnSvpU6Bh6YxWwE/g2KHz7+dXQU7AQ9l5leCdW6
   5RrY4OmBLjzTfe6VsdVnf3zfToTDjnR3xjA5LOYSumsmBOrBoWTTdQqrE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223474902"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="223474902"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:19:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613229699"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:19:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7Hyu-009G33-PI;
        Tue, 11 Jan 2022 16:18:36 +0200
Date:   Tue, 11 Jan 2022 16:18:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd2RvIeP3LRc/+gl@smile.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
 <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
 <Yd1h8c8Sk4fZ+h0A@paasikivi.fi.intel.com>
 <Yd1odcLqimcvSreV@smile.fi.intel.com>
 <Yd2QkVMnmZ57qXTH@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd2QkVMnmZ57qXTH@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 04:13:37PM +0200, Sakari Ailus wrote:
> On Tue, Jan 11, 2022 at 01:22:29PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 11, 2022 at 12:54:41PM +0200, Sakari Ailus wrote:
> > > On Tue, Jan 11, 2022 at 12:10:28PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 11, 2022 at 12:12:46AM +0200, Sakari Ailus wrote:
> > > > > On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> > > > > > The %p4cc specifier in some cases might get an unaligned pointer.
> > > > > > Due to this we need to make copy to local variable once to avoid
> > > > > > potential crashes on some architectures due to improper access.
> > > > > 
> > > > > I guess this problem exists virtually everywhere where pointers are being
> > > > > handled: the pointer could be unaligned.
> > > > 
> > > > True. And my patch improves the situation.
> > > > See, for example, 0f70fe605fad ("hexdump: fix for non-aligned buffers").
> > > 
> > > This is different since there's no guarantee of a void pointer's alignment.
> > > 
> > > The pixelformat used for %p4cc is a pointer to u32.
> > 
> > Oh, look at the %p, compiler doesn't know about the %p extensions and caller
> > may supply whatever they want, i.e. %p may take any address that can be kept
> > in void *. Actual argument _is_ void *. What you put there as u32 is just
> > personal expectation, and not the reality.
> 
> If you assume this, you should add get_unaligned() calls in all places
> where you're casting a type to another with higher alignment requirements.

Those places so far were not subject of any reports, but ideally yes, you are
right (in a scope of %p extensions, otherwise it's silly).

I will leave this to the VSPRINTF / PRINTK maintainers to proceed. Personally
I found this patch useful since we don't know what other user will do unaligned
call to it.

-- 
With Best Regards,
Andy Shevchenko


