Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC7C4B4D81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiBNKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349736AbiBNKyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:54:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A289CE1;
        Mon, 14 Feb 2022 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644833967; x=1676369967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ip8ECjYU3CIeQjPLRao5dfe4kBXCOpu/TG5z8yOdjjM=;
  b=K9wu0nFQPdXfl5eNnWftfBmk3WcxpDrRGAVPNd1c8JXkCFZjE6fO2hIJ
   jWirZV7ZM5uc1Dh9zEkG90wjfUDbxXoal6RqjjRxDUBrPRPnanNa7WpPi
   mzJM0ewKzVOXTP+ZS+m+ppONIgLyVgLM8ghwqhSQKhxPVuJW9Qu7LJkNs
   8TUQLAUwWDMmzHN+ZWusmFL3rGC7LWfTt17d5+MG/RdhL8qg+H33vhZN7
   s+AUUXHFYxaFmR7xPJFJrUZmauXI6L848wlyrqDg8kuhuhRdvUwOc54le
   OFxpO67rQfdHLHVzOta/6XIkGt4rYgrsi36S0lTmtIP402X1/DvoLwQFE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230697751"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="230697751"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:19:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="501691178"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:19:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJYR8-004PH0-Vm;
        Mon, 14 Feb 2022 12:18:26 +0200
Date:   Mon, 14 Feb 2022 12:18:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <YgosclY9ebD3t020@smile.fi.intel.com>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212130410.6901-13-ojeda@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 02:03:38PM +0100, Miguel Ojeda wrote:

> From: Gary Guo <gary@garyguo.net>

Not sure I understand this...

> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>

> Signed-off-by: Gary Guo <gary@garyguo.net>

...together with this in the current SoB chain.

> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I'm wondering if you considered to use %pV.

-- 
With Best Regards,
Andy Shevchenko


