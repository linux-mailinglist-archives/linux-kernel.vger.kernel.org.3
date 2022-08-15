Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDD59283B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiHODng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHODnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:43:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3F13F21
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:43:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f22so8132685edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8GGB/49mCW+ASejosbIfzxpTGaMVR2I7jGs9zaiNEuA=;
        b=NzuKLoOEIbmS2zWZ6FLQc9Z0EReusgl0yz0sb1p0uTvAtt0HMvEgCWcsUvAgYVt+Ll
         Gcskv3uZLFw6E+Jf86vRQIq8cjy9hVjAf51w7UEf69hytsRgwj8vCSSMvPGClnkKmEsy
         LyElPxKcSnmJSaZ1SbJF3Xrh6G+qeSTZgw2SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8GGB/49mCW+ASejosbIfzxpTGaMVR2I7jGs9zaiNEuA=;
        b=nHnscXV7OhhCdfTZl0IDL+mnLwHnW7ZfZAKr7EkDwWY8YLV4t2fgvGFsDeGPEkfNVN
         s0ksdc0mbix7O9z2fBfSbiW5KYmDVEHWJO+ySTiFR3NTJbCWQBt86mDDWFYhQ2wxqv+o
         xYs9tWpCMnECzLy58W2oTRiGmMTNdfm3ebFN2LRF7QQq2kZuB4KF/K+0YBxX5U92fSlL
         xGTjICp3jWy4jERRZFKbfgFU2LqBcCSM0MT9Py7o0hCRw/X8DPG7C0yj3GJ7jX5oivqG
         gtQnjM8puA9rYw3HVTDRuBOUMqciAfT1eEAut8bZf1QOGzDWyVQr4VjVcdkKfDIAoz0q
         kWeQ==
X-Gm-Message-State: ACgBeo1BW3wvshHgJPtHeAIq6wgxeofGsU9Me5N8Usc74BdihePkyD6Y
        Qa5ZzOvQGoSFLakWTaAKYZztVSaUN0ioETpb
X-Google-Smtp-Source: AA6agR7fKyeEHB8pEJ52+L6YEaTXp6uAkKkQ+FjsJMOzFC3QZfib58lsRJIJc4xc4onhojxDzwPE0g==
X-Received: by 2002:aa7:dc17:0:b0:441:e5fc:7f91 with SMTP id b23-20020aa7dc17000000b00441e5fc7f91mr12763998edu.301.1660535006560;
        Sun, 14 Aug 2022 20:43:26 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id jl15-20020a17090775cf00b00730df07629fsm3622239ejc.174.2022.08.14.20.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 20:43:25 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id h1so3339104wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:43:25 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr3981246wmm.68.1660535005014; Sun, 14
 Aug 2022 20:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <20220814225415.n546anzvud6sumux@box.shutemov.name> <CAHk-=wiOqbuzy7xzsLrN8LXKGGUUMH109wcKOXx_PV9PkHa=Zw@mail.gmail.com>
In-Reply-To: <CAHk-=wiOqbuzy7xzsLrN8LXKGGUUMH109wcKOXx_PV9PkHa=Zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 20:43:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
Message-ID: <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 3:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If TDX has problems with it, then TDX needs to be fixed. And it's
> simple enough - just make sure you have a guard page between any
> kernel RAM mapping and whatever odd crazy page.

.. thinking about this more, I thought we had already done that in the
memory initialization code - ie make sure that we always leave a gap
between any page we mark and any IO memory after it.

But it's possible that I'm confused with the IO window allocation
code, which does the reverse (ie actively try to avoid starting
allocations close to the end-of-RAM because there is often
undocumented stolen memory there)

I'd much rather lose one page from the page allocator at the end of a
RAM region than lose the ability to do string word operations.

Of course, it's also entirely possible that even if my memory about us
already trying to do that is right (which it might not be), we might
also have lost that whole thing over time, since we've had a lot of
updates to the bootmem/memblock setup.

Bringing in Mike Rapoport in case he can point to the code (or lack there-of).

Mike?

               Linus
