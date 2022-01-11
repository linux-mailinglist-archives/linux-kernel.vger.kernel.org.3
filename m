Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092D848AF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiAKONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:13:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:63115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241298AbiAKONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641910427; x=1673446427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUBeKS4zuJaAQNtIFK9lHYyLpB7BElJSE0gdqqb7qJQ=;
  b=LrhobFwI3A0mzTvH95McYtaeoUqoOYvYJ+i9S8EO50yyTGkpMhINZjVj
   a+rgbyijH/P8lgDid9jQ/e+VcvcjiliAAFAFpgrQV2jrND+eGKKJhU/sT
   MtIBZ84E5aJEwEphaYldZ156G411prci1TOnVFIziwA+AcWsoRVfSkad0
   yl1Or/hF0RAKUl8eiusWF69kKaibZblqXX7i7ErCZikuaH0AMIpp5WiPT
   9dcW+TVBqOZHaRfIOkWv4nms/4kdOKLLjWDVmaxsyyHfbIrmhLpeZSPtV
   gNhwEDaVIDHtChUrGtsBQBiHaYKt1b8vVZdcGRY4DKLt2Gv6AhZvGvk0L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="241044241"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="241044241"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:13:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="613227995"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 06:13:39 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BE5C9202B9;
        Tue, 11 Jan 2022 16:13:37 +0200 (EET)
Date:   Tue, 11 Jan 2022 16:13:37 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd2QkVMnmZ57qXTH@paasikivi.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
 <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
 <Yd1h8c8Sk4fZ+h0A@paasikivi.fi.intel.com>
 <Yd1odcLqimcvSreV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1odcLqimcvSreV@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jan 11, 2022 at 01:22:29PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 12:54:41PM +0200, Sakari Ailus wrote:
> > On Tue, Jan 11, 2022 at 12:10:28PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 11, 2022 at 12:12:46AM +0200, Sakari Ailus wrote:
> > > > On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> > > > > The %p4cc specifier in some cases might get an unaligned pointer.
> > > > > Due to this we need to make copy to local variable once to avoid
> > > > > potential crashes on some architectures due to improper access.
> > > > 
> > > > I guess this problem exists virtually everywhere where pointers are being
> > > > handled: the pointer could be unaligned.
> > > 
> > > True. And my patch improves the situation.
> > > See, for example, 0f70fe605fad ("hexdump: fix for non-aligned buffers").
> > 
> > This is different since there's no guarantee of a void pointer's alignment.
> > 
> > The pixelformat used for %p4cc is a pointer to u32.
> 
> Oh, look at the %p, compiler doesn't know about the %p extensions and caller
> may supply whatever they want, i.e. %p may take any address that can be kept
> in void *. Actual argument _is_ void *. What you put there as u32 is just
> personal expectation, and not the reality.

If you assume this, you should add get_unaligned() calls in all places
where you're casting a type to another with higher alignment requirements.

-- 
Sakari Ailus
