Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A4D578BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiGRUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGRUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:23:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080931356
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:23:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w2so15014478ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3Z3tfeKRJLdAhCCmhWHihJdksAblGizQ/tJ4Dbs+/0=;
        b=HD/VtTr2HeFoaOVpMcfUVs71WCVWY48z0aqcCEiLsX5857s65SH7E5Xb2GjKv3dtWy
         6DmQ9EkCke2ysjQ1N8K2jZB/5gkUbhNp5W2rkR0jCyl6FPTEqwNsyR98jtzPVWJqavRr
         CFbToIfVeJnkjCBBMcdKNkGSveJa+L/1XBtFwxmQ/czqGrrwIW5nO1y3f4zPntYjryFn
         ab5+ruztb1pA9NxwVq7dkPRPKR9aEpwssmZJUyYfvcsF9vGsEJPIa8/Ogtc9yk1S7apl
         2+x8Y87K+VH46qhxvdr5FouKMsKYd/DgRr0ClKYHVU/QLia2LCnSz9qTaU7UmMPfBf7n
         GJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3Z3tfeKRJLdAhCCmhWHihJdksAblGizQ/tJ4Dbs+/0=;
        b=P4qRaIhdkdcE4g0hJnlCfsji/LIIV8L26A/5FZqWmWhim9V9W9tycSekyHXL9BICOe
         mXYCWmhC2CmzRKcg7Gij4svXbM35NS4ek+w4hfciYH770DWNQPJT46C4iHEWmQ0/kHI0
         k8IazQBT8kDIDlcVgaJHMWx26TBCD15kj7JjNX8mapdkWqx2CJUsQ6MugHlCpGTkuZkY
         dQozTtjgyrU45f6L1hAmlYlP7qKL4x/6F7jsPs7+hRwr4vzuoUo2aG5YlcUROxTTrKsQ
         ZebgAtKxwcHRusfmz2+fJdMW3tGWi0IOu80IBVtS+q7sIbv48LhqIovBJHVsD0/Qipro
         +tvA==
X-Gm-Message-State: AJIora+MID6kd/XPQunIUvjVuPRNNBbq/BXGUe8GfbL6ZS5GEKkyFfZI
        AFVqN5lOA2LXiQXtEA95kWzy+VgdVOmJdfgWrJA3Yg==
X-Google-Smtp-Source: AGRyM1ucIKcIR0ILXQCLuba5IMjLqiY0xKoOhbqsIuI59lX0d0LNg307CusOi23Ffxs7aSlum+8gG33zVH2Hil+sy4M=
X-Received: by 2002:a2e:3607:0:b0:25d:73a7:97b4 with SMTP id
 d7-20020a2e3607000000b0025d73a797b4mr14294228lja.352.1658175781963; Mon, 18
 Jul 2022 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220629213632.3899212-1-blakejones@google.com>
 <Yr6u/jdLvg2TcT8s@krava> <YtVzVZoo5PTj0qXH@kernel.org> <CAP_z_CjUi-Uk_mftfw33+eac13sLyHMBtQJd8V393SaD4OocNg@mail.gmail.com>
 <YtW1aFY4MyeqxhdH@kernel.org>
In-Reply-To: <YtW1aFY4MyeqxhdH@kernel.org>
From:   Blake Jones <blakejones@google.com>
Date:   Mon, 18 Jul 2022 13:22:50 -0700
Message-ID: <CAP_z_CgPPg7o1TYyQ0b9MtEO17X-69Te3zOfocXK2MYc-SmPmA@mail.gmail.com>
Subject: Re: [PATCH v3] Add a "-m" option to "perf buildid-list".
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah yeah of course, sorry about that!


On Mon, Jul 18, 2022 at 12:33 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jul 18, 2022 at 10:07:32AM -0700, Blake Jones escreveu:
> > Fabulous, thanks!
> >
> > On Mon, Jul 18, 2022 at 7:51 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > wrote:
> > > > > Signed-off-by: Blake Jones <blakejones@google.com>
> > > >
> > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > To clarify, b4 found v3 and that was the one applied.
>
> Now fixing this:
>
>   28     5.28 debian:experimental-x-mips    : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
>     builtin-buildid-list.c: In function 'buildid__map_cb':
>     builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                    ~~~~^                  ~~~~~~~~~~
>           |                        |                     |
>           |                        long unsigned int     u64 {aka long long unsigned int}
>           |                    %16llx
>     builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                          ~~~~^                        ~~~~~~~~
>           |                              |                           |
>           |                              long unsigned int           u64 {aka long long unsigned int}
>           |                          %16llx
>     cc1: all warnings being treated as errors
>   29    23.06 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
>   30     6.08 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
>     builtin-buildid-list.c: In function 'buildid__map_cb':
>     builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                    ~~~~^                  ~~~~~~~~~~
>           |                        |                     |
>           |                        long unsigned int     u64 {aka long long unsigned int}
>           |                    %16llx
>     builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>        32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
>           |                          ~~~~^                        ~~~~~~~~
>           |                              |                           |
>           |                              long unsigned int           u64 {aka long long unsigned int}
>           |                          %16llx
>     cc1: all warnings being treated as errors
>
>
> These should use PRIx64, etc.
>
> - Arnaldo
