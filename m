Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436215932A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiHOP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiHOP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:58:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DB1A80E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:58:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so10093633edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kw9cCSp2v6lTn00tET+V9Ob4XlH+2ZWKz74aJFYqrBc=;
        b=OOAA4IE6YBl7I5aP5vqsyGb/fF3W0qtrjDDLFG25fNI3zcQhBBR6oZzj2bRlF76zjV
         vjxur8+z8enpP3yFWyEk6jUzu1VUyVgsKZ3N5vJ0h2l2qkeVgA0yXpE4niDvp8ilL/Zd
         gjRsa5+9mR31oxFzFIq254w04NLlaQgVTVcBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kw9cCSp2v6lTn00tET+V9Ob4XlH+2ZWKz74aJFYqrBc=;
        b=JuFnP+fZ76xo+FfUQxxpMd1YeYGbZuMd8SrFFyjrs2mvUk4sXy6PK6ve+wdL5fEKKz
         aIdbJJ5w/H8fjvDoycdGLkAN4FDjadPelMWGsPN8SAntxcFhLJtLzzMKflTW3YQAX6jN
         QrXBp+PfrYyP8rxZp5i8Wjl4uf6jkcuBKMR2XXj86tLWKfjcqt8jZJ6kvf14BeE+ehNh
         kC9kqzGyBV2k3H5pzu3ud4F+cdLVDDMZhGpqUdxBjAfKg+4inhDuWvpCMkH9X5kqlBS3
         5+Dgv3412QNHKiyWFvzuiBJSKh57yRaOqKlu9N3dhKXoe/4dCuf8/g7zoBZLJpebxgob
         yEYA==
X-Gm-Message-State: ACgBeo1QijCNgRH/UdfPrmddwMvPmzOrgS2v8lhp8zacgABl/VBeet0K
        WCnv6rWP4kjZnXGu33vV/HRGZoSOXPyGpr11
X-Google-Smtp-Source: AA6agR7s4rqc3KggQVFVVw/ZtlxXm0UKwAClma51xw9+BRnSaVVRINPip1G94MUsDbgxlGWn8A3d1Q==
X-Received: by 2002:a05:6402:2792:b0:43f:6873:7497 with SMTP id b18-20020a056402279200b0043f68737497mr15951547ede.175.1660579118530;
        Mon, 15 Aug 2022 08:58:38 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id fd4-20020a1709072a0400b00722f069fd40sm4219800ejc.159.2022.08.15.08.58.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 08:58:37 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso8004393wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:58:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:3a5:f526:cdb4 with SMTP id
 i22-20020a05600c355600b003a5f526cdb4mr3233474wmq.145.1660579117166; Mon, 15
 Aug 2022 08:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
In-Reply-To: <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 08:58:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
Message-ID: <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Mon, Aug 15, 2022 at 12:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So obviously we could use _ASM_EXTABLE_TYPE_REG together with something
> like: "mov (%[reg]), %[reg]" to not depend on these fixed registers, but
> yeah, that doesn't seem needed. Code-gen is fine as is.

I looked at using TYPE_REG, but it got *much* more complicated for no
obvious gain.

The biggest downside of the fixed registers is actually the address,
which in the fs/dcache.c case doesn't matter (the address is just in a
register anyway, and the compiler can pick the register it wants to
and seems to happily pick %rdx).

But in fs/namei.c, the code *used* to be able to use register indexed
addressing, and now needs to use a 'lea' to generate the address into
a single register.

Using _ASM_EXTABLE_TYPE_REG wouldn't help that case - we'd have to
actually disassemble the instruction that faulted, and figure out the
address that way. Because while the fault itself gives us an address,
it gives us the address of the fault, which will be the first byte of
the next page, not the beginning address for the access that we want.

And no, disassembling the instruction wouldn't kill us either (we know
it's a "mov" instruction, so it's just the modrm bytes), but again it
really didn't seem worth the pain. The generated code with the fixed
registers wasn't optimal, but it was close enough that it really
doesn't seem to matter.

> > +     regs->ip = ex_fixup_addr(e);
> > +     return true;
>
> I think the convention here is to do:
>
>         return ex_handler_default(e, regs);

Ahh, yes, except for the FP case where we restore it first (because
the code seems to want to print out the restored address for some
reason).

I had just started with the ex_handler_default() implementation as the
boiler plate, which is why I did that thing by hand.

Will fix.

The other question I had was actually the "return false" above - I
decided that if the address of the fault does *not* match the expected
"round %rdx up" address, we shouldn't do any fixup at all, and treat
it as a regular kernel oops - as if the exception table hadn't been
found at all.

That seems to be a good policy, but no other exception handler does
anything like that, so maybe somebody has comments about that thing?
All the other exception handler fixup functions always return true
unconditionally, but the fixup_exception() code is clearly written to
be able to return 0 for "no fixup".

I may have written that code originally, but it's _soo_ long ago that ....

              Linus
