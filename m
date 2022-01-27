Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29049E54F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiA0O6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:58:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:28832 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234362AbiA0O6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643295489; x=1674831489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3XEtJaxLuq1L25kvcnhdlIwMrA/HbaNIC1yWdkEF8s=;
  b=Fcx+XxXdWBRzSf+bRafVIAB5j9tniH9MX26MvYL8UzliTxNWcL6SlYSh
   wCp+tAEpBm+1rkNsX167J0wGaqWsmgwmloGRpZQjJvnztuMH1bcQwm/70
   jgfMYq4QxpFjYy606Wp18+9OjN4EHItiNEhAGjG/jdhQVywUYK/5sB1SU
   O4hPrweRyRS9Kb0aebESemhqKRFRNKGbYHxQy1jzWnYcBow6XpqzdFnln
   l+mEME4TpHnNJLv5Bod+ByVURaEuq2jdJYesV8QULU3JNIgDQYPv8LxGI
   cphjg12B3nTaeqGSCv/o6ijbDyQhBxCseB7P5FegJWJ0GTm7gx0bamkwT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271333047"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="271333047"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:58:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="628712758"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:58:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD6Cq-00F10o-Qh;
        Thu, 27 Jan 2022 16:57:00 +0200
Date:   Thu, 27 Jan 2022 16:57:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 3/3] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <YfKyvPhmJnQXzE94@smile.fi.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <20220126141917.75399-3-andriy.shevchenko@linux.intel.com>
 <202201261321.34794CCF3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201261321.34794CCF3@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:22:32PM -0800, Kees Cook wrote:
> On Wed, Jan 26, 2022 at 04:19:17PM +0200, Andy Shevchenko wrote:

...

> >  	*p++ = ' ';
> >  	*p++ = '(';
> 
> No need for any of the manual construction nor stpcpy():

No, we are better to avoid recursive printf() calls.
Entire vsprintf.c is written keeping that in mind.

-- 
With Best Regards,
Andy Shevchenko


