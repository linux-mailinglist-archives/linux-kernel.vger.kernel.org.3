Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38E524440
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbiELEaQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 00:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiELEaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:30:13 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F2620F9D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:29:59 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7d621d1caso42644237b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XqBqQ+XRvyAHUyGfBZIABF5Embq5Xn1tLFaDAHrehy0=;
        b=SjYSlNjradb8xsdLxJrOoO57gFeddQhIN7aSvVVzAr3NT12jd7yBDjBlmIYGMOtqtC
         0iDfIr5XOW0Gx8OreHZQEowRFS6Kwyp5bHWwucndMYw28JWVAtgGv7vIj/+5C6bxrQUg
         4E508vMZQYXCo+qL/QqnlHZBRV5VXbKuP50S2ZsWbjzgO/rIw3LnwH5VZYkZ6ipQpb9M
         Qk6UT6e+U43L6L+SB6lbNsOyJr67y5TDV7h1Z2P/yeBPTlO5zYy5LkYTwCOpLDxkfyoi
         6TUF9DlS0fefptZLpjkRUTOsVLAg6OSnpTaBdYEkLisKkaAZTQKN328QrLOd7UdpiGtq
         kdjA==
X-Gm-Message-State: AOAM532XDoYwROjJ4bvZLTRNI0HnHteNVD7euhLHM7FkSRpIj1/9CwVy
        CmIpHTzOH4NDKsBGI3hzzYE8D1IbFW6U1lOOZVA=
X-Google-Smtp-Source: ABdhPJyyVkmDxcTDBFjfTHOEDq9W/5HTODdg+KeIBAkAVH3WC7JPKZR0Bvog0/jCQrKv80S+rQPqP4YDlS9waRSLq3Y=
X-Received: by 2002:a81:34f:0:b0:2f7:bbb1:1576 with SMTP id
 76-20020a81034f000000b002f7bbb11576mr28802714ywd.45.1652329798501; Wed, 11
 May 2022 21:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr> <20220512011855.1189653-2-mailhol.vincent@wanadoo.fr>
 <154f41707c58acdac26c3300c5b429f381c45708.camel@perches.com>
In-Reply-To: <154f41707c58acdac26c3300c5b429f381c45708.camel@perches.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 12 May 2022 13:29:47 +0900
Message-ID: <CAMZ6Rq+Nm9wSajUFP7PyctB50t5ANpe9LhRmO3GJvmgkuXzEOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 12:02, Joe Perches <joe@perches.com> wrote:
> On Thu, 2022-05-12 at 10:18 +0900, Vincent Mailhol wrote:
> > For x86_64, the current ffs() implementation does not produce
> > optimized code when called with a constant expression. On the
> > contrary, the __builtin_ffs() function of both GCC and clang is able
> > to simplify the expression into a single instruction.
> []
> > -static __always_inline int ffs(int x)
> > +static __always_inline int variable_ffs(int x)
> >  {
> >       int r;
> >
> > @@ -310,6 +299,19 @@ static __always_inline int ffs(int x)
> >       return r + 1;
> >  }
> >
> > +/**
> > + * ffs - find first set bit in word
> > + * @x: the word to search
> > + *
> > + * This is defined the same way as the libc and compiler builtin ffs
> > + * routines, therefore differs in spirit from the other bitops.
> > + *
> > + * ffs(value) returns 0 if value is 0 or the position of the first
> > + * set bit if value is nonzero. The first (least significant) bit
> > + * is at position 1.
> > + */
> > +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
>
> How about not defining another function and using parentheses around
> the function definition to avoid the macro expansion like:
>
> #define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : ffs(x))
>
> and
>
> static __always_inline int (ffs)(int x)
> {
>         etc...
> }

Sorry, but I don’t really like this approach.

Main issue I see is that this code will emit a -Wshadow warning.

And using parentheses around the function definition just seems an
obscure hack to me. The variable_foo() gives me less headache. Was
this pattern ever used anywhere else in the kernel?


Yours sincerely,
Vincent Mailhol
