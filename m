Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B44DDB47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiCROJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiCROJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:09:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C31FCC6;
        Fri, 18 Mar 2022 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647612495; x=1679148495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJCDHSRIKGH8VTdIUAq1uTf5J24fd/oecWbmG0Lcnd8=;
  b=PpDWoRzMI9DbdD9abqmHna8KaWOX1+z6xwqRSaasgaGubtG+R9d+sj+V
   dF8eozasUkPWR8K7+ZMEWEnOE1XnO8VSo6mDIP+026bsDXnzyRSUJs++W
   S4BqdLbT6n0P90Of2UoPXsiMx1YPv8ZswMlnnajJ05No4UDJ8+bhySRnd
   wG6hSbdV/j4oY+EGapehIINEF/gj9PD8G+sRwktjPNEPBDrZUpVTp7R0n
   G4aVd1tAy1x5gB2O6M0qN/QYhpZiVK3zAuWd/ch2qru5DjU9lSqUi7e+p
   j3froF2JuTpcGH/GMAjzd6FcIa1KlHGpQ2BHn4QEC6ACembshrWgMunM3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281951749"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="281951749"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:08:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="513873836"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:08:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDGN-002GQx-I5;
        Fri, 18 Mar 2022 16:07:31 +0200
Date:   Fri, 18 Mar 2022 16:07:31 +0200
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
Subject: Re: [PATCH v5 12/20] vsprintf: add new `%pA` format specifier
Message-ID: <YjSSI4cmGblm+6j7@smile.fi.intel.com>
References: <20220317181032.15436-1-ojeda@kernel.org>
 <20220317181032.15436-13-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317181032.15436-13-ojeda@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:10:00PM +0100, Miguel Ojeda wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.

...

> +	case 'A':
> +		if (!IS_ENABLED(CONFIG_RUST)) {
> +			WARN_ONCE(1, "Please remove %%pA from non-Rust code\n");
> +			return error_string(buf, end, "(%pA?)", spec);
> +		}

I'm wondering if the Big Scary Banner as trace_printk() does would be better
(in case we can tell that %pA is used in the code when RUST=n).

-- 
With Best Regards,
Andy Shevchenko


