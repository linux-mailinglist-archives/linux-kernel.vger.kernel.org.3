Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57D49E02F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiA0LEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:04:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:60950 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239942AbiA0LEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643281461; x=1674817461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VvT1Bjef2duRgl2x3XRoAHuY+VVE3Ni6AYhrZqmo9w=;
  b=l3/d7f5D2mStHNOHCnOhIeFyppm+GNklvwXBxaK2h1HJV6PJDXWeR3z7
   mslDzDWbwctraF0OkwHbEYsUjOEUPrLDe1eignxaU0FESkaOk5ttMuiGL
   qvR8KJ5xM3rjNcdLHVRlDrx5Qhf0uzVyHAws/PQndgHWVrBV/ApNyxmSY
   i3hUaYHQXxITbeNL3UZOoxJFWIBfrph1GYKQyz5Y0YwcQcWvlRxcDmrv3
   OlUdHjGp3SmFXUETyiDdveRGFcn/IJWvuwQ5YuRAIIBhrVwoQUQxpZ0Zx
   wn/0kkuRR1jb4WwEz6y16thLePjdvdV7HHeHxI0AgYuMCLLC333IMDgig
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310132124"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310132124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:04:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="696601420"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:04:05 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id E3463202F2;
        Thu, 27 Jan 2022 13:04:02 +0200 (EET)
Date:   Thu, 27 Jan 2022 13:04:02 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/3] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <YfJ8IhqsNtyfrsfO@paasikivi.fi.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <20220126141917.75399-3-andriy.shevchenko@linux.intel.com>
 <202201261321.34794CCF3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201261321.34794CCF3@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Jan 26, 2022 at 01:22:32PM -0800, Kees Cook wrote:
> On Wed, Jan 26, 2022 at 04:19:17PM +0200, Andy Shevchenko wrote:
> > The literals "big-endian" and "little-endian" may be potentially
> > occurred in other places. Dropping space allows linker to
> > "compress" them by using only a single copy.
> > 
> > Rasmus suggested, while at it, replacing strcpy() + strlen() by
> > p = stpcpy(), which is done here as well.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> > v3: no changes
> >  lib/vsprintf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 4e8f3e9acb99..e2a1d89f1a5c 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1781,8 +1781,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
> >  		*p++ = isascii(c) && isprint(c) ? c : '.';
> >  	}
> >  
> > -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
> > -	p += strlen(p);
> > +	*p++ = ' ';
> > +	p = stpcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
> >  
> >  	*p++ = ' ';
> >  	*p++ = '(';
> 
> No need for any of the manual construction nor stpcpy():
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index d7ad44f2c8f5..aef8bd2789a9 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1788,14 +1788,9 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
>  		*p++ = isascii(c) && isprint(c) ? c : '.';
>  	}
>  
> -	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
> -	p += strlen(p);
> -
> -	*p++ = ' ';
> -	*p++ = '(';
> -	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));
> -	*p++ = ')';
> -	*p = '\0';
> +	snprintf(p, sizeof(output) - sizeof(*fourcc), " %s (0x%x)",
> +		*fourcc & BIT(31) ? "big-endian" : " little-endian",
> +		*fourcc);
>  
>  	return string(buf, end, output, spec);
>  }
> 
> 
> (untested)

This could work but results in two nested calls to vsnprintf(). I'd
definitely avoid that, due to stack usage and then albeit it's easy to see
the recursion will end with two iterations, that will very fast cease to be
the case if you keep applying the pattern.

-- 
Regards,

Sakari Ailus
