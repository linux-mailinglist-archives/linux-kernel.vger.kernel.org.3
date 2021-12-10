Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0107147090B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbhLJSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:45:38 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44928 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhLJSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:45:37 -0500
Received: by mail-lf1-f54.google.com with SMTP id z7so19599455lfi.11;
        Fri, 10 Dec 2021 10:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/vZFfyyGbtD8bnHKJffHn0egoSdbRjyGjsJBHQqKr8=;
        b=4t3D4KnQtNe0e8m2yj+Ke9lWji8fQ6sEIbq1hsHiHw7dQDDrphsWCUVCZMGsZ0Z8E4
         cBqkLGV6xNjeIauAgfB5ARa5EefabYKsPEuuRd5gidnQyV2x84/pfBF1jyyBXCafPJu0
         ZhBXOtRcCUqdG33+GDuhOsoTLKx32+f+iSdD59hrfrx0CHPvSLc5mm9pzhMANUQCDKhF
         G09OGFFMMiLdjyMjuwAmJxBgo56GkSZ5k/GEZIUjgv8rzuqJziIghzHVri3/cyPXufqF
         3tsKlcbAF6C9bKQAfpMx0iZfWL4+tv9/H13qG/AOZ5A9Fzwf93XBSgouNtpUp9/r4Ekc
         g1WA==
X-Gm-Message-State: AOAM531ijSZAGikZvOdi+Nwcndj3Uwq3YGm+T/jPejA2xxPdWZtUepIV
        gpT8wiP9ZfRVfIHYDQyCt0vWeg/1qNwt9jmfdu4=
X-Google-Smtp-Source: ABdhPJzSirnbrYv9rYoyj9m7S/o4CrKa5bGDf0xNi1iC5x1U8HaTeAfyjlyTD8zPTC5izteDBuj/fwXR4s7T4JgWNNo=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr14452961lfv.481.1639161720961;
 Fri, 10 Dec 2021 10:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20211209200425.303561-1-jolsa@kernel.org> <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
 <YbNGxMAu5LYvqtpq@krava>
In-Reply-To: <YbNGxMAu5LYvqtpq@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Dec 2021 10:41:49 -0800
Message-ID: <CAM9d7cit-GKyDcVp435np7WSe_KW-+NYD7rHSC10EEoW1EpTSA@mail.gmail.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 4:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Dec 09, 2021 at 03:39:20PM -0800, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Thu, Dec 9, 2021 at 12:04 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > hi,
> > > after migrating to fedora 35 I found perf record hanging on exit
> > > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > > debuginfod query which might take long time to process.
> > >
> > > I discussed this briefly with Frank and I'm sending the change
> > > to disable debuginfod by default in perf record.
> > >
> > > Frank had other idea we could discuss here to fork or just spawn
> > > "/usr/bin/debuginfod-find ...." into background after perf record.
> > >
> > > Perhaps there are other ways as well, hence this is RFC ;-)
> >
> > I thought the debuginfod was for perf report, not record.
> > Maybe I'm missing something but how about moving it to
> > report?  We can talk to debuginfod after checking the local
> > build-id cache and binary on the system.
>
> at the end of the perf record we populate buildid cache
> with profiled binaries for the current perf.data
>
> **IF** there's DEBUGINFOD_URLS defined, that code will
> also ask debuginfod for binaries it could not find on
> the system

Yeah, I know what you're doing.  But I guess debuginfod
contains binaries for the distro and they'd be available for
a while.  Then I think we don't need to do it at perf record.

Thanks,
Namhyung
