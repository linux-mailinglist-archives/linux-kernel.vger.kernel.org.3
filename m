Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79A5223A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348634AbiEJSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348832AbiEJSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:17:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC8893980
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:13:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d15so22226716lfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+mhbUG8PMDB8QXSseDQwzEe01Khv6i9dx48j8lmtdY=;
        b=VYL9j4eEhQi+y5jroNsekGGDgbHvK7gBY2RS5tr5c3cJkqy9ODxmTeYuY3+r+6f8/w
         eafQ2ivjlBXqswOgGzsGHGnflJnHCXk3DUJMiGvX2AW+dbAUMsHyo+1VoZZJUPQNXS9W
         PogVEThUknDYF9kmc6Y8HnbQ3tpVTPWtTLbvyYXW3hWpfiTorKr+RS2FV0Z+nk2FQpVV
         dolMATi5dThlZtLi4gGg1BWjYI7oPdCzQ9+mD4sz0cASszscxWcHjbRqiYFIvtFbGYpp
         49Q8bkQlaIg9iDlJ1nstNphpmoJDXr0RNyQogChGWb1MEbN4vxyT/KvgRcXWjO/U8aqp
         04UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+mhbUG8PMDB8QXSseDQwzEe01Khv6i9dx48j8lmtdY=;
        b=mamlO2FnKFflJY5c0Rr3cIawoeG30LjMbErNUh1s9zmQVGZa85T98yjjyUObnrv3IT
         uM+5Mj+aK+LoJFC9QMXe+qIN3r+HAl7JZsTy8tmCW5QzRR1TQnJ0dei0+TRqbowFvLoV
         cJkMjxGUu+zebLS7yrWhuPQEsD3l+J9o1QLzDGrOyGRMEfLY5VHmPtntoMvPXdyXcy52
         4/9IwxpxCWZ72QIQwvDViCw0Rij6i9dKAE4JfWbVniegUDv4FhZLFimMDRziCj9jV0jE
         ihcpvpS1WgGyvAvpeUnAicuAUrLNF/vnXRsJpbBXvYkwIp3sPPd3AaNxhDg8qNRQQC0w
         vjLw==
X-Gm-Message-State: AOAM530d4Do179iux2zYaqO6jipFFTi68/VvCpdDg/sYz8TaY45HuEt8
        kUfLBW/KGKh7e0Myk6hTGYAhTko6AKMQWD4l+/Jczw==
X-Google-Smtp-Source: ABdhPJzflSbkOIVfh3BfhcfU3qBsFSUkT8A9ZRNLjuHTUKPrO6sSQhGwP4fCX9UKcjPngmjO5g8FetAXbFrAFELGW1Q=
X-Received: by 2002:a05:6512:1048:b0:473:c648:c5c3 with SMTP id
 c8-20020a056512104800b00473c648c5c3mr17114682lfb.487.1652206384534; Tue, 10
 May 2022 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213704.2524229-1-blakejones@google.com> <YnqW68rLssWA8uba@kernel.org>
In-Reply-To: <YnqW68rLssWA8uba@kernel.org>
From:   Blake Jones <blakejones@google.com>
Date:   Tue, 10 May 2022 11:12:53 -0700
Message-ID: <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
Subject: Re: [PATCH] Add an "-m" option to "perf buildid-list".
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Thanks for taking a look at this!

On Tue, May 10, 2022 at 9:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Tue, May 03, 2022 at 02:37:04PM -0700, Blake Jones escreveu:
> > +-m::
> > +--modules::
> > +     Show buildid, start/end text address, and path of kernel and modules.
>
> Hi,
>
>         Wouldn't it be better to have -m show just modules, name +
> buildid, then have -v show more verbose info, i.e. the start, end and
> switch from just the module name to its full path?
>
>         Then to get what your patch produces now one would use:
>
>         $ perf buildid-list -kmv
>
>         That would be more flexible, wdyt?

I'm open to using "-v" like this if you think it would be useful; is
there a use case you have in mind for the non-verbose mode? For doing
external symbolization of stack traces, the BuildID isn't useful without
also knowing the starting and ending addresses.

If "-m" only showed information about modules and not about the kernel,
then "perf buildid-list -km" (without "-v") would have different output
formats for the kernel and for the modules. So I'm inclined to have "-m"
include information about the kernel as well as the modules.

How does that sound?

Blake
