Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC75A48ABBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbiAKKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:54:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:52878 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238019AbiAKKyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641898486; x=1673434486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63xmTGn9lBdK3U4EFWqQEKciamR4hubP+IGQXhYm0yk=;
  b=kiUtYMrSuKzKgxG1xlgz7MTwITx99ECkVxLEw+a1WjxgVfHq7HBZRgIa
   8svO2hXYnmpIlOnv+Z4P8AFbMQHEKBUUTYijhw8UTCBeSrpKTs03Yc9Gv
   PYY936qu1VY0LpPQ3nNvejpyz5nbnPdk0ZkuqAQXsOGXyJ4kxllSC/kqh
   ZqvgXQbvv0zbnPxsRWL+/mQ8LzW/fvjS1rptxz8cIsZ7snbDb5aRicaJa
   GFwjZwBEJr6vsiknMhyMv7TG+zPEtjLn1VbqL9xeJ+IYuiCV4m8XKBS2Q
   rYHsLK+yMUnuyAHY+ACwEzvfNLi3kFimbo5ZhZ6nSe06F/qOEuXewJp0j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223440012"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="223440012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:54:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474494525"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:54:43 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id AB19B2017F;
        Tue, 11 Jan 2022 12:54:41 +0200 (EET)
Date:   Tue, 11 Jan 2022 12:54:41 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd1h8c8Sk4fZ+h0A@paasikivi.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
 <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jan 11, 2022 at 12:10:28PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 12:12:46AM +0200, Sakari Ailus wrote:
> > On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> > > The %p4cc specifier in some cases might get an unaligned pointer.
> > > Due to this we need to make copy to local variable once to avoid
> > > potential crashes on some architectures due to improper access.
> > 
> > I guess this problem exists virtually everywhere where pointers are being
> > handled: the pointer could be unaligned.
> 
> True. And my patch improves the situation.
> See, for example, 0f70fe605fad ("hexdump: fix for non-aligned buffers").

This is different since there's no guarantee of a void pointer's alignment.

The pixelformat used for %p4cc is a pointer to u32.

-- 
Kind regards,

Sakari Ailus
