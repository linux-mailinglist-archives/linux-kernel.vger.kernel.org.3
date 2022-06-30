Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AA56149D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiF3IRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiF3IQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:16:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155542A25
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:14:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x184so29660769ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyqY8NPtV9nOL1byOGe85YhLGexT/CIt+eGWlU/GS7w=;
        b=gtCO1D7K21fpP2koBzksoVqeK5N/i3XuU/FtvL9LJvFqBndv4zYelVakK0FunbBVsx
         1g3Ve7RZ3KJUqLIbAx0dqXu4TcDjYyby/FaiY3l9VOe4lROlHNERL3MBJ2E4vdJy5141
         ueeVtn0H7YalFqEDNjvDXVfsJ+Baxtu7f2KM1q0nzmmtbdsmFBfdwCMQ7XiUo0GBPjOp
         0zACGrthsQNzPR0xTEmD/SbklKts+a+JSjuHO6ExOmpdum/qyF9G/I7j2yN5Mz1CbtMY
         4geL9OFqyELW7UJS7cUbclR+t/WHOYZQwD1Q+UDn+ty7iCh6dtLkxaEOuW1XxqJslO83
         09qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyqY8NPtV9nOL1byOGe85YhLGexT/CIt+eGWlU/GS7w=;
        b=5/d+BAghZ+7x155t48baIUA2BserrFq6SzOM1eVa/1aMqXyjGMr5vOQFHATO8JZAcZ
         Kg1UgOO0kHlW0PCHNb2Orx56tpEZ7DCxErvlclAOukzVEDKJYzeXbl6ncmDWnEH0hEJr
         zKfIdzngxP3mkPzDTEkOOHrM+H1AuvoDlpnxz62Q5eQlSa9sPzIMar10h36leZZvAGjn
         Ww2zac5RA48ECchGqwJU6oVDcgi93R9HkVypNaLIKeKD4FsIkvYbqFg/xADO6VqpG4Pt
         ZaJXn7Ug0FmedsD4Jpnkaq24gM9BM1Rd7NPNBqpGGqnfJDhqe2RQhPSWvHdhCeElmavN
         W3bw==
X-Gm-Message-State: AJIora8ivDQkNWtCtTCGEKVkwXr46QN5sKB8jqobdOgvaZLvsg0yN+JJ
        S9Bdjcaf5z87wn3AO55wvkWlfz4epbo33xfRH2o=
X-Google-Smtp-Source: AGRyM1vYw60ly77s93AhHQO3cVlf5Ysj40C4HYQ4R7/0OxJ4IsWrYnJPFVfbGwCnFfBBVeWTuTIcndvwUrcPCOu1muU=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr7976423ybs.93.1656576851143; Thu, 30 Jun
 2022 01:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com>
In-Reply-To: <20220629235326.480858-1-justinstitt@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 10:13:34 +0200
Message-ID: <CAHp75VdQws+Q8aoh0BZkq1K4Grw0ugo_=NZ1uYO0g38xFjT9Lw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_printf.c: fix clang -Wformat warnings
To:     Justin Stitt <justinstitt@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 2:11 AM Justin Stitt <justinstitt@google.com> wrote:
>
> see warnings:
> | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> | but the argument has type 'int' [-Werror,-Wformat] test("0|1|1|128|255",
> | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:159:41: error: format specifies type 'unsigned short'
> | but the argument has type 'int' [-Werror,-Wformat]
> | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
>
> There's an ongoing movement to eventually enable the -Wformat flag for
> clang. Previous patches have targeted incorrect usage of
> format specifiers. In this case, however, the "incorrect" format
> specifiers are intrinsically part of the test cases. Hence, fixing them
> would be misaligned with their intended purpose. My proposed fix is to
> simply disable the warnings so that one day a clean build of the kernel
> with clang (and -Wformat enabled) would be possible. It would also keep
> us in the green for alot of the CI bots.

a lot

...

>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+ blank line

> +#define DO_PRAGMA(x) _Pragma(#x)
> +#define NOWARN(warnoption, ...)
> +           DO_PRAGMA(GCC diagnostic push)
> +                   DO_PRAGMA(GCC diagnostic ignored #warnoption)
> +                           __VA_ARGS__
> +                                   DO_PRAGMA(GCC diagnostic pop)

Is it deliberately a broken indentation here?

...

> +       /* disable -Wformat for this chunk */
> +       NOWARN(-Wformat,
>         test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
>         test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
>         test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);

Perhaps shift right the lines as well?

> +       )
> +       /* end chunk */

-- 
With Best Regards,
Andy Shevchenko
