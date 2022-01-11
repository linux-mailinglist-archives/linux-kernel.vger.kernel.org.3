Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7448AB16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiAKKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:11:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:5533 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237473AbiAKKLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641895909; x=1673431909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/lDCyktziNUijHGvCdrqEFsA50vOCVpKeSqLtCdLxY=;
  b=Ct6Yvz1fq6lEjYcfknickBIYUvYvmhVrD5nakPhjc+Wq2OUF4AJ/cGBv
   o4wSj5QZR9eQX63y8J3YyuGn3jXUp5gKHgVCFomIrLf/Iad/9QRkU0VrU
   ZqNPi17cBX1u+My11NNNBOoIdcz+yLps1g4mWfTmXfeI/eUzh5wwFR0Pi
   z4HO2YRHqqLyWEB5aX2y6BOjYXDj4sQI6DKrNRmJjkfvlrFgFxLmuH8tQ
   VUpDvwtnluZ6khPRG8e2dcyI+Jx+QX+FxTK9SpX8Bome0Njh0rjTiFwfy
   vonelQ1PlRAd+wZivPd1W3W58OPks80CPpJHT7JM2VBrA2poQfmMLMKGH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242263851"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242263851"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:11:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474482561"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:11:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7E6m-009BWQ-If;
        Tue, 11 Jan 2022 12:10:28 +0200
Date:   Tue, 11 Jan 2022 12:10:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd1XlN0e23GRF9i6@smile.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
 <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:12:46AM +0200, Sakari Ailus wrote:
> On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> > The %p4cc specifier in some cases might get an unaligned pointer.
> > Due to this we need to make copy to local variable once to avoid
> > potential crashes on some architectures due to improper access.
> 
> I guess this problem exists virtually everywhere where pointers are being
> handled: the pointer could be unaligned.

True. And my patch improves the situation.
See, for example, 0f70fe605fad ("hexdump: fix for non-aligned buffers").

> Does this even address the false
> positive compiler warning?

First of all, the warning is real and legit, it's not false positive.
Second, no, this is another side of the fix.

-- 
With Best Regards,
Andy Shevchenko


