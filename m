Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F234A79C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiBBUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347251AbiBBUwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:52:03 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4802C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:52:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y17so289651plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPEMedQu4jTNYHJmp71olOjxDB0xRf7+fA/WfqhgIVA=;
        b=EAlOPLnqtqVr6UWoSRQCQiil8xtekqy0ucrjftpEPAugnwRJaCgExC22zDJ3dLa32p
         IEtN7Zr25QITv0r/g5zMyAkjB0tErkFPXm8iUVah6oF4t6y9SojxveFQX8MkNVFtbGkl
         Y02gvbpZvq4nfuJCQ6hoiWRRvdk4dxnYiQ4EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPEMedQu4jTNYHJmp71olOjxDB0xRf7+fA/WfqhgIVA=;
        b=JzbIIu3F/7dI0VqEsLEnVM0A6vyVvIxU+terYF2zXfffVVKMpnNaCkKCPkPTqnwktH
         G/SQHwCWdVwa5kkylS3HUPNhcDBd7MEHWDUkT8m543kRdvS1eqW8uU3nP/p338idIgjL
         EmUHoTi56hEuCC5fNF0J7GakNv9rO4DO31gP9Z4fZo+pUw2V851kATFmPXEd7JeLAjXO
         rG+675qCORWipmLIxAPie3TRk4XufsPPrOUEnPznvQamBVlMchHaHamJc1ZoXq35D+EH
         6pg7k+gbP91b2J02wJ0HtgocAesAbq8GvswbPc+a9iXHZGr4KvgANpE0jOX/daUja9FR
         8SLg==
X-Gm-Message-State: AOAM531pdzqBGppBHtOUQ6WOTozMsoCtQVIfpDfKKsTmLAtMa/eOOAnN
        FrcpypH5aKHA2gBdivWjv01c1IX/B4Flmw==
X-Google-Smtp-Source: ABdhPJxdd9YfV7EbD3xvSuaZUXxBX9DB7g4c3W3Ag1C9zKX/pGzoQSAo0PKxahuKofQSPv3t073cQw==
X-Received: by 2002:a17:902:d64a:: with SMTP id y10mr18742283plh.66.1643835121970;
        Wed, 02 Feb 2022 12:52:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f16sm28486385pfa.147.2022.02.02.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:52:01 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:52:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202021237.487D3DE73@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160149.GA2322037@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
> > Add a simple test for strlen() functionality, including using it as a
> > constant expression.
> > 
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > I'll be taking this as part of my Clang FORTIFY_SOURCE series.
> > ---
> >  lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/lib/test_string.c b/lib/test_string.c
> > index 9dfd6f52de92..59994f552c48 100644
> > --- a/lib/test_string.c
> > +++ b/lib/test_string.c
> > @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Unlike many other string functions, strlen() can be used in
> > + * static initializers when string lengths are known at compile
> > + * time. (i.e. Under these conditions, strlen() is a constant
> > + * expression.) Make sure it can be used this way.
> > + */
> > +static const int strlen_ce = strlen("tada, a constant expression");
> > +
> 
> This results in:
> 
> lib/test_string.c:188:30: error: initializer element is not constant
>   188 | static const int strlen_ce = strlen("tada, a constant expression");
> 
> for several of my tests. I don't think you can mandate that a compiler
> implements this.

Which tests?

This property of strlen() is already required by our builds (this is how
I tripped over it). For example:

drivers/firmware/xilinx/zynqmp-debug.c:

#define PM_API(id)               {id, #id, strlen(#id)}
static struct pm_api_info pm_api_list[] = {
        PM_API(PM_GET_API_VERSION),
        PM_API(PM_QUERY_DATA),
};



> 
> Guenter
> 
> > +static __init int strlen_selftest(void)
> > +{
> > +	/* String length ruler:         123456789012345 */
> > +	static const char normal[]   = "I am normal";
> > +	static const char *ptr       = "where do I go?";
> > +	static const char trailing[] = "hidden NULLs\0\0\0";
> > +	static const char leading[]  = "\0\0hidden text";
> > +
> > +	if (strlen(normal) != 11)
> > +		return 0x100001;
> > +	if (strlen(ptr++) != 14)
> > +		return 0x100002;
> > +	if (strlen(ptr++) != 13)
> > +		return 0x100003;
> > +	if (strlen(trailing) != 12)
> > +		return 0x100004;
> > +	if (strlen(leading) != 0)
> > +		return 0x100005;
> > +	if (strlen_ce != 27)
> > +		return 0x100006;
> > +
> > +	return 0;
> > +}
> > +
> >  static __exit void string_selftest_remove(void)
> >  {
> >  }
> > @@ -212,6 +244,11 @@ static __init int string_selftest_init(void)
> >  	if (subtest)
> >  		goto fail;
> >  
> > +	test = 5;
> > +	subtest = strlen_selftest();
> > +	if (subtest)
> > +		goto fail;
> > +
> >  	pr_info("String selftests succeeded\n");
> >  	return 0;
> >  fail:
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
