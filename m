Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273E4B5232
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348568AbiBNNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:55:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiBNNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:55:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D065A2;
        Mon, 14 Feb 2022 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644846906; x=1676382906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yguvRxMRnV5IB+hh/M/twMshNoTTuG75v2iSOANJTMY=;
  b=Zqa4zMHVJSnp5exm5GP2FAV9TXs8EHVaGnzNEJYK+D14WfgWNaD39JHY
   s6W8tnZwxdEfgxF8cqpJWNWgGC2C8pBjnrWKgsSV3nRJECpeaq4M4UpWA
   TI+e6X0GOX2oLWWDt37zi5TlyDUDkHgpqJHFDYVLW8EXiZ1SrqJ8CgKVo
   NhosWtR7D5R8tFKTKIzInFT8hkpy0X4rwFpS52Xsa5cKT4UQakpMb8D3F
   Q4mrhc4cDHk5xUEGhjmM6mCQM23HIlLvmXNdL8x5jLPd7j77Qn29ynQiX
   wKRgf0kf6ZxR7pHhyzRaEBojONtLptMYathi4vowR5Byz8WBTG371MWVn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247686644"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="247686644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:55:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="587214685"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:55:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJbnr-004YcY-FU;
        Mon, 14 Feb 2022 15:54:07 +0200
Date:   Mon, 14 Feb 2022 15:54:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <Ygpe/zalrTRFpNwg@smile.fi.intel.com>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
 <CANiq72mwkSo-W3QcyMnQ-o1COA5YJt1Ab9Xti7cdG6Krz3Sj7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mwkSo-W3QcyMnQ-o1COA5YJt1Ab9Xti7cdG6Krz3Sj7w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:27:48PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 14, 2022 at 11:19 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Not sure I understand this...
> >
> > ...together with this in the current SoB chain.
> 
> From my reading of `Documentation/process/submitting-patches.rst`,
> this is the case I have to use:
> 
> ```
> Example of a patch submitted by a Co-developed-by: author::
> 
>     From: From Author <from@author.example.org>
> 
>     <changelog>
> 
>     Co-developed-by: Random Co-Author <random@coauthor.example.org>
>     Signed-off-by: Random Co-Author <random@coauthor.example.org>
>     Signed-off-by: From Author <from@author.example.org>
>     Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
>     Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
> ```
> 
> Do you think another case applies?

I see, thanks for elaboration!

...

> > I'm wondering if you considered to use %pV.
> 
> Please see Rasmus' reply, i.e. we are using Rust's own formatting
> machinery (the compiler validates the format string and creates an
> object that represents the formatting to be done).

Yes, I read that.

-- 
With Best Regards,
Andy Shevchenko


