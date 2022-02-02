Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430A4A7A03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiBBVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347433AbiBBVJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:09:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A484AC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:09:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s6so306132plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/I9lN88woCCUFoo8q3GQ0U+UOLVhyA+KEq79xDhOwQ=;
        b=gy2KhoZlWLVxHSeIlgNS6LXR2Do4lE0fzqAmjllj1apNx5NM03qgdBQOKsPdZMjYmC
         DzR2yPDsHQfDvpcQQde05juXuWh8Az/4jleLh1nFeg7UL+dTeUB7Kvj+n1+XZ5P+AlfZ
         hOXLTDoIBxgMnG4UXHSA4hMy5PGguDk8o1u+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/I9lN88woCCUFoo8q3GQ0U+UOLVhyA+KEq79xDhOwQ=;
        b=PeImw+Rc1hFKpzoTK2ClgEkma+KJ7GaMIJdjpe4fiOQVPCGWa/RPxMR1bEJWexy9vt
         gR6p3p1BvW5UlwF0n8/U8ZfHRPm3PSBzuyRSfBf1y6ZHeOWtohMFithRSjKpeFUnGHxB
         9UHDOO57nVVAwIaDZkO1RXirwl+PrD/+yI0nZ7YmTxzNp42Tbgqyavp4pnTzEVh8vMlG
         JfPYwSUWIl0JF8WO5efOrfNMnxjpa9uukvALWdXFiCwyjHveOnvHBWh5MAesEr4sAKxC
         JrelMMqvVJ6s0T6/4Bs5B44dDdeDdpP+1KcI1N+PHjKbpUtfWDSjBwLVaG9ztJiFVnfJ
         HqYg==
X-Gm-Message-State: AOAM533+FtTzEde1VDpQ0VjWq2R0Jv27FzmhrMQfv6/Md+TWUYYZJY85
        70KcYFYOhIVni/bTWY/G5WxbwA==
X-Google-Smtp-Source: ABdhPJwLGGUSXvSqUXoGyNotccNLcNU1es0zC0+QmCFktC8Y7/ncaKyqZeg/GnVbmr6ggTBnd6rZGw==
X-Received: by 2002:a17:902:ec81:: with SMTP id x1mr31734885plg.109.1643836171113;
        Wed, 02 Feb 2022 13:09:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm8158756pfj.148.2022.02.02.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:09:30 -0800 (PST)
Date:   Wed, 2 Feb 2022 13:09:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/4] Compiler Attributes: Add Clang's __pass_object_size
Message-ID: <202202021307.75435AF9@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-2-keescook@chromium.org>
 <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:11:51AM +0100, Miguel Ojeda wrote:
> On Wed, Feb 2, 2022 at 1:30 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +/*
> > + * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
> 
> For attributes that are not supported under all compilers, we have the
> "Optional" lines in the comment. From a quick look in Godbolt,
> `__pass_object_size__` and `__overloadable__` are supported for all
> Clang >= 11 but not GCC/ICC. Thus, could you please add to the
> comment:
> 
>     * Optional: not supported by gcc.
>     * Optional: not supported by icc.
> 
> to those two patches?
> 
> For `__diagnose_as_builtin__`, I only see it on Clang trunk, so I
> assume >= 14, thus could you please add:
> 
>     * Optional: only supported since clang >= 14.
> 
> ?
> 
> Thanks!

Gotcha, I will adjust these.

> > + * The "type" argument should match the __builtin_object_size(p, type) usage.
> 
> This should go above on top of the comment (it is true there is one
> case that does not follow it, but that one has to be cleaned up).
> 
> Also, this bit seems to be explained in the Clang documentation (i.e.
> not kernel-specific). Do you think we need it here?

It's the kind of detail I feel like I might forget a month from now, so
I added it as a bit of a hint. If you think it's too redundant, I can
leave it off.

-- 
Kees Cook
