Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3049D185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiAZSNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:13:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:35276 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235901AbiAZSNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643220812; x=1674756812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CFhBhSP843Q8YZaso+hCoDq89yEO5QSnWt7DycdSiFg=;
  b=F2/rqSuwUatGk+C2K40PRuixHk0srkaiOEY77XUiB0nAcevpbdsspjHY
   8iajk2j2QaZDHduhA7Fk53nU8Dyd4/2vFnfbb6Rx5mhO6M6AQlviK0x4N
   JEuI7ZzRk/RV1ru/kPLZtNP/3wljKvE3dZB5h6E8IQS5lk4v8DsGq4r3m
   bEhh6dWJMtxQy9pIxqp907F6BQVIA/hR2FCP5TKNVA6NvRo6/GSqXwwwe
   RX1wSutb4lzCcJlgyhJ4g968ViAfARodBv1IrJFao7SNZi+9wztXvUs4C
   J8l4bSiPLDaP9M/zEQZlYdhXFCxrBiojsr4vctjE0ZD1A5W69EvD4jLqx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245447640"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="245447640"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:13:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="674431515"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:13:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCmmM-00EhmW-Rw;
        Wed, 26 Jan 2022 20:12:22 +0200
Date:   Wed, 26 Jan 2022 20:12:22 +0200
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
Message-ID: <YfGPBi2VWlRHqxXe@smile.fi.intel.com>
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

For the record :-)
https://lore.kernel.org/lkml/CAHp75VfniSw3AFTyyDk2OoAChGx7S6wF7sZKpJXNHmk97BoRXA@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


