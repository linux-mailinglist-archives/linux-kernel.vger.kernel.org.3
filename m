Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E656056E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiF2QIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiF2QIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:08:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36019A45B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:08:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k20so1477905edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Os4mayMMpFsaTesvNE1De3rTgq6xRWw/qV7BZPpOtpk=;
        b=WKBtC/f/OZCaP/FFnlHcOyXMiWjUU7ynF9xFnSGYbWvYA/X2Ax01CmrgO82VoImDvh
         X6nmUOcLu5gKe4FtBVG+K8vhI82rRrROpHqYLC06NPtTZeImiePzTylR71l1sfllzP/6
         UQBikD4IORsuI4Y/FcT9ULSZA2hI2EQYkZ0Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Os4mayMMpFsaTesvNE1De3rTgq6xRWw/qV7BZPpOtpk=;
        b=zSSbjypFg4+tG3xlOwhyZpuGCXcGQvHWxifeaabGVDzV1kQfCSGS5D+WJLGboqj3bT
         MJEPofs9nD5yDNMul2ihik8aJEekS9AuOAV4Uk66vjEGqVz1LUGt6FdME1DNKc30UYqL
         7bmM1hUtZMC4j+4EtQ43yH0tW/ecb8KZGnTtI1i6RmmdfNO2ProGeILdRUgo1WhqLJ4O
         ETMBUaeIoqxX+OiaLgsVxPo9Z519rffVNkEoH2UNcSCw6HVr+6NhbUU45u6mKBos9lhP
         e4/tN6CdZc3hY/txwhJelT9mvWyEVklowtslSJRcGbb85SAyAchWuhKr4lWPE6UjjZAO
         HKMA==
X-Gm-Message-State: AJIora8Dsac3bys3KBXvCypOnwVo/pvO01OXufCxaC+u3S0MHfFTvrdB
        /2Bq9Rhl3eDXkkJJX303lM91UdSZKpaO/fYP
X-Google-Smtp-Source: AGRyM1tMaVXyZb4mKVzWTq7lXzRSEnVEWe+sAD/+UkCb/4yk4hlein69EsgCKQd5t1v9ZR0EGJt7SA==
X-Received: by 2002:a05:6402:3587:b0:435:b9a1:d5c5 with SMTP id y7-20020a056402358700b00435b9a1d5c5mr5232561edc.219.1656518919592;
        Wed, 29 Jun 2022 09:08:39 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b0042bdb6a3602sm11407084edt.69.2022.06.29.09.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 09:08:38 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so11710191wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:08:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:3a1:68bf:d17a with SMTP id
 g12-20020a05600c4ecc00b003a168bfd17amr4140154wmq.154.1656518917270; Wed, 29
 Jun 2022 09:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X> <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian> <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
 <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com> <20220628224255.w4lmzalkx3qejuyg@treble>
In-Reply-To: <20220628224255.w4lmzalkx3qejuyg@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jun 2022 09:08:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
Message-ID: <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
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

On Tue, Jun 28, 2022 at 3:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> So, something like this:

No, clang should just be fixed.

These UBSAN reports should usually be WARN_ON_ONCE.

It's all the same issues we've had before: causing a panic will just
kill the machine, and gets us fewer reports.

Now, UBSAN is something that presumably normal people don't actually
run on real hardware, so it's probably less of a deal than some. But
hey, maybe somebody wants to actually run an UBSAN kernel on a real
load with a full accelerated graphical UI and real drivers: a panic
may end up killing the kernel, and there you sit, with a dead machine
and no idea what went wrong.

So the whole "panic if UBSAN reports something" is COMPLETE GARBAGE.
It actually makes the whole point of running UBSAN go away. You *lose*
coverage.

So please don't make the kernel worse because clang got something like
this wrong.

Just fix clang.

And fix your mindset.

                  Linus
