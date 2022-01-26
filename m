Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38849D167
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiAZSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:06:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:52782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbiAZSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643220367; x=1674756367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mOvdaqkpM7nB64Fyioa8p769KOkoDPOpvSTh4Zg379c=;
  b=CbP8hA3M4YBs5c9XmO7elBWhkV0tio2cxV8phHh8Kd5iMJGpkuQ4nsfb
   3uPfOtUWDk5vG7UzKgy5zMG9j+DCb9H7UC9BJKwVW/UGnV4kdDvXQGhIc
   6SGrn6B4eWtTKaG5+PvTAUbXjVy2rzD23mwbPGjHtIE4HdqVDfVAAQ7d5
   ro5QQ8M9lJSwInrCZqAcaAMVCqdth3E0A8ZRY/IEGPDtDhyhDaQcb5c6i
   mTnX4YFjL/u9UFcWq48QVLe1I0+mWw7CPYsbBgxH2Aic76Xe8YP2g+UrY
   PLeZtLsZIsYbnLBKJDwt9N1abfO5ZE5HIKk90jgLC7jKIkBBOUeysmOKh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307327008"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="307327008"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:06:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="618040579"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:06:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCmf8-00Ehb6-S3;
        Wed, 26 Jan 2022 20:04:54 +0200
Date:   Wed, 26 Jan 2022 20:04:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3 1/3] string: Make stpcpy() possible to use
Message-ID: <YfGNRvy2KReoG/jF@smile.fi.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <YfF46oYCaelKU5qU@dev-arch.archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfF46oYCaelKU5qU@dev-arch.archlinux-ax161>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:38:02AM -0700, Nathan Chancellor wrote:
> On Wed, Jan 26, 2022 at 04:19:15PM +0200, Andy Shevchenko wrote:
> > It is a good rule to avoid submitting code without users.
> 
> While I agree with the sentiment in the general case, I don't think that
> it applies in this case and this comment should be dropped. The message
> of the commit this fixes and the comment right above the declaration
> both make it pretty obvious why this interface was added with no in-tree
> users and why the declaration was placed right above the definition.

Thanks for accenting on this. Yes, I see now the reasoning and I don't
know which way is better. As a consumer of this API it shows a room for
micro-optimizations (I dunno if GCC and/or Clang able to replace the two
by stpcpy(), as done in the patch, at compile time).

That said, depending on the others' opinions let see how to proceed.

> > Currently the stpcpy() is unusable due to missed declaration.
> > Any attempts to use it will bring something like:
> > 
> >   error: implicit declaration of function ‘stpcpy’ [-Werror=implicit-function-declaration]
> > 
> > Move declaration to the header and guard it as other string functions.
> > 
> > Fixes: 1e1b6d63d634 ("lib/string.c: implement stpcpy")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Regardless, the commit itself seems fine from a technical standpoint. I
> won't comment on whether or not this interface should be opened up.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


