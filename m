Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC63D54B762
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbiFNRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiFNRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:11:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE221265
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:11:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j20so10479275ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyAFd7sRCaU+w7b+0hvxe+0ICDGoRhy4smmcnlfnVf8=;
        b=VVS3gab1omADGHC2/BM3jOV1A6eY4GdNrthiz8+wp8S5cMIFr2uLLkmB9rWypRLBGh
         CRxK1pt/YGuuK56vtZsvD/CNMXbTrPe44abbnBJSPlaV01HMvRdyVC7/7MaSsSEpfN7s
         VDYCYJeggFAC7pCVElIRie85ffAJzopAS55ANKLnocre+BCSHOgwqfWQCRJcTPWE4Isn
         EMA4XWOG5gWQCH1wII6Qhfdp2vMCpX6b1JJNwkUqT158J1cG33IKcVtKEJAS5U2wsbnf
         ewajr7lOHPJhZ8+i/OX/prvULKZVaxQeqwV/q5JhEUl6DvRw7s02/8LnPBl0C23kEfKq
         mpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyAFd7sRCaU+w7b+0hvxe+0ICDGoRhy4smmcnlfnVf8=;
        b=tzv6LRaC/bWBthChqx5hp9NmluWH3UaGhBVxhoHEY2aFA+bW8GNvo4y2IR7nU4w86Q
         IYXgm8nyuPU5YIbhdDOVocRTfc6ZA5EAWa2nSYG7tOArbnHlflOnw06SzQ3psdf5iLfO
         nJvYFBNT8eEWjr7+wkxObAJsjJjoMzZiXaGB/uAvnrLebgaqhjaO/lWV+7bn9PQIt/gQ
         g5pgCeV7W1tRhfzi5yE1/IyvGiCe6cu009q3KpU0vP0+5Pu7pZEJp5BxrZSG6ytJjsMg
         9tRvXL1OEIhfRyCTCPSt9XO06Vd6tMOORNd51d924YeXlLjb6PY2ZRpg0+orDxPJ2X+L
         1KWQ==
X-Gm-Message-State: AJIora9m5NpTil5D33Bof4yvPh18srSs7xPjFna3nzJGYotC4+exj4dX
        QSlFY0REP+2MR88sdZzHnG5l+2HfQ3jWgSbQtsD2wA==
X-Google-Smtp-Source: AGRyM1t/zo81ZsO+O0ZI1OPCqjgaCdubDxR4EFdi0YVKZ7767whrD8qazGD2NsdH5B4zjqm8DDOFG4TjN6wHpKoUiwY=
X-Received: by 2002:a2e:8e98:0:b0:255:9d3d:bac3 with SMTP id
 z24-20020a2e8e98000000b002559d3dbac3mr3037050ljk.103.1655226708884; Tue, 14
 Jun 2022 10:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
In-Reply-To: <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jun 2022 10:11:37 -0700
Message-ID: <CAKwvOd=SotrVcZshzGzsMprkORkVXFwYc-3mREkJSDCQ1nvbFw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 9:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 14, 2022 at 7:49 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > The bigger question I want to raise here is whether we want to
> > discourage passing uninitialized variables to functions in the kernel
> > altogether.
>
> I'm assuming you mean pass by reference.
>
> Some functions are really fundamentally about initializing things, and
> expect uninitialized allocations.
>
> Obviously the traditional example of this is "memset()", and that one
> can be special-cased as obvious, but we probably have a ton of wrapper
> things like that.
>
> IOW, things like just "snprintf()" etc is fundamentally passed an
> uninitialized buffer, because the whole point is that it will write to
> that buffer.
>
> And no, we don't want to initialize it, since the buffer may be big
> (on purpose).
>
> Now, for *small* things (like that "pointer to inode") that aren't
> some kind of array or big structure, I think it might be good to
> perhaps be stricter. But even there we do have cases where we pass
> things by reference because the function is explicitly designed to
> initialize the value: the argument isn't really "an argument", it's a
> "second return value".
>
> But always initializing in the caller sounds stupid and
> counter-productive, since the point is to initialize by calling the
> helper function (think things like returning a "cookie" or similar:
> initializing the cookie to NULL in the caller is just plain _wrong_.
>
> What I think might be a good model is to be able to mark such
> arguments as "must be initialized by callee".

Yeah, being able to enforce that would be nice.

Now that we have clang's static analyzer wired up (commit 6ad7cbc01527
("Makefile: Add clang-tidy and static analyzer support to makefile")),
Intel's 0day bot has been reporting cases it finds for some classes of
warnings.  There's been a few interesting (to me) cases where these
"init" routines would conditionally initialize a "second return value"
but the caller either did not do return value checking or the callee
was not marked __must_check (or both).

As with -Wsometimes-uninitialized, my experience has been that folks
consistently get error handling/exceptional cases wrong in so far as
passing unitialized values later.  Clang's -Wsometimes-uninitialized
is intra-proceedural, so doesn't catch the problems with "init"
routines. Clang's static analyzer is interproceedural; the trade off
being the time the analysis takes.

Maybe a new function parameter attribute would be nice?

#define __must_init __attribute__((must_init))
int init (int * __must_init x) {
// ^ warning: function parameter x marked '__attribute__((must_init))'
not unconditionally initialized
  if (stars_dont_align) {
    return -42;
  }
  *x = 42;
  return 0;
}
void foo (void) {  int x; init(&x); /* use of x without fear */ }


>
> So then the rule could be that small arguments passed by reference
> have to be either initialized by the caller, or the argument must have
> that "initialized by callee" attribute, and then the initialization
> would be enforced in the callee instead.
>
> But making the rule be that the caller *always* has to initialize
> sounds really wrong to me.
>
>              Linus



-- 
Thanks,
~Nick Desaulniers
