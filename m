Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E248A280
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbiAJWM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:12:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:36182 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238643AbiAJWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641852776; x=1673388776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TcPgNN0UF5CAT4Vwe9MSpJBjD9y4b9or6vEp7bQIsPg=;
  b=cqEQAKoIkB5ootlThVntO130fjuUrRjXXCJbXrYec7qyNH0jzGURBj4P
   4BwDNzTgEN6Yf+GWYkXkzNfr4Hfh9nzbzMti5cZHWUcH4COAbjps8lgvC
   J38HPLKqozrRCB2BJFk0EzK1VkLbRrX49A6wYrqsP1hne3Co3x5rtSrXo
   N6ScpPIxVKJXUzwvsum25CxaHoV+Pwr7G6y0OIPSc/fT6gocyyqdz+W5A
   KyclkrE0cU4ARkN/XsHSSKhACeMCTbqPK9+Sn7PNEEVtM+6eRDzDyDqha
   uEe9ujA5VYdUFcpcZzz1MErLhYbqwPtLqNjpAYUhlZF3S16Si5Iau7FDJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306694229"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="306694229"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:12:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="762306284"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:12:48 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C3F022043C;
        Tue, 11 Jan 2022 00:12:46 +0200 (EET)
Date:   Tue, 11 Jan 2022 00:12:46 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <YdyvXq8D2jsiM47E@paasikivi.fi.intel.com>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jan 10, 2022 at 10:50:49PM +0200, Andy Shevchenko wrote:
> The %p4cc specifier in some cases might get an unaligned pointer.
> Due to this we need to make copy to local variable once to avoid
> potential crashes on some architectures due to improper access.

I guess this problem exists virtually everywhere where pointers are being
handled: the pointer could be unaligned. Does this even address the false
positive compiler warning?

> 
> Fixes: af612e43de6d ("lib/vsprintf: Add support for printing V4L2 and DRM fourccs")
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index c130dcaca5e2..b02f01366acb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -49,6 +49,7 @@
>  
>  #include <asm/page.h>		/* for PAGE_SIZE */
>  #include <asm/byteorder.h>	/* cpu_to_le16 */
> +#include <asm/unaligned.h>
>  
>  #include <linux/string_helpers.h>
>  #include "kstrtox.h"
> @@ -1761,7 +1762,7 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
>  	char output[sizeof("0123 little-endian (0x01234567)")];
>  	char *p = output;
>  	unsigned int i;
> -	u32 val;
> +	u32 orig, val;
>  
>  	if (fmt[1] != 'c' || fmt[2] != 'c')
>  		return error_string(buf, end, "(%p4?)", spec);
> @@ -1769,21 +1770,22 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
>  	if (check_pointer(&buf, end, fourcc, spec))
>  		return buf;
>  
> -	val = *fourcc & ~BIT(31);
> +	orig = get_unaligned(fourcc);
> +	val = orig & ~BIT(31);
>  
> -	for (i = 0; i < sizeof(*fourcc); i++) {
> +	for (i = 0; i < sizeof(u32); i++) {
>  		unsigned char c = val >> (i * 8);
>  
>  		/* Print non-control ASCII characters as-is, dot otherwise */
>  		*p++ = isascii(c) && isprint(c) ? c : '.';
>  	}
>  
> -	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
> +	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
>  	p += strlen(p);
>  
>  	*p++ = ' ';
>  	*p++ = '(';
> -	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));
> +	p = special_hex_number(p, output + sizeof(output) - 2, orig, sizeof(u32));
>  	*p++ = ')';
>  	*p = '\0';
>  

-- 
Kind regards,

Sakari Ailus
