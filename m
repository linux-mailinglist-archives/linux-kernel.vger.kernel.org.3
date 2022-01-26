Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48AC49D469
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiAZVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiAZVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:22:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:22:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o11so864011pjf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WwF77iiskBi0tVOR9grcbM66YdixrtGONmO8eGaXJuM=;
        b=V1i1qj1oiJh62NhKr9M7Fyd5gODgYFX4zN1hQPxtYWlMzEXVMC85/I1+X2NgQD+LRC
         0me7e11svC4wFCcWBEAGe3akZh8FmFEanhKJw44KLS3bM7/fvz2gn5TF9DpiHIZhEzCQ
         NUd6Y9ikCnkixs3SjmCCVGnumh3odJE8CIpVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WwF77iiskBi0tVOR9grcbM66YdixrtGONmO8eGaXJuM=;
        b=kejsOK/J2OkLcnJX3a1hAKHYVgYEcJtRS6hvg2M0ArdZDRvWpR6MUocpuuL9VqroQ8
         HsXhzQotRuAOI6L7ydyvz4j4L+qFNkCDHqf5zbFRb80RqeWolnmqa0vHoeImNSx7DyoK
         FaSbLOii8pRWxS8qPBReJWcrGIy39lJkR2nt2xRUUPnHH9FuKSLevLEhsBIv6mTgrQZm
         i3CO/O8Avob1j16XPDexnfT3qaodV2WC88GMSCJxW8Td/ZeF8N129rPx0f7WBnoCDgY2
         A3/0INX/5EsQZungwZRyOB/QFLpFTX4csLa1sd7cUy9YvVeqr5eCk34JaIZB9z4o+H57
         JIiA==
X-Gm-Message-State: AOAM531r6Esjs78qzCVWqfKr/Co5PzvvigjpPw2Ut/SjS98s7qjMRu8V
        1+wyUGZ8Vwj0/V6k63vEMOtQ4A==
X-Google-Smtp-Source: ABdhPJzL9z4Pxpeqav6p9g9loj8DvsVgb6O3b+CmJ+Ds8EuMGEvhjepebp+uewcyGUBCsYwcuErZ9A==
X-Received: by 2002:a17:902:ce8f:: with SMTP id f15mr518312plg.3.1643232153633;
        Wed, 26 Jan 2022 13:22:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y13sm3009620pfi.2.2022.01.26.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:22:33 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:22:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 3/3] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <202201261321.34794CCF3@keescook>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
 <20220126141917.75399-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126141917.75399-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:19:17PM +0200, Andy Shevchenko wrote:
> The literals "big-endian" and "little-endian" may be potentially
> occurred in other places. Dropping space allows linker to
> "compress" them by using only a single copy.
> 
> Rasmus suggested, while at it, replacing strcpy() + strlen() by
> p = stpcpy(), which is done here as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> v3: no changes
>  lib/vsprintf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 4e8f3e9acb99..e2a1d89f1a5c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1781,8 +1781,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
>  		*p++ = isascii(c) && isprint(c) ? c : '.';
>  	}
>  
> -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
> -	p += strlen(p);
> +	*p++ = ' ';
> +	p = stpcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
>  
>  	*p++ = ' ';
>  	*p++ = '(';

No need for any of the manual construction nor stpcpy():

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7ad44f2c8f5..aef8bd2789a9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1788,14 +1788,9 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 		*p++ = isascii(c) && isprint(c) ? c : '.';
 	}
 
-	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
-	p += strlen(p);
-
-	*p++ = ' ';
-	*p++ = '(';
-	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));
-	*p++ = ')';
-	*p = '\0';
+	snprintf(p, sizeof(output) - sizeof(*fourcc), " %s (0x%x)",
+		*fourcc & BIT(31) ? "big-endian" : " little-endian",
+		*fourcc);
 
 	return string(buf, end, output, spec);
 }


(untested)

-- 
Kees Cook
