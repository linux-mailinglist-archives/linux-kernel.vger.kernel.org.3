Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA1476083
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbhLOSQD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 13:16:03 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37731 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbhLOSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:16:00 -0500
Received: by mail-lf1-f44.google.com with SMTP id c32so44845842lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQG36V6DTbwoVLAJqXerjwCdN1jzRWsIwTOQpwr2EbI=;
        b=1g02p6xtaCklBKVKrNUjEmDI3/U2jEjvgorWAOOQuNXR9/mnlYI4eViAqAg0/rXIwZ
         /hVOvb+e1BpffaCLuPedlTETuaweLVb9JkrAcGd82plDmuPpBBLvyurW8C8QWcnNaCXT
         LjKy1Jsm5qcHTaNN4qNjtsupzGK0t3b9PJkpTQdd3zSS5BNdpBfaXlp3/jGKlidrl6bf
         +oXWMgKgJSwL9TQDL03eNKFeC+4KMIR2QSNooKpoMhoYwGQ8xCEOQKymcIZdGGPil2wE
         VuLBhpkoFm2CkGilRVWVSRNoezzVeuSr227F19eGkHP19JfDQp2JI0NXzQ9Ylp9Yp9Pc
         ZeEQ==
X-Gm-Message-State: AOAM533t9wgPRoZR03suJUOqTpRiSisj+PvXUWZdbHN+sb0vwyVJyUib
        4WVCwvWAhVsr9I5XR5v7y4kDdqtr+rI6vL7lhpk=
X-Google-Smtp-Source: ABdhPJwxlhnMXpB3jWFJahyoTZylx8Jq77EGyWpCwNiJM908b19e6mVEYQ5yqo7ua40B8t2wUkbnN/8C6ENMy9vyLtk=
X-Received: by 2002:a05:6512:22c3:: with SMTP id g3mr11221707lfu.528.1639592159160;
 Wed, 15 Dec 2021 10:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <20211129231830.1117781-5-namhyung@kernel.org>
 <011B6FDF-15F0-411F-98F2-155E95BE7047@linux.vnet.ibm.com> <CAM9d7cgaYC9BxeA3dRtb8CP+9BnFQ7pXgG9X+ku_CZ43i=ZqGg@mail.gmail.com>
In-Reply-To: <CAM9d7cgaYC9BxeA3dRtb8CP+9BnFQ7pXgG9X+ku_CZ43i=ZqGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 10:15:48 -0800
Message-ID: <CAM9d7cgnQOZVaCs7Yj=siBLkhK7Z5TmmXLBA+VkGs1S3PUOSTw@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Athira,
>
> On Sun, Dec 5, 2021 at 6:24 PM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> >
> >
> > > On 30-Nov-2021, at 4:48 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The -b/--use-bpf option is to use BPF to get latency info of kernel
> > > functions.  It'd have better performance impact and I observed that
> > > latency of same function is smaller than before when using BPF.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> [SNIP]
> > > @@ -1144,6 +1166,8 @@ int cmd_ftrace(int argc, const char **argv)
> > >       const struct option latency_options[] = {
> > >       OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
> > >                    "Show latency of given function", parse_filter_func),
> > > +     OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
> > > +                 "Use BPF to measure function latency"),
> >
> >
> > Hi Namhyung,
> >
> > Can this be inside BPF_SKEL check, similar to how we have “bpf-prog” and other options in builtin-stat.c ?
> >
> > #ifdef HAVE_BPF_SKEL
> > <<OPT_BOOLEAN for use-bpf>>
> > #endif
> >
> > Otherwise when using “-b” and if perf is not built with BPF_SKEL, we will just return in perf_ftrace__latency_prepare_bpf without any error messages.
>
> Thanks for reporting this.  Yeah, it should report
> error messages in such conditions.
>
> I think it'd be better to add an error message
> rather than hiding the option.

Well, now we build perf with BPF by default.
So I think it's ok to follow your suggestion.
it'd show the usage and options when the -b option is used
and BPF support is not enabled.

Thanks,
Namhyung
