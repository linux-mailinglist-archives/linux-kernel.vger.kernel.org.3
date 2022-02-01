Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398A74A57C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiBAHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiBAHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:32:57 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14FDC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:32:57 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so15378506ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJSDBj0HvFrkS4TLKuPLvlZS13YusH/7w8kLNZ4wxGA=;
        b=LJlQ0q/uL3MKzgZ4tIKPUGf5ZdjHG3YbTGagkGQxErLE4GBrP3pwtVAXcfI5DOb35r
         f00BWzfnnUUT5iYd+03lUSTl8kRq88RhbO3jYBPd3Zl0Rn+QqgfJEX+CJ19AacVQfGr4
         N6v3W/E44lcWKD5oUwsRX7FY7jU2eSQJYPKuqSOpOkb6FF7wfgRi2y/IExRaHHs5vxPx
         AMVhxMzRPnQm+APmaNOSn18Hz/In7wZXJNkgJovDhIHBLZKI0AprlnlqXWHeZQuHl8fr
         h3yLsL1/c2RO1yrytOTE/VRejXuJW4wqW3kzfgcVVfYHwesKQc56G3gjThWJIu9DPj9r
         +GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJSDBj0HvFrkS4TLKuPLvlZS13YusH/7w8kLNZ4wxGA=;
        b=zwbWeihWr7pG82UlEByq25rpJzFf6MA2KxquRnZyPGxfiTuTm6YMXxTkmiPHEF9C1L
         1uqAYwXw0kNRLAr3ZzEt6SF9SHttqWFjg6gpAhRAOMdrWY4JGF8HjMx5XAWJHXR1ZMLe
         R0J+73D0S0maUu/a3t19qoiSl8pXwplUZU3uOSZpIHOirnXb4Wj7eKl6cvQLPzuVlCWS
         9chIekBBKZmzlaFY1TL1uPDRGUCF4VlMgZk2ldgJoa1R0Iun1Aw6KO2r4qrmLQJogMTh
         jFoZbSCr9QXJiEJ9NdC/Tip6w3H6Ii8+Sx14is1cycvQcwEdx0ZRaYDGo5sFF1eZSv4v
         XnlA==
X-Gm-Message-State: AOAM531CinrS1Mgp6rnDylYLhE5aISsSAbM6vC4DzGSzYo/rctVRkYJC
        Pf+WwrtlTwSbYfcQdtBQUcnGWGK2wqDmVWCmTUG0uChupDVBTA==
X-Google-Smtp-Source: ABdhPJyT9m4eJrn2NJRLqyik1zmslChCJeZLrGkukJT+0lnFfwqo/WvDQUXQ8MvtVpST6dcT6SNask0BDMM/CbbmysQ=
X-Received: by 2002:a9d:356:: with SMTP id 80mr13762561otv.335.1643700776891;
 Mon, 31 Jan 2022 23:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com>
In-Reply-To: <20220131103407.1971678-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 08:32:45 +0100
Message-ID: <CACT4Y+Zcg9Jf9p+RHWwKNDoCpfH-SBTzPpuQBBryyeopMONmEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: Copy perf_event_attr::sig_data on modification
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 11:34, Marco Elver <elver@google.com> wrote:
>
> The intent has always been that perf_event_attr::sig_data should also be
> modifiable along with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, because it is
> observable by user space if SIGTRAP on events is requested.
>
> Currently only PERF_TYPE_BREAKPOINT is modifiable, and explicitly copies
> relevant breakpoint-related attributes in hw_breakpoint_copy_attr().
> This misses copying perf_event_attr::sig_data.
>
> Since sig_data is not specific to PERF_TYPE_BREAKPOINT, introduce a
> helper to copy generic event-type-independent attributes on
> modification.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for the quick fix.

> ---
>  kernel/events/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fc18664f49b0..db0d85a85f1b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3197,6 +3197,15 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
>         return err;
>  }
>
> +/*
> + * Copy event-type-independent attributes that may be modified.
> + */
> +static void perf_event_modify_copy_attr(struct perf_event_attr *to,
> +                                       const struct perf_event_attr *from)
> +{
> +       to->sig_data = from->sig_data;
> +}
> +
>  static int perf_event_modify_attr(struct perf_event *event,
>                                   struct perf_event_attr *attr)
>  {
> @@ -3219,10 +3228,17 @@ static int perf_event_modify_attr(struct perf_event *event,
>         WARN_ON_ONCE(event->ctx->parent_ctx);
>
>         mutex_lock(&event->child_mutex);
> +       /*
> +        * Event-type-independent attributes must be copied before event-type
> +        * modification, which will validate that final attributes match the
> +        * source attributes after all relevant attributes have been copied.
> +        */
> +       perf_event_modify_copy_attr(&event->attr, attr);
>         err = func(event, attr);
>         if (err)
>                 goto out;
>         list_for_each_entry(child, &event->child_list, child_list) {
> +               perf_event_modify_copy_attr(&child->attr, attr);
>                 err = func(child, attr);
>                 if (err)
>                         goto out;
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
