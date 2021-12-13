Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B427A4734F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbhLMTaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:30:03 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42570 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbhLMTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:30:00 -0500
Received: by mail-lf1-f42.google.com with SMTP id t26so32820406lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRbjdpMqsKSOJrmgnRsjFJuNxvRJTbJgBzRDg5R8e0Y=;
        b=W+7VlcKpyWKg1hBQ/5p6rDeuybgZgUQHLT6OTuhgdvxw+SMS8v9TAw24t25LQBeCzf
         /P1m/JmPWG/IkM9FU/DpDZH0l35fuyN+1Gu5/ZArzx9PbeUHDOElwJmmkJSHjaV++PTm
         dHjABVJUdMDYcUZbicqYTBwUfNZVXbotPUATwoYlCNIfir8tLnqsFGxa837e+Tra4hmg
         CwVThQ8OLPStW23q0aucrA3OsxrqQLdYDVaYIShRyBgO4frzSKYY72QRRmP15+KMkWP4
         Aot5TmFSKERMO1Zsw+qRERwk4sEDcoKDRnmOYRdlZfeGlV1Zky1uwJINmE2GunUvXKCg
         Abzg==
X-Gm-Message-State: AOAM532V/BGAg4uW13FcSwCYSDU+iwHxhJDPcy50/W8of77+i2Ceuc2h
        8ACSe+Xqfquvu8eljDqkSmlcrSgr87dMcGVf51I=
X-Google-Smtp-Source: ABdhPJw77MD6X04TZw9vSgRsZOUIPtqRVWhtzc7tg7HVqYc09C21BwwZ2BQRXfAu9LULXaj0tf9lLZYkeEaEdKA4CZM=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr281218lfv.481.1639423798931;
 Mon, 13 Dec 2021 11:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20211213084829.114772-1-adrian.hunter@intel.com>
 <20211213084829.114772-3-adrian.hunter@intel.com> <YbdHBhw7lk/6vKd5@kernel.org>
In-Reply-To: <YbdHBhw7lk/6vKd5@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Dec 2021 11:29:47 -0800
Message-ID: <CAM9d7cgMLnwrwJLerSrYyp++o1TTVOh0Dtv7ewvQ4z0T+ct6Eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf inject: Fix segfault due to perf_data__fd()
 without open
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 5:13 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Dec 13, 2021 at 10:48:29AM +0200, Adrian Hunter escreveu:
> > The fixed commit attempts to get the output file descriptor even if the
> > file was never opened e.g.
> >
> >  $ perf record uname
> >  Linux
> >  [ perf record: Woken up 1 times to write data ]
> >  [ perf record: Captured and wrote 0.002 MB perf.data (7 samples) ]
> >  $ perf inject -i perf.data --vm-time-correlation=dry-run
> >  Segmentation fault (core dumped)
> >  $ gdb --quiet perf
> >  Reading symbols from perf...
> >  (gdb) r inject -i perf.data --vm-time-correlation=dry-run
> >  Starting program: /home/ahunter/bin/perf inject -i perf.data --vm-time-correlation=dry-run
> >  [Thread debugging using libthread_db enabled]
> >  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> >
> >  Program received signal SIGSEGV, Segmentation fault.
> >  __GI___fileno (fp=0x0) at fileno.c:35
> >  35      fileno.c: No such file or directory.
> >  (gdb) bt
> >  #0  __GI___fileno (fp=0x0) at fileno.c:35
> >  #1  0x00005621e48dd987 in perf_data__fd (data=0x7fff4c68bd08) at util/data.h:72
> >  #2  perf_data__fd (data=0x7fff4c68bd08) at util/data.h:69
> >  #3  cmd_inject (argc=<optimized out>, argv=0x7fff4c69c1f0) at builtin-inject.c:1017
> >  #4  0x00005621e4936783 in run_builtin (p=0x5621e4ee6878 <commands+600>, argc=4, argv=0x7fff4c69c1f0) at perf.c:313
> >  #5  0x00005621e4897d5c in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:365
> >  #6  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:409
> >  #7  main (argc=4, argv=0x7fff4c69c1f0) at perf.c:539
> >  (gdb)
>
> Thanks, applied.
>
> - Arnaldo
>
>
> > Fixes: 0ae03893623d ("perf tools: Pass a fd to perf_file_header__read_pipe()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> > ---
> >  tools/perf/builtin-inject.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index af70f1c72052..409b721666cb 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -755,12 +755,16 @@ static int parse_vm_time_correlation(const struct option *opt, const char *str,
> >       return inject->itrace_synth_opts.vm_tm_corr_args ? 0 : -ENOMEM;
> >  }
> >
> > +static int output_fd(struct perf_inject *inject)
> > +{
> > +     return inject->in_place_update ? -1 : perf_data__fd(&inject->output);
> > +}
> > +
> >  static int __cmd_inject(struct perf_inject *inject)
> >  {
> >       int ret = -EINVAL;
> >       struct perf_session *session = inject->session;
> > -     struct perf_data *data_out = &inject->output;
> > -     int fd = inject->in_place_update ? -1 : perf_data__fd(data_out);
> > +     int fd = output_fd(inject);
> >       u64 output_data_offset;
> >
> >       signal(SIGINT, sig_handler);
> > @@ -1015,7 +1019,7 @@ int cmd_inject(int argc, const char **argv)
> >       }
> >
> >       inject.session = __perf_session__new(&data, repipe,
> > -                                          perf_data__fd(&inject.output),
> > +                                          output_fd(&inject),
> >                                            &inject.tool);
> >       if (IS_ERR(inject.session)) {
> >               ret = PTR_ERR(inject.session);
> > --
> > 2.25.1
>
> --
>
> - Arnaldo
