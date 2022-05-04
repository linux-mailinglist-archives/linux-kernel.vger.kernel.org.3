Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14251AF9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353672AbiEDUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbiEDUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:46:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F051339
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:42:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so3024576edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wgCvSGeoLgTvUhr6ldUxnnG33sX0YtUZwS6z+cjGVKU=;
        b=ODR59VkSmmMDoe+nKh6pekgpw4CMJsSCFZ2twwlnrrKsgoEIOi/6/LOKfdCtQayvwy
         Su2MIIlzRimbOG4EYf0HZo/aww18+o8zKrV3u0AaBGRWKjuK0/RPvn78qK7uf3+3v8UT
         FXkpj8Q+27ZxNnsUC0sYHtRnBKeBc2et4lMq1M3azLBokJ+VEmhY0whcJsIXvrUiIjJj
         LuH0ardcLXJtH5hC9va90hnsC6mw6F/zbv22Rj0bxBmFO3WuFj61fYVdZG+Su53mxPYg
         QhDuoFc+4BLURuGsda8KJsPUWgFbZJBUleY4rFvAx40mZdyAlhlq3Gek9QbNlt67Umlj
         KOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wgCvSGeoLgTvUhr6ldUxnnG33sX0YtUZwS6z+cjGVKU=;
        b=kJ2wJIT6X6Qy2DB2XhqMiUlDBhNkzN0/rMLlRsirH1h32ghDf1I/yrTRyXInHBzNJr
         ++3n6KRQEpGNaO7lZBUjw5ASQZRGOs48HonbuvMxGCA3xKD8Idxh3Mj7ktUn23kUGcyc
         S2EW3jGKkeA3JYT9dAw/qBspU6W6DfBZw/A6ogw/IbexfVtCphYjr0OqX6kFKONq6JeK
         W+WAHQtxvkpNGnvl1ECKIOwXsUkuR1M1HdL13odumW2sD3qbixvdNEzUz3eW60ge0ZZb
         +CzGHATVqi6uTVxPcne4Y6UIgP+hBsPlPOBVsEDj6h8jTEGF9bioV5ZjzqUkGDnWr2HH
         XtrA==
X-Gm-Message-State: AOAM532oor1vrkU0iH2i3o7cwGDDYXsrDzHSHqhqH/H3TiF1Elki1Yrs
        595XPANZQn2nXy55is0mCu/3hYkdCw737qV1bpuM4g==
X-Google-Smtp-Source: ABdhPJxDrzakPqYRb56RH8Ng2H63kxh5peJ3DhjNTf4bXod+p7+aXU1xh3g8b/19aKKB7wOx4j1peJ94uaDFdKBKqp8=
X-Received: by 2002:a05:6402:2945:b0:41d:aad:c824 with SMTP id
 ed5-20020a056402294500b0041d0aadc824mr25325497edb.364.1651696961339; Wed, 04
 May 2022 13:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-2-davidgow@google.com>
 <CAGS_qxqm1ys1qUz__4uXWOgs=34M5MB3QMnhg40FHtRhatF3+g@mail.gmail.com>
In-Reply-To: <CAGS_qxqm1ys1qUz__4uXWOgs=34M5MB3QMnhg40FHtRhatF3+g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 4 May 2022 16:42:30 -0400
Message-ID: <CAFd5g452ecbNbSyODT3Prraj5cOEugHm=asE_h+ik-yriUvf6w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kunit: Expose 'static stub' API to redirect functions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 4, 2022 at 4:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Mar 17, 2022 at 9:13 PM David Gow <davidgow@google.com> wrote:
> > +#define kunit_activate_static_stub(test, real_fn_addr, replacement_add=
r) do {  \
> > +       typecheck(typeof(real_fn_addr), replacement_addr);             =
         \
>
> We can't call this macro in the same scope for functions w/ different
> signatures.
>
> E.g. if we add this func to the example test
>   static void other_func(void) {}
> then trying to call kunit_activate_static_stub() on it in the same
> test case, we get
>
> ./include/linux/typecheck.h:10:14: error: conflicting types for
> =E2=80=98__dummy=E2=80=99; have =E2=80=98void(void)=E2=80=99
>    10 | ({      type __dummy; \
>       |              ^~~~~~~
> ./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=98=
typecheck=E2=80=99
>    99 |         typecheck(typeof(real_fn_addr), replacement_addr);
>                  \
>       |         ^~~~~~~~~
> lib/kunit/example-test.c:64:9: note: in expansion of macro
> =E2=80=98kunit_activate_static_stub=E2=80=99
>    64 |         kunit_activate_static_stub(test, other_func, other_func);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/typecheck.h:10:14: note: previous declaration of
> =E2=80=98__dummy=E2=80=99 with type =E2=80=98int(int)=E2=80=99
>    10 | ({      type __dummy; \
>       |              ^~~~~~~
> ./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=98=
typecheck=E2=80=99
>    99 |         typecheck(typeof(real_fn_addr), replacement_addr);
>                  \
>       |         ^~~~~~~~~
> lib/kunit/example-test.c:62:9: note: in expansion of macro
> =E2=80=98kunit_activate_static_stub=E2=80=99
>    62 |         kunit_activate_static_stub(test, add_one, subtract_one);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Afaict, the problem is that GCC thinks we're declaring a *function*
> called __dummy, not a variable.
> So it bleeds across the scope boundary of do-while unlike normal variable=
s.

Yeah, I ran into that problem too. I posted a fix to gerrit. I have
been meaning to share it here.

> There's the typecheck_fn macro, but it doesn't work either.

That's weird. It worked for me.
