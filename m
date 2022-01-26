Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C549D16F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiAZSIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:08:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:59238 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236949AbiAZSIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643220529; x=1674756529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=630S9s/e9vVdb20f/VudwkoJcZwibuloW7Wrp/l56J4=;
  b=KVDjhZDfsIY047V98+sEvBVb1VFIxHLxYJHBXwptd0uuhZsaDXymanBj
   LU29PXtZD5Fz8iDHXWrc8597N7EYAFPK9EGLh8/cSuvYspiNtKhysyIGO
   ZP+G/8vJcnrb0EO91ECqcYcheWkoRmD7DkY0MwFJ/wsgxf7cpC3xOBmx9
   dNWeZ/atWlFD27y43nEihMRMBjvwQLVsSzwNt1XAv0npUW8lP9giO0GvS
   hQZgF+FvAZpEXYLxE+XC4sAq4QWxbPZ0ghEWYjtgdpS+wKDiifORxj+sN
   L8WqveENdY1idzRva6BzLfdkSRDJ5yZ2UdYkxa1ngwRna28QcJbk0KqN8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244212239"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244212239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:08:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="563485914"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:08:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCmhn-00EheX-LF;
        Wed, 26 Jan 2022 20:07:39 +0200
Date:   Wed, 26 Jan 2022 20:07:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3 1/3] string: Make stpcpy() possible to use
Message-ID: <YfGN6xOP4PTL3k3P@smile.fi.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <CAKwvOdkBAe4qMdFgDFWNLHMsJrW+PBwa7-hAL5T9fReQqNiF7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkBAe4qMdFgDFWNLHMsJrW+PBwa7-hAL5T9fReQqNiF7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:49:38AM -0800, Nick Desaulniers wrote:
> On Wed, Jan 26, 2022 at 6:19 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It is a good rule to avoid submitting code without users.
> > Currently the stpcpy() is unusable due to missed declaration.
> > Any attempts to use it will bring something like:
> >
> >   error: implicit declaration of function ‘stpcpy’ [-Werror=implicit-function-declaration]
> >
> > Move declaration to the header and guard it as other string functions.

...

> Recall the discussion from Kees:
> https://lore.kernel.org/lkml/CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com/
> and
> https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/

> I'm guessing that the 0day bot report was on the third patch in this
> series, which looks to use stpcpy:
> https://lore.kernel.org/lkml/20220126141917.75399-3-andriy.shevchenko@linux.intel.com/
> 
> for patch 3,

Yes. It was Rasmus' suggestion.

> I'd s/"compress"/de-duplicate/ or s/"compress"/merge/.

I'll fix it locally.

> Kees, I'm curious if we can do something like require the string
> length to be known at compile time otherwise BUILD_BUG_ON?

Perhaps static_assert() is better.

-- 
With Best Regards,
Andy Shevchenko


