Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22FB54B846
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbiFNSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbiFNSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:08:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8443C714
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:08:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g2so10653818ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1HT10eh1GO5bHFhhzFg6L2ZKS3F6a/ZKqNJB8u6nSo=;
        b=d+G50quMVzD8X1zWpNXl70m2dG0hT+RVXZR68ghr81UzXBAZxdEj8QLUJC/usbxSJb
         4sCg875GjsPzfBwk2k5nqnq2PpdMtARImdhKXIDS3vQNgWc/cEC5bhz7y4rWHllTmFMk
         i5oUYQvRcu0pQgagLIyWvfUSXjghs9/O4s8LE2VOkCiiRJf8SVL7EbxGROvhQLOYS1PM
         Db1fvMlydmzpmdSD689iyQJigiVU+sfOyDaWbHhjSSnXi4/XmSVE6Ym0hxTaIo4sMJiu
         WH+YN6YnAZ+cTQCwReRezO5uACl9RF9zltggTFtcdLBaCGSINqKfs5x0+acWu21NoZz4
         HwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1HT10eh1GO5bHFhhzFg6L2ZKS3F6a/ZKqNJB8u6nSo=;
        b=traPS+BEYKNnOaYWPL0L2RCZbf3TFy44fHi4DFSg57Q0w3jo4kGeu5DTGbO3ZCXt7z
         rM/iQkZhqXVexymbklxfZ1SeIhPK6SqOYKOZGCjkaq8VLGK8iLDNlA34A4RmkXGG1Bs0
         yCIJsp+oSUACUjselsO+2QHQBrzCJ3CNAMagGP8AE+LeE4CgOWzp2ryIdOhrQFh6KbW8
         JCIUwYvZVBLR/b5NUG2qMm0meYzmQpsFUzBYnd/VLlTCoupiuSbtHtBZA5Dv71DXUnqC
         jScYvjJhKBWkhh41UgkYf2T+LxQkXUTPeW+4texcKIlRzyEeZgSvSkDmefG8BWgCG45l
         Ea1w==
X-Gm-Message-State: AJIora/H2jMJYksgADwHh+gknhwTzPY5qx/gxUpDkUcnJ6Uv7g2393+f
        f/IuRd/J8g1CTeslqBDm2HAtsZAu9hk6JQAZE9+hhw==
X-Google-Smtp-Source: AGRyM1vlpU+YYoVx423VwrpRCMxHTBgsHKGjOk7TAYtjS0pSAZgttUkcGWdalwmXngjLB35ExMkH4cPI1eCs/qGCrbc=
X-Received: by 2002:a2e:2ac1:0:b0:255:7677:97f3 with SMTP id
 q184-20020a2e2ac1000000b00255767797f3mr3227264ljq.513.1655230125976; Tue, 14
 Jun 2022 11:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAKwvOd=SotrVcZshzGzsMprkORkVXFwYc-3mREkJSDCQ1nvbFw@mail.gmail.com> <CAHk-=wgmezfDP_b93_Hw090vUd-TKb-odZNPhB9L_2vL5pn6kQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgmezfDP_b93_Hw090vUd-TKb-odZNPhB9L_2vL5pn6kQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jun 2022 11:08:33 -0700
Message-ID: <CAKwvOd=C1GC09zobqLK0higE3xPpghWBbB4xujyC8-QDyd_DTQ@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 14, 2022 at 10:11 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Maybe a new function parameter attribute would be nice?
>
> Right, exactly something like this seems reasonable.
>
> > #define __must_init __attribute__((must_init))
> > int init (int * __must_init x) {
> > // ^ warning: function parameter x marked '__attribute__((must_init))'
> > not unconditionally initialized
> >   if (stars_dont_align) {
> >     return -42;
> >   }
> >   *x = 42;
> >   return 0;
> > }
> > void foo (void) {  int x; init(&x); /* use of x without fear */ }

Thinking more about your snprintf example which is potentially more
costly than initializing just one value...here's another case for us
to consider.

int maybe_init (char* buf) {
  if (stars_align)
    return -42;
  buf[42] = 0;
  return 0;
}

char foo (void) {
  char buf [PATH_MAX];
  maybe_init(buf);
  return char[42];
}

I'm thinking the attribute would have to go on the pointed to type not
the pointer, i.e. `__must_init char *` not `char * __must_init`.
Similarly, you'd need to unconditionally initialize all of buf which
might be painful.  __must_init would not give you the specificity to
differentiate between "this whole buffer must be initialized" vs "only
index 42 need be initialized."  I _think_ that's fine, perhaps "only
index 42 need be initialized" is YAGNI and you could just _not_ use
__must_init for such a case.

One thing I'm curious about; if you have an aggregate in C (struct or
array) and don't fully initialize the whole object, just
members/sub-objects, but only use those I assume that's not UB? (Which
is what my maybe_init example does).  I think that's fine.

Another thing that makes me uncertain about my maybe_init example
above is decay-to-pointer, and the compiler's ability to track things
like __builtin_object_size precisely (or across translation units);
Kees is having a dog of a time with __builtin_object_size of structs
that contain flexible array members for example.  If a function
accepts a `__must_init struct foo*`, can we know if we were passed an
array of struct foo* vs just one? What if `struct foo` is an opaque
type; then the callee can't verify that all members of the struct have
been initialized (at least designated initialized wouldn't work;
memcpy should though...can you get the sizeof an opaque type though?)

But maybe I'm getting ahead of myself and am just describing good unit
tests when building such a feature.  Probably worth prototyping to get
a sense of the ergonomics and limitations.  But it doesn't sound too
controversial, which is probably good enough to get started. I'm sure
Alexander and team will have additional ideas or proposals for
achieving the same outcome.
-- 
Thanks,
~Nick Desaulniers
