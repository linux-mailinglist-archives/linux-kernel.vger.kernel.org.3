Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F656214D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiF3Rbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF3Rbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:31:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0714120BD3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:31:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x3so34995556lfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKovRKzTTq8kVAKncWkMW8HntSojKecvaV7C1Tiy6gA=;
        b=KiMJPhP6xYYFUTWaCNcg8Z9VnzBD8Sm0oGGvMtn8MvEbc8PTHuawBiezi89pfsM7Qg
         Weaotn/+nwWWMTsRSzSg3qRF0kqlRQQhIV56sfRjnhfJlsreFVjkQwOx56O2r6XGhDIE
         5MwNLhFeUXTLv7GhRSR68Rj4yk3AT6dh4zwiNg6OLPp3JgFANNXzgIlgbjJGJVPQTKnx
         MCEUiDTeM+atlaHz/soeTiQbt2NENBGmLKydg6UEQBFGBoYX7OfGhPE0X3Fm27YP4uzU
         UqdaYdcuGBsxGYIcG7YALT7F6u1V1TWM2roEZKCy53hl8+dLM5hWEuupgxTAOg99+qcZ
         o7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKovRKzTTq8kVAKncWkMW8HntSojKecvaV7C1Tiy6gA=;
        b=CH1ZXipCLXhnv3oLe5PgXhTWwughobSr6eyG0JsmhlGN4DGl/CoA1XZmWpMrQsbM9D
         njQnFXfr+R8AygdpdP5LqLCS7qv03mMAgS3yaNvdqfHoqVeSLu3oX4A1ZCxkdFo8BQLp
         fNibRy9lnS/Q2bmz1qRohjN/6ejAPjQ9wF7ae/aGH8keKgk3XVRbFoZMZd47KDo/lPJQ
         pOO6aVmh6hRD7yGrucOiUNWMoisTFaHMDKPAAP2gK3pA3f2rg8R2VtXr0lG/iFBZszoV
         +8IZALlnqdRctEmL/9oLTsihXq03PA5gb+KyT4a+WJjbezWq8S0iLb0YPZ4Ovriv2T+n
         G5/Q==
X-Gm-Message-State: AJIora/GmHq1NPtwo8ixtmrEmtW7lt78zyr9nUYYLDv/TpAIquqeekfi
        Iq6jP9J7NDvgNf2NkVwjkh1LTuNbalzBb09D6Y63VA==
X-Google-Smtp-Source: AGRyM1vC8qvT64BKHvXZRWx0+8khtoYbG2fNUSn6dQgJUNzOHR73qJQimcWU1Ouvt7DOWBH7/hK5HihBjOUZbkXXK/U=
X-Received: by 2002:a05:6512:b8d:b0:47f:74f0:729b with SMTP id
 b13-20020a0565120b8d00b0047f74f0729bmr6261421lfv.403.1656610306179; Thu, 30
 Jun 2022 10:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com> <CAHp75VdQws+Q8aoh0BZkq1K4Grw0ugo_=NZ1uYO0g38xFjT9Lw@mail.gmail.com>
In-Reply-To: <CAHp75VdQws+Q8aoh0BZkq1K4Grw0ugo_=NZ1uYO0g38xFjT9Lw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jun 2022 10:31:34 -0700
Message-ID: <CAKwvOdmyXX=P4k_ymT=3EmzEuTZryozOTbe=F08bokw=axieUQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test_printf.c: fix clang -Wformat warnings
To:     Justin Stitt <justinstitt@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, Jun 30, 2022 at 1:14 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 2:11 AM Justin Stitt <justinstitt@google.com> wrote:
> >
> > +       /* disable -Wformat for this chunk */
> > +       NOWARN(-Wformat,
> >         test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> >         test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> >         test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
>
> Perhaps shift right the lines as well?

Along these lines, I think it would look nicer to pass a block
statement (a group of statements) to the macro rather than use
__VA_ARGS__.  Here's an example:
https://godbolt.org/z/fsYcGGEMb

You have to be careful with control flow out of blocks like this
sometimes, but for these simple localized cases it looks like that
should be fine.

As Nathan mentions, you can probably re-use the existing infra in your
definition of NOWARN.  I do prefer some macro to make it appear that
the pragma is scoped to a block statement, rather than multiple lines
for the diag push + pop inline.
-- 
Thanks,
~Nick Desaulniers
